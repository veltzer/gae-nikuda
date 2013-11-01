<?php
	require_once 'utils.php';

	// start the page
	nikuda_initpage();
	// connect to host DataBase
	nikuda_connect();
	// do something
	echo "<p>hello</p>";
	// disconnect from the database
	nikuda_disconnect();
	// finish the page
	nikuda_finipage();
?>
