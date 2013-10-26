<?PHP
	// connect to host DataBase
	mysql_connect("localhost","reemj_doron","doron15")
		or die("Could not connect: " . mysql_error());
	mysql_select_db("reemj_nikuda")
		or die("Could not select DB: " . mysql_error());

	mysql_set_charset("hebrew")
		or die("Could not set Hebrew character set: " . mysql_error());

	// get queried words
	// decode JSON string to PHP object
	$RequestedWords = $_POST['Words'];

	$ReplyWords = array();

	// Iterate on words in request
	foreach ($RequestedWords as $Word){
		// Get word's possible punctuations from DB
		$Naked = $Word['Naked'];
		$ID = $Word['ID'];
		$GetWord = "SELECT Nikud FROM wordlist WHERE Naked = '$Naked'";
		$Nikudot = mysql_query($GetWord)
			or die("Failed in selecting word:" . mysql_error());

		$Nikudim = array();

		// Push the word's punctuations into the word's reply
		while ($Nikud = mysql_fetch_array($Nikudot)) {
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
?>