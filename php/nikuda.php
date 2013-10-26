<?PHP
	function nIkUdA()
	{
	  // connect to host DataBase
	  mysql_connect("localhost","reemj_doron","doron15")
		  or die("Could not connect: " . mysql_error());
	  mysql_select_db("reemj_nikuda")
		  or die("Could not select DB: " . mysql_error());

	  mysql_set_charset("hebrew")
		  or die("Could not set Hebrew character set: " . mysql_error());
	}
?>