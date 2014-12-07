package com.pineapple.business.model
{
	public class UserVO
	{
		
		private var _id:int;
		private var _nome:String;
		private var _imagem:String;
		private var _matricula:String;
		private var _email:String;
		private var _senha:String;
		private var _entidade:String;
		private var _mensagem:String;
		private var _login:String;
		private var _expertise:String;
		private var _isConvidado:Boolean;
		
		private var _extras:Object;
		
		public function UserVO()
		{
			
			extras = new Object();
			
		}

		[Bindable]
		public function get email():String
		{
			return _email;
		}

		public function set email(value:String):void
		{
			_email = value;
		}

		[Bindable]
		public function get senha():String
		{
			return _senha;
		}

		public function set senha(value:String):void
		{
			_senha = value;
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
		public function get imagem():String
		{
			return _imagem;
		}

		public function set imagem(value:String):void
		{
			_imagem = value;
		}

		public function get matricula():String
		{
			return _matricula;
		}

		public function set matricula(value:String):void
		{
			_matricula = value;
		}

		public function get entidade():String
		{
			return _entidade;
		}

		public function set entidade(value:String):void
		{
			_entidade = value;
		}

		[Bindable]
		public function get mensagem():String
		{
			return _mensagem;
		}

		public function set mensagem(value:String):void
		{
			_mensagem = value;
		}

		[Bindable]
		public function get login():String
		{
			return _login;
		}

		public function set login(value:String):void
		{
			_login = value;
		}

		public function get expertise():String
		{
			return _expertise;
		}

		public function set expertise(value:String):void
		{
			_expertise = value;
		}

		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

		public function get isConvidado():Boolean
		{
			return _isConvidado;
		}

		public function set isConvidado(value:Boolean):void
		{
			_isConvidado = value;
		}

		public function get extras():Object
		{
			return _extras;
		}

		public function set extras(value:Object):void
		{
			_extras = value;
		}


	}
}