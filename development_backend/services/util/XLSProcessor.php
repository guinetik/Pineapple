<?php

require_once ('../excel_reader2.php');
require_once ('../basicas/Usuario.php');
require_once ('../controller/UsuarioController.php');

class XLSProcessor 
{

	public function processarXLS($caminho) 
	{

		$data = new Spreadsheet_Excel_Reader($caminho);
		$result = $data -> dumpToAssocArray();
		$retorno = true;
		
		foreach ($result as $key => $value)
		{
			
			if($retorno)
			{
				
				$login = addslashes($value["login"]);
				$matricula = addslashes($value["matricula"]);
				$nome = addslashes($value["nome"]);
				$entidade = addslashes($value["entidade"]);
				$email = addslashes($value["email"]);			
				
				$usuario = new Usuario();
				$usuario->setLogin($login);
				$usuario->setMatricula($matricula);
				$usuario->setNome($nome);
				$usuario->setEntidade($entidade);
				$usuario->setEmail($email);
				
				$controller = new UsuarioController();
				$retorno = $controller->inserirUsuario($usuario);
				
			} else 
			{
				
				return $retorno;
				
			}
			
		}
		
		return $retorno;

	}

}
?>
