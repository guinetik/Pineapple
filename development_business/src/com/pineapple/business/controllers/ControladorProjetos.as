package com.pineapple.business.controllers
{
	
	import com.guinetik.kinetic.external.ServerSide;
	import com.pineapple.business.events.DataReturnEvent;
	import com.pineapple.business.model.EquipeVO;
	import com.pineapple.business.model.OrientacaoVO;
	import com.pineapple.business.model.ProjetoVO;
	import com.pineapple.business.model.SprintVO;
	import com.pineapple.business.model.UserVO;
	import com.pineapple.business.repository.ProjetosRepository;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.ObjectEncoding;

	[Event(name="data_return", type="com.pineapple.business.events.DataReturnEvent")]
	public class ControladorProjetos extends EventDispatcher
	{
		
		private var projectsRepo:ProjetosRepository;
		
		public function ControladorProjetos()
		{
			
			projectsRepo = new ProjetosRepository();
			projectsRepo.addEventListener(DataReturnEvent.DATA_RETURN, onDataReturn);
			
		}
		
		protected function onDataReturn(event:Event):void
		{
			
			dispatchEvent(event);
			
		}
		
		public function solicitarMudanca(orientacao:OrientacaoVO, mensagem:String):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.solicitarMudanca", onResultOperation, onStatus, {id_orientacao:orientacao.id_orientacao, id_equipe:orientacao.id_equipe, id_professor:orientacao.id_professor, mensagem:mensagem, projeto:orientacao.projeto});
			
		}
		
		public function reenviarSolicitacao(orientacao:OrientacaoVO):void
		{
			
			trace("ControladorProjetos.reenviarSolicitacao(", orientacao.id_orientacao, ")");
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.reenviarSolicitacao", onResultOperation, onStatus, {id_orientacao:orientacao.id_orientacao});
			
		}
		
		public function getSolicitacoesMudanca(user:UserVO):void
		{
			
			projectsRepo.getSolicitacoesMudanca(user);
			
		}
		
		private function onResultOperation(result:Object):void
		{
			
			trace("ControladorProjetos.onResultOperation(", result, ")");
			
			
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.result = result;
			this.dispatchEvent(e);
			
		}
		
		private function onStatus(result:Object):void
		{
			
			trace("RepositorioLogin.onStatus()");
			for each (var i:String in result) 
			{
				trace(i, result[i]);
			}
			
		}
		
		public function getIdeias():void
		{
			
			projectsRepo.getIdeias();
			
		}
		
		public function getUltimasIdeias():void
		{
			
			projectsRepo.getUltimasIdeias();
			
		}
		
		public function getMinhasIdeias():void
		{
			
			projectsRepo.getMinhasIdeias();
			
		}
		
		public function cadastrarProjeto(vo:ProjetoVO):void
		{
			
			projectsRepo.cadastrarProjeto(vo);
			
		}
		
		public function getProjetos():void
		{
			
			projectsRepo.getProjetos();
			
		}
		
		public function getAllProjects():void
		{
			
			projectsRepo.getAllProjects();
			
		}
		
		public function getMeusProjetos():void
		{
			
			projectsRepo.getMeusProjetos();
			
		}
		
		public function getProjetosByEquipe(e:EquipeVO):void
		{
			
			projectsRepo.getProjetosByEquipe(e);
			
		}
		
		public function getProjetosById(id_projeto:int):void
		{
			
			projectsRepo.getProjetosById(id_projeto);
			
		}
		
		public function orientarProjeto(p:ProjetoVO):void
		{
			
			projectsRepo.orientarProjeto(p);
			
		}
		
		public function editarProjeto(projeto:ProjetoVO):void
		{
			
			projectsRepo.editarProjeto(projeto);
			
		}
		
		public function getSprintsByProjeto(p:ProjetoVO):void
		{
			
			projectsRepo.getSprintsByProjeto(p);
			
		}
		
		public function getProjetosByProfessor(login:String, resultType:String = "RENDERER"):void
		{
			
			projectsRepo.getProjetosByProfessor(login, resultType);
			
		}
		
		public function getSprintsProfessor(u:UserVO):void
		{
			
			projectsRepo.getListaProjetosProfessor(u);
			
		}
		
		public function getSprints(refresh:Boolean = false):void
		{
			
			if(projectsRepo.repo == null)
			{
				
				projectsRepo.getListaProjetos();	
				
			} else 
			{
				
				if(refresh) projectsRepo.getListaProjetos();
				else projectsRepo.despacha();
				
			}
			
		}
		
		public function definirDatas(p:ProjetoVO):void
		{
			
			projectsRepo.definirDatas(p);
			
		}
		
		public function alterarStatus(p:ProjetoVO):void
		{
			
			projectsRepo.alterarStatus(p);
			
		}
		
		public function salvarSprint(s:SprintVO):void
		{
			
			projectsRepo.salvarSprint(s);
			
		}
		
		public function isProfessorOrientador(login:String, idProjeto:int):void
		{
			
			projectsRepo.isProfessorOrientador(login, idProjeto);
			
		}
		
		public function doesIdeiaHasOrientationRequest(id_ideia:int, id_equipe:int, id_professor:int):void
		{
			
			projectsRepo.doesIdeiaHasOrientationRequest(id_ideia, id_equipe, id_professor);
			
		}
		
		public function deleteSprint(s:SprintVO):void
		{
			
			projectsRepo.deleteSprint(s);
			
		}
		
		public function definirDatasSprint(s:SprintVO):void
		{
			
			projectsRepo.definirDatasSprint(s);
			
		}
		
		public function alterarStatusSprint(s:SprintVO):void
		{
			
			projectsRepo.alterarStatusSprint(s);
			
		}
		
		public function solicitarOrientacao(p:ProjetoVO, e:EquipeVO, professor:UserVO):void
		{
			
			projectsRepo.solicitarOrientacao(p, e, professor);
			
		}
	
		
		public function getOrientacoesByProfessor(id_professor:int):void
		{
			
			projectsRepo.getOrientacoesByProfessor(id_professor);
			
		}
		
		public function recusarOrientacao(id_orientacao:int):void
		{
			
			projectsRepo.recusarOrientacao(id_orientacao);
			
		}
		
		public function deletarProjeto(p:ProjetoVO):void
		{
			
			projectsRepo.deletarProjeto(p);
			
		}
		
	}
}