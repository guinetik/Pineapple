<?php

class Projeto
{
	
	private $id;
	private $nome;
	private $descricao;
	private $status;
	private $autor;
	private $dataCadastro;
	private $dataInicio;
	private $dataFim;
	private $orientador; 
	private $equipe;
	 
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
	
	public function getAutor()
	{
		
		return $this->autor;
		
	}
	
	public function getDataCadastro()
	{
		
		return $this->dataCadastro;
		
	}
	
	public function getDataInicio()
	{
		
		return $this->dataInicio;
		
	}
	
	public function getDataFim()
	{
		
		return $this->dataFim;
		
	}
	
	public function getOrientador()
	{
		
		return $this->orientador;
		
	}
	
	public function getEquipe()
	{
		
		return $this->equipe;
		
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
	
	public function setAutor($autor)
	{
		
		$this->autor = $autor;
			
	}
	
	
	public function setDataCadastro($dataCadastro)
	{
		
		
		$this->dataCadastro = $dataCadastro;
		
	}
	
	public function setDataInicio($dataInicio)
	{
		
		$this->dataInicio = $dataInicio;
		
	}
	
	public function setDataFim($dataFim)
	{
		
		$this->dataFim = $dataFim;
		
	}
	
	public function setOrientador($orientador)
	{
		
		
		$this->orientador = $orientador;
		
	}
	
	public function setEquipe($equipe)
	{
		
		
		$this->equipe = $equipe;
		
	}
	
}

?>
