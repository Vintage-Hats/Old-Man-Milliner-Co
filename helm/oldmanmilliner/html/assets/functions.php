<?php

	/* set credFlipper equal...
		... to 1 to use cred located in the assets folder
		... to 2 to use cred located in the html folder
		... to 3 to use cred located in the www folder
	*/

	$credFlipper = 1;
	switch ($credFlipper) {
		case 1: require_once 'cred.php'; 	break;
		case 2: require_once '../cred.php';	break;
		case 3: require_once '../../cred.php';	break;
	}


	function q($query) {
		$c = fetchC();
		$conn = new mysqli($c['h'], $c['u'], $c['w'], $c['n'], $c['p'], $c['s'])
			or die ('Could not connect to the database server' . mysqli_connect_error());
		unset($c);
		$records = $conn->query($query);
		return $records;
	}
?>
