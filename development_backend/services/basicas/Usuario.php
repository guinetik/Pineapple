<?php

class Usuario
{
	
	private $nome;
	private $matricula;
	private $login;
	private $senha;
	private $imagem;
	private $mensagem;
	private $entidade;
	private $expertise;
	private $permissao;
	private $email;
	private $id;
	 
	
	public function getId()
	{
		
		return $this->id;
		
	}
	
	public function setId($id)
	{
		
		$this->id = $id;
		
	}
	
	public function getNome()
	{
		
		return $this->nome;
		
	}
	
	public function getMatricula()
	{
		
		return $this->matricula;
		
	}
	
	public function getLogin()
	{
		
		return $this->login;
		
	}
	
	public function getSenha()
	{
		
		return $this->senha;
		
	}
	
	public function getImagem()
	{
		
		return $this->imagem;
		
	}
	
	public function getMensagem()
	{
		
		return $this->mensagem;
		
	}
	
	public function getEntidade()
	{
		
		return $this->entidade;
		
	}
	
	public function getExpertise()
	{
		
		return $this->expertise;
		
	}
	
	public function getPermissao()
	{
	
		return $this->permissao;
	
	}
	
	public function getEmail()
	{
		
		return $this->email;
		
	}
	
	// sets
	
	public function setNome($nome)
	{
		
		$this->nome = $nome;
		
	}
	
	public function setMatricula($matricula)
	{
		
		$this->matricula = $matricula;
		
	}
	
	public function setLogin($login)
	{
		$this->login = $login;
		
		
	}
	
	public function setSenha($senha)
	{
		
		$this->senha = $senha;
			
	}
	
	
	public function setImagem($imagem)
	{
		
		
		$this->imagem = $imagem;
		
	}
	
	public function setMensagem($mensagem)
	{
		
		$this->mensagem = $mensagem;
		
	}
	
	public function setEntidade($entidade)
	{
		
		$this->entidade = $entidade;
		
	}
	
	public function setExpertise($expertise)
	{
		
		
		$this->expertise = $expertise;
		
	}
	
	public function setPermissao($permissao)
	{
	
	
		$this->permissao = $permissao;
	
	}
	
	public function setEmail($email)
	{
		
		
		$this->email = $email;
		
	}
	
}

?>
