#!/bin/bash


##############################################################################
# CHECK IF THE MVN IS INSTALLED TO PERFORM MVN TREE/ANALYSE AND EXIT IF NOT
##############################################################################

function check_if_mvn_installed () {

readonly CHECK_IF_MVN_INSTALLED=$(command -v mvn);

echo "Check if mvn installed $CHECK_IF_MVN_INSTALLED"

if [ "$CHECK_IF_MVN_INSTALLED" == "" ]; then
  echo "You don\'t seem to have mvn installed."
  echo "Get it: https://maven.apache.org/download.cgi"
  echo "Exiting ..."
  exit 127;
fi;
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
# COUNT THE NUMBER OF CLASS EXISTING ON THE PROJECT
##############################################################################

function count_number_classes () {

readonly RAISER_CLASS_COUNT=$(find $WHERE_TO_SEARCH_DEPENDENCIES_RAISER3 -name *.java | xargs grep -w "public class" | wc -l)

echo "| =====================================  $RAISER_PROJECT contain $RAISER_CLASS_COUNT classes ===================================== |"

}

##############################################################################
# SCAN RAISER 1 FEATURES USED ON THE PROJECT
##############################################################################

function scan_raiser_v1_features () {

echo -e "FeatureName\t,Use\t,Pourcent\t,TotalClasses\n" >> $RAISER_PROJECT-raiser1-features-$(date +"%m-%d-%y").csv

for feature in "${!features_raiser_v1[@]}"; do 

# Search all *.java files, and calculate the number of use of feature.
COUNT=$(find "$WHERE_TO_SEARCH_DEPENDENCIES_RAISER3" -name *.java | xargs grep -w "${features_raiser_v1[$feature]}" | wc -l)

echo -e "\e[92m|===================== The feature: $feature is used \e[91m$COUNT \e[92m times on the project =====================|"

POURCENT=$((COUNT*100/RAISER_CLASS_COUNT))

show_level_of_use POURCENT

echo -e "\e[92m| ######################## The level of use of RAISER $feature is \e[91m$LEVEL % ==> \e[93m$POURCENT% \e[92m######################## |"

echo -e "$feature\t,$COUNT\t,$POURCENT\t,$RAISER_CLASS_COUNT\n" >> $RAISER_PROJECT-raiser1-features-$(date +"%m-%d-%y").csv

done

}

##############################################################################
# SCAN RAISER 2 FEATURES USED ON THE PROJECT
##############################################################################

function scan_raiser_v2_features () {

printf "FeatureName\t,Use\t,Pourcent\t,TotalClasses\n" >> $RAISER_PROJECT-raiser2-features-$(date +"%m-%d-%y").csv

for feature in "${!features_raiser_v2[@]}"; do 

# Search all *.java files, and calculate the number of use of feature.
COUNT=$(find "$WHERE_TO_SEARCH_DEPENDENCIES_RAISER3" -name *.java | xargs grep -w "${features_raiser_v2[$feature]}" | wc -l)

echo -e "\e[92m| ######################## The feature: $feature is used \e[91m$COUNT \e[92mtimes in this project ######################## |"

POURCENT=$((COUNT*100/RAISER_CLASS_COUNT))

show_level_of_use POURCENT

echo -e "\e[92m| ######################## The level of use of RAISER $feature is \e[91m$LEVEL % ==> \e[93m$POURCENT% \e[92m######################## |"

printf "$feature\t,$COUNT\t,$POURCENT\t,$RAISER_CLASS_COUNT\n" >> $RAISER_PROJECT-raiser2-features-$(date +"%m-%d-%y").csv

done

}

##############################################################################
# SCAN RAISER 3 FEATURES USED ON THE PROJECT
##############################################################################

function scan_raiser_v3_features () {

printf "FeatureName\t,Use\t,Pourcent\t,TotalClasses\n" >> $RAISER_PROJECT-raiser3-features-$(date +"%m-%d-%y").csv

for feature in "${!features_raiser_v3[@]}"; do 

# Search all *.java files, and calculate the number of use of feature.
COUNT=$(find "$WHERE_TO_SEARCH_DEPENDENCIES_RAISER3" -name *.java | xargs grep -w "${features_raiser_v3[$feature]}" | wc -l)

echo -e "\e[92m| ######################## The feature: $feature is used \e[91m$COUNT \e[92mtimes in this project ######################## |"

POURCENT=$((COUNT*100/RAISER_CLASS_COUNT))

show_level_of_use POURCENT

echo -e "\e[92m| ######################## The level of use of RAISER $feature is \e[91m$LEVEL % ==> \e[93m$POURCENT% \e[92m######################## |"

printf "$feature\t,$COUNT\t,$POURCENT\t,$RAISER_CLASS_COUNT\n" >> $RAISER_PROJECT-raiser3-features-$(date +"%m-%d-%y").csv

done

}

##############################################################################
# SHOW THE POURCENTAGE OF USE IN TERM OF FAIBLE, MODERE, ELEVE
##############################################################################

function show_level_of_use () {

pourcent=$1

LEVEL='' 

if [[ "$pourcent" -le 30 || "$pourcent" -ge 0 ]] ; then
  LEVEL='LOW'

elif [[ "$pourcent" -le 60 || "$pourcent" -ge 30 ]] ; then
  LEVEL='MODERATED'

else [[ "$pourcent" -le 100 || "$pourcent" -ge 60 ]] ; 
  LEVEL='HIGH'
fi

}

##############################################################################
# INPUT/ MAP FEATURES RAISER 1/
############################################################################## 

declare -A features_raiser_v1=( 

["RAISER_BUSINESS_CONTROLLER"]="@BusinessController"
["RAISER_BO_REFLECTION_BUILDER"]="com.bnpparibas.raiser.bo.BoRaiserReflectionToStringBuilder"
["RAISER_BO_ABSTRACTION_BUILDER"]="com.bnpparibas.raiser.bo.AbstractRaiserBo"
["RAISER_BO_CONFIGURATION"]="com.bnpparibas.raiser.configuration"
["RAISER_SOA"]="com.bnpparibas.raiser.soa"
["RAISER_BO_UTILS"]="com.bnpparibas.raiser.utils"

)

##############################################################################
# INPUT/ MAP FEATURES RAISER 2/
############################################################################## 

declare -A features_raiser_v2=( 

["RAISER_BUSINESS_CONTROLLER"]="@BusinessController"
["RAISER_BO_REFLECTION_BUILDER"]="com.bnpparibas.raiser.bo.BoRaiserReflectionToStringBuilder"
["RAISER_BO_ABSTRACTION_BUILDER"]="com.bnpparibas.raiser.bo.AbstractRaiserBo"
["RAISER_BO_CONFIGURATION"]="com.bnpparibas.raiser.configuration"
["RAISER_SOA"]="com.bnpparibas.raiser.soa"
["RAISER_BO_UTILS"]="com.bnpparibas.raiser.utils"

)

##############################################################################
# INPUT/ MAP FEATURES RAISER 3/
############################################################################## 

declare -A features_raiser_v3=(

["RAISER_LOGGER"]="com.bnpparibas.raiserframework.log.IRaiserLog"
["RAISER_AUTOLOG"]="com.bnpparibas.raiserframework.log.aop.Autolog"
["RAISER_MAIL"]="com.bnpparibas.raiserframework.mail.RaiserMailSender"
["RAISER_REST"]="@RestController"
["RAISER_SWAGGER"]="io.swagger.annotations.Api"
["RAISER_EXCEPTION"]="com.bnpparibas.raiser.utils"

)

declare -A starters_raiser_v3=(

["RAISER_OIDC_SAML_COUNT"]="raiser-spring-boot-starter-saml"
["RAISER_OIDC_RHSSO_COUNT"]="raiser-spring-boot-starter-oidc"
["RAISER_SOAP_COUNT"]="raiser-spring-boot-starter-soap-service"

)

declare -A level_of_use=(

["LOW"]="30"
["MODERATED"]="60"
["HIGH"]="90"

)

 
##############################################################################
# MAIN
##############################################################################

echo "| ==========================================  START SCAN OF RAISER PROJECT ========================================== |"

check_raiser_path_project_to_scan

check_raiser_version_to_scan

check_raiser_project_to_scan

count_number_classes 

case $RAISER_VERSION in
     v1|V1)
         
		  scan_raiser_v1_features
          ;;
     v2|V2)
          scan_raiser_v2_features
          ;;
     v3|V3)
          scan_raiser_v3_features
          ;; 
     *)
          echo "this version of raiser is not allowed."
          ;;
esac

echo "| ==========================================  END OF SCAN OF $RAISER_PROJECT ========================================== |"

