<?PHP
	echo "<p>";
	// connect to host DataBase
	mysql_connect("localhost","mark","")
		or die("Could not connect: " . mysql_error());
	mysql_select_db("nikuda")
		or die("Could not select DB: " . mysql_error());

	mysql_set_charset("utf8")
		or die("Could not set Hebrew character set: " . mysql_error());

	// Get sample Hebrew Word
	echo "Getting a word ('ברוכים')<br/>";
	$GetWord = "SELECT Nikud FROM wordlist WHERE Naked = 'הצרוף'";
	$Nikudot = mysql_query($GetWord)
		or die("Failed in selecting word:" . mysql_error());

	echo "<br/>Results:<br/>";
	while ($Nikud = mysql_fetch_array($Nikudot)) {
		echo $Nikud[0];
		echo "more";
		echo "<br/>";
	}

	echo "<br/>";
	echo "<br/>";

// Get first 100 words
	echo "Getting first 100 words<br/>";
	$GetWord = "SELECT Nikud FROM wordlist Limit 100";
	$Nikudot = mysql_query($GetWord)
		or die("Failed in selecting word:" . mysql_error());

	echo "<br/>Results:<br/>";
	while ($Nikud = mysql_fetch_array($Nikudot)) {
		echo $Nikud[0];
		echo "<br/>";
	}
  
	echo "</p>";
?>
