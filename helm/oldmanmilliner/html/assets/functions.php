<?php
	try {
		$pdo = new PDO('mysql:host = localhost; dbname=oldManMilliner', 'dave', 'pass');
	}
	catch(PDOException $e) {
		echo "Unable to connect to the database server.";
		exit();
	}
?>