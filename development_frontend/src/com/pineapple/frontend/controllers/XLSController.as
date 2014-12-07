package com.pineapple.frontend.controllers
{
	import com.guinetik.kinetic.external.ServerSide;
	import com.pineapple.business.events.DataReturnEvent;
	
	import flash.events.EventDispatcher;
	import flash.net.ObjectEncoding;

	[Event(name="data_return", type="com.pineapple.business.events.DataReturnEvent")]
	public class XLSController extends EventDispatcher
	{
		public function XLSController()
		{
			
			
		}
		
		public function processarXLS(arquivo:String):void
		{
			
			var caminho:String = "../../uploads/" + arquivo;
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.processarXLS", onResultProcessing, null, {caminho:caminho});
			
		}
		
		private function onResultProcessing(result:Object):void
		{
			
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.result = result;
			this.dispatchEvent(e);
			
		}
		
	}
}