package com.pineapple.business.controllers
{
	import com.pineapple.business.events.DataReturnEvent;
	import com.pineapple.business.repository.UsuarioRepository;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	[Event(name="data_return", type="com.pineapple.business.events.DataReturnEvent")]
	public class ControladorUsuario extends EventDispatcher
	{
		
		private var repo:UsuarioRepository;
		
		public function ControladorUsuario(target:IEventDispatcher=null)
		{
			super(target);
			
			repo = new UsuarioRepository();
			repo.addEventListener(DataReturnEvent.DATA_RETURN, onDataReturn);
			
		}
		
		protected function onDataReturn(event:Event):void
		{
			
			this.dispatchEvent(event);
			
		}
		
		public function getPerfilUsuario(nome:String):void
		{
			
			repo.getPerfilUsuario(nome);
			
		}
		
		public function getListaUsuarios():void
		{
			
			repo.getListaUsuarios();
			
		}
		
	}
}