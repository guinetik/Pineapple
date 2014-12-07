<?php
	
	require_once '../dao/EquipeDAO.php';
	
	class EquipeController
	{
		
		public function salvarEquipe($equipe)
		{
			
			$dao = new EquipeDAO();
			$resultado = $dao->salvarEquipe($equipe);
			
			return $resultado;
			 
		}
		
		public function getAlunosConvidados($equipe)
		{
			
			$dao = new EquipeDAO();
			$resultado = $dao->getAlunosConvidados($equipe);
				
			return $resultado;
			
		}
		
		public function getMeusConvites($usuario)
		{
			
			$dao = new EquipeDAO();
			$resultado = $dao->getMeusConvites($usuario);
			
			return $resultado;
			
		}
		
		public function aceitarConvite($equipe, $id_convite)
		{
			
			$dao = new EquipeDAO();
			$resultado = $dao->aceitarConvite($equipe, $id_convite);
			
			return $resultado;
			
		}
		
		public function recusarConvite($id_convite)
		{
			
			$dao = new EquipeDAO();
			$resultado = $dao->recusarConvite($id_convite);
			return $resultado;
			
		}
		
		public function convidarParaEquipe($equipe, $lider, $user)
		{
			
			$dao = new EquipeDAO();
			$resultado = $dao->convidarParaEquipe($equipe, $lider, $user);
				
			return $resultado;
			
		}
		
		public function getEquipesWhereUserIsLeader($usuario)
		{ 
			
			$dao = new EquipeDAO();
			$equipes = $dao->getEquipesWhereUserIsLeader($usuario);
			
			return $equipes; 
			
		}
		
		public function getEquipes($equipe)
		{ 
			
			$dao = new EquipeDAO();
			$equipes = $dao->getEquipes($equipe);
			
			return $equipes; 
			
		}
		
		public function getItemMembros($equipe)
		{
			
			$dao = new EquipeDAO();
			$equipes = $dao->getItemMembros($equipe);
			
			return $equipes;
			
		}
		
		public function getNomeAlunos()
		{
			
			$dao = new EquipeDAO();
			$equipes = $dao->getNomeAlunos();
			
			return $equipes;
			
		}
		
		public function removeUsuarioFromEquipe($equipe, $usuario)
		{
			
			$dao = new EquipeDAO();
			return $dao->removeUsuarioFromEquipe($equipe, $usuario);
			
		}
		
		public function removerEquipe($equipe, $id)
		{
			
			$dao = new EquipeDAO();
			return $dao->removerEquipe($equipe, $id);
			
		}
		
		public function getNomeEquipe($usuario)
		{
			
			$dao = new EquipeDAO();
			$equipes = $dao->getNomeEquipe($usuario);
			
			return $equipes;
			
		}
		
		public function getNomeEquipeEspecial($equipe)
		{
			
			$dao = new EquipeDAO();
			$equipes = $dao->getNomeEquipeEspecial($equipe);
			
			return $equipes;
			
		}
		
		public function delegarLider($equipe)
		{
			
			$dao = new EquipeDAO();
			$resultado = $dao->delegarLider($equipe);
			
			return $resultado;
			
		}
		
		public function getEquipeById($id_equipe)
		{
			
			$dao = new EquipeDAO();
			$resultado = $dao->getEquipeById($id_equipe);
				
			return $resultado;
			
		}
		
		public function getAllEquipes()
		{
				
			$dao = new EquipeDAO();
			$resultado = $dao->getAllEquipes();
		
			return $resultado;
				
		}
		
	}