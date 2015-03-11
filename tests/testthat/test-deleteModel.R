context("deleteModel")

library(httr)

OPENSCORING.SERVER <- "http://localhost:8081/openscoring"
url <- paste(OPENSCORING.SERVER, "/model/DecisionTreeIris", sep="")
httr::PUT(url, body = upload_file("resources/DecisionTreeIris.pmml", "text/xml"))

test_that("Test that model can be removed from openscoring server", {
	expect_equal(isDeployed("DecisionTreeIris", OPENSCORING.SERVER), TRUE)
	deleteModel("DecisionTreeIris", OPENSCORING.SERVER)
	expect_equal(isDeployed("iris-rf", OPENSCORING.SERVER), FALSE)
})
