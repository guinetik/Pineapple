package com.pineapple.business.controllers
{
	import com.pineapple.business.events.DataReturnEvent;
	import com.pineapple.business.model.ConviteVO;
	import com.pineapple.business.model.EquipeVO;
	import com.pineapple.business.model.UserVO;
	import com.pineapple.business.repository.EquipeRepository;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	[Event(name="data_return", type="com.pineapple.business.events.DataReturnEvent")]
	public class ControladorEquipe extends EventDispatcher
	{
		
		private var repo:EquipeRepository;
		
		public function ControladorEquipe(target:IEventDispatcher=null)
		{
			super(target);
			
			repo = new EquipeRepository();
			repo.addEventListener(DataReturnEvent.DATA_RETURN, onDataReturn);
			
		}
		
		protected function onDataReturn(event:Event):void
		{
			
			dispatchEvent(event);
			
		}
		
		public function getEquipesWhereUserIsLeader(a:UserVO):void
		{
			
			repo.getEquipesWhereUserIsLeader(a);
			
		}
		
		public function getEquipes():void
		{
			
			repo.getEquipes();
			
		}
		
		public function getAlunosConvidados(e:EquipeVO):void
		{
			
			trace("ControladorEquipe.getAlunosConvidados(", e.id, ")");
			
			repo.getAlunosConvidados(e);
			
		}
		
		public function salvarEquipe(e:EquipeVO):void
		{
			
			repo.salvarEquipe(e);
			
		}
		
		public function salvarMembro(e:EquipeVO):void
		{
			
			
			
		}
		
		public function getMeusConvites(a:UserVO):void
		{
			
			repo.getMeusConvites(a);
			
		}
		
		public function removeUsuarioFromEquipe(e:EquipeVO, usuario:String):void
		{
			
			trace("ControladorEquipe.removeUsuarioFromEquipe(", e.nome,  usuario, ")");
			repo.removeUsuarioFromEquipe(e, usuario);
			
		}
		
		public function removerEquipe(e:EquipeVO):void
		{
			
			repo.removerEquipe(e);
			
		}
		
		public function getEquipesByAluno(a:UserVO):void
		{
			
			repo.getEquipesByAluno(a);
			
		}
		
		public function getMembrosDaEquipe(e:EquipeVO):void
		{
			
			repo.getMembrosDaEquipe(e);
			
		}
		
		public function getNomeEquipe(a:UserVO):void
		{
			
			
			
		}
		
		public function getEquipeById(id:int):void
		{
			
			repo.getEquipeById(id);
			
		}
		
		public function getAlunos():void
		{
			
			repo.getAlunos();
			
		}
		
		public function delegarLider(e:EquipeVO):void
		{
			
			repo.delegarLider(e);
			
		}
		
		public function convidarParaEquipe(e:EquipeVO, u:UserVO, l:UserVO):void
		{
			
			repo.convidarParaEquipe(e, u, l);
			
		}
		
		public function aceitarConvite(c:ConviteVO, a:UserVO):void
		{
			
			repo.aceitarConvite(c, a);
			
		}
		
		public function recusarConvite(id:int):void
		{
			
			repo.recusarConvite(id);
			
		}
		
	}
}