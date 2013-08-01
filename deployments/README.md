A file called ROOT.war is necessary to satisfy the jbossas-7
cartridge. However, the standalone.xml has been modified to set
auto-deploy-zipped="false" in the deployment scanner, thus preventing
AS7 from trying to deploy this dummy file.
