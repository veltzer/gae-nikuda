<?php
	// connect to host DataBase
	mysql_connect("localhost","reemj_doron","doron15")
		or die("Could not connect: " . mysql_error());
	mysql_select_db("reemj_nikuda")
		or die("Could not select DB: " . mysql_error());

	mysql_set_charset("hebrew")
		or die("Could not set Hebrew character set: " . mysql_error());

	$Request = $_POST['Request']
	// validate client
	$ValidateClient = "SELECT Name FROM clients WHERE Name = '$Request->Name' AND Code = '$Request->Code'";

	$Valid = mysql_query($ValidateClient)
		or die("Failed in validating client:" . mysql_error());

	// if succesfull than add
	if (mysql_fetch_array($Valid)) {

		// get inserted words
		// decode JSON string to php object
		$RequestedWords = json_decode($Request->Words]);

		foreach ($RequestedWords as $Word){
			$AddWord = "INSERT IGNORE INTO wordlist VALUES(NULL, '$Word->Naked', '$Word->Nikud')";

			mysql_query($AddWord)
				or die("Failed in adding word:" . '$Word->Naked . ", error:" . mysql_error());
			}
			else {
				die("Client validation failed.");
			}
		}
	}
?>
