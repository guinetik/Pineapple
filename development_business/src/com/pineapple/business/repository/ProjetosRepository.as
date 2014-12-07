package com.pineapple.business.repository
{
	
	import com.guinetik.kinetic.external.ServerSide;
	import com.pineapple.business.controllers.ControladorLogin;
	import com.pineapple.business.events.DataReturnEvent;
	import com.pineapple.business.model.AtividadeVO;
	import com.pineapple.business.model.EquipeVO;
	import com.pineapple.business.model.ObjectTranslator;
	import com.pineapple.business.model.OrientacaoVO;
	import com.pineapple.business.model.ProjetoVO;
	import com.pineapple.business.model.SprintVO;
	import com.pineapple.business.model.UserVO;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.ObjectEncoding;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;

	[Event(name="data_return", type="com.pineapple.business.events.DataReturnEvent")]
	public class ProjetosRepository extends EventDispatcher
	{
		
/*		[Embed(source="assets/data/sprints.xml", mimeType="text/xml")]
		protected var dados:Class;*/
		protected var _repo:ArrayCollection;
		private var countAtividades:int = 0;
		private var numSprints:int;
		private var getLista:Boolean = false;
		private var gettingMeusProjetos:Boolean = false;
		private var gettingListaProfessor:Boolean = false;
		
		public function ProjetosRepository()
		{
			
			
			
		}
		
		public function getListaProjetos():void
		{
			
			getLista = true;
			getEquipes();
			
		}
		
		public function getProjetos():void
		{
			
			getLista = false;
			getEquipes();
			
		}
		
		private function getEquipes():void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getEquipesByUsuario", onResultEquipe, onStatus, {nome:LoginRepository.getInstance().loggedUser.nome});
			
		}
		
		private function onResultEquipe(result:Object):void
		{
			
			trace("RepositorioSprints.onResultEquipe(result)");
			
			var r:Array = result as Array;
			var nomes:Array = [];
			
			trace(r.length);
			
			if(r.length > 0)
			{
				
				for (var i:int = 0; i < r.length; i++) 
				{
					
					nomes.push(r[i].nome);
					
				}
				
				ServerSide.call("facade.Facade.getProjetoByEquipes", onResultProjetos, onStatus, {equipes:nomes});
				
				
			} else 
			{
				
				var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
				e.data = new ArrayCollection();
				this.dispatchEvent(e);
				
			}
			
		}
		
		private function onResultProjetos(result:Object):void
		{
			
			trace("RepositorioSprints.onResultProjetos(", result, ")");
			
			if(result is Array)
			{
				
				trace("is");
				
				var r:Array = result as Array;
				
				repo = new ArrayCollection();
				
				if(r.length > 0)
				{
					
					trace("r.length > 0");
					
					for (var i:int = 0; i < r.length; i++) 
					{
						
						var arr:Array = r[i];
						if(arr.length > 0)
						{
							
							var projeto:Object = arr[0];
							var vo:ProjetoVO = ObjectTranslator.objectToInstance(projeto, ProjetoVO) as ProjetoVO;
							repo.addItem(vo);
							
						}
						
					}
					
					if(getLista || gettingMeusProjetos)
					{
						
						trace("getLista || gettingMeusProjetos");
						if(repo.length > 0)
						{
							
							getSprintsFromProjeto();
							
						} else
						{
							
							despachaVazio();
							
						}
						
					} else 
					{
						
						trace("else");
						
						var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
						e.data = repo;
						dispatchEvent(e);
						
					}
					
				} else 
				{
					
					despachaVazio();
					
				}
				
			} else 
			{
				
				despachaVazio();
				
			}
			
		}
		
		private function despachaVazio():void
		{
			
			trace("ProjetosRepository.despachaVazio()");
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.data = new ArrayCollection();
			dispatchEvent(e);
			
		}
		
		private function getSprintsFromProjeto():void
		{
			
			trace("RepositorioProjetos.getSprints()");
			
			for (var i:int = 0; i < repo.length; i++) 
			{
				
				var projeto:ProjetoVO = repo.getItemAt(i) as ProjetoVO;
				ServerSide.call("facade.Facade.getSprintsByProjeto", onResultSprints, onStatus, {id_projeto:projeto.id});
				
			}
			
			
		}
		
		private function onResultSprints(result:Object):void
		{
			
			trace("RepositorioProjetos.onResultSprints(result)");
			
			var r:Array = result as Array;
			
			if(r.length > 0)
			{
				
				for (var i:int = 0; i < r.length; i++) 
				{
					
					var sprint:SprintVO = ObjectTranslator.objectToInstance(r[i], SprintVO) as SprintVO;
					var atividadeRepo:AtividadesRepository = new AtividadesRepository();
					atividadeRepo.addEventListener(Event.COMPLETE, onAtividadeComplete);
					atividadeRepo.getAtividadesBySprint(sprint);
					
					numSprints++;
					
					var projeto:ProjetoVO = getProjetoById(sprint.idprojeto);
					projeto.children.addItem(sprint);
					
					trace("onResultSprints", projeto.children.length);
					
				}
				
			} else 
			{
				
				var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN)
				e.data = repo;
				this.dispatchEvent(e);
				
			}

			
		}
		
		protected function onAtividadeComplete(event:Event):void
		{
			
			trace("RepositorioProjetos.onAtividadeComplete(", numSprints, countAtividades, ")");
			
			if(++countAtividades > numSprints-1)
			{
				
//				if(gettingMeusProjetos)
//				{
//					
//					setTimeout(despachaMeusProjetos, 1000);
//					
//				} else
//				{
//					
//					setTimeout(despacha, 1000);
//					
//				}
				
				setTimeout(despachaMeusProjetos, 1000);
				
			}
			
		}
		
		private function despachaMeusProjetos():void
		{
			
			var e:DataReturnEvent					= new DataReturnEvent(DataReturnEvent.DATA_RETURN, true);
			e.data 									= repo;
			
			this.dispatchEvent(e);
			
		}
		
		public function despacha():void
		{
			
			var e:DataReturnEvent					= new DataReturnEvent(DataReturnEvent.DATA_RETURN, true);
			
			var retorno:ArrayCollection				= new ArrayCollection();
			
			trace("RepositorioProjetos.despacha()", repo.length);
			
			
			for (var i:int = 0; i < repo.length; i++) 
			{
				
				var vo:ProjetoVO					= repo.getItemAt(i) as ProjetoVO;
				
				//retorno.addItem({nome:"Projeto"});
				retorno.addItem(vo);
				
				var sprints:ArrayCollection			= vo.children;
				var atividades:Array				= new Array();
				retorno.addItem({nome:"Sprints"});
				
				for (var j:int = 0; j < sprints.length; j++) 
				{
					
					var sprint:SprintVO				= sprints[j] as SprintVO;
					
					for (var k:int = 0; k < sprint.children.length; k++) 
					{
						
						atividades.push(sprint.children[k]);
						
					}
					
					
					retorno.addItem(sprint);
					
				}
				
				if(atividades.length > 0)
				{
					
					retorno.addItem({nome:"Atividades"});
					for (var l:int = 0; l < atividades.length; l++) 
					{
						
						retorno.addItem(atividades[l]);
						
					}
					
				}
				
				
			}
			
			e.data = retorno;
			
			this.dispatchEvent(e);
			
		}
		
		private function getProjetoById(idProjeto:int):ProjetoVO
		{
			
			var retorno:ProjetoVO = null;
			
			for (var i:int = 0; i < repo.length; i++) 
			{
				
				var projeto:ProjetoVO = repo.getItemAt(i) as ProjetoVO;
				if(projeto.id == idProjeto) retorno = projeto;
				
			}
			
			return retorno;
			
		}
		
		private function onStatus(result:Object):void
		{
			
			trace("RepositorioLogin.onStatus()");
			for each (var i:String in result) 
			{
				trace(i, result[i]);
			}
			
		}

		public function get repo():ArrayCollection
		{
			return _repo;
		}

		public function set repo(value:ArrayCollection):void
		{
			_repo = value;
		}

		public function getIdeias():void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getIdeias", onResultIdeias, onStatus);
			
		}
		
		private function onResultIdeias(result:Object):void
		{
			
			var r:Array 							= result as Array;
			var ideias:Array 						= [];
			
			for (var i:int = 0; i < r.length; i++) 
			{
				
				ideias.push(ObjectTranslator.objectToInstance(r[i], ProjetoVO));
				
			}
			
			if(gettingMeusProjetos || gettingListaProfessor)
			{
				
				repo = new ArrayCollection(ideias);
				getSprintsFromProjeto();
				
			} else 
			{
				
				var retorno:ArrayCollection 			= new ArrayCollection(ideias);
				var e:DataReturnEvent					= new DataReturnEvent(DataReturnEvent.DATA_RETURN, true);
				e.data 									= retorno;
				this.dispatchEvent(e);
				
			}
			
			
		}
		
		public function cadastrarProjeto(vo:ProjetoVO):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.cadastrarProjeto", onResultOperation, onStatus, vo);
			
		}
		
		private function onResultOperation(result:Object):void
		{
			
			trace("ProjetosRepository.onResultOperation(", result, ")");
			
			
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.result = Boolean(result);
			trace(e.result);
			this.dispatchEvent(e);
			
		}
		
		public function getMeusProjetos():void
		{
			
			gettingMeusProjetos = true;
			getEquipes();
			
		}
		
		public function getProjetosById(id_projeto:int):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getProjetosById", onResultProjeto, onStatus, {id_projeto:id_projeto});
			
		}
		
		private function onResultProjeto(result:Object):void
		{
			
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.result = ObjectTranslator.objectToInstance(result, ProjetoVO);
			this.dispatchEvent(e);
			
		}
		
		public function editarProjeto(projeto:ProjetoVO):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.editarProjeto", onResultOperation, onStatus, projeto);
			
		}
		
		public function getMinhasIdeias():void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getMinhasIdeias", onResultIdeias, onStatus, {usuario:LoginRepository.getInstance().loggedUser.nome});
			
		}
		
		public function getUltimasIdeias():void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getUltimasIdeias", onResultIdeias, onStatus);
			
		}
		
		public function getSprintsByProjeto(p:ProjetoVO):void
		{
			
			trace("p.id = ", p.id);
			
			ServerSide.call("facade.Facade.getSprintsByProjeto", onResultProjectSprints, onStatus, {id_projeto:p.id});
			
		}
		
		private function onResultProjectSprints(result:Object):void
		{
			
			trace("RepositorioProjetos.onResultSprints(result)");
			
			var r:Array = result as Array;
			var retorno:ArrayCollection = new ArrayCollection();
			
			for (var i:int = 0; i < r.length; i++) 
			{
				
				var sprint:SprintVO = ObjectTranslator.objectToInstance(r[i], SprintVO) as SprintVO;
				retorno.addItem(sprint);
				
			}
			
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.data = retorno;
			this.dispatchEvent(e);
			
			
		}
		
		public function getProjetosByEquipe(e:EquipeVO):void
		{
			
			ServerSide.call("facade.Facade.getProjetosByEquipe", onResultProjetosByEquipe, onStatus, e);
			
		}
		
		private function onResultProjetosByEquipe(result:Object):void
		{
			
			var arr:Array = result as Array;
			var retorno:ArrayCollection = new ArrayCollection();
			
			for (var i:int = 0; i < arr.length; i++) 
			{
				
				retorno.addItem(ObjectTranslator.objectToInstance(arr[i], ProjetoVO));
				
			}
			
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.data = retorno;
			this.dispatchEvent(e);
			
			
		}
		
		public function getListaProjetosProfessor(u:UserVO):void
		{
			
			this.gettingListaProfessor = true;
			ServerSide.call("facade.Facade.getProjetosProfessor", onResultIdeias, onStatus, {login:u.login});
			
		}
		
		public function getProjetosByProfessor(login:String, resultType:String = "RENDERER"):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			
			if(resultType == "RENDERER")
			{
				
				ServerSide.call("facade.Facade.getProjetosProfessor", onResultIdeias, onStatus, {login:login});
				
			} else 
			{
				
				gettingMeusProjetos = true;
				ServerSide.call("facade.Facade.getProjetosProfessor", onResultIdeias, onStatus, {login:login});
				
			}
			
		}
		
		public function definirDatas(p:ProjetoVO):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.definirDatas", onResultOperation, onStatus, p);
			
		}
		
		public function alterarStatus(p:ProjetoVO):void
		{
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.alterarStatus", onResultOperation, onStatus, p);
			
		}
		
		public function salvarSprint(s:SprintVO):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.cadastrarSprint", onResultOperation, onStatus, s);
			
		}
		
		public function isProfessorOrientador(login:String, idProjeto:int):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.isProfessorOrientador", onResultOperation, onStatus, {login:login, id_projeto:idProjeto});
			
		}
		
		public function deleteSprint(s:SprintVO):void
		{
			
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.deleteSprint", onResultOperation, onStatus, s);
			
		}
		
		public function definirDatasSprint(s:SprintVO):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.definirDatasSprint", onResultOperation, onStatus, s);
			
		}
		
		public function alterarStatusSprint(s:SprintVO):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.alterarStatusSprint", onResultOperation, onStatus, s);
			
		}
		
		public function solicitarOrientacao(p:ProjetoVO, e:EquipeVO, professor:UserVO):void
		{
			
			var id_projeto:int = ProjetoVO(p).id;
			var nome_projeto:String = ProjetoVO(p).nome;
			var nome_equipe:String = EquipeVO(e).nome;
			var nome_professor:String = UserVO(professor).nome;
			var email_professor:String = UserVO(professor).email;
			var id_equipe:int = EquipeVO(e).id;
			var id_professor:int = UserVO(professor).id;
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.solicitarOrientacao", onResultOperation, onStatus, {id_projeto:id_projeto, nome_projeto:nome_projeto, nome_equipe:nome_equipe, nome_professor:nome_professor, email_professor:email_professor, id_equipe:id_equipe, id_professor:id_professor});
			
		}
		
		public function getOrientacoesByProfessor(id_professor:int):void
		{
			
			trace("ProjetosRepository.getOrientacoesByProfessor(id_professor)");
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getOrientacoesByProfessor", onResultOrientacoes, onStatus, {id_professor:id_professor});
			
		}
		
		private function onResultOrientacoes(result:Object):void
		{
			
			var arr:Array = result as Array;
			
			trace("ProjetosRepository.onResultOrientacoes(", arr.length, ")");
			
			var retorno:ArrayCollection = new ArrayCollection();
			for (var i:int = 0; i < arr.length; i++) 
			{
				
				trace("id_equipe", arr[i].id_equipe);
				retorno.addItem(ObjectTranslator.objectToInstance(arr[i], OrientacaoVO));
				
			}
			
			var e:DataReturnEvent = new DataReturnEvent(DataReturnEvent.DATA_RETURN);
			e.data = retorno;
			this.dispatchEvent(e);
			
			
		}
		
		public function doesIdeiaHasOrientationRequest(id_ideia:int, id_equipe:int, id_professor:int):void
		{
			
			trace("ProjetosRepository.doesIdeiaHasOrientationRequest(", id_ideia, id_equipe, id_professor, ")");
			
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.doesIdeiaHasOrientationRequest", onResultOperation, onStatus, {id_ideia:id_ideia, id_equipe:id_equipe, id_professor:id_professor});
			
		}
		
		public function orientarProjeto(p:ProjetoVO):void
		{
			
			trace("ProjetosRepository.orientarProjeto(", p.id, p.equipe, p.orientador, ")");
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.orientarProjeto", onResultOperation, onStatus, p);
			
		}
		
		public function recusarOrientacao(id_orientacao:int):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.recusarOrientacao", onResultOperation, onStatus, {id_orientacao:id_orientacao});
			
		}
		
		public function getAllProjects():void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getAllProjects", onResultIdeias, onStatus);
			
		}
		
		public function getSolicitacoesMudanca(user:UserVO):void
		{
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.getSolicitacoesMudanca", onResultOrientacoes, onStatus, user);
			
		}
		
		private function onResultMudancas(result:Object):void
		{
			
			
			
		}
		
		public function deletarProjeto(p:ProjetoVO):void
		{
			
			ServerSide.setConnection("http://projects.guinetik.com/public/pineapple_backend/gateway.php");
			ServerSide.connection.objectEncoding = ObjectEncoding.AMF3;
			ServerSide.call("facade.Facade.deletarProjeto", onResultOperation, onStatus, {id_projeto:p.id});
			
		}
	}
}class ProjetosEnforcer {}