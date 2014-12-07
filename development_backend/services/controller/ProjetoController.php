<?php

require_once '../basicas/Usuario.php';
require_once '../dao/ProjetoDAO.php';
require_once '../dao/UsuarioDAO.php';
require_once '../phpmailer/class.phpmailer.php';

class ProjetoController
{

	public function cadastrarProjeto($projeto)
	{
			
		$dao = new ProjetoDAO();
		$resultado = $dao->cadastrarProjeto($projeto);
			
		return $resultado;
			
	}
	
	public function getAllProjects()
	{
		
		$dao = new ProjetoDAO();
		$resultado = $dao->getAllProjects($projeto);
			
		return $resultado;
		
	}
	
	public function getSolicitacoesMudanca($usuario)
	{
		
		$dao = new ProjetoDAO();
		$resultado = $dao->getSolicitacoesMudanca($usuario);
			
		return $resultado;
		
	}
	
	public function reenviarSolicitacao($id_orientacao)
	{
		
		$dao = new ProjetoDAO();
		$resultado = $dao->reenviarSolicitacao($id_orientacao);
			
		return $resultado;
		
	}
	
	public function deletarProjeto($projeto)
	{
		
		$dao = new ProjetoDAO();
		$resultado = $dao->deletarProjeto($projeto);
			
		return $resultado;
		
	}
	
	public function solicitarOrientacao($id_projeto, $nome_projeto, $nome_equipe, $nome_professor, $email_professor, $id_equipe, $id_professor)
	{
		
		$dao = new ProjetoDao();
		return $dao->solicitarOrientacao($id_projeto, $nome_projeto, $nome_equipe, $nome_professor, $email_professor, $id_equipe, $id_professor);
		
	}
	
	public function solicitarMudanca($id_orientacao)
	{
		
		$dao = new ProjetoDao();
		return $dao->solicitarMudanca($id_orientacao);
		
	}
		
	
	public function getOrientacoesByProfessor($id_professor)
	{
		
		$dao = new ProjetoDAO();
		return $dao->getOrientacoesByProfessor($id_professor);
		
	}

	public function orientarProjeto($projeto)
	{
			
		$dao = new ProjetoDAO();
		$resultado = $dao->orientarProjeto($projeto);
			
		return $resultado;
			
	}
	
	public function recusarOrientacao($id_orientacao)
	{
		
		$dao = new ProjetoDAO();
		$resultado = $dao->recusarOrientacao($id_orientacao);
			
		return $resultado;
		
	}

	public function definirDatas($projeto)
	{
			
		$dao = new ProjetoDAO();
		$resultado = $dao->definirDatas($projeto);
			
		return $resultado;
			
	}

	public function getProjetos()
	{
			
		$dao = new ProjetoDAO();
		$projetos = $dao->getProjetos();
			
		return $projetos;
			
	}

	public function getUltimasIdeias()
	{

		$dao = new ProjetoDAO();
		$projetos = $dao->getUltimasIdeias();

		return $projetos;

	}

	public function getMinhasIdeias($usuario)
	{

		$dao = new ProjetoDAO();
		$projetos = $dao->getMinhasIdeias($usuario);

		return $projetos;

	}
	
	public function alterarStatus($projeto)
	{
		
		$dao = new ProjetoDAO();
		return $dao->alterarStatus($projeto);
		
	}

	public function getProjetosProfessor($usuario)
	{
			
		$dao = new ProjetoDAO();
		$projetos = $dao->getProjetosProfessor($usuario);
			
		return $projetos;
			
	}
	
	public function getProjetosById($id_projeto)
	{
		
		$dao = new ProjetoDAO();
		$projetos = $dao->getProjetosById($id_projeto);
			
		return $projetos[0];
		
	}

	public function getProjetosEquipe($equipe)
	{
			
		$dao = new ProjetoDAO();
		$projetos = $dao->getProjetosEquipe($equipe);
			
		return $projetos;
			
	}

	public function editarProjeto($projeto)
	{
			
		$dao = new ProjetoDAO();
		return $dao->editarProjeto($projeto);
			
	}
	
	public function isProfessorOrientador($login, $id_projeto)
	{
		
		$dao = new ProjetoDAO();
		return $dao->isProfessorOrientador($login, $id_projeto);
		
	}
	
	public function doesIdeiaHasOrientationRequest($id_ideia, $id_equipe, $id_professor)
	{
		
		$dao = new ProjetoDAO();
		return $dao->doesIdeiaHasOrientationRequest($id_ideia, $id_equipe, $id_professor);
		
	}


}

?>