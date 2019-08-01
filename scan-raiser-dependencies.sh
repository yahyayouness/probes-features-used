#!/bin/bash

##############################################################################
# CHECK IF THE RAISER PROJECT PATH TO SCAN IS FILLED
##############################################################################

function check_path_param () {
if [ "$1" != "" ]; then
    
	readonly WHERE_TO_SEARCH_DEPENDENCIES_RAISER3="$1"
		
else

	echo -e "\e[93mPlease enter the path of the project to scan: "

	read WHERE_TO_SEARCH_DEPENDENCIES_RAISER3

fi
 }
 
 ##############################################################################
# CHECK IF THE FIRST PARAM $1 IS CONTAINING THE PROJECT PATH TO SCAN 
##############################################################################

function check_raiser_path_project_to_scan () {
if [ "$1" != "" ]; then
    
	readonly WHERE_TO_SEARCH_DEPENDENCIES_RAISER3="$1"
		
else

	echo -e "\e[93mPlease enter the project path to scan:\e[91m "

	read WHERE_TO_SEARCH_DEPENDENCIES_RAISER3

fi
 }

##############################################################################
# CHECK IF THE SECOND PARAM $2 IS CONTAINING THE VERSION OF RAISER TO USE
##############################################################################

function check_raiser_version_to_scan () {
if [ "$2" != "" ]; then
    
	readonly RAISER_VERSION="$2"
		
else

	echo -e "\e[93mPlease enter the raiser version to use:\e[91m "

	read RAISER_VERSION

fi
 }

##############################################################################
# CHECK IF THE THIRD PARAM $3 IS CONTAINING THE NAME OF PROJECT TO SCAN
##############################################################################

function check_raiser_project_to_scan () {
if [ "$3" != "" ]; then
    
	readonly RAISER_PROJECT="$3"
		
else

	echo -e "\e[93mPlease enter the raiser project to scan:\e[91m "

	read RAISER_PROJECT

fi
 }

##############################################################################
# CHECK IF THE MVN IS INSTALLED AND EXIT IF NOT
##############################################################################

function check_if_mvn_installed () {

readonly CHECK_IF_MVN_INSTALLED=$(command -v mvn);

echo "Start checking mvn installation $CHECK_IF_MVN_INSTALLED"

if [ "$CHECK_IF_MVN_INSTALLED" == "" ]; then
  echo "You don\'t seem to have mvn installed."
  echo "Get it: https://maven.apache.org/download.cgi"
  echo "Exiting with code 127..."
  exit 127;
fi;
 }

##############################################################################
# SCAN DEPENDECIES AND SAVE THEN IN TXT FILE
##############################################################################

function scan_raiser_dependencies () {

echo -e "\e[92m######################## Start scan raiser 3 dependencies in [ $WHERE_TO_SEARCH_DEPENDENCIES_RAISER3 ] ########################"

readonly POM_RAISER_DEPENDENCIES=$(cd "$WHERE_TO_SEARCH_DEPENDENCIES_RAISER3"; mvn org.apache.maven.plugins:maven-dependency-plugin:2.1:tree -Dincludes=com.bnpparibas.raiserframework | grep com.bnpparibas.raiserframework )

echo -e "\e[92m\n$POM_RAISER_DEPENDENCIES\n"

echo -e "\e[92m######################## End scan raiser 3 dependencies in [ $WHERE_TO_SEARCH_DEPENDENCIES_RAISER3 ] ########################"

echo -e "$POM_RAISER_DEPENDENCIES\n" >> $RAISER_PROJECT-raiser3-dependencies-$(date +"%m-%d-%y").txt

}

##############################################################################
# DIRECTORY COMMANDS
##############################################################################

check_raiser_path_project_to_scan

check_raiser_version_to_scan

check_raiser_project_to_scan

check_if_mvn_installed

scan_raiser_dependencies