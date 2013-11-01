<?php
	require_once 'utils.php';

	// start the page
	nikuda_initpage();
	// connect to host DataBase
	nikuda_connect();

	$Request = $_POST['Request']
	// validate client
	$ValidateClient = "SELECT Name FROM clients WHERE Name = '$Request->Name' AND Code = '$Request->Code'";

	global $link;
	$Valid = mysqli_query($link, $ValidateClient)
		or die("Failed in validating client:" . mysqli_error());

	// if succesfull than add
	if (mysqli_fetch_array($Valid)) {

		// get inserted words
		// decode JSON string to php object
		$RequestedWords = json_decode($Request->Words]);

		foreach ($RequestedWords as $Word){
			$AddWord = "INSERT IGNORE INTO wordlist VALUES(NULL, '$Word->Naked', '$Word->Nikud')";

			mysqli_query($link, $AddWord)
				or die("Failed in adding word:" . $Word->Naked . ", error:" . mysqli_error());
			}
			else {
				die("Client validation failed.");
			}
		}
	}
	nikuda_disconnect();
	nikuda_finipage();
?>
