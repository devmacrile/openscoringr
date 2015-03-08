#' Returns the schema of the given model.
#'
#' The schema of the model includes "activeFields", "groupFields", "targetFields",
#' and "outputFields".  \code{getModelSchema} returns a list with this information
#' associated with the model name.
#'
#' @param model_name name of the model for which to retrieve schema
#' @export
getModelSchema <- function(model_name, host){
  if(!isDeployed(model_name, host)){
    stop(paste("No deployed model named ", model_name, sep=""))
  }

  url <- paste(host, "/model/",
               model_name, "/schema", sep="")
  schema <- httr::content(httr::GET(url))
  return(schema)
}


