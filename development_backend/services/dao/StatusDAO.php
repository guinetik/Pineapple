<?php
require_once '../util/DBConnection.php';

class StatusDAO {

	public function getStatus() {

		$query = "select * from status";

		try {

			$mySQL = new DBConnection();
			return $mySQL->consulta($query);

		} catch (Exception $e) {

			throw $e->getMessage();

		}

		return $query;

	}
}
?>