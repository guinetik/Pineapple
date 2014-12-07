<?php
require_once '../util/DBConnection.php';

class ComentarioDAO {
	
	public function getComentarios($projeto) 
	{

		$idProjeto = $projeto->getId();	

		$query = "select c.*, u.imagem from comentario c inner join usuario u on c.autor = u.nome where c.idProjeto = $idProjeto order by c.dataCadastro DESC";
 
		try {

			$mySQL = new DBConnection();
			return $mySQL->consulta($query);

		} catch (Exception $e) {

			throw $e->getMessage();

		}
		
		return $query;

	}
	
	public function getUltimosComentarios($usuario)
	{
		
		$query = "select pr.nome as Projeto,c.*,u.imagem from equipe_usuario eu inner join equipe eq on(eu.nomeEquipe = eq.nome) inner join projeto pr on(pr.equipe = eq.nome) inner join comentario c ON c.idProjeto = pr.id inner join usuario u ON u.nome = c.autor where eu.nomeMembro = '$usuario' order by c.dataCadastro DESC LIMIT 5";
		
		try {
		
			$mySQL = new DBConnection();
			return $mySQL->consulta($query);
		
		} catch (Exception $e) {
		
			return $e->getMessage();
		
		}
		
	}
	
	public function getUltimosComentariosByProfessor($usuario)
	{
		
		$login = $usuario->getLogin();
		
		$query = "SELECT c . * , u.imagem, pr.nome AS Projeto FROM comentario c INNER JOIN projeto pr ON c.idprojeto = pr.id INNER JOIN usuario u ON u.nome = c.autor WHERE pr.orientador =  '$login' ORDER BY c.dataCadastro DESC  LIMIT 3";
		
		try {
		
			$mySQL = new DBConnection();
			return $mySQL->consulta($query);
		
		} catch (Exception $e) {
		
			return $e->getMessage();
		
		}
		
	}

	public function salvarComentario($comentario) {

		$descricao = addslashes($comentario->getDescricao());
		$idProjeto = addslashes($comentario->getIdProjeto());
		$autor = addslashes($comentario->getAutor());

		$query = "insert into comentario (descricao, idProjeto, autor) values ('$descricao', $idProjeto, '$autor')";

		try 
		{

			$mySQL = new DBConnection();
			return $mySQL->genericQuery($query);
			
		} catch (Exception $e) {

			$result = $e->getMessage();
			return $result;

		}

	}

}
?>
