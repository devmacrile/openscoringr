library(openscoringr)
context("deploy")

# Test prerequisites/constants
OPENSCORING.SERVER <- "http://localhost:8081/openscoring"
load("resources/IrisSVM.Rdata")  # Loads IrisSVM svm object
load("resources/IrisLinearModel.Rdata")  # Loads glm object


test_that("Test that model can be deployed to openscoring server", {
	deploy(IrisSVM, "IrisSVM", OPENSCORING.SERVER)
	expect_equal(isDeployed("IrisSVM", OPENSCORING.SERVER), TRUE)
	
	deploy(IrisLinearModel, "IrisLinearModel", OPENSCORING.SERVER)
	expect_equal(isDeployed("IrisLinearModel", OPENSCORING.SERVER), TRUE)
})



