context("deploy")

OPENSCORING.SERVER <- "http://localhost:8080/openscoring"
load("resources/iris-rf.Rdata")  # Loads iris.rf randomForest object

deploy(iris.rf, "iris-rf", OPENSCORING.SERVER)



