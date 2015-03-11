context("getModels")

OPENSCORING.SERVER <- "http://localhost:8081/openscoring"
load("resources/IrisSVM.Rdata")  # Loads IrisSVM svm object
load("resources/IrisLinearModel.Rdata")  # Loads glm object


test_that("Test that model can be deployed to openscoring server", {
	
	# Deploy models s.t. getModels not empty
	deploy(IrisSVM, "IrisSVM", OPENSCORING.SERVER)
	deploy(IrisLinearModel, "IrisLinearModel", OPENSCORING.SERVER)
	deployed_models <- getModels(host)
	expect_equal(is_true("IrisSVM" %in% deployed_models$Id), TRUE)
	expect_equals(is_true("IrisLinearModel" %in% deployed_models$Id, TRUE)
})