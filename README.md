openscoringr
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

#### TODO  
Incorporate the authentication functionality (simply testing on localhost with no auth for proof-of-concept)
Add information about how to install R package  
Add some examples





