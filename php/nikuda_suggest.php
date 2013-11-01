<?php
	require_once 'utils.php';

	// decode JSON string to php object
	$QueriedWord = $_POST['Word'];
	// get queried word
	$Naked = $QueriedWord['Naked'];

	if (strlen($Naked) >= 3) {
		// start the page
		nikuda_initpage();
		// connect to host DataBase
		nikuda_connect();

		global $link;
		$Reply = array();
		$Reply['Nakeds'] = array();
		$Reply['ID'] = $QueriedWord['ID'];

		// Get word's possible completions from DB
		// add ORDER BY Frequency when this is implemented in DB
		$stmt=$link->prepare('SELECT DISTINCT Naked FROM wordlist WHERE Naked LIKE ? LIMIT 50')
			or die('Failed in preparing statement' . mysqli_error($link));
		$Naked.='%';
		$stmt->bind_param('s', $Naked);
		$stmt->execute();
		$stmt->bind_result($result);

		// Push the word's punctuations into the word's reply
		while($stmt->fetch()) {
			array_push($Reply['Nakeds'], $result);
		}

		// Echo encoded reply
		echo json_encode($Reply);

		nikuda_disconnect();
		nikuda_finipage();
	} else {
		header('HTTP/1.1 500 Internal Server Fatal Error', true, 500);
		exit(0);
	}
?>
