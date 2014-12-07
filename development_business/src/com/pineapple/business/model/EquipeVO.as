package com.pineapple.business.model
{
	public class EquipeVO
	{
		
		private var _id:int;
		private var _nome:String;
		private var _descricao:String;
		private var _lider:String;
		private var _criador:String;
		private var _imagem_criador:String;
		private var _imagem_lider:String;
		
		[Bindable]
		public function get lider():String
		{
			return _lider;
		}

		public function set lider(value:String):void
		{
			_lider = value;
		}

		[Bindable]
		public function get descricao():String
		{
			return _descricao;
		}

		public function set descricao(value:String):void
		{
			_descricao = value;
		}

		[Bindable]
		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}
		
		[Bindable]
		public function get nome():String
		{
			return _nome;
		}
		
		public function set nome(value:String):void
		{
			_nome = value;
		}

		[Bindable]
		public function get criador():String
		{
			return _criador;
		}

		public function set criador(value:String):void
		{
			_criador = value;
		}

		[Bindable]
		public function get imagem_criador():String
		{
			return _imagem_criador;
		}

		public function set imagem_criador(value:String):void
		{
			_imagem_criador = value;
		}

		[Bindable]
		public function get imagem_lider():String
		{
			return _imagem_lider;
		}

		public function set imagem_lider(value:String):void
		{
			_imagem_lider = value;
		}


	}
}