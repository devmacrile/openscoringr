% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/deploy.r
\name{deploy}
\alias{deploy}
\title{Deploy a model to the openscoring server.}
\usage{
deploy(model, model_name, host, save = FALSE)
}
\arguments{
\item{model}{the model object to be PMML'd and deployed}

\item{model_name}{the name of the model to be deployed, defaults to the name of the model object if not provided}

\item{host}{the address of the server to which to deploy the model}

\item{save}{indicates whether to keep the generated pmml or not}
}
\description{
This function takes a given model implemented in R,
creates an appropriate PMML file to deploy to the server,
and deploys this model to the openscoring server to be
invoked via the REST API.
}
\examples{
\dontrun{
server <- "http://localhost:8080/openscoring"
data(iris)
mymodel <- kmeans(iris[,-5], 3, iter.max=20, nstart=5)
deploy(mymodel, "Example", server)
}
}

