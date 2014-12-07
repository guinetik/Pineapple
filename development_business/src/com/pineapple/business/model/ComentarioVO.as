package com.pineapple.business.model
{
	public class ComentarioVO
	{
		
		private var _id:int;
		private var _idsprint:int;
		private var _idprojeto:int;
		private var _descricao:String;
		private var _datacadastro:String;
		private var _autor:String;
		private var _imagem:String;
		private var _projeto:String;
		
		public function ComentarioVO()
		{
			
			
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

		public function get idsprint():int
		{
			return _idsprint;
		}

		public function set idsprint(value:int):void
		{
			_idsprint = value;
		}

		public function get idprojeto():int
		{
			return _idprojeto;
		}

		public function set idprojeto(value:int):void
		{
			_idprojeto = value;
		}

		public function get descricao():String
		{
			return _descricao;
		}

		public function set descricao(value:String):void
		{
			_descricao = value;
		}

		public function get datacadastro():String
		{
			return _datacadastro;
		}

		public function set datacadastro(value:String):void
		{
			_datacadastro = value;
		}

		public function get autor():String
		{
			return _autor;
		}

		public function set autor(value:String):void
		{
			_autor = value;
		}

		public function get imagem():String
		{
			return _imagem;
		}

		public function set imagem(value:String):void
		{
			_imagem = value;
		}

		public function get projeto():String
		{
			return _projeto;
		}

		public function set projeto(value:String):void
		{
			_projeto = value;
		}


	}
}