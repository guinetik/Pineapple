<?php
class Equipe
{
	
	private $id;
	private $nome;
	private $descricao;
	private $nomeMembro;
	private $lider;

	
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
	
	public function getNomeMembro()
	{
		
		return $this->nomeMembro;
		
	}
	
	public function getLider()
	{
		
		return $this->lider;
		
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
	
	public function setNomeMembro($nomeMembro)
	{
		
		$this->nomeMembro = $nomeMembro;
			
	}
	
	public function setLider($lider)
	{
		
		$this->lider = $lider;
			
	}
	
}
?>
