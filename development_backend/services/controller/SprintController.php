<?php
	
	require_once '../dao/SprintDAO.php';
	
	class SprintController
	{
		
		
		public function getSprints($projeto)
		{
			
			$dao = new SprintDAO();
			$sprints = $dao->getSprints($projeto);
			
			return $sprints;
			
		}
		 
		public function salvarSprint($sprint)
		{
			
			$dao = new SprintDAO();
			
			if($sprint->getId() > 0)
			{
				
				$resultado = $dao->salvarSprint($sprint);
				
			} else 
			{
				
				$resultado = $dao->createSprint($sprint);
				
			}
			
			return $resultado;
			
		}
		
		public function deleteSprint($sprint)
		{
			
			$dao = new SprintDAO();
			return $dao->deleteSprint($sprint);
			
		}
		
		public function definirDatas($sprint) 
		{
			
			$dao = new SprintDAO();
			return $dao->definirDatas($sprint);
			
		}
		
		public function alterarStatus($sprint)
		{
			
			$dao = new SprintDAO();
			return $dao->alterarStatus($sprint);
			
		}
		
		
	}

?>
