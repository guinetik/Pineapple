<?php
require_once '../dao/ComentarioDAO.php';

class ComentarioController {

	public function getComentarios($projeto) {

		$dao = new ComentarioDAO();
		$comentarios = $dao->getComentarios($projeto);

		return $comentarios;
 
	}

	public function salvarComentario($comentario) {

		$dao = new ComentarioDAO();
		$resultado = $dao->salvarComentario($comentario);

		return $resultado;

	}
	
	public function getUltimosComentariosByProfessor($usuario)
	{
		
		$dao = new ComentarioDAO();
		$resultado = $dao->getUltimosComentariosByProfessor($usuario);
		return $resultado;
		
	}
	
	public function getUltimosComentarios($usuario)
	{
		
		$dao = new ComentarioDAO();
		$resultado = $dao->getUltimosComentarios($usuario);
		return $resultado;
		
	}
}
?>
