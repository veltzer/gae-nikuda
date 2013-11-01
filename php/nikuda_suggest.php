<?php
	require_once 'utils.php';

	// start the page
	nikuda_initpage();
	// connect to host DataBase
	nikuda_connect();

	// get queried word
	// decode JSON string to php object
	$QueriedWord = $_POST['Word'];

	$Naked = $QueriedWord['Naked'];
	global $link;

	if (strlen($Naked) >= 3) {
		$Reply = array();
		$Reply['Nakeds'] = array();
		$Reply['ID'] = $QueriedWord['ID'];

		// Get word's possible completions from DB
		$GetSuggestions = "SELECT DISTINCT Naked FROM wordlist WHERE Naked LIKE '$Naked%' LIMIT 50"; // add ORDER BY Frequency when this is implemented in DB
		$Nakeds = mysqli_query($link, $GetSuggestions)
			or die("Failed in selecting similar words:" . mysqli_error($link));

		// Push the word's punctuations into the word's reply
		while ($Naked = mysqli_fetch_array($Nakeds)) {
			array_push($Reply['Nakeds'], $Naked[0]);
		}

		// Echo encoded reply
		echo json_encode($Reply);
	}
	nikuda_disconnect();
	nikuda_finipage();
?>
