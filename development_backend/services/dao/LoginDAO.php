<?php

require_once '../util/DBConnection.php';

class LoginDAO
{

	public function processarLogin($login, $senha)
	{

		$query = "SELECT * FROM `usuario` WHERE login = '$login' AND senha = '$senha'";

		try {

			$mySQL = new DBConnection();
			return $mySQL->consulta($query);

		} catch (Exception $e) {

			throw $e->getMessage();

		}

		return $query;

	}

}