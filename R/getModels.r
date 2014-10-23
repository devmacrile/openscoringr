#' Gets a list of available models on the openscoring server
#'
#' Returns a data.frame with information about the deployed models
#'
#' @param host the address of the openscoring server from which to get model information
#' @param data.type indicates the final R data type for the response (data.frame or list)
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
  models <- content(GET(url))

  if(data.type == "list"){
    return(models)
  }

  model.count <- length(models)
  id.index <- seq(1, 2*model.count - 1, by=2)
  summ.idx <- seq(2, 2*model.count, by=2)
  mdl.char <- unlist(models)
  df <- data.frame(mdl.char[id.index], mdl.char[summ.idx])
  colnames(df) <- c("Id", "Summary")
  return(df)
}
