<?php
	
	require_once '../util/DBConnection.php';
	require_once '../basicas/Usuario.php';

	class UsuarioDAO
	{
		
		public function getUsuarios($usuario)
		{
				
			$nome = $usuario->getNome();
			$query = "select * from usuario where nome ='$nome'";
			
			try
			{
				
				$mySQL = new DBConnection();
				return $mySQL->consulta($query);
				
			} catch (Exception $e) 
			{
				
				throw $e->getMessage();
				
			}
			
			return $query;
				
		}
		
		public function getUsuarioById($id)
		{
				
			$query = "select * from usuario where id = $id";
			
			try
			{
				
				$mySQL = new DBConnection();
				return $mySQL->consulta($query);
				
			} catch (Exception $e) 
			{
				
				return $e->getMessage();
				
			}
				
		}
		
		public function inserirUsuario($usuario)
		{
			
			if($usuario->getNome() != null && $usuario->getNome() != "")
			{
				
				$query 	= "insert into usuario (login, matricula, senha, nome, entidade, email) values (";
				$query .= "'" . addslashes($usuario->getLogin()) . "', ";
				$query .= "'" . addslashes($usuario->getMatricula()) . "', ";
				$query .= "'" . addslashes($usuario->getMatricula()) . "', ";
				$query .= "'" . addslashes($usuario->getNome()) . "', ";
				$query .= "'" . addslashes($usuario->getEntidade()) . "', ";
				$query .= "'" . addslashes($usuario->getEmail()) . "'); ";
				
				try
				{
					
					$mySQL = new DBConnection();
					return $mySQL->genericQuery($query);
					
				} catch (Exception $e) 
				{
					
					return $e->getMessage();
					
				}
				
			} else return true;
			
		}
		
		public function getProfessores()
		{
			
			$query = "select * from usuario where entidade = 'professor'";
				
			try
			{
			
				$mySQL = new DBConnection();
				return $mySQL->consulta($query);
			
			} catch (Exception $e)
			{
			
				throw $e->getMessage();
			
			}
				
			return $query;
			
		}
		
		public function getListaUsuarios()
		{
				
			$query = "select * from usuario";
			
			try
			{
				
				$mySQL = new DBConnection();
				return $mySQL->consulta($query);
				
			} catch (Exception $e) 
			{
				
				throw $e->getMessage();
				
			}
			
			return $query;
				
		}
		
		public function getPermissoesUsuario($usuario)
		{
			
			$login = $usuario->getLogin();
			$query = "select nome_permissao from permissao_usuario where login = '$login'";
			
			try
			{
				
				$mySQL = new DBConnection();
				return $mySQL->consulta($query);
				
			} catch (Exception $e) 
			{
				
				throw $e->getMessage();
				
			}
			
			return $query;
			
		}
		
		public function editarUsuario($usuario,  $nomeUsuario)
		{
			
			$nome = addslashes($usuario->getNome());
			$email = addslashes($usuario->getEmail());
			$senha = addslashes($usuario->getSenha());
			$mensagem = addslashes($usuario->getMensagem());
			$login = addslashes($usuario->getLogin());
			$imagem = addslashes($usuario->getImagem());			
			
			$query = "update usuario set ";
			$query .= "nome = '$nome', ";
			$query .= "email = '$email', ";
			$query .= "senha = '$senha', ";
			$query .= "mensagem = '$mensagem', ";
			$query .= "login = '$login', ";
			$query .= "imagem = '$imagem'";
			$query .= "WHERE login = '$login'";
			
			$query2 = "update equipe_usuario SET nomemembro = '$nome' WHERE nomeMembro = '$nomeUsuario'";
//			$query2 = "select * from equipe_usuario WHERE nomemembro = '$nomeUsuario'";
			
			try 
			{
			
				$mySQL = new DBConnection();
				if ($mySQL->genericQuery($query)) return $mySQL->genericQuery($query2);
				else return false;
			
			} catch (Exception $e) 
			{
			
				return $e->getMessage();
			
			}
			
		}
		
		public function inserirPermissao($usuario) {

		$login = addslashes($usuario->getLogin());
		$permissao = addslashes($usuario->getPermissao());

		$query = "insert into permissao_usuario (login, nome_permissao) values ('$login', '$permissao')";

		try {

			$mySQL = new DBConnection();
			return $mySQL->genericQuery($query);

		} catch (Exception $e) {

			throw $e->getMessage();

		}

		return $query;

	}
		
		
		
		
	}