<?php
class Expertise
{
	
	private $id;
	private $login;
	private $nome;
	private $color;

	public function getNome()
	{
		
		return $this->nome;
		
	} 
	
	public function getLogin()
	{
		
		return $this->login; 
		
	}
	
	public function getId()
	{
		
		return $this->id;
		
	}
	
	public function getColor()
	{
	
		return $this->color;
	
	}
	
	
	// sets
	
	public function setNome($nome)
	{
		
		$this->nome = $nome;
		
	}
	
	public function setLogin($login)
	{
		$this->login = $login;
		
		
	}
	
	public function setId($id)
	{
		
		$this->id = $id;
		
	}
	
	public function setColor($color)
	{
	
		$this->color = $color;
	
	}
	
}
?>
