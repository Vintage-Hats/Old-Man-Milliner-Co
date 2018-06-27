<?php		
	$h = "milliner.cbtlze2bnbgy.us-east-1.rds.amazonaws.com";
	$p = 3306;
	$s = "";
	$u = "milliner";
	$w = "ilikehats";
	$n = "oldmanmilliner";

	function q($query) {
		$conn = new mysqli($h, $u, $w, $n, $p, $cs)
			or die ('Could not connect to the database server' . mysqli_connect_error());
		$records = $conn->query($query);
		return $records;
	}
?>
