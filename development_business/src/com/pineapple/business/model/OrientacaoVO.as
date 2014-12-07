package com.pineapple.business.model
{
	
	public class OrientacaoVO
	{
		
		private var _id_equipe:int;
		private var _id_projeto:int;
		private var _id_professor:int;
		private var _id_orientacao:int;
		
		private var _equipe:String;;
		private var _projeto:String;
		private var _professor:String;
		
		private var _nomeprofessor:String;
		
		private var _status:String;
		
		public function OrientacaoVO()
		{
		}

		public function get id_equipe():int
		{
			return _id_equipe;
		}

		public function set id_equipe(value:int):void
		{
			_id_equipe = value;
		}

		public function get id_projeto():int
		{
			return _id_projeto;
		}

		public function set id_projeto(value:int):void
		{
			_id_projeto = value;
		}

		public function get id_professor():int
		{
			return _id_professor;
		}

		public function set id_professor(value:int):void
		{
			_id_professor = value;
		}

		[Bindable]
		public function get equipe():String
		{
			return _equipe;
		}

		public function set equipe(value:String):void
		{
			_equipe = value;
		}

		[Bindable]
		public function get projeto():String
		{
			return _projeto;
		}

		public function set projeto(value:String):void
		{
			_projeto = value;
		}

		public function get professor():String
		{
			return _professor;
		}

		public function set professor(value:String):void
		{
			_professor = value;
		}

		public function get id_orientacao():int
		{
			return _id_orientacao;
		}

		public function set id_orientacao(value:int):void
		{
			_id_orientacao = value;
		}

		public function get nomeprofessor():String
		{
			return _nomeprofessor;
		}

		public function set nomeprofessor(value:String):void
		{
			_nomeprofessor = value;
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