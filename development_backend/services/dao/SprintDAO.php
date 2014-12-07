<?php
	
	require_once '../util/DBConnection.php';

	class SprintDAO
	{
		
			public function getSprints($projeto) {

		$idProjeto = $projeto->getId();

		$query = "select * from sprint where idProjeto = $idProjeto ORDER BY datacadastro ASC";

		try {

			$mySQL = new DBConnection();
			return $mySQL->consulta($query);

		} catch (Exception $e) {

			throw $e->getMessage();

		}

		return $query;

	}
		
		public function createSprint($sprint)
		{
			
			
			$query 	= "insert into sprint (nome, descricao, dataInicio, dataFim, idProjeto, status) values (";
			$query .= "'" . addslashes($sprint->getNome()) . "', ";
			$query .= "'" . addslashes($sprint->getDescricao()) . "', ";
			$query .= "'" . addslashes($sprint->getDataInicio()) . "', ";
			$query .= "'" . addslashes($sprint->getDataFim()) . "', ";
			$query .= "'" . addslashes($sprint->getIdProjeto()) . "', ";
			$query .= "'Inicio');";
			
			try
			{
				
				$mySQL = new DBConnection();
				return $mySQL->genericQuery($query);
				
			} catch (Exception $e) 
			{
				
				return $e->getMessage();
				
			}
			
		}
		
		public function alterarStatus($sprint)
	{
		
		$id = $sprint->getId();
		$status = $sprint->getStatus();
		$query = "UPDATE sprint SET sprint.status ='$status' WHERE sprint.id = $id";
		
		try
		{
			$mySQL = new DBConnection();
			return $mySQL->genericQuery($query);
		
		} catch (Exception $e) {
		
			return $e->getMessage();
		
		}
		
	}
		
		public function definirDatas($sprint) {

		$id = $sprint->getId();
		$dataInicio = $sprint->getDataInicio();
		$dataFim = $sprint->getDataFim();

		$query = "UPDATE sprint SET sprint.dataInicio ='$dataInicio', sprint.dataFim = '$dataFim' WHERE sprint.id = $id";
		
		try 
		{
			$mySQL = new DBConnection();
			return $mySQL->genericQuery($query);

		} catch (Exception $e) {

			return $e->getMessage();

		}

	}
		
		public function deleteSprint($sprint)
		{
			
			$id = $sprint->getId();
			$query = "delete from sprint where id = $id";
			$query2 = "delete from atividade where idSprint = $id";
	
			try 
			{
	
				$mySQL = new DBConnection();
				if($mySQL->genericQuery($query))
				{
					
					return $mySQL->genericQuery($query2);
					
				} else 
				{
					
					return false;
					
				}
	
			} catch (Exception $e) {
	
				return $e->getMessage();
	
			}
	
		}
		
		
		
		public function salvarSprint($sprint)
		{
			
			$result = false;
			
			$query = "update sprint set ";
			$query .= "nome = '" . addslashes($sprint->getNome()) . "', ";
			$query .= "descricao = '" . addslashes($sprint->getDescricao()) . "', ";
			$query .= "status = '" . addslashes($sprint->getStatus()) . "', ";
			$query .= "dataInicio = '" . addslashes($sprint->getDataInicio()) . "', ";
			$query .= "dataFim = '" . addslashes($sprint->getDataFim()) . "'";
			$query .= "WHERE id = " . addslashes($sprint->getId());
			
			
			try
			{
				
				$mySQL = new DBConnection();
				return $mySQL->genericQuery($query);
				
			} catch (Exception $e) 
			{
				
				$result = $e->getMessage();
				
			}
			
			return $result;
			
		}
		
	}

?>
