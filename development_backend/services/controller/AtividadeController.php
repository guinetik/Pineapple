<?php
require_once '../dao/AtividadeDAO.php';

class AtividadeController
{

	public function getAtividades($sprint)
	{

		$dao = new AtividadeDAO();
		$atividades = $dao->getAtividades($sprint);
		return $atividades;

	}
	
	public function createAtividade($atividade)
	{
		
		$dao = new AtividadeDAO();
		return $dao->createAtividade($atividade);
		
	}

	public function salvarAtividade($atividade) 
	{

		$dao = new AtividadeDAO();

		if ($atividade->getId() > 0) {

			$resultado = $dao->salvarAtividade($atividade);

		} else {

			$resultado = $dao->createAtividade($atividade);

		}

		return $resultado;

	}

	public function deletarAtividade($atividade) {

		$dao = new AtividadeDAO();
		$resultado = $dao->deletarAtividade($atividade);


		return $resultado;

	}
}
?>
