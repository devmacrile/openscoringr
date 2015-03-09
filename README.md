openscoringr		[![Image not found!](https://travis-ci.org/devmacrile/openscoringr.svg?branch=master)](https://travis-ci.org/devmacrile/openscoringr)
============

An R wrapper for the openscoring REST API enabling the deployment, management, and scoring of
predictive models with openscoring server.

Requirements:
*	R (>= 2.7.0)
*	openscoring server

#### Installing the openscoring server  
Please check out the [official documentation](https://github.com/jpmml/openscoring) for more details, including 
requirements for the openscoring server and [PMML](http://www.dmg.org/v4-1/GeneralStructure.html) support.  

Make sure you have >= Java 1.7, and the appropriate environment variables configured (i.e. JAVA_HOME).  Clone
the GitHub repository into the directory of your choice with the following command:  

	cd where/I/want/openscoring
	git clone https://github.com/jpmml/openscoring.git
	
Now, enter the project root directory and build using [Maven](http://maven.apache.org/) (if you need to install,
just download the appropriate binary and follow the instructions [here](http://maven.apache.org/download.cgi)
) with the following:  

	mvn clean install
	
After a minute, if this is successful, you can execute the built server executable:  

	java -jar openscoring-server/target/server-executable-1.2-SNAPSHOT.jar
	
which will start up the REST web service (at [http://localhost:8080/openscoring](http://localhost:8080/openscoring ) by default).  

#### Installing the R Package  
Use Hadley's [devtools](https://github.com/hadley/devtools) package to install directly from GitHub:
```r
	install.packages("devtools")
	library(devtools)
	install_github("devmacrile/openscoringr")
	
	
#### Example Usage  

Using the openscoringr package to deploy a model, get information about the deployed model, score new data, and remove the deployed model.

```r
  	library(openscoringr)
	library(randomForest)
	data(iris)
	
	# Construct a dummy predictive model
	intraining <- sample(1:nrow(iris), 125)
	iris.train <- iris[intraining, ]
	iris.test <- iris[-intraining, ]
	iris.rf <- randomForest(Species ~ ., data=iris.train)
	
	# Deploy a model to openscoring
	OPENSCORING.SERVER <- "http://localhost:8080/openscoring"
	deploy(iris.rf, "iris-rf", OPENSCORING.SERVER)
	
	# Get a list of deployed models
	getModels(openscoring.server)  # Will have 'iris-rf' deployed
	isDeployed("iris-rf", OPENSCORING.SERVER)  # Will return TRUE
	
	# Get schema for individual model
	getModelSchema("iris-rf", OPENSCORING.SERVER)
	
	# Score new data on deployed model
	predictions <- score(iris.test, "iris-rf", OPENSCORING.SERVER)
	
	# Remove model from deployment
	deleteModel("iris-rf", OPENSCORING.SERVER)
```
	
	
	
	






