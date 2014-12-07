package com.pineapple.frontend.controllers
{
	import com.pineapple.business.model.AtividadeVO;
	import com.pineapple.business.model.EquipeVO;
	import com.pineapple.business.model.OrientacaoVO;
	import com.pineapple.business.model.ProjetoVO;
	import com.pineapple.business.model.SprintVO;
	import com.pineapple.frontend.PineappleFrontend;
	import com.pineapple.frontend.views.paneis.CadastrarAtividades;
	import com.pineapple.frontend.views.paneis.CadastrarComentario;
	import com.pineapple.frontend.views.paneis.CadastrarIdeia;
	import com.pineapple.frontend.views.paneis.CadastrarSprint;
	import com.pineapple.frontend.views.paneis.ConvidarParaEquipe;
	import com.pineapple.frontend.views.paneis.CriarEquipe;
	import com.pineapple.frontend.views.paneis.EditarAtividade;
	import com.pineapple.frontend.views.paneis.EditarCadastro;
	import com.pineapple.frontend.views.paneis.EditarResumo;
	import com.pineapple.frontend.views.paneis.EditarSprint;
	import com.pineapple.frontend.views.paneis.MeusProjetos;
	import com.pineapple.frontend.views.paneis.MinhasEquipes;
	import com.pineapple.frontend.views.paneis.SolicitarMudanca;
	import com.pineapple.frontend.views.paneis.SolicitarOrientacao;
	import com.pineapple.frontend.views.paneis.VisualizarAtividades;
	import com.pineapple.frontend.views.paneis.VisualizarEquipe;
	import com.pineapple.frontend.views.paneis.VisualizarEquipes;
	import com.pineapple.frontend.views.paneis.VisualizarIdeia;
	import com.pineapple.frontend.views.paneis.VisualizarIdeias;
	import com.pineapple.frontend.views.paneis.VisualizarPerfil;
	import com.pineapple.frontend.views.paneis.VisualizarProjeto;
	import com.pineapple.frontend.views.paneis.VisualizarSprint;
	import com.pineapple.frontend.views.paneis.WebcamCapturer;
	import com.pineapple.frontend.views.ui.UIEvent;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	
	import mx.core.IFlexModuleFactory;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;

	[Event(name="refresh_ui", type="com.pineapple.frontend.views.ui.UIEvent")]
	public class MenuController extends EventDispatcher
	{
		private var _root:DisplayObject;
		private var _factory:IFlexModuleFactory;
		
		public function resolveIntent(intent:String):void
		{
			
			switch (intent)
			{
				case "CADASTRAR_IDEIA":
					
					var cadastrarIdeia:CadastrarIdeia=new CadastrarIdeia();
					cadastrarIdeia.styleName = PineappleFrontend.getInstance().styleName;
					PopUpManager.addPopUp(cadastrarIdeia, this.root, true, null, factory);
					PopUpManager.centerPopUp(cadastrarIdeia);
					cadastrarIdeia.addEventListener(CloseEvent.CLOSE, onPopUpClose);
					
					break;
				
				case "EDITAR_CADASTRO":
					
					var editarPerfil:EditarCadastro=new EditarCadastro();
					editarPerfil.styleName = PineappleFrontend.getInstance().styleName;
					PopUpManager.addPopUp(editarPerfil, this.root, true, null, factory);
					PopUpManager.centerPopUp(editarPerfil);
					
					break;
				
				case "MEUS_PROJETOS":
					
					var meusProjetos:MeusProjetos=new MeusProjetos();
					meusProjetos.styleName = PineappleFrontend.getInstance().styleName;
					PopUpManager.addPopUp(meusProjetos, this.root, true, null, factory);
					PopUpManager.centerPopUp(meusProjetos);
					meusProjetos.addEventListener(CloseEvent.CLOSE, onPopUpClose);
					
					break;
				
				case "CRIAR_EQUIPE":
					
					var p3:CriarEquipe=new CriarEquipe();
					PopUpManager.addPopUp(p3, this.root, true);
					p3.styleName = PineappleFrontend.getInstance().styleName;
					PopUpManager.centerPopUp(p3);
					
					break;
				
				case "MINHAS_EQUIPES":
					
					var p2:MinhasEquipes=new MinhasEquipes();
					PopUpManager.addPopUp(p2, this.root, true);
					p2.styleName = PineappleFrontend.getInstance().styleName;
					PopUpManager.centerPopUp(p2);
					
					break;
				
				case "BUSCAR_EQUIPE":
					
					var p:VisualizarEquipes=new VisualizarEquipes();
					PopUpManager.addPopUp(p, this.root, true);
					p.styleName = PineappleFrontend.getInstance().styleName;
					PopUpManager.centerPopUp(p);
					
					break;
				
				case "VISUALIZAR_IDEIAS":
					
					var visualizarIdeias:VisualizarIdeias=new VisualizarIdeias();
					visualizarIdeias.intent="GET_ALL_IDEIAS";
					visualizarIdeias.width=1100;
					visualizarIdeias.height=650;
					
					PopUpManager.addPopUp(visualizarIdeias, this.root, true);
					visualizarIdeias.styleName = PineappleFrontend.getInstance().styleName;
					PopUpManager.centerPopUp(visualizarIdeias);
					visualizarIdeias.getData();
					visualizarIdeias.addEventListener(CloseEvent.CLOSE, onPopUpClose);
					
					break;
				
				case "MINHAS_IDEIAS":
					
					var visualizarMinhasIdeias:VisualizarIdeias=new VisualizarIdeias();
					visualizarMinhasIdeias.intent="GET_MINHAS_IDEIAS";
					visualizarMinhasIdeias.width=1100;
					visualizarMinhasIdeias.height=650;
					visualizarMinhasIdeias.styleName = PineappleFrontend.getInstance().styleName;
					PopUpManager.addPopUp(visualizarMinhasIdeias, this.root, true, null, factory);
					PopUpManager.centerPopUp(visualizarMinhasIdeias);
					visualizarMinhasIdeias.getData();
					visualizarMinhasIdeias.addEventListener(CloseEvent.CLOSE, onPopUpClose);
					
					break;
				
				
			}
			
		}

		public function get root():DisplayObject
		{
			return _root;
		}

		public function set root(value:DisplayObject):void
		{
			_root = value;
		}

		public function get factory():IFlexModuleFactory
		{
			return _factory;
		}

		public function set factory(value:IFlexModuleFactory):void
		{
			_factory = value;
		}

		
		public function openConvidarParaEquipe(selectedEquipe:String = ""):void
		{
			
			var p:ConvidarParaEquipe=new ConvidarParaEquipe();
			p.styleName = PineappleFrontend.getInstance().styleName;
			
			if(selectedEquipe != "")
				p.selectedEquipe=selectedEquipe;
			
			PopUpManager.addPopUp(p, this.root, true);
			PopUpManager.centerPopUp(p);	
			
		}
		
		public function openWebcamCapturer():DisplayObjectContainer
		{
			
			var p:WebcamCapturer=new WebcamCapturer();
			p.styleName = PineappleFrontend.getInstance().styleName;
			PopUpManager.addPopUp(p, this.root, true);
			PopUpManager.centerPopUp(p);
			return p;
			
		}
		
		public function openCriarEquipes():void
		{
			
			PopUpManager.centerPopUp(PopUpManager.createPopUp(this.root, CriarEquipe, true));
			
		}
		
		public function visualizarEquipe(equipe:EquipeVO):void
		{

			var p:VisualizarEquipe = new VisualizarEquipe();
			var id_equipe:int = equipe.id;
			
			p.styleName = PineappleFrontend.getInstance().styleName;
			PopUpManager.addPopUp(p, this.root, true);
			PopUpManager.centerPopUp(p);
			
			if(equipe.nome != null)
			{
				
				p.equipe = equipe;
				p.onChange();
				
			} else 
			{
				
				p.getEquipeById(id_equipe);	
				
			}
			
		}
		
		public function openEditarAtividade():DisplayObjectContainer
		{
			
			var p:EditarAtividade=new EditarAtividade();
			p.styleName = PineappleFrontend.getInstance().styleName;
			PopUpManager.addPopUp(p, this.root, true);
			PopUpManager.centerPopUp(p);
			
			return p;
			
		}
		
		public function visualizarProjeto(projeto:ProjetoVO):void
		{
			
			var p:VisualizarProjeto=new VisualizarProjeto();
			p.width=800;
			p.height=500;
			p.styleName = PineappleFrontend.getInstance().styleName;
			PopUpManager.addPopUp(p, this.root, false);
			PopUpManager.centerPopUp(p);
			p.addEventListener(CloseEvent.CLOSE, onPopUpClose);
			
			var id_projeto:int = projeto.id;
			if(projeto.datacadastro != null)
			{
				
				p.projeto = projeto;
				p.init();
				
			} else 
			{
				
				p.getProjetoById(id_projeto);
				
			}
			
			
		}
		
		public function abrirPerfil(nome:String):void
		{
			
			var p:VisualizarPerfil=new VisualizarPerfil();
			p.styleName = PineappleFrontend.getInstance().styleName;
			PopUpManager.addPopUp(p, this.root, false);
			PopUpManager.centerPopUp(p);
			p.nome=nome;
			p.init();
			
		}
		
		public function solicitarOrientacao(id_ideia:int):void
		{
			
			var p:SolicitarOrientacao=new SolicitarOrientacao();
			p.idIdeia= id_ideia;
			p.styleName=PineappleFrontend.getInstance().styleName;
			PopUpManager.addPopUp(p, this.root, true);
			PopUpManager.centerPopUp(p);
			
		}
		
		public function adicionarComentario(projeto:ProjetoVO):void
		{
			
			var adicionarComentario:CadastrarComentario=new CadastrarComentario();
			adicionarComentario.projeto=projeto;
			adicionarComentario.styleName=PineappleFrontend.getInstance().styleName;
			adicionarComentario.addEventListener(CloseEvent.CLOSE, onPopUpClose);
			PopUpManager.addPopUp(adicionarComentario, this.root, false);
			PopUpManager.centerPopUp(adicionarComentario);
			
		}
		
		protected function onPopUpClose(event:CloseEvent):void
		{
			
			trace("MenuController.onPopUpClose(event)");
			this.dispatchEvent(new UIEvent(UIEvent.REFRESH_UI));
			
		}
		
		public function editarResumo(projeto:ProjetoVO):DisplayObjectContainer
		{
			
			var p:EditarResumo=new EditarResumo();
			p.projeto=projeto;
			p.styleName=PineappleFrontend.getInstance().styleName;
			p.addEventListener(CloseEvent.CLOSE, onPopUpClose);
			PopUpManager.addPopUp(p, this.root, false);
			PopUpManager.centerPopUp(p);
			
			return p;
			
		}
		
		public function cadastrarSprint(id_projeto:int):DisplayObjectContainer
		{
			
			var p:CadastrarSprint=new CadastrarSprint();
			p.idProjeto=id_projeto;
			PopUpManager.addPopUp(p, this.root, true);
			PopUpManager.centerPopUp(p);
			return p;
			
		}
		
		public function cadastrarAtividade(idprojeto:int, idsprint:int):DisplayObjectContainer
		{
			
			var p:CadastrarAtividades=new CadastrarAtividades();
			p.idProjeto=idprojeto;
			p.idSprint=idsprint;
			p.styleName = PineappleFrontend.getInstance().styleName;
			PopUpManager.addPopUp(p, this.root, true);
			PopUpManager.centerPopUp(p);
			return p;
			
		}
		
		public function editarSprint(sprint:SprintVO):DisplayObjectContainer
		{
			
			var p:EditarSprint = new EditarSprint();
			p.sprint = sprint;
			p.styleName = PineappleFrontend.getInstance().styleName;
			PopUpManager.addPopUp(p, this.root, true);
			PopUpManager.centerPopUp(p);
			p.init();
			return p;
			
		}
		
		public function visualizarSprint(sprint:SprintVO):void
		{
			
			var panelSprint:VisualizarSprint 		= new VisualizarSprint();
			panelSprint.width 						= 800;
			panelSprint.height 						= 500;
			panelSprint.sprint	 					= sprint;
			panelSprint.addEventListener(CloseEvent.CLOSE, onPopUpClose);
			PopUpManager.addPopUp(panelSprint, this.root, false);
			panelSprint.styleName = PineappleFrontend.getInstance().styleName;
			PopUpManager.centerPopUp(panelSprint);
			panelSprint.init();
			
		}
		
		public function visualizarAtividade(atividade:AtividadeVO):void
		{
			
			var panelAtividade:VisualizarAtividades = new VisualizarAtividades();
			panelAtividade.width 					= 800;
			panelAtividade.height 					= 500;
			panelAtividade.atividade 				= atividade
			panelAtividade.addEventListener(CloseEvent.CLOSE, onPopUpClose);
			panelAtividade.styleName = PineappleFrontend.getInstance().styleName;
			PopUpManager.addPopUp(panelAtividade, this.root, false);
			PopUpManager.centerPopUp(panelAtividade);
			panelAtividade.init();
			
		}
		
		public function visualizarIdeia(ideia:ProjetoVO):void
		{
			
			var p:VisualizarIdeia=new VisualizarIdeia();
			if(ideia.nome != null)
			{
				
				p.ideia=ideia;
				p.init();
				
			} else 
			{
				
				
				p.getIdeaById(ideia.id);
				
			}
			
			p.styleName = PineappleFrontend.getInstance().styleName;
			PopUpManager.addPopUp(p, this.root, true);
			PopUpManager.centerPopUp(p);
			
		}
		
		public function solicitarMudanca(o:OrientacaoVO):void
		{
			
			var p:SolicitarMudanca = new SolicitarMudanca();
			p.orientacao = o;
			p.styleName = PineappleFrontend.getInstance().styleName;
			p.addEventListener(CloseEvent.CLOSE, onPopUpClose);
			PopUpManager.addPopUp(p, this.root, true);
			PopUpManager.centerPopUp(p);
			
		}
		
		public function cadastrarIdeia():void
		{
			
			PopUpManager.centerPopUp(PopUpManager.createPopUp(this.root, CadastrarIdeia, true));
			
		}
		
		public function criarEquipe():void
		{
			
			PopUpManager.centerPopUp(PopUpManager.createPopUp(this.root, CriarEquipe, true));
			
		}
	}
}