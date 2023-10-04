

#!/bin/bash



# Set the domain that needs to access the server

DOMAIN=${DOMAIN_NAME}



# Set the path to the Apache configuration file

CONF_FILE=${PATH_TO_APACHE_CONFIG_FILE}



# Add the Access-Control-Allow-Origin header to the configuration file

sed -i "/${_VIRTUALHOST}/i Header set Access-Control-Allow-Origin \"$DOMAIN\"" $CONF_FILE



# Restart Apache to apply the changes

systemctl restart apache2