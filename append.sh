#!/bin/bash

echo 'Installing...'
cd /opt/bitnami/mediawiki

PIWIK_URL=$1
PIWIK_ID_NUMBER=$2
WP_OAUTH_ID=$3
WP_OAUTH_SECRET=$4

cat "
##File Extension
$wgFileExtensions = array(
    'png', 'gif', 'jpg', 'jpeg', 'jp2', 'webp', 'ppt', 'pdf', 'psd',
    'mp3', 'xls', 'xlsx', 'swf', 'doc','docx', 'odt', 'odc', 'odp',
    'odg', 'mpp'
    );

##Math
wfLoadExtension( 'Math' );
$wgDefaultUserOptions['math'] = 'mathml';
$wgMathFullRestbaseURL = 'https://en.wikipedia.org/api/rest_';

##Piwik
wfLoadExtension( 'Piwik' );
$wgPiwikURL = "$PIWIK_URL";
$wgPiwikIDSite = "$PIWIK_ID_NUMBER";
$wgPiwikTrackUsernames = true;

##Oauth
$wgInvalidUsernameCharacters = '';
wfLoadExtension( 'MW-OAuth2Client' );
$wgOAuth2Client['client']['id']     = '$WP_OAUTH_ID'; // The client ID assigned to you by the provider
$wgOAuth2Client['client']['secret'] = '$WP_OAUTH_SECRET'; // The client secret assigned to you by the provider
$wgOAuth2Client['configuration']['authorize_endpoint']     = 'http://WP_URL/oauth/authorize'; // Authorization URL
$wgOAuth2Client['configuration']['access_token_endpoint']  = 'http://WP_URL/oauth/token'; // Token URL
$wgOAuth2Client['configuration']['api_endpoint']           = 'http://WP_URL/oauth/me'; // URL to fetch user JSON
$wgOAuth2Client['configuration']['redirect_uri']           = 'http://MEDIAWIKI_URL/index.php/Special:OAuth2Client/callback'; // URL for OAuth2 server to redirect to,$
$wgOAuth2Client['configuration']['username'] = 'user_login'; // JSON path to username
$wgOAuth2Client['configuration']['email'] = 'user_email'; // JSON path to email
$wgOAuth2Client['configuration']['http_bearer_token'] = 'Bearer'; // Token to use in HTTP Authentication
$wgOAuth2Client['configuration']['query_parameter_token'] = 'access_token'; // query parameter to use
//$wgOAuth2Client['configuration']['scopes'] = 'read_citizen_info'; //Permissions
$wgOAuth2Client['configuration']['service_name'] = 'Oauth Registry'; // the name of your service
$wgOAuth2Client['configuration']['service_login_link_text'] = 'OAuth2Login'; // the text of the login link" >> LocalSettings.php