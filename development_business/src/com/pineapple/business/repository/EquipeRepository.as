package com.pineapple.business.repository
{
	import com.guinetik.kinetic.external.ServerSide;
	import com.pineapple.business.events.DataReturnEvent;
	import com.pineapple.business.model.ConviteVO;
	import com.pineapple.business.model.EquipeVO;
	import com.pineapple.business.model.ObjectTranslator;
	import com.pineapple.business.model.UserVO;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.ObjectEncoding;
	
	import mx.collections.ArrayCollection;
	
	[Event(name="data_return", type="com.pineapple.business.events.DataReturnEvent")]
	public class EquipeRepository extends EventDispatcher
	{
		public function EquipeRepository(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function getEquipesWhereUserIsLeader(a:UserVO):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			
			var nome:String;
			
			if(a == null)
			{
				
				nome = LoginRepository.getInstance().loggedUser.nome;
				
			} else  nome = a.nome;
			
			ServerSide.call("facade.Facade.getEquipesWhereUserIsLeader", onResultEquipes, onStatus, {nome:nome});
			
		}
		
		private function onResultEquipes(result:Object):void
		{
			
			var r:Array = result as Array;
			var a:ArrayCollection = new ArrayCollection();
			
			for (var i:int = 0; i < r.length; i++) 
			{
				
				a.addItem(ObjectTranslator.objectToInstance(r[i], EquipeVO));
				
			}
			
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.data = a;
			dispatchEvent(e);
			
		}
		
		private function onResultConvites(result:Object):void
		{
			
			var r:Array = result as Array;
			var a:ArrayCollection = new ArrayCollection();
			
			for (var i:int = 0; i < r.length; i++) 
			{
				
				a.addItem(ObjectTranslator.objectToInstance(r[i], ConviteVO));
				
			}
			
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.data = a;
			dispatchEvent(e);
			
		}
		
		private function onStatus(result:Object):void
		{
			
			trace("RepositorioLogin.onStatus()");
			for each (var i:String in result) 
			{
				trace(i, result[i]);
			}
			
		}
		
		public function salvarEquipe(e:EquipeVO):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.salvarEquipe", onResultCrud, onStatus, e);
			
		}
		
		private function onResultCrud(result:Object):void
		{
			
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.result = result;
			dispatchEvent(e);
			
		}
		
		public function getAlunos():void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getAlunos", onResultAlunos, onStatus);
			
		}
		
		private function onResultAlunos(result:Object):void
		{
			
			var r:Array = result as Array;
			var a:ArrayCollection = new ArrayCollection();
			
			for (var i:int = 0; i < r.length; i++) 
			{
				
				a.addItem(ObjectTranslator.objectToInstance(r[i], UserVO));
				
			}
			
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.data = a;
			dispatchEvent(e);
			
		}
		
		public function getMembrosDaEquipe(e:EquipeVO):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getItemMembros", onResultAlunos, onStatus, e);
			
		}
		
		public function getEquipesByAluno(a:UserVO):void
		{
			
			if(a == null)
			{
				
				a = LoginRepository.getInstance().loggedUser;
				
			}
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getEquipesByUsuario", onResultEquipes, onStatus, a);			
			
		}
		
		public function delegarLider(e:EquipeVO):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.delegarLider", onResultCrud, onStatus, e);
			
		}
		
		public function removeUsuarioFromEquipe(e:EquipeVO, usuario:String):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.removeUsuarioFromEquipe", onResultCrud, onStatus, {equipe:e.nome, nome:usuario});
			
		}
		
		public function removerEquipe(e:EquipeVO):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.removerEquipe", onResultCrud, onStatus, {nome:e.nome, id:e.id});
			
		}
		
		public function convidarParaEquipe(e:EquipeVO, u:UserVO, l:UserVO):void
		{
			
			trace(e.id, e.nome, u.email, l.email);
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.convidarParaEquipe", onResultCrud, onStatus, {id_equipe:e.id, nome_equipe:e.nome, nome_lider:l.nome, email_lider:l.email, id_lider:l.id, nome_user:u.nome, email_user:u.email, id_user:u.id});
			
		}
		
		public function getAlunosConvidados(e:EquipeVO):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getAlunosConvidados", onResultAlunos, onStatus, {id_equipe:e.id});
			
		}
		
		public function getMeusConvites(a:UserVO):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getMeusConvites", onResultConvites, onStatus, {id_usuario:a.id});
			
		}
		
		public function getEquipeById(id:int):void
		{
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getEquipeById", onResultEquipe, onStatus, {id_equipe:id});
			
		}
		
		private function onResultEquipe(result:Object):void
		{
			
			var eq:EquipeVO = ObjectTranslator.objectToInstance(result[0], EquipeVO);
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.result = eq;
			this.dispatchEvent(e);
			
		}
		
		public function aceitarConvite(c:ConviteVO, a:UserVO):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.aceitarConvite", onResultCrud, onStatus, {nomeMembro:a.nome, nome:c.nome, id_equipe:c.id_equipe, id_convite:c.id});
			
		}
		
		public function recusarConvite(id:int):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.recusarConvite", onResultCrud, onStatus, {id_convite:id});
			
		}
		
		public function getEquipes():void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getAllEquipes", onResultEquipes, onStatus);
			
		}
	}
}