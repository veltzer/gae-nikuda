<?php
/*
 * Here is the php site configuration for nikuda
 * ${attr.messages_dne}
 */
$db_host=('${attr.nikuda_local_db_host}'=='') ? null : '${attr.nikuda_local_db_host}';
$db_user=('${attr.nikuda_local_db_user}'=='') ? null : '${attr.nikuda_local_db_user}';
$db_pass=('${attr.nikuda_local_db_password}'=='') ? null : '${attr.nikuda_local_db_password}';
$db_name=('${attr.nikuda_local_db_name}'=='') ? null : '${attr.nikuda_local_db_name}';
$db_port=('${attr.nikuda_local_db_port}'=='') ? null : '${attr.nikuda_local_db_port}';
$db_socket=('${attr.nikuda_local_db_socket}'=='') ? null : '${attr.nikuda_local_db_socket}';
$db_charset='utf8';
$do_log_errors=true;
$do_ob=true;
$do_utf_headers=true;
$utf_charset='utf-8';
$do_error_handling=true;
$do_set_charset=true;
?>
