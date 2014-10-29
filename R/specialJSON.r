#' Returns JSON structure required by openscoring server.  Intended as a private function.
#'
#' To POST data to be scored, must conform to the JSON structure accepted by the
#' openscoring server.  Single example, using the first row of the iris dataset:
#' {
#'    "id" : "example-001",
#'    "arguments" : {
#'      "Sepal_Length" : 5.1,
#'      "Sepal_Width" : 3.5,
#'      "Petal_Length" : 1.4,
#'      "Petal_Width" : 0.2
#'    }
#' }
#'
#' The batch format is a JSON array of these objects.
#' [{
#'    "id" : "example-001",
#'    "arguments" : {
#'      "Sepal_Length" : 5.1,
#'      "Sepal_Width" : 3.5,
#'      "Petal_Length" : 1.4,
#'      "Petal_Width" : 0.2
#'    }
#' },
#' {
#'    "id" : "example-001",
#'    "arguments" : {
#'      "Sepal_Length" : 4.9,
#'      "Sepal_Width" : 3,
#'      "Petal_Length" : 1.4,
#'      "Petal_Width" : 0.2
#'    }
#' }]
#'
#' @param x is a data.frame
#' @keywords JSON
#' @export
specialJSON <- function(x){
  if(!is.data.frame(x) | dim(x)[1] == 0){
    stop("Argument 'x' must be a data frame with at least one row!")
  }

  if(nrow(x) == 1){
    request <- paste('{"id" : "obs-1", "arguments" : ',
                     toJSON(unbox(x)), '}', sep='')
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
