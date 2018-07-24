<?php
	require_once 'cred.php';

	function q($query) {
		$c = fetchC();
		$conn = new mysqli($c['h'], $c['u'], $c['w'], $c['n'], $c['p'], $c['s'])
			or die ('Could not connect to the database server' . mysqli_connect_error());
		unset($c);
		$records = $conn->query($query);
		return $records;
	}
?>
