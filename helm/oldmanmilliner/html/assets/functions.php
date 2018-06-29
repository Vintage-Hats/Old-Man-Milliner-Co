<?php
	if (!function_exists('mysqli_init') && !extension_loaded('mysqli')) {
	    echo 'We don\'t have mysqli!!!';
	} else {
		function q($query) {		
			$h = "milliner.cbtlze2bnbgy.us-east-1.rds.amazonaws.com";
			$p = 3306;
			$s = "";
			$u = "milliner";
			$w = "ilikehats";
			$n = "oldmanmilliner";
			$conn = new mysqli($h, $u, $w, $n, $p, $s);
			$records = $conn->query($query);
			return $records;
		}
	}
?>
