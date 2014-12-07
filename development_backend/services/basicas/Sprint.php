<?php

class Sprint
{
	
	private $id;
	private $nome;
	private $descricao;
	private $status;
	private $comentario;
	private $dataInicio;
	private $dataFim;
	private $idProjeto;
	private $idcomentario;
	 
	public function getId()
	{
		
		return $this->id;
		
	}
	
	public function getNome()
	{
		
		return $this->nome;
		
	}
	
	public function getDescricao()
	{
		
		return $this->descricao;
		
	}
	
	public function getStatus()
	{
		
		return $this->status;
		
	}
	
	public function getComentario()
	{
		
		return $this->comentario;
		
	}
	
	public function getDataInicio()
	{
		
		return $this->dataInicio;
		
	}
	
	public function getDataFim()
	{
		
		return $this->dataFim;
		
	}
	
	public function getIdProjeto()
	{
		
		return $this->idProjeto;
		
	}
	
	public function getIdComentario()
	{
		
		return $this->idcomentario;
		
	}
	
	// sets
	
	public function setId($id)
	{
		
		$this->id = $id;
		
	}
	
	public function setNome($nome)
	{
		
		$this->nome = $nome;
		
	}
	
	public function setDescricao($descricao)
	{
		$this->descricao = $descricao;
		
		
	}
	
	public function setStatus($status)
	{
		
		$this->status = $status;
			
	}
	
	
	public function setComentario($comentario)
	{
		
		
		$this->comentario = $comentario;
		
	}
	
	public function setDataInicio($dataInicio)
	{
		
		$this->dataInicio = $dataInicio;
		
	}
	
	public function setDataFim($dataFim)
	{
		
		$this->dataFim = $dataFim;
		
	}
	
	public function setIdProjeto($idProjeto)
	{
		
		
		$this->idProjeto = $idProjeto;
		
	}
	
	public function setIdComentario($idComentario)
	{
		
		
		$this->idcomentario = $idComentario;
		
	}
	
}

?>
