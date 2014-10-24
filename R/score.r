#' Score a deployed model on new data
#'
#' Takes feature data and returns a prediction response by applying
#' the selected model to the data provided.  This can be called
#' in either "single prediction" mode (i.e. one observation of features,
#' one set of prediction values returned)
#' @param model_name name of the model used to score
#' @param host address of openscoring server
#' @param d data on which to execute model
#' @param mode either 'single' or 'batch'
#' @keywords score batch
#' @export
#' @example
score <- function(model_name, host, d){



}
