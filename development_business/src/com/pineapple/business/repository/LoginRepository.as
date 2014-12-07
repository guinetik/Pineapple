package com.pineapple.business.repository
{
	import com.guinetik.kinetic.external.ServerSide;
	import com.pineapple.business.events.AccessEvent;
	import com.pineapple.business.events.DataReturnEvent;
	import com.pineapple.business.model.ObjectTranslator;
	import com.pineapple.business.model.UserVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.ObjectEncoding;
	
	import mx.collections.ArrayCollection;

	[Event(name="access_granted", type="com.pineapple.business.events.AccessEvent")]
	[Event(name="access_denied", type="com.pineapple.business.events.AccessEvent")]
	public class LoginRepository extends EventDispatcher
	{
		
		private static var instance:LoginRepository;
		
		public function LoginRepository(enforcer:RepositorioLoginEnforcer)
		{
			
			
			if(enforcer == null) throw new Error("singleton e tal. chama o getinstance");
			instance = this;
			
		}
		
		public static function getInstance():LoginRepository
		{
			
			if(instance == null)
			{
				
				return new LoginRepository(new RepositorioLoginEnforcer());
				
			} else 
			{
				
				return instance;
				
			}
			
		}
		
		public function logout():void
		{
			
			this.loggedUser			 				= null;
			this.dispatchEvent(new AccessEvent(AccessEvent.USER_LOGOUT));
			
		}
		
		private var testUser:UserVO;
		[Bindable] public var loggedUser:UserVO;
		
		public function logarUsuario(email:String, password:String):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.processarLogin", onResult, onStatus, {login:email, senha:password});
			
			
		}
		
		private function onResult(result:Object):void
		{
			
			var r:Array = result as Array;
			
			if(r.length > 0)
			{
				
				loggedUser = ObjectTranslator.objectToInstance(r[0], UserVO ) as UserVO;
				dispatchEvent(new AccessEvent(AccessEvent.ACCESS_GRANTED, true, false));
				
			} else 
			{
				
				dispatchEvent(new AccessEvent(AccessEvent.ACCESS_DENIED, true, false));
				
			}
			
		}
		
		private function onStatus(result:Object):void
		{
			
			trace("RepositorioLogin.onStatus()");
			for each (var i:String in result) 
			{
				trace(i, result[i]);
			}
			
		}
		
		public function getProfessores():void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getProfessores", onResultProfessores, onStatus);
			
		}
		
		private function onResultProfessores(result:Object):void
		{
			
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			var retorno:ArrayCollection = new ArrayCollection();
			var arr:Array = result as Array;
			
			for (var i:int = 0; i < arr.length; i++) 
			{
				
				retorno.addItem(ObjectTranslator.objectToInstance(arr[i], UserVO));
				
			}
			
			e.data = retorno;
			
			
			this.dispatchEvent(e);
			
		}
	}
}
class RepositorioLoginEnforcer {}