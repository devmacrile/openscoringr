#' Returns the schema of the given model
#'
#' The schema of the model includes "activeFields", "groupFields",
#' "targetFields", and "outputFields".  Returns a list with this information
#' associated with the model name.
#'
#' @param model_name the name of the model for which to retrieve schema
#' @keywords schema model get
#' @export
getModelSchema <- function(model_name, host){
  if(!isDeployed(model_name, host)){
    stop(paste("No deployed model named ", model_name, sep=""))
  }

  url <- paste(host, "/model/",
               model_name, "/schema", sep="")
  schema <- content(GET(url))
  print(schema)
}


