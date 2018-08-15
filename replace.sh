#!/bin/bash

#Receiving the flags
while getopts ":p:k:w:s:h" opt; do
  case $opt in
    p)
      PIWIK_URL=$OPTARG
      ;;
    k)
      PIWIK_ID_NUMBER=$OPTARG
      ;;
    w)
      WP_OAUTH_ID=$OPTARG
      ;;
    s)
      WP_OAUTH_SECRET=$OPTARG
      ;;
    h)
      echo "-p Piwik URL" >&2
      echo "-k Piwik ID Number" >&2
      echo "-w Wordpress OAuth ID" >&2
      echo "-s Wordpress Secret" >&2
      ;;
    \?)
      echo "Invalid option : -$OPTARG" >&2
      echo "Type replace.sh -h for help" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      echo "Type replace.sh -h for help" >&2
      exit 1
      ;;
  esac
done

if [ ! -z "${PIWIK_URL}" ]; then #-p
    sed -i '/\$wgPiwikURL =/d' ./LocalSettings.php
    sed -i "/wfLoadExtension( 'Piwik' );/a \$wgPiwikURL = '$PIWIK_URL';" ./LocalSettings.php
    echo "Set Piwik URL: $PIWIK_URL"
fi
if [ ! -z "${PIWIK_ID_NUMBER}" ]; then #-k
    sed -i '/\$wgPiwikIDSite =/d' ./LocalSettings.php
    sed -i "/\$wgPiwikURL =/a \$wgPiwikIDSite = '$PIWIK_ID_NUMBER';" ./LocalSettings.php
    echo "Set Piwik ID Number: $PIWIK_ID_NUMBER"
fi
if [ ! -z "${WP_OAUTH_ID}" ]; then #-w
    sed -i "/\$wgOAuth2Client\['client'\]\['id'\]     = /d" ./LocalSettings.php
    sed -i "/wfLoadExtension( 'MW-OAuth2Client' );/a \$wgOAuth2Client['client']['id']     = '$WP_OAUTH_ID'; // The client ID assigned to you by the provider" ./LocalSettings.php
    echo "Set Wordpress OAuth ID: $WP_OAUTH_ID"
fi
if [ ! -z "${WP_OAUTH_SECRET}" ]; then #-s
    sed -i "/\$wgOAuth2Client\['client'\]\['secret'\] =/d" ./LocalSettings.php
    sed -i "/\$wgOAuth2Client\['client'\]\['id'\]     = /a \$wgOAuth2Client['client']['secret'] = '$WP_OAUTH_SECRET'; // The client secret assigned to you by the provider" ./LocalSettings.php
    echo "Set Wordpress OAuth Secret: $WP_OAUTH_SECRET"
fi
