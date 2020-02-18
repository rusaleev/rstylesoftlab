# rstylesoftlab

**settingsService**

is required to run the credit calculator

runs on localhost:8080

mvn clean package spring-boot:run

**creditCalculator**

depends on settingsService running

runs on localhost:8081

mvn clean package spring-boot:run

open http://localhost:8081/