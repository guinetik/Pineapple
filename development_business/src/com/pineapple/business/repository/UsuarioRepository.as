package com.pineapple.business.repository
{
	import com.guinetik.kinetic.external.ServerSide;
	import com.pineapple.business.events.DataReturnEvent;
	import com.pineapple.business.model.ExpertiseVO;
	import com.pineapple.business.model.ObjectTranslator;
	import com.pineapple.business.model.UserVO;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.ObjectEncoding;
	
	import mx.collections.ArrayCollection;
	
	[Event(name="data_return", type="com.pineapple.business.events.DataReturnEvent")]
	public class UsuarioRepository extends EventDispatcher
	{
		public function UsuarioRepository(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function getPerfilUsuario(nome:String):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getUsuarios", onResultPerfil, onStatus, {nome:nome});
			
		}
		
		private function onResultPerfil(result:Object):void
		{
			
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.result = ObjectTranslator.objectToInstance(result[0], UserVO);
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
		
		public function getListaUsuarios():void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getListaUsuarios", onResultUsers, onStatus);
			
		}
		
		private function onResultUsers(result:Object):void
		{
			
			trace("UsuarioRepository.onResultUsers(", result, ")");
			
			var arr:Array = result as Array;
			var retorno:ArrayCollection = new ArrayCollection();
			for (var i:int = 0; i < arr.length; i++) 
			{
				
				retorno.addItem(ObjectTranslator.objectToInstance(arr[i], UserVO));
				
			}
			
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.data = retorno;
			this.dispatchEvent(e);
			
		}
	}
}