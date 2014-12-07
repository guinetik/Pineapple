<?php
	
	require_once '../dao/ExpertiseDAO.php';
	
	class ExpertiseController
	{
		
		
		public function getExpertises()
		{
			
			$dao = new ExpertiseDAO();
			$expertises = $dao->getExpertises();
			
			return $expertises; 
			
		} 
		
		public function getExpertisesUsuario($expertise)
		{
			
			$dao = new ExpertiseDAO();
			$expertises = $dao->getExpertisesUsuario($expertise);
			
			return $expertises;
			
		}
		
		public function addExpertiseToUsuario($expertise)
		{
			
			$dao = new ExpertiseDAO();
			$resultado = $dao->addExpertiseToUsuario($expertise);
			
			return $resultado;
			
		}
		
		public function saveExpertise($expertise)
		{
			
			$dao = new ExpertiseDAO();
			$resultado = $dao->saveExpertise($expertise);
				
			return $resultado;
			
		}
		
		public function removeExpertiseFromUsuario($expertise)
		{
			
			$dao = new ExpertiseDAO();
			$resultado = $dao->removeExpertiseFromUsuario($expertise);
			
			return $resultado;
			
		}
		
	}