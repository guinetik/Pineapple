<?php
class Status
{
	
	private $id;
	private $nome;
	private $descricao;

	
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
	
}
?>
