#' Score a deployed model on new data
#'
#' Takes feature data and returns a prediction response by applying
#' the selected model to the data provided.  This can be called
#' in either "single prediction" mode (i.e. one observation of features,
#' one set of prediction values returned), or "batch" mode where
#' prediction responses are returned for a collection of observations.
#'
#' @param model_name name of the model used to score
#' @param host Address of openscoring server (i.e. "http://localhost:8080/openscoring")
#' @param data Data on which to execute model.  Must be a data.frame and
#' the colnames must match the activeFields of model_name.
#' Run getModelSchema(model_name)$activeFields to get the active
#' @keywords score batch
#' @export
score <- function(data, model_name, host){
  if(!isDeployed(model_name, host)){
    stop(paste("No deployed model named ", model_name, sep=""))
  }
  if(class(data) != "data.frame"){
    stop(paste("The 'data' parameter must have class 'data.frame'\n",
               "(class '", class(data), "' provided)", sep=""))
  }

  schema <- getModelSchema(model_name, host)
  active_fields <- unlist(schema$activeFields)
  clnms <- colnames(data)
  if(!setequal(clnms, active_fields)){
    stop(paste("The 'data' field names do not match the activeFields of the model!"))
  }

  request <- specialJSON(data)
  if(!validate(request)){
    stop("Not proper JSON!")
  }

  if(nrow(data) == 1){
    # Single prediction
    url <- paste(host, "/model/", model_name, sep="")
    response <- POST(url, body = request,
                     add_headers("Content-Type" = "application/json"))
    pred <- as.data.frame(content(response))
    result <- cbind(data, pred[, -1])
    return(result)
  }
  else{
    # Batch prediction
    url <- paste(host, "/model/", model_name,
                 "/batch", sep="")
    response <- POST(url, body = request,
                     add_headers("Content-Type" = "application/json"))
    response <- content(response)
    pred <- do.call("rbind", lapply(response, data.frame))
    result <- cbind(data, pred[, -1])
    return(result)
  }

}
