<?php

/* CONNECT TO LOCALHOST toggle *

	$conn = new mysqli("localhost", "dave", "pass", "oldManMilliner");
		
// */ // END CONNECT TO LOCALHOST

/* CONNECT TO OMM toggle */

	$dbhost="milliner.cbtlze2bnbgy.us-east-1.rds.amazonaws.com";
	$dbport=3306;
	$dbsckt="";
	$dbuser="milliner";
	$dbpass="ilikehats";
	$dbname="oldmanmilliner";

	$conn = new mysqli($dbhost, $dbuser, $dbpass, $dbname, $dbport, $dbsckt)
		or die ('Could not connect to the database server' . mysqli_connect_error());
	
	$q = "SELECT * FROM hats;";
	$records = $conn->query($q);
	
// */ // END CONNECT TO OMM

/* TEST 01: DESCRIBE CONNECTION toggle *
	
	if ($conn->connect_error) {
		echo var_dump(get_object_vars($conn->connect_error));
		die($connection->connect_error);
	} else {
		echo "<p>". var_dump(get_object_vars($conn)) ."</p>";
		echo "<p>host info: " . mysqli_get_host_info($conn) . PHP_EOL ."</p>";
	}

// */ // END DESCRIBE OBJECT

/* TEST 02: DESCRIBE RECORDS toggle *

	$rows = $records->num_rows;
	// parse and display data
	for ($i = 0; $i < $rows; ++$i ) {
		$records->data_seek($i);
		$record = $records->fetch_array(MYSQLI_ASSOC);
		echo $record['id'].": ".$record['hatName']."<br>";
	}

// */ // END DESCRIBE RECORDS




?>