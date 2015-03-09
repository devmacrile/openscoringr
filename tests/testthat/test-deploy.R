library(openscoringr)
context("deploy")

# Test prerequisites/constants
OPENSCORING.SERVER <- "http://localhost:8080/openscoring"
load("resources/iris-rf.Rdata")  # Loads iris.rf randomForest object


test_that("model can be deployed to openscoring server", {
	deploy(iris.rf, "iris-rf", OPENSCORING.SERVER)
})



