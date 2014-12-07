package com.pineapple.business.model
{
	import mx.collections.ArrayCollection;
	import mx.utils.UIDUtil;

	public class GenericObject
	{
		
		private var _id:int;
		private var _nome:String;
		private var _children:ArrayCollection;
		private var _uid:String;
		private var _status:String;
		private var _icon:Class;
		
		private var _descricao:String;
		
		public function GenericObject()
		{
			
			this.children = new ArrayCollection();
			this.uid = UIDUtil.createUID();
			
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
		
		public function get id():int
		{
			return _id;
		}
		
		public function set id(value:int):void
		{
			_id = value;
		}

		[Bindable]
		public function get children():ArrayCollection
		{
			return _children;
		}

		public function set children(value:ArrayCollection):void
		{
			_children = value;
		}

		public function get uid():String
		{
			return _uid;
		}

		public function set uid(value:String):void
		{
			_uid = value;
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
		public function get status():String
		{
			return _status;
		}

		public function set status(value:String):void
		{
			_status = value;
		}

		public function get icon():Class
		{
			return _icon;
		}

		public function set icon(value:Class):void
		{
			_icon = value;
		}

		
	}
}