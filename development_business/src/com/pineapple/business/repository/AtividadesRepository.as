package com.pineapple.business.repository
{
	import com.guinetik.kinetic.external.ServerSide;
	import com.pineapple.business.events.DataReturnEvent;
	import com.pineapple.business.model.AtividadeVO;
	import com.pineapple.business.model.ObjectTranslator;
	import com.pineapple.business.model.SprintVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;

	[Event(name="data_return", type="com.pineapple.business.events.DataReturnEvent")]
	public class AtividadesRepository extends EventDispatcher
	{
		
		private var target:SprintVO;
		
		public function AtividadesRepository()
		{
			
			
		}
		
		public function createAtividade(a:AtividadeVO):void
		{
			
			ServerSide.call("facade.Facade.createAtividade", onResultCadastrarAtividade, onStatus, a);
			
		}
		
		private function onResultCadastrarAtividade(result:Object):void
		{
			
			trace("AtividadesRepository.onResultCadastrarAtividade(", result, ")");
			
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.result = result;
			dispatchEvent(e);
			
		}
		
		public function getAtividadesBySprint(sprint:SprintVO):void
		{
			
			this.target = sprint;
			ServerSide.call("facade.Facade.getAtividadesBySprint", onResult, onStatus, {id_sprint:sprint.id});
			
		}
		
		private function onResult(result:Object):void
		{
			
			trace("AtividadesRepository.onResult(result)");
			
			var r:Array = result as Array;
			
			for (var i:int = 0; i < r.length; i++) 
			{
				
				this.target.children.addItem(ObjectTranslator.objectToInstance(r[i], AtividadeVO));
				
			}
			
			this.dispatchEvent(new Event(Event.COMPLETE));
			
		}
		
		private function onStatus(result:Object):void
		{
			
			trace("RepositorioLogin.onStatus()");
			for each (var i:String in result) 
			{
				trace(i, result[i]);
			}
			
		}
		
		public function exlcuirAtividade(a:AtividadeVO):void
		{
			
			ServerSide.call("facade.Facade.deletarAtividade", onResultGeneric, onStatus, a);
			
		}
		
		private function onResultGeneric(result:Object):void
		{
			
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.result = result;
			this.dispatchEvent(e);
			
		}
		
		public function salvarAtividade(a:AtividadeVO):void
		{
			
			ServerSide.call("facade.Facade.salvarAtividade", onResultGeneric, onStatus, a);
			
		}
	}
}