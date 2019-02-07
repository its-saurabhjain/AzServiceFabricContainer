1. Setup the set up your development environment. This process includes installing the Service Fabric SDK and Visual Studio 2017 or 2015.
https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-get-started
---Installed VS 2019 preview
---Installed Service Fabric SDK
---Installed dotnet core sdk 2.2
2. Install Docker for windows.
3. Create dotnet application and deploy
https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-tutorial-create-dotnet-app
4. Stateless Web app invoking Stateful Service, and deployed on azure.

5. Powershell command to get clinet certificate from .pfx in azure devops
 [System.Convert]::ToBase64String([System.IO.File]::ReadAllBytes("C:\Cloud\Azure\AzureDevOps\serv
ice-fabric-dotnet-quickstart\mytestcert.pfx"))

*****IMP*****
1. clone the application
2. login to azure account usiing powershell and cd to the TODO directory
3. run ./CreateAzureSQLDB.ps1 and get server name
4. run ./CreateContainerRegistry.ps1
5. Modify the web.config file for the connection string (get the conncetion string from Azure SQL DB and replace user id and password)
6. Create a new Service Fabric cluster from Visual Studio 
7. Modify AzureAccessSQLDB.ps1 with server name received from step 3
8. run ./AzureAccessSQLDB.ps1
9. publish the application using visual studio (make sure docker engine is running as this will create a new image and will push that image to the container repository on Azure)
10.Try accessing the application, initiall it takes time and you will not see the page..try few time and the page will appear....

