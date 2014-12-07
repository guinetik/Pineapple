package com.pineapple.business.controllers
{
	import com.guinetik.kinetic.external.ServerSide;
	import com.pineapple.business.events.AccessEvent;
	import com.pineapple.business.events.DataReturnEvent;
	import com.pineapple.business.model.UserType;
	import com.pineapple.business.model.UserVO;
	import com.pineapple.business.repository.LoginRepository;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.ObjectEncoding;

	[Event(name="access_granted", type="com.pineapple.business.events.AccessEvent")]
	[Event(name="access_denied", type="com.pineapple.business.events.AccessEvent")]
	[Event(name="data_return", type="com.pineapple.business.events.DataReturnEvent")]
	public class ControladorLogin extends EventDispatcher
	{
		
		private var repo:LoginRepository;
		
		public function ControladorLogin()
		{
			
			repo = LoginRepository.getInstance();
			repo.addEventListener(AccessEvent.ACCESS_GRANTED, onAccessGranted);
			repo.addEventListener(AccessEvent.ACCESS_DENIED, onAccessDenied);
			repo.addEventListener(DataReturnEvent.DATA_RETURN, onDataReturn);
			
		}
		
		protected function onDataReturn(event:Event):void
		{
			
			trace("ControladorLogin.onDataReturn(event)");
			
			dispatchEvent(event);
			
		}
		
		public function getProfessores():void
		{
			
			repo.getProfessores();
			
		}
		
		protected function onAccessDenied(event:Event):void
		{
			
			trace("ControladorLogin.onAccessDenied(event)");
			dispatchEvent(event);
			
		}
		
		protected function onAccessGranted(event:Event):void
		{
			
			trace("ControladorLogin.onAccessGranted(event)");
			dispatchEvent(event);
			
		}
		
		public function getLoggedUser():UserVO
		{
			
			return repo.loggedUser;
			
		}
		
		public function logarUsuario(email:String, senha:String):void
		{
			
			repo.logarUsuario(email, senha);
			
		}
		
		public function editarUsuario(user:UserVO, nomeUsuario:String):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.editarUsuario", onEditarResult, onStatus, {nome:user.nome, nome_usuario:nomeUsuario, email:user.email, mensagem:user.mensagem, imagem:user.imagem, senha:user.senha, login:user.login});
			
		}
		
		private function onEditarResult(result:Object):void
		{
			
			trace("ControladorLogin.onEditarResult(", result, ")");
			
			var e:DataReturnEvent 		= new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.result	 				= result;
			
			this.dispatchEvent(e);
			
		}
		
		private function onStatus(result:Object):void
		{
			
			trace("ControladorLogin.onStatus()");
			for each (var i:String in result) 
			{
				trace(i, result[i]);
			}
			
		}

	}
}