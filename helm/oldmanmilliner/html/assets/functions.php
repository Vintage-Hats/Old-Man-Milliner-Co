<?php
	$local = 1;
	/* set credFlipper equal...
		... to 1 to use cred located in the assets folder
		... to 2 to use cred located in the html folder
		... to 3 to use cred located in the www folder
		... to anything but 1 - 3 to use locally provided creds
	*/

	$credFlipper = 0;
	switch ($credFlipper) {
		case 1: require_once 'cred.php'; 	break;
		case 2: require_once '../cred.php';	break;
		case 3: require_once '../../cred.php';	break;
		default: $local = 0;
	}

	if($local) {
		function q($query) {
			$c = fetchC();
			$conn = new mysqli($c['h'], $c['u'], $c['w'], $c['n'], $c['p'], $c['s'])
				or die ('Could not connect to the database server' . mysqli_connect_error());
			unset($c);
			$records = $conn->query($query);
			return $records;
		}
	} else {		
		$h = "milliner.cbtlze2bnbgy.us-east-1.rds.amazonaws.com";
		$p = 3306;
		$s = "";
		$u = "milliner";
		$w = "ilikehats";
		$n = "oldmanmilliner";
		
		function q($query) {
			$c = fetchC();
			$conn = new mysqli($h, $u, $w, $n, $p, $cs)
				or die ('Could not connect to the database server' . mysqli_connect_error());
			unset($c);
			$records = $conn->query($query);
			return $records;
		}
	}
?>
