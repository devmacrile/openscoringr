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
#'
#' @param x is a data.frame
#' @keywords JSON
#' @export
specialJSON <- function(x){
  if(!is.data.frame(x) | dim(x)[1] == 0){
    stop("Argument 'x' must be a data frame with at least one row!")
  }

  if(dim(x) == 1){


  }



}
