package com.pineapple.business.model
{
	import com.pineapple.business.AssetManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import mx.collections.ArrayCollection;

	public class ProjetoVO extends GenericObject
	{
		
		private var _autor:String;
		private var _orientador:String;
		private var _equipe:String;
		private var _datainicio:String;
		private var _datafim:String;
		private var _datacadastro:String;
		private var _imagem:String;
		
		public function ProjetoVO()
		{
			
			super();
			this.icon = AssetManager.TreeProject;
			
		}
		
		[Bindable]
		public function get autor():String
		{
			return _autor;
		}

		public function set autor(value:String):void
		{
			_autor = value;
		}

		public function get orientador():String
		{
			return _orientador;
		}

		public function set orientador(value:String):void
		{
			_orientador = value;
		}

		public function get equipe():String
		{
			return _equipe;
		}

		public function set equipe(value:String):void
		{
			_equipe = value;
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

		public function get datacadastro():String
		{
			return _datacadastro;
		}

		public function set datacadastro(value:String):void
		{
			_datacadastro = value;
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

	}
}