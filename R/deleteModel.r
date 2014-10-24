#' Deletes the model from the openscoring server
#'
#' @param model_name name of the model to delete
#' @param host address of server from which to remove model
#' @keywords delete
#' @export
deleteModel <- function(model_name, host){
  if(!isDeployed(model_name, host)){
    stop(paste("No deployed model named ", model_name, sep=""))
  }

  valid_input = 0
  while(valid_input == 0){
    pos <- readline(prompt = "Are you sure you would like to delete this model? (y/n)")
    if(pos == "y"){
      valid_input = 1
    }
    if(pos == "n"){
      return("Model not removed.")
    }
  }

  url <- paste(host, "/model/", model_name, sep="")
  invisible(DELETE(url))
}
