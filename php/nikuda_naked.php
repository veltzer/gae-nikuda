<?php
	require_once 'utils.php';

	// start the page
	nikuda_initpage();
	// connect to host DataBase
	nikuda_connect();

	// get queried words
	// decode JSON string to php object
	$RequestedWords = $_POST['Words'];

	$ReplyWords = array();

	global $link;
	$stmt=$link->prepare('SELECT Nikud FROM wordlist WHERE Naked = ?')
		or die('Failed in preparing statement' . mysqli_error($link));

	// Iterate on words in request
	foreach ($RequestedWords as $Word){
		// Get word's possible punctuations from DB
		$Naked = $Word['Naked'];
		$ID = $Word['ID'];

		$stmt->bind_param('s', $Naked);
		$stmt->execute();
		$stmt->bind_result($result);
		$Nikudim = array();
		while($stmt->fetch()) {
			array_push($Nikudim, $result);
		}

		$ReplyWord = array();
		$ReplyWord['ID'] = $ID;
		$ReplyWord['Naked'] = $Naked;
		$ReplyWord['Nikudim'] = $Nikudim;
		// Push the reply word into the reply
		array_push($ReplyWords, $ReplyWord);
	}

	// Echo encoded reply
	echo json_encode($ReplyWords);

	nikuda_disconnect();
	nikuda_finipage();
?>
