package com.pineapple.business.model
{
	public class ExpertiseVO
	{
		private var _nome:String;
		private var _id:int;
		private var _color:String;
		
		public function ExpertiseVO()
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
		public function get color():String
		{
			return _color;
		}

		public function set color(value:String):void
		{
			_color = value;
		}


	}
}