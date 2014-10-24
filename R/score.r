#' Score a deployed model on new data
#'
#' Takes feature data and returns a prediction response by applying
#' the selected model to the data provided.  This can be called
#' in either "single prediction" mode (i.e. one observation of features,
#' one set of prediction values returned)
#' @param model_name name of the model used to score
#' @param host address of openscoring server
#' @param data data on which to execute model
#' @param mode either 'single' or 'batch'
#' @keywords score batch
#' @export
score <- function(model_name, host, data, mode){
  if(!isDeployed(model_name, host)){
    stop(paste("No deployed model named ", model_name, sep=""))
  }
  if(class(data) != "data.frame"){
    stop(paste("The 'data' parameter must have class data.frame
               (class ", class(data), "provided", sep=""))
  }
  #Check data against model schema



}
