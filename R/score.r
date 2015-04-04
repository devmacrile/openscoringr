#' Scores new data on a deployed model.
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
#' @aliases predict
#' @export
score <- function(data, model_name, host){
  if(!isDeployed(model_name, host)){
    stop(paste("No deployed model named ", model_name, sep=""))
  }
  if(class(data) != "data.frame"){
    stop(paste("The 'data' parameter must have class 'data.frame'\n",
               "(class '", class(data), "' provided)", sep=""))
  }

  # Get model schema to ensure features are present in new data
  mdl_summary <- getModelSchema(model_name, host)
  active_fields <- sapply(mdl_summary$schema$activeFields, function(x) x$id)
  clnms <- colnames(data)
  if(!all(active_fields %in% clnms)){
    stop(paste("The 'data' field names do not match the activeFields of the model!"))
  }

  # Jsonify the new data
  request <- specialJSON(data)
  if(!jsonlite::validate(request)){
    stop("Not proper JSON!")
  }
  
  if(nrow(data) == 1){
    # Single prediction
    url <- paste(host, "/model/", model_name, sep="")
    response <- httr::POST(url, body = request,
                     add_headers("Content-Type" = "application/json"))
    pred <- as.data.frame(httr::content(response))
    result <- cbind(data, pred[, -1])
    return(result)
  }
  else{
    # Batch prediction
    url <- paste(host, "/model/", model_name,
                 "/batch", sep="")
    response <- httr::POST(url, body = request,
                     add_headers("Content-Type" = "application/json"))
    response <- httr::content(response)
    pred <- do.call("rbind", lapply(response, data.frame))
    result <- cbind(data, pred[, -1])
    return(result)
  }
}
