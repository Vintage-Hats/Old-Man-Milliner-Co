<?php
	require_once '/var/www/html/cred.php';

/*[t] CONNECTION TOGGLE :: FIXME: remove for production*/
	// LOCALHOST 
	function q($query) {
		$c = getC("1");
		$conn = new mysqli($c[0], $c[1], $c[2], $c[3]);
		unset($c);
		$records = $conn->query($query);
		return $records;
	}

	/*/

	// OMM
	function q($query) {
		$c = getC("0"); //FIXME: change to no longer send an argument
		$conn = new mysqli($c['h'], $c['u'], $c['w'], $c['n'], $c['p'], $c['s'])
			or die ('Could not connect to the database server' . mysqli_connect_error());
		unset($c);
		$records = $conn->query($query);
		return $records;
	}

// */ // END CONNECTION TOGGLE

/* TEST: DESCRIBE RECORDS toggle *

	$rows = $records->num_rows;
	// parse and display data
	for ($i = 0; $i < $rows; ++$i ) {
		$records->data_seek($i);
		$record = $records->fetch_array(MYSQLI_ASSOC);
		echo $record['id'].": ".$record['hatName']."<br>";
	}

// */ // END DESCRIBE RECORDS

?>
