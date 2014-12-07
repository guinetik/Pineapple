package com.pineapple.business.model
{
	import com.pineapple.business.AssetManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import mx.collections.ArrayCollection;

	public class SprintVO extends GenericObject
	{
		
		private var _idprojeto:int;
		private var _idcomentario:int;
		private var _comentario:String;
		private var _datainicio:String;
		private var _datafim:String;
		
		public function SprintVO()
		{
			
			super();
			this.icon = AssetManager.TreeSprint;
			
		}
		
		public function get nomeComStatus():String
		{
			
			return nome + " - Status: " + status;
			
		}

		public function get comentario():String
		{
			return _comentario;
		}

		public function set comentario(value:String):void
		{
			_comentario = value;
		}

		public function get datainicio():String
		{
			return _datainicio;
		}

		public function set datainicio(value:String):void
		{
			_datainicio = value;
		}

		public function get datafim():String
		{
			return _datafim;
		}

		public function set datafim(value:String):void
		{
			_datafim = value;
		}

		public function get idprojeto():int
		{
			return _idprojeto;
		}

		public function set idprojeto(value:int):void
		{
			_idprojeto = value;
		}

		public function get idcomentario():int
		{
			return _idcomentario;
		}

		public function set idcomentario(value:int):void
		{
			_idcomentario = value;
		}

	}
}