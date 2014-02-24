<?php
require_once 'config.php';

function nikuda_initpage() {
	function fatal_error_handler($buffer) {
		global $do_ob;
		if ($do_ob) {
			header('HTTP/1.1 500 Internal Server Fatal Error', true, 500);
			header('buffer: '.$buffer);
			ob_end_clean();
		} else {
			echo $buffer;
		}
		exit(0);
	}
	function handle_error($errno, $errstr, $errfile, $errline){
		global $do_ob;
		if ($do_ob) {
			header('HTTP/1.1 500 Internal Server Error', true, 500);
			header('errstr: '.$errstr);
			header('errno: '.$errno);
			header('errfile: '.$errfile);
			header('errline: '.$errline);
			ob_end_clean();
		} else {
			echo $errno;
			echo $errstr;
			echo $errfile;
			echo $errline;
		}
		exit(0);
	}

	// ERROR HANDLING
	error_reporting(E_ALL);
	set_error_handler('handle_error');
	global $do_log_errors;
	if ($do_log_errors) {
		// dont show errors to the user
		ini_set('display_errors',0);
		// log errors instead
		ini_set('log_errors',1);
		// error log file
		//ini_set('error_log','phperrors.txt');
	}

	global $do_ob;
	if ($do_ob) {
		//ob_start('fatal_error_handler');
		ob_start();
	}

	global $do_utf_headers;
	if ($do_utf_headers) {
		header('Content-Type: text/html; charset=utf-8');
	}
}

function nikuda_connect() {
	global $db_host, $db_user, $db_pass, $db_name, $db_charset, $link;
	$link=mysqli_connect($db_host,$db_user,$db_pass, $db_name)
		or die('Could not connect: '.mysqli_connect_error());
	mysqli_set_charset($link, $db_charset)
		or die('Could not set character set: '.mysqli_error());
}

function nikuda_disconnect() {
	global $db_host, $db_user, $db_pass, $db_name, $db_charset, $link;
	$link->close();
}

function nikuda_finipage() {
	global $do_ob;
	if ($do_ob) {
		ob_end_flush();
	}
}

?>
