#!/bin/bash

USERID=INSERTHERE
USERPASSWORD=INSERTHERE
COOKIEFILE=./cookie.txt
COOKIEHANDLING=``
USERAGENT="TaHoma/2.6 CFNetwork/672.0.8 Darwin/14.0.0"
APIURL=https://www.tahomalink.com/enduser-mobile-web/externalAPI

#Constants for testing only. Insert propper values from the generated XML-files.
GATEWAYID=INSERTHERE
ACTIONGROUPOID=INSERTHERE

# TaHoma LogIn
# This creates a bunch of XML-files which have to be parsed -> TODO
echo `curl -s -k -A $USERAGENT -b $COOKIEFILE -c $COOKIEFILE --data "userId=$USERID&userPassword=$USERPASSWORD" $APIURL/login` > login.xml
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getEndUser` > getEndUser.xml
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getSetup` > getSetup.xml
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getActionGroups` > getActionGroups.xml
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getWeekPlanning` > getWeekPlanning.xml
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getScheduledExecutions` > getScheduledExecutions.xml
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getHistory` > getHistory.xml
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getSensorTriggers` > getSensorTriggers.xml
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getUserPreferences` > getUserPreferences.xml
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getSetupOptions` > getSetupOptions.xml
# TODO: gatewayId has to be extracted from getSetupOptions or getSetup
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getActiveProtocolsType?gatewayId=$GATEWAYID` > getActiveProtocolsType.xml
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getSetupQuota?quotaId=smsCredit` > getSetupQuota.xml
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/refreshAllStates` > refreshAllStates.xml

#App is polling the server every two seconds
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getEvents`
sleep 2
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getEvents`
sleep 2
#Start ActionGroup
# TODO: ActionGroup ID has to be extracted from getActionGroups 
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/scheduleActionGroup?oid=$ACTIONGROUPOID&delay=0`
#App refreshes event status every two seconds
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getEvents`
sleep 2
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getEvents`
sleep 2
#App uses the following queries to determine if the ActionGroup is running
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getScheduledExecutions`
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getEvents`
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getCurrentExecutions`
sleep 2
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getEvents`
sleep 2
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getEvents`
sleep 2
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getEvents`
sleep 2
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getEvents`
sleep 2
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getEvents`
sleep 2
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getEvents`
sleep 2
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getEvents`
sleep 2
#App is now checking if the ActionGroup is still running if not the  ActionGroup will be found in getHistory and the App goes to normal 'polling'-state
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getEvents`
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getHistory`
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getCurrentExecutions`
sleep 2
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getEvents`
sleep 2
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getEvents`
sleep 2
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/getEvents`
sleep 2
#Logging out and exit
echo `curl -s -k -A $USERAGENT -b ./cookie.txt -c ./cookie.txt $APIURL/logout`
