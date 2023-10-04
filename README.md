
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Apache Cross-Origin Resource Sharing (CORS) Errors
---

Cross-Origin Resource Sharing (CORS) is a security feature in web browsers that restricts web pages from making requests to a different domain than the one that served the web page. When a website tries to make a cross-origin request, the browser will block the request by default. The Apache server is commonly used to serve web pages, and sometimes it can be misconfigured, causing CORS errors to occur. These errors can prevent certain web pages or resources from loading correctly, resulting in a poor user experience.

### Parameters
```shell
export APACHE_CONF_DIR="PLACEHOLDER"

export ORIGIN="PLACEHOLDER"

export RESOURCE_URL="PLACEHOLDER"

export APACHE_ERROR_LOG="PLACEHOLDER"

export _VIRTUALHOST="PLACEHOLDER"

export DOMAIN_NAME="PLACEHOLDER"

export PATH_TO_APACHE_CONFIG_FILE="PLACEHOLDER"
```

## Debug

### Check the Apache configuration file for any CORS-related directives
```shell
grep -i -r "Header set Access-Control-Allow-Origin" ${APACHE_CONF_DIR}
```

### Verify that the CORS headers are being set correctly for the requested resource
```shell
curl -H "Origin: ${ORIGIN}" -I ${RESOURCE_URL}
```

### Check the Apache error log for any CORS-related errors or warnings
```shell
tail -f ${APACHE_ERROR_LOG}
```

### Verify that the CORS headers are being sent from the server to the client
```shell
curl -H "Origin: ${ORIGIN}" -I ${RESOURCE_URL} | grep -i "Access-Control-Allow-Origin"
```

### Check the response headers for any other relevant information
```shell
curl -I ${RESOURCE_URL}
```

## Repair

### Add the appropriate Access-Control-Allow-Origin header to the server response to allow cross-origin requests from the specific domains that need to access the server.
```shell


#!/bin/bash



# Set the domain that needs to access the server

DOMAIN=${DOMAIN_NAME}



# Set the path to the Apache configuration file

CONF_FILE=${PATH_TO_APACHE_CONFIG_FILE}



# Add the Access-Control-Allow-Origin header to the configuration file

sed -i "/${_VIRTUALHOST}/i Header set Access-Control-Allow-Origin \"$DOMAIN\"" $CONF_FILE



# Restart Apache to apply the changes

systemctl restart apache2


```