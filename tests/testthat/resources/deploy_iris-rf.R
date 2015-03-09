command <- 'curl -X PUT --data-binary @iris-rf.pmml -H "Content-type: text/xml" http://localhost:8080/openscoring/model/iris-rf'
system(command)