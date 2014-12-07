package com.pineapple.business.controllers
{
	import com.pineapple.business.events.DataReturnEvent;
	import com.pineapple.business.model.AtividadeVO;
	import com.pineapple.business.repository.AtividadesRepository;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	[Event(name="data_return", type="com.pineapple.business.events.DataReturnEvent")]
	public class ControladorAtividades extends EventDispatcher
	{
		
		private var repositorio:AtividadesRepository;
		
		public function ControladorAtividades(target:IEventDispatcher=null)
		{
			
			super(target);
			
			repositorio = new AtividadesRepository();
			repositorio.addEventListener(DataReturnEvent.DATA_RETURN, onDataReturn);
			
		}
		
		protected function onDataReturn(event:Event):void
		{
			
			this.dispatchEvent(event);
			
		}
		
		public function createAtividade(a:AtividadeVO):void
		{
			
			repositorio.createAtividade(a);
			
		}
		
		public function excluirAtividade(a:AtividadeVO):void
		{
			
			repositorio.exlcuirAtividade(a);
			
		}
		
		public function salvarAtividade(a:AtividadeVO):void
		{
				
			repositorio.salvarAtividade(a);		
			
		}
		
		
	}
}