package com.pineapple.business.model
{
	public class ConviteVO
	{
		
		private var _id:int;
		private var _nome:String;
		private var _id_equipe:int;
		private var _status:String;
		
		public function ConviteVO()
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

		public function get id_equipe():int
		{
			return _id_equipe;
		}

		public function set id_equipe(value:int):void
		{
			_id_equipe = value;
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

		public function get status():String
		{
			return _status;
		}

		public function set status(value:String):void
		{
			_status = value;
		}


	}
}