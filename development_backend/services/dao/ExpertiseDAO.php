<?php
	
	require_once '../util/DBConnection.php';

	class ExpertiseDAO
	{
		
		public function getExpertises()
		{
				
			$query = "select * from expertises";
			
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
		
		public function getExpertisesUsuario($expertise)
		{
			
			$login = $expertise->getLogin();
			$query = "select e.* from expertises e INNER JOIN expertise_usuario u ON e.id = u.id_expertise WHERE u.login = '$login'";
			
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
		
		public function saveExpertise($expertise)
		{
			
			$nome = addslashes($expertise->getNome());
			$color = addslashes($expertise->getColor());
			$query = "insert into expertises (nome, color) values ('$nome', '$color')";
			
			try
			{
			
				$mySQL = new DBConnection();
				if($mySQL->genericQuery($query))
				{
					
					return mysql_insert_id();
					
				} else return false;
			
			} catch(Exception $e)
			{
			
				return $e->getMessage();
			
			}
			
		}
		
		public function addExpertiseToUsuario($expertise)
		{
			
			$id = $expertise->getId();
			$login = addslashes($expertise->getLogin());
			$query = "insert into expertise_usuario (id_expertise, login) values ('$id', '$login')";
			
			try
			{
				
				$mySQL = new DBConnection();
				return $mySQL->genericQuery($query);
				
			} catch(Exception $e)
			{
				
				return $e->getMessage();
				
			}
			
		}
			
		public function removeExpertiseFromUsuario($expertise)
		{
			
			$id = $expertise->getId();
			$login = $expertise->getLogin();
			
			$query = "DELETE FROM expertise_usuario WHERE id_expertise = $id AND login = '$login'";
				
			try
			{
			
				$mySQL = new DBConnection();
				return $mySQL->genericQuery($query);
			
			} catch(Exception $e)
			{
			
				return $e->getMessage();
			
			}
			
		}
		
	}