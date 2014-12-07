<?php

require_once '../dao/LoginDAO.php';

class LoginController
{
	
	public function processarLogin($login, $senha)
	{
			
		$dao = new LoginDAO();
		return $dao->processarLogin($login, $senha);
	
	}
	
}