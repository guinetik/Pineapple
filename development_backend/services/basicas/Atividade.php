<?php
class Atividade
{
	
	private $id;
	private $nome;
	private $descricao;
	private $status;
	private $idSprint;

	 
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
	
	public function getIdSprint()
	{
		
		return $this->idSprint;
		
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
	
	public function setIdSprint($idSprint)
	{
		
		$this->idSprint = $idSprint;
			
	}
	
	
}
?>
