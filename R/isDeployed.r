#' Tests to see whether a given model is deployed
#'
#' @param model_name name of the model to test for deployment
#' @param host the address of the openscoring server
#' @export
isDeployed <- function(model_name, host){
  models <- getmodels(host)
  if(model_name %in% models$Id){
    return(TRUE)
  }
  else{
    return(FALSE)
  }

}
