#' Tests to see whether a given model is deployed
#'
#' @param model_name name of the model to test for deployment
#' @param host the address of the openscoring server
#' @keywords deployed test bool
#' @export
isDeployed <- function(model_name, host){
  models <- getModels(host)
  if(model_name %in% models$Id){
    return(TRUE)
  }
  else{
    return(FALSE)
  }

}
