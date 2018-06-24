<?php
    
    if (isset($_POST['testPost'])) {
		$where = ''; 	// WHERE portion of the server call
		$nArrays = 0;	// Count the number of form arrays used by the visitor
		
		// count the number of elements in each form array
		$nStyles    = isset($_POST['styles'])    ? count($_POST['styles'])    : 0;
		$nColors    = isset($_POST['colors'])    ? count($_POST['colors'])    : 0;
		$nSizes     = isset($_POST['sizes'])     ? count($_POST['sizes'])     : 0;
		$nMaterials = isset($_POST['materials']) ? count($_POST['materials']) : 0;

		
		if($nStyles) { 									// if nStyles is truth-y, then ... 
			$i = 1; ++$nArrays; 						// ... set i to 1, increment nArrays, then ...
			if($nStyles > 1) $where .= "(";				// ... check if the styles should be enclosed in parenthesis.
			foreach($_POST['styles'] as $style) {		// each style selected 
				$where .= "style = '" . $style . "'";	// add the current selected style to the string
				if($i < $nStyles) {						// If i is less than nStyles ...
					$where .= " OR ";					// ... then add an OR 
				}
				++$i;
			}
			if($nStyles > 1) $where .= ")";
		}

		if($nStyles && ($nColors OR $nSizes OR $nMaterials)) $where .= " AND ";

		if($nColors) {
			$i = 1; ++$nArrays;
			if($nColors > 1) $where .= "(";
			foreach($_POST['colors'] as $color) {
				$where .= "color = '" . $color . "'";
				if($i < $nColors) {
					$where .= " OR ";
				}
				++$i;
			}
			if($nColors > 1) $where .= ")";
		}

		if($nColors && ($nSizes OR $nMaterials)) $where .= " AND ";
		
		if($nSizes) {
			$i = 1; ++$nArrays;
			if($nSizes > 1) $where .= "(";
			foreach($_POST['sizes'] as $size) {
				$where .=  $size . " > 0";
				if($i < $nSizes) {
					$where .= " OR ";
				}
			++$i;
			}
			if($nSizes > 1) $where .= ")";
		}

		if($nSizes && $nMaterials) $where .= " AND ";

		if($nMaterials) {
			$i = 1; ++$nArrays;
			if($nMaterials > 1) $where .= "(";
			foreach($_POST['materials'] as $material) {
				$where .= "material = '" . $material . "'";
				if($i < $nMaterials) {
					$where .= " OR ";
				}
				++$i;
			}
			if($nMaterials > 1) $where .= ")";
		}

		if($nArrays > 1) {
			$where = "(" . $where . ")";
		}
		$query = "SELECT * FROM hats LEFT JOIN inventory ON (hats.id = inventory.hatID) WHERE " . $where . " ORDER BY hats.hatName;";
/* [t] TROUBLESHOOTING: display the string before it gets sent to get hats. * // FIXME: remove echo before going to production
		echo $query;
// */ // END TROUBLESHOOTING
    }
    else {
        $query = "SELECT * FROM hats LEFT JOIN inventory ON (hats.id = inventory.hatID) ORDER BY hats.hatName;";
	}
	
    $records = q($query);
    $rows = $records->num_rows;
    for($i = 0; $i < $rows; ++$i) {
        $records->data_seek($i);
        $record = $records->fetch_array(MYSQLI_ASSOC);
        $crown = ''; $brim = '';
        if($record['crown']) $crown = "                  <li>Crown height: " . $record['crown'] . "&quot;</li>\n";
        if($record['brim'])  $brim  = "                  <li>Brim width: " . $record['brim'] . "&quot;</li>\n";
        echo "          <div class='product'>\n";
        echo "              <h3>" . $record['hatName'] . " from " . $record['label'] . "</h3>\n";
        echo "              <img class='smIMG' src='images/" . $record['image'] . "'>\n";
        echo "              " . $record['description'];
        echo "                  <li>Style: " . $record['style'] . "</li>\n";
        echo "                  <li>Material: " . $record['material'] . "</li>\n";
        echo $crown;
        echo $brim;
		echo "                  <li>Color: " . $record['color'] . "</li>\n";
		echo "				</ul>\n<br>\n";
		echo "				<div>\n";
		echo " 					<p class='sizes'>Small  | Medium  | Large  | X-large   </p>";
		echo "					<p class='price'>$" . $record['price'] . "</p>\n";
		echo "				</div>\n";
        echo "          </div>\n";
    }

?>