<?php
	function q($query) {		
		$h = "milliner.cbtlze2bnbgy.us-east-1.rds.amazonaws.com";
		$p = 3306;
		$s = "";
		$u = "milliner";
		$w = "ilikehats";
		$n = "oldmanmilliner";
		$conn = new mysqli($h, $u, $w, $n, $p, $s)
			or die ('Could not connect to the database server' . mysqli_connect_error());
		$records = $conn->query($query);
		return $records;
	}
?>
