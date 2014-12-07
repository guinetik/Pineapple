<?php
	
	require_once '../dao/UsuarioDAO.php';
	
	class UsuarioController
	{
		
		
		public function getUsuarios($usuario)
		{
			
			$dao = new UsuarioDAO();
			$usuarios = $dao->getUsuarios($usuario);
			
			return $usuarios;
			
		} 
		
		public function inserirUsuario($usuario)
		{
			
			$dao = new UsuarioDAO();
			return $dao->inserirUsuario($usuario);
			
		}
		
		public function getListaUsuarios()
		{
			
			$dao = new UsuarioDAO();
			$usuarios = $dao->getListaUsuarios();
			
			return $usuarios;
			
		}
		
		public function getProfessores()
		{
			
			$dao = new UsuarioDAO();
			$usuarios = $dao->getProfessores();
				
			return $usuarios;
			
		}
		
		public function getPermissoesUsuario($usuario)
		{
			
			$dao = new UsuarioDAO();
			$permissoes = $dao->getPermissoesUsuario($usuario);
			
			return $permissoes;
			
		}
		
		public function inserirPermissao($usuario)
		{
			
			$dao = new UsuarioDAO();
			$resultado = $dao->inserirPermissao($usuario);
			
			return $resultado;
			
		}
		
		public function editarUsuario($usuario, $nomeUsuario)
		{
			
			$dao = new UsuarioDAO();
			$resultado = $dao->editarUsuario($usuario, $nomeUsuario);
				
			return $resultado;
			
		}
		
	}