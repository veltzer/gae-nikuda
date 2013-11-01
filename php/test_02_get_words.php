<?php
	require_once 'utils.php';

	// start the page
	nikuda_initpage();
	// connect to host DataBase
	nikuda_connect();

	echo "<p>";
	// Get sample Hebrew Word
	echo "Getting a word ('ברוכים')<br/>";
	$GetWord = "SELECT Nikud FROM wordlist WHERE Naked = 'הצרוף'";
	global $link;
	$Nikudot = mysqli_query($link, $GetWord)
		or die("Failed in selecting word:" . mysqli_error());

	echo "<br/>Results:<br/>";
	while ($Nikud = mysqli_fetch_array($Nikudot)) {
		echo $Nikud[0];
		echo "<br/>";
	}

	echo "<br/>";
	echo "<br/>";

	// Get first 100 words
	echo "Getting first 100 words<br/>";
	$GetWord = "SELECT Nikud FROM wordlist Limit 100";
	$Nikudot = mysqli_query($link, $GetWord)
		or die("Failed in selecting word:" . mysqli_error());

	echo "<br/>Results:<br/>";
	while ($Nikud = mysqli_fetch_array($Nikudot)) {
		echo $Nikud[0];
		echo "<br/>";
	}
  
	echo "</p>";

	// disconnect from the database
	nikuda_disconnect();
	// finish the page
	nikuda_finipage();
?>
