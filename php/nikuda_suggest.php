<?php
	// connect to host DataBase
	mysql_connect("localhost","reemj_doron","doron15")
		or die("Could not connect: " . mysql_error());
	mysql_select_db("reemj_nikuda")
		or die("Could not select DB: " . mysql_error());

	mysql_set_charset("hebrew")
		or die("Could not set Hebrew character set: " . mysql_error());

	// get queried word
	// decode JSON string to php object
	$QueriedWord = $_POST['Word'];

	$Naked = $QueriedWord['Naked'];

	if (strlen($Naked) >= 3) {
		$Reply = array();
		$Reply['Nakeds'] = array();
		$Reply['ID'] = $QueriedWord['ID'];

		// Get word's possible completions from DB
		$GetSuggestions = "SELECT DISTINCT Naked FROM wordlist WHERE Naked LIKE '$Naked%' LIMIT 50"; // add ORDER BY Frequency when this is implemented in DB
		$Nakeds = mysql_query($GetSuggestions)
			or die("Failed in selecting similar words:" . mysql_error());

		// Push the word's punctuations into the word's reply
		while ($Naked = mysql_fetch_array($Nakeds)) {
			array_push($Reply['Nakeds'], $Naked[0]);
		}

		// Echo encoded reply
		echo json_encode($Reply);
	}
?>
