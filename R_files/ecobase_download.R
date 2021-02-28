#To get the list of available Ewe models
library(RCurl)
library(XML)
library(plyr)
h=basicTextGatherer()
curlPerform(url = 'http://sirs.agrocampus-ouest.fr/EcoBase/php/webser/soap-client_3.php',writefunction=h$update)
data<-xmlTreeParse(h$value(),useInternalNodes=TRUE)
liste_mod<-ldply(xmlToList(data),data.frame) #liste_mod contains a list and decription of available models in EcoBase

#To get the input values for model mymodel - 403 
library(RCurl)
library(XML)
library(plyr)
h=basicTextGatherer()
mymodel<-403
curlPerform(url = paste('http://sirs.agrocampus-ouest.fr/EcoBase/php/webser/soap-client.php?no_model=',mymodel,sep=''),writefunction=h$update,verbose=TRUE)
data<-xmlTreeParse(h$value(),useInternalNodes=TRUE)
input1<-xpathSApply(data,'//group',function(x) xmlToList(x))

#To get the ouptput values for model mymodel - 403 
library(RCurl)
library(XML)
library(plyr)
h=basicTextGatherer()
mymodel<-403
curlPerform(url = paste('http://sirs.agrocampus-ouest.fr/EcoBase/php/webser/soap-client_output.php?no_model=',mymodel,sep=''),writefunction=h$update,verbose=TRUE)
data<-xmlTreeParse(h$value(),useInternalNodes=TRUE)
output1<-xpathSApply(data,'//group',function(x) xmlToList(x))

#Downloading food web databases and deriving basic structural metrics (it can't install rmangal which is a dependency of the fw_package)
library(devtools)
install_github("FMestre1/fw_package")
library(fw)
mg1 <- create.fw.list(db="mg", ref=TRUE, spatial = TRUE)