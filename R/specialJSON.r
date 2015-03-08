#' Private function that returns JSON structure required by openscoring server.
#'
#' To POST data to be scored, must conform to the JSON structure accepted by the
#' openscoring server.  Single example, using the first row of the iris dataset:
#'
#' @param x data.frame with the data to be parsed into JSON.
specialJSON <- function(x){
  if(!is.data.frame(x) | dim(x)[1] == 0){
    stop("Argument 'x' must be a data frame with at least one row!")
  }

  if(nrow(x) == 1){
    request <- paste('{"id" : "obs-1", "arguments" : ',
                     jsonlite::toJSON(jsonlite::unbox(x)), '}', sep='')
  }
  else{
    for(i in 1:nrow(x)){
      if(i == 1) request <- specialJSON(x[i, ])
      else{
        obj <- specialJSON(x[i, ])
        request <- paste(request, obj, sep=",")
      }
    }
    request <- paste("[", request, "]", sep="")
  }

  return(request)

}
