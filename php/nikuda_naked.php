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

	// Iterate on words in request
	foreach ($RequestedWords as $Word){
		// Get word's possible punctuations from DB
		$Naked = $Word['Naked'];
		$ID = $Word['ID'];
		$GetWord = 'SELECT Nikud FROM wordlist WHERE Naked = \''.$Naked.'\'';
		$Nikudot = mysqli_query($link, $GetWord)
			or die('Failed in selecting word:' . mysqli_error($link));

		$Nikudim = array();

		// Push the word's punctuations into the word's reply
		while ($Nikud = mysqli_fetch_array($Nikudot)) {
			array_push($Nikudim, $Nikud[0]);
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
