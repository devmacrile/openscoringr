#' Gets a list of available models on the openscoring server.
#'
#' Returns a data.frame with information about the deployed models
#'
#' @param host the address of the openscoring server from which to get model information
#' @param data.type indicates the final R data type for the response (data.frame or list)
#' @aliases get models
#' @export
getModels <- function(host, data.type="data.frame"){
  if(missing(host)){
    stop("Please provide a valid openscoring server address!")
  }
  if(substr(host, nchar(host), nchar(host)) == "/"){
    host <- substr(host, 0, nchar(host) - 1)
  }
  if(data.type != "data.frame" & data.type != "list"){
    stop("Valid data.types are 'data.frame' or 'list' (data.frame by default)")
  }

  url <- paste(host, "/model", sep="")
  models <- httr::content(httr::GET(url))

  if(length(models) == 0){
    # No models to display
    stop("No models deployed!")
  }

  if(data.type == "list"){
    # Already in list format
    return(models)
  }
  
  df <- do.call(rbind.data.frame, models[[1]])
  colnames(df) <- c("Id", "Summary")
  df
}
