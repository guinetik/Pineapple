package com.pineapple.business.model
{
	import com.pineapple.business.AssetManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class AtividadeVO extends GenericObject
	{
		
		private var _idsprint:int;
		
		public function AtividadeVO()
		{
			
			super();
			this.icon = AssetManager.TreeAtividade
			
		}

		public function get idsprint():int
		{
			return _idsprint;
		}

		public function set idsprint(value:int):void
		{
			_idsprint = value;
		}


	}
}