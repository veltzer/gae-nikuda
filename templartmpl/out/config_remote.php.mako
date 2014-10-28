<?php
/*
 * Here is the php site configuration for nikuda
 * ${attr.messages_dne}
 */
$db_host=empty('${attr.nikuda_remote_db_host}') ? null : '${attr.nikuda_remote_db_host}';
$db_user=empty('${attr.nikuda_remote_db_user}') ? null : '${attr.nikuda_remote_db_user}';
$db_pass=empty('${attr.nikuda_remote_db_password}') ? null : '${attr.nikuda_remote_db_password}';
$db_name=empty('${attr.nikuda_remote_db_name}') ? null : '${attr.nikuda_remote_db_name}';
$db_port=empty('${attr.nikuda_remote_db_port}') ? null : '${attr.nikuda_remote_db_port}';
$db_socket=empty('${attr.nikuda_remote_db_socket}') ? null : '${attr.nikuda_remote_db_socket}';
$db_charset='utf8';
$do_log_errors=true;
$do_ob=true;
$do_utf_headers=false;
$utf_charset='utf-8';
$do_error_handling=true;
$do_set_charset=true;
?>
