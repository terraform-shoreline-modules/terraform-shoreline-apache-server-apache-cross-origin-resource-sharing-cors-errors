resource "shoreline_notebook" "apache_cross_origin_resource_sharing_cors_errors" {
  name       = "apache_cross_origin_resource_sharing_cors_errors"
  data       = file("${path.module}/data/apache_cross_origin_resource_sharing_cors_errors.json")
  depends_on = [shoreline_action.invoke_add_access_control_header]
}

resource "shoreline_file" "add_access_control_header" {
  name             = "add_access_control_header"
  input_file       = "${path.module}/data/add_access_control_header.sh"
  md5              = filemd5("${path.module}/data/add_access_control_header.sh")
  description      = "Add the appropriate Access-Control-Allow-Origin header to the server response to allow cross-origin requests from the specific domains that need to access the server."
  destination_path = "/agent/scripts/add_access_control_header.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_add_access_control_header" {
  name        = "invoke_add_access_control_header"
  description = "Add the appropriate Access-Control-Allow-Origin header to the server response to allow cross-origin requests from the specific domains that need to access the server."
  command     = "`chmod +x /agent/scripts/add_access_control_header.sh && /agent/scripts/add_access_control_header.sh`"
  params      = ["DOMAIN_NAME","PATH_TO_APACHE_CONFIG_FILE","_VIRTUALHOST"]
  file_deps   = ["add_access_control_header"]
  enabled     = true
  depends_on  = [shoreline_file.add_access_control_header]
}

