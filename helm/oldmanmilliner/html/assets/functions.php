<?php
	require_once 'cred.php';

function q($query) {

/*  // *
	$h = "milliner.cbtlze2bnbgy.us-east-1.rds.amazonaws.com";
	$p = 3306;
	$s = "";
	$u = "milliner";
	$w = "ilikehats";
	$n = "oldmanmilliner";
// */
		$c = fetchC();
		$conn = new mysqli($c['h'], $c['u'], $c['w'], $c['n'], $c['p'], $c['s'])
			or die ('Could not connect to the database server' . mysqli_connect_error());
		unset($c);
		$records = $conn->query($query);
		return $records;
	}
?>