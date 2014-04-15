<?php
	require_once 'utils.php';

	// connect to host DataBase
	nikuda_connect();
	// do something
	echo "<p>hello</p>";
	// disconnect from the database
	nikuda_disconnect();
?>
