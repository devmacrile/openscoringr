context("deleteModel")
source('resources/deploy_iris-rf.R')

OPENSCORING.SERVER <- "http://localhost:8080/openscoring"

test_that("Test that model can be removed from openscoring server", {
	deleteModel("iris-rf", OPENSCORING.SERVER)
	expect_equal(isDeployed("iris-rf", OPENSCORING.SERVER), FALSE)
})
