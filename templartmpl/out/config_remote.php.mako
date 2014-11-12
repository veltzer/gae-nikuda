<?php
/*
 * Here is the php site configuration for nikuda
 * ${tdefs.messages_dne}
 */
$db_host=('${tdefs.nikuda_remote_db_host}'=='') ? null : '${tdefs.nikuda_remote_db_host}';
$db_user=('${tdefs.nikuda_remote_db_user}'=='') ? null : '${tdefs.nikuda_remote_db_user}';
$db_pass=('${tdefs.nikuda_remote_db_password}'=='') ? null : '${tdefs.nikuda_remote_db_password}';
$db_name=('${tdefs.nikuda_remote_db_name}'=='') ? null : '${tdefs.nikuda_remote_db_name}';
$db_port=('${tdefs.nikuda_remote_db_port}'=='') ? null : '${tdefs.nikuda_remote_db_port}';
$db_socket=('${tdefs.nikuda_remote_db_socket}'=='') ? null : '${tdefs.nikuda_remote_db_socket}';
$db_charset='utf8';
$do_log_errors=true;
$do_ob=true;
$do_utf_headers=false;
$utf_charset='utf-8';
$do_error_handling=true;
$do_set_charset=true;
?>
