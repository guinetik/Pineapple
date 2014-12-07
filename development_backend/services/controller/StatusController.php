<?php
require_once '../dao/StatusDAO.php';

class StatusController {

	public function getStatus() {

		$dao = new StatusDAO();
		$status = $dao->getStatus();

		return $status;

	}
 
	}
?>
