#' Deploy a model to the openscoring server.
#'
#' This function takes a given model implemented in R,
#' creates an appropriate PMML file to deploy to the server,
#' and deploys this model to the openscoring server to be
#' invoked via the REST API.
#'
#' @param model the model object to be PMML'd and deployed
#' @param model_name the name of the model to be deployed, defaults to the name of the model object if not provided
#' @param host the address of the server to which to deploy the model
#' @param save indicates whether to keep the generated pmml or not
#' @export
#' @examples
#' server <- "http://localhost:8080/openscoring"
#' data(iris)
#' mymodel <- kmeans(iris[,-5], 3, iter.max=20, nstart=5)
#' deploy(mymodel, "Example", server)
deploy <- function(model, model_name, host, save=FALSE){
  if(missing(model)){
    stop("You must provide a model in order to deploy!")
  }
  if(missing(model_name)){
    model_name <- deparse(substitute(model))
  }
  if(substr(host, nchar(host), nchar(host)) == "/"){
    host <- substr(host, 0, nchar(host) - 1)
  }

  pmml.err.msg <- "Could not convert your model format to valid PMML.  Please
  ensure you are using a supported model type."
  tryCatch({model_rep <- pmml(model)},
           error = function(e){ stop(pmml.err.msg) },
           exception = function(x){ stop(pmml.err.msg) }
  )

  fname <- paste(model_name, ".pmml", sep="")
  saveXML(model_rep, fname)

  url <- paste(host, "/model/", model_name, sep="")
  PUT(url, body = upload_file(fname, "text/xml"))

  if(save == FALSE){
    file.remove(fname)
  }
  print("Model successfully deployed.")

}
