package com.pineapple.business.repository
{
	import com.guinetik.kinetic.external.ServerSide;
	import com.pineapple.business.events.DataReturnEvent;
	import com.pineapple.business.model.ExpertiseVO;
	import com.pineapple.business.model.ObjectTranslator;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.ObjectEncoding;
	
	import mx.collections.ArrayCollection;
	
	[Event(name="data_return", type="com.pineapple.business.events.DataReturnEvent")]
	public class ExpertiseRepository extends EventDispatcher
	{
		public function ExpertiseRepository(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function getExpertises():void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getExpertises", onResultExpertises, onStatus);
			
		}
		
		public function getExpertisesUsuario(login:String):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getExpertisesUsuario", onResultExpertises, onStatus, {login:login});
			
		}
		
		public function addExpertiseToUsuario(e:ExpertiseVO, login:String):void
		{
			
			trace("ExpertiseRepository.addExpertiseToUsuario(", e.id, login, ")");
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.addExpertiseToUsuario", onResultCrud, onStatus, {id:e.id, login:login});
			
		}
		
		private function onResultCrud(result:Object):void
		{
			
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.result = result;
			dispatchEvent(e);
			
		}
		
		private function onResultExpertises(result:Object):void
		{
			
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			
			var expertises:ArrayCollection = new ArrayCollection();
			var arr:Array = result as Array;
			
			for (var i:int = 0; i < arr.length; i++) 
			{
				
				var expertise:ExpertiseVO = ObjectTranslator.objectToInstance(arr[i], ExpertiseVO);
				expertises.addItem(expertise);
				
			}
			
			e.data = expertises;
			
			
			this.dispatchEvent(e);
			
		}
		
		private function onStatus(result:Object):void
		{
			
			trace("UsuarioRepository.onStatus()");
			for each (var i:String in result) 
			{
				trace(i, result[i]);
			}
			
		}
		
		public function saveAndAddExpertiseToUsuario(e:ExpertiseVO, login:String):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.saveAndAddExpertiseToUsuario", onResultCrud, onStatus, {nome:e.nome, color:e.color, login:login});
			
		}
		
		public function removeExpertiseFromUsuario(e:ExpertiseVO, login:String):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.removeExpertiseFromUsuario", onResultCrud, onStatus, {id:e.id, login:login});
			
		}
		
	}
}