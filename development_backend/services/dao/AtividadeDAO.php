<?php
require_once '../util/DBConnection.php';

class AtividadeDAO {

	public function getAtividades($sprint) 
	{

		$idSprint = $sprint->getId();

		$query = "select * from atividade where idSprint = $idSprint";

		try 
		{
 
			$mySQL = new DBConnection();
			return $mySQL->consulta($query);

		} catch (Exception $e) 
		{

			return $e->getMessage();

		}

	}

	public function createAtividade($atividade) {

		$nome = addslashes($atividade->getNome());
		$descricao = addslashes($atividade->getDescricao());
		$idSprint = addslashes($atividade->getIdSprint());

		$query = "insert into atividade (nome, descricao, status, idSprint) values ('$nome', '$descricao', 'Inicio', '$idSprint');";

		try {

			$mySQL = new DBConnection();
			return $mySQL->genericQuery($query);

		} catch (Exception $e) {

			throw $e->getMessage();

		}

		return $query;

	}

	public function salvarAtividade($atividade) {

		$id = addslashes($atividade->getId());
		$nome = addslashes($atividade->getNome());
		$descricao = addslashes($atividade->getDescricao());
		$idSprint = addslashes($atividade->getIdSprint());
		$status = addslashes($atividade->getStatus());

		$query = "update atividade set nome = '$nome', descricao = '$descricao', status = '$status' where id = $id";

		try {

			$mySQL = new DBConnection();
			return $mySQL->genericQuery($query);

		} catch (Exception $e) {

			throw $e->getMessage();

		}

		return $query;

	}

	public function deletarAtividade($atividade) {

		$id = $atividade->getId();

		$query = "delete from atividade where id = '$id'";

		try {

			$mySQL = new DBConnection();
			return $mySQL->genericQuery($query);

		} catch (Exception $e) {

			throw $e->getMessage();

		}

		return $query;

	}
}
?>