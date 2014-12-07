<?php

require_once ('../controller/SprintController.php');
require_once ('../controller/AtividadeController.php');
require_once ('../controller/UsuarioController.php');
require_once ('../controller/ExpertiseController.php');
require_once ('../controller/EquipeController.php');
require_once ('../controller/ProjetoController.php');
require_once ('../controller/ComentarioController.php');
require_once ('../controller/StatusController.php');
require_once ('../controller/LoginController.php');
require_once ('../basicas/Usuario.php');
require_once ('../basicas/Sprint.php');
require_once ('../basicas/Expertise.php');
require_once ('../basicas/Equipe.php');
require_once ('../basicas/Projeto.php');
require_once ('../basicas/Atividade.php');
require_once ('../basicas/Comentario.php');
require_once ('../basicas/Status.php');
require_once ('../util/XLSProcessor.php');

class Facade
{

	public function processarLogin($params)
	{

		$controller = new LoginController(3);
		return $controller->processarLogin($params["login"], $params["senha"]);

	}
	
	public function processarXLS($params)
	{
		
		$caminho = $params["caminho"];
		$processor = new XLSProcessor();
		return $processor->processarXLS($caminho);
		
	}
	
	public function getExpertisesUsuario($params)
	{
	
		$login = $params["login"];
	
		$expertise = new Expertise();
		$expertise->setLogin($login);
		$controller = new ExpertiseController();
		return $controller->getExpertisesUsuario($expertise);
	
	}
	
	public function deletarProjeto($params)
	{
		
		$id_projeto = $params["id_projeto"];
		$p = new Projeto();
		$p->setId($id_projeto);
		$controller = new ProjetoController();
		return $controller->deletarProjeto($p);
		
	}
	
	public function getExpertises()
	{
	
		$controller = new ExpertiseController();
		return $controller->getExpertises();
	}
	
	public function addExpertiseToUsuario($params)
	{
		
		$controller = new ExpertiseController();
		
		$id = $params["id"];
		$login = $params["login"];
		
		$expertise = new Expertise();
		$expertise->setId($id);
		$expertise->setLogin($login);
		
		return $controller->addExpertiseToUsuario($expertise);
		
	}
	
	public function saveAndAddExpertiseToUsuario($params)
	{
		
		$nome = $params["nome"];
		$color = $params["color"];
		$login = $params["login"];
		
		$expertise = new Expertise();
		$expertise->setNome($nome);
		$expertise->setColor($color);
		$expertise->setLogin($login);
		
		$controller = new ExpertiseController();
		$id_inserted = $controller->saveExpertise($expertise);
		$expertise->setId($id_inserted);
		
		return $controller->addExpertiseToUsuario($expertise);
		
	}
	
	public function removeExpertiseFromUsuario($params)
	{
		
		$id = $params["id"];
		$login = $params["login"];
		
		$expertise = new Expertise();
		$expertise->setId($id);
		$expertise->setLogin($login);
		
		$controller = new ExpertiseController();
		
		return $controller->removeExpertiseFromUsuario($expertise);
		
	}

	public function getAlunos()
	{

		$controller = new EquipeController();
		return $controller->getNomeAlunos();
	}

	public function getEquipesByUsuario($params)
	{

		$nome = $params["nome"];
		$equipe = new Equipe();
		$equipe->setNomeMembro($nome);

		$equipe_controller = new EquipeController();
		$equipes = $equipe_controller->getEquipes($equipe);

		return $equipes;

	}

	public function getItemMembros($params)
	{

		$nome = $params["nome"];

		$equipe = new Equipe();
		$equipe->setNome($nome);
		$controller = new EquipeController();
		return $controller->getItemMembros($equipe);

	}
	
	public function getMeusConvites($params)
	{
		
		$id_usuario = $params["id_usuario"];
		$usuario = new Usuario();
		$usuario->setId($id_usuario);
		
		$controller = new EquipeController();
		return $controller->getMeusConvites($usuario);
		
	}
	
	public function getAlunosConvidados($params)
	{
		
		$id_equipe = $params["id_equipe"];
		
		$equipe = new Equipe();
		$equipe->setId($id_equipe);
		
		$equipe_controller = new EquipeController();
		
		return $equipe_controller->getAlunosConvidados($equipe);
		
	}

	public function getEquipesWhereUserIsLeader($params)
	{

		$nome = $params["nome"];
		$usuario = new Usuario();
		$usuario->setNome($nome);

		$equipe_controller = new EquipeController();

		return $equipe_controller->getEquipesWhereUserIsLeader($usuario);

	}

	public function salvarEquipe($params)
	{

		$controller = new EquipeController();

		$nome = $params["nome"];
		$descricao = $params["descricao"];
		$lider = $params["lider"];

		$equipe = new Equipe();
		$equipe->setNome($nome);
		$equipe->setDescricao($descricao);
		$equipe->setLider($lider);

		return $controller->salvarEquipe($equipe);

	}
	
	public function convidarParaEquipe($params)
	{
		
		$id_equipe = $params["id_equipe"];
		$nome_equipe = $params["nome_equipe"];
		
		$equipe = new Equipe();
		$equipe->setId($id_equipe);
		$equipe->setNome($nome_equipe);
		
		$nome_lider = $params["nome_lider"];
		$email_lider = $params["email_lider"];
		$id_lider = $params["id_lider"];
		
		$lider = new Usuario();
		$lider->setId($id_lider);
		$lider->setNome($nome_lider);
		$lider->setEmail($email_lider);
		
		$nome_user = $params["nome_user"];
		$email_user = $params["email_user"];
		$id_user = $params["id_user"];
		
		$user = new Usuario();
		$user->setId($id_user);
		$user->setNome($nome_user);
		$user->setEmail($email_user);
		
		$controller = new EquipeController();
		return $controller->convidarParaEquipe($equipe, $lider, $user);
		
	}
	
	public function getEquipeById($params)
	{
		
		$id_equipe = $params["id_equipe"];
		$controller = new EquipeController();
		return $controller->getEquipeById($id_equipe);
		
	}
	
	public function getAllEquipes()
	{
		
		$controller = new EquipeController();
		return $controller->getAllEquipes();
		
	}
	
	public function aceitarConvite($params)
	{
	
		$controller = new EquipeController();
	
		$nomeMembro = $params["nomeMembro"];
		$nome = $params["nome"];
		$id_equipe = $params["id_equipe"];
		$id_convite = $params["id_convite"];
	
		$equipe = new Equipe();
		$equipe->setNomeMembro($nomeMembro);
		$equipe->setNome($nome);
		$equipe->setId($id_equipe);
	
		return $controller->aceitarConvite($equipe, $id_convite);
	
	}
	
	public function recusarConvite($params)
	{
		
		$id_convite = $params["id_convite"];
		$controller = new EquipeController();
		return $controller->recusarConvite($id_convite);
		
	}

	public function getIdeias()
	{

		$projetos_controller = new ProjetoController();
		return $projetos_controller->getProjetos();

	}
	
	public function getAllProjects()
	{
		
		$projetos_controller = new ProjetoController();
		return $projetos_controller->getAllProjects();
		
	}

	public function getUltimasIdeias()
	{

		$projetos_controller = new ProjetoController();
		return $projetos_controller->getUltimasIdeias();

	}

	public function getMinhasIdeias($params)
	{

		$usuario = $params["usuario"];
		$projetos_controller = new ProjetoController();
		return $projetos_controller->getMinhasIdeias($usuario);

	}

	public function getProfessores()
	{

		$controller = new UsuarioController();
		return $controller->getProfessores();

	}
	
	public function getProjetosProfessor($params)
	{
	
		$controller = new ProjetoController();
	
		$login = $params["login"];
	
		$usuario = new Usuario();
		$usuario->setNome($login);
		return $controller->getProjetosProfessor($usuario);
	
	}
	
	public function orientarProjeto($params)
	{
		
		$id = $params["id"];
		$equipe = $params["equipe"];
		$orientador = $params["orientador"];
		$dataInicio = $params["datainicio"];
		$dataFim = $params["datafim"];
		
		$p = new Projeto();
		$p->setId($id);
		$p->setEquipe($equipe);
		$p->setOrientador($orientador);
		$p->setDataInicio($dataInicio);
		$p->setDataFim($dataFim);
		
		$controller = new ProjetoController();
		return $controller->orientarProjeto($p);
		
	}
	
	public function recusarOrientacao($params)
	{
		
		$id_orientacao = $params["id_orientacao"];
		$controller = new ProjetoController();
		return $controller->recusarOrientacao($id_orientacao);
		
	}
	
	public function getProjetosById($params)
	{
		
		$id_projeto = $params["id_projeto"];
		$controller = new ProjetoController();
		return $controller->getProjetosById($id_projeto);
		
	}

	public function getProjetoByEquipes($params)
	{

		$equipes = $params["equipes"];

		$projetos_controller = new ProjetoController();
		$projetos = array();

		for($x=0; $x< count($equipes); $x++)
		{
				
			$equipe = new Equipe();
			$equipe->setNome($equipes[$x]);
			array_push($projetos, $projetos_controller->getProjetosEquipe($equipe));
				
		}

		return $projetos;

	}
	
	public function definirDatas($params)
	{
	
		$controller = new ProjetoController();
	
		$id = $params["id"];
		$dataInicio = $params["datainicio"];
		$dataFim = $params["datafim"];
	
	
		$projeto = new Projeto();
		$projeto->setId($id);
		$projeto->setDataInicio($dataInicio);
		$projeto->setDataFim($dataFim);
		return $controller->definirDatas($projeto);
	
	}
	
	public function alterarStatus($params)
	{
	
		$controller = new ProjetoController();
	
		$id = $params["id"];
		$status = $params["status"];
	
		$projeto = new Projeto();
		$projeto->setId($id);
		$projeto->setStatus($status);
		
		return $controller->alterarStatus($projeto);
	
	}
	
	public function cadastrarSprint($params)
	{
	
		$controller = new SprintController();
	
		$id = $params["id"];
		$nome = $params["nome"];
		$status = $params["status"];
		$descricao = $params["descricao"];
		$dataInicio = $params["datainicio"];
		$dataFim = $params["datafim"];
		$idProjeto = $params["idprojeto"];
	
		$sprint = new Sprint();
		$sprint->setId($id);
		$sprint->setNome($nome);
		$sprint->setStatus($status);
		$sprint->setDescricao($descricao);
		$sprint->setDataInicio($dataInicio);
		$sprint->setDataFim($dataFim);
		$sprint->setIdProjeto($idProjeto);
	
	
		return $controller->salvarSprint($sprint);
	
	
	}
	
	public function removeUsuarioFromEquipe($params)
	{
		
		$usuario = $params["nome"];
		$equipe = $params["equipe"];
		$controller = new EquipeController();
		return $controller->removeUsuarioFromEquipe($equipe, $usuario);
		
	}
	
	public function removerEquipe($params)
	{
		
		$equipe = $params["nome"];
		$id = $params["id"];
		
		$controller = new EquipeController();
		return $controller->removerEquipe($equipe, $id);
		
	}
	
	public function delegarLider($params)
	{
	
		$controller = new EquipeController();
	
		$id = $params["id"];
		$lider = $params["lider"];
	
		$equipe = new Equipe();
		$equipe->setId($id);
		$equipe->setLider($lider);
	
		return $controller->delegarLider($equipe);
	
	}
	
	public function getProjetosByEquipe($params)
	{
		
		$nome = $params["nome"];
		
		$equipe = new Equipe();
		$equipe->setNome($nome);
		
		$projetos_controller = new ProjetoController();
		return $projetos_controller->getProjetosEquipe($equipe);
		
	}

	public function getSprintsByProjeto($params)
	{

		$id = $params["id_projeto"];
		$projeto = new Projeto();
		$projeto->setId($id);

		$sprint_controller = new SprintController();
		return $sprint_controller->getSprints($projeto);

	}

	public function salvarAtividade($params)
	{

		$controller = new AtividadeController();

		$id = $params["id"];
		$nome = $params["nome"];
		$status = $params["status"];
		$descricao = $params["descricao"];
		$idSprint = $params["idsprint"];

		$atividade = new Atividade();
		$atividade->setId($id);
		$atividade->setNome($nome);
		$atividade->setStatus($status);
		$atividade->setDescricao($descricao);
		$atividade->setIdSprint($idSprint);


		return $controller->salvarAtividade($atividade);


	}
	
	public function createAtividade($params)
	{
	
		$controller = new AtividadeController();
	
		$id = $params["id"];
		$nome = $params["nome"];
		$status = $params["status"];
		$descricao = $params["descricao"];
		$idSprint = $params["idsprint"];
	
		$atividade = new Atividade();
		$atividade->setId($id);
		$atividade->setNome($nome);
		$atividade->setStatus($status);
		$atividade->setDescricao($descricao);
		$atividade->setIdSprint($idSprint);
	
	
		return $controller->createAtividade($atividade);
	
	
	}

	public function deletarAtividade($params)
	{

		$controller = new AtividadeController();

		$id = $params["id"];

		$atividade = new Atividade();
		$atividade->setId($id);

		return $controller->deletarAtividade($atividade);

	}

	public function getComentariosByProjeto($params)
	{

		$id = $params["id_projeto"];
		$projeto = new Projeto();
		$projeto->setId($id);

		$sprint_controller = new ComentarioController();
		return $sprint_controller->getComentarios($projeto);

	}
	
	public function getUltimosComentarios($params)
	{
		
		$usuario = $params["usuario"];
		$sprint_controller = new ComentarioController();
		return $sprint_controller->getUltimosComentarios($usuario);
		
	}
	
	public function getUltimosComentariosByProfessor($params)
	{
		
		$usuario = new Usuario();
		$usuario->setLogin($params["login"]);
		$sprint_controller = new ComentarioController();
		return $sprint_controller->getUltimosComentariosByProfessor($usuario);
		
	}

	public function salvarComentario($params)
	{

		$controller = new ComentarioController();

		$autor = $params["autor"];
		$descricao = $params["descricao"];
		$idProjeto = $params["idprojeto"];

		$comentario = new Comentario();
		$comentario->setAutor($autor);
		$comentario->setDescricao($descricao);
		$comentario->setIdProjeto($idProjeto);

		return $controller->salvarComentario($comentario);


	}

	public function editarUsuario($params)
	{

		$usuario = new Usuario();
		$usuario->setNome($params["nome"]);
		$usuario->setEmail($params["email"]);
		$usuario->setMensagem($params["mensagem"]);
		$usuario->setImagem($params["imagem"]);
		$usuario->setSenha($params["senha"]);
		$usuario->setLogin($params["login"]);
		$nomeUsuario = $params["nome_usuario"];

		$controller = new UsuarioController();
		return $controller->editarUsuario($usuario, $nomeUsuario);


	}
	
	public function getListaUsuarios()
	{
		
		$controller = new UsuarioController();
		return $controller->getListaUsuarios();
		
	}
	
	function getUsuarios($params)
	{
	
		$nome = $params["nome"];
	
		$usuario = new Usuario();
		$usuario->setNome($nome);
		$controller = new UsuarioController();
		return $controller->getUsuarios($usuario);
	
	}
	
	public function solicitarMudanca($params)
	{
	
		$id_equipe = $params["id_equipe"];
		$id_professor = $params["id_professor"];
		$resumo = $params["mensagem"];
		$projeto = $params["projeto"];
		$id_orientacao = $params["id_orientacao"];
		
		$controllerEquipe = new EquipeController();
		$result_equipe = $controllerEquipe->getEquipeById($id_equipe);
		$lider_nome= $result_equipe[0]["lider"];
		
		$usuario = new Usuario();
		$usuario->setNome($lider_nome);
		
		$controllerLider = new UsuarioDAO();
		$resultLider = $controllerLider->getUsuarios($usuario);
		
		$lider = new Usuario();
		$lider->setNome($resultLider[0]["nome"]);
		$lider->setEmail($resultLider[0]["email"]);
		
		$controllerProfessor = new UsuarioDAO();
		$result_professor = $controllerProfessor->getUsuarioById($id_professor);
		
		$professor = new Usuario();
		$professor->setNome($result_professor[0]["nome"]);
		$professor->setEmail($result_professor[0]["email"]);
		$nomeProfessor = $professor->getNome();
		$nomeLider = $lider->getNome(); 
		$assunto = "Pineapple Ideas: Solicitação de Mudança no projeto - $projeto";
		
		$mensagem = "Olá $nomeLider, <br/>Você está recebendo esse e-mail porque o professor <i>$nomeProfessor</i> solicitou mudanças no projeto <b>$projeto</b>.";
		$mensagem .= "<br/>Leia os comentários abaixo e <a href='http://projects.guinetik.com/public/pineapple/' target='_blank'>acesse o sistema</a> para alterar o seu projeto.<br/>";
		$mensagem .= "<br/>---";
		$mensagem .= "<br/><br/>$resumo";
		$mensagem .= "<br/>---";
		$mensagem .= "<br/>Atenciosamente, seus amigos do<br/>";
		$mensagem .= "<img src='http://projects.guinetik.com/public/pineapple/assets/logo_h.png' width='185' height='75'/>";
		
		$mail = new PHPMailer();
		$mail->setLanguage("br");
		$mail->CharSet = "utf-8";
		$mail->IsSMTP();
		$mail->Host = "ssl://smtp.gmail.com";
		$mail->Port = 465;
		$mail->From = "pineapple.ideas@gmail.com";
		$mail->FromName = "Pineapple Ideas";
		$mail->AddAddress($lider->getEmail());
		$mail->IsHTML(true);
		$mail->Subject = ($assunto);
		$mail->Body = ($mensagem);
		$mail->SMTPAuth = true; // Usa autentica‹o SMTP? (opcional)
		$mail->Username = "pineapple.ideas@gmail.com";
		$mail->Password = 'pine123apple'; // Senha do servidor SMTP
		$mail->AddBCC('pineapple.ideas@gmail.com', 'Pineapple Ideas');
		
		$projetoController = new ProjetoController();
		
		if($projetoController->solicitarMudanca($id_orientacao))
		{
			
			return $mail->Send();
			
		} else 
		{
			
			return false;
			
		}
		
	}

	public function getSolicitacoesMudanca($params)
	{
		
		$nome = $params["nome"];
		$usuario = new Usuario();
		$usuario->setNome($nome);
		$projetoController = new ProjetoController();
		return $projetoController->getSolicitacoesMudanca($usuario);
		
	}
	
	public function reenviarSolicitacao($params)
	{
		
		$id_orientacao = $params["id_orientacao"];
		$controller = new ProjetoController();
		return $controller->reenviarSolicitacao($id_orientacao);
		
	}
		

	public function getAtividadesBySprint($params)
	{

		$idSprint = $params["id_sprint"];

		$sprint = new Sprint();
		$sprint->setId($idSprint);

		$controller = new AtividadeController();
		return $controller->getAtividades($sprint);

	}

	public function editarProjeto($params)
	{

		$controller = new ProjetoController();
		$descricao = $params["descricao"];
		$nome = $params["nome"];

		$projeto = new Projeto();
		$projeto->setDescricao($descricao);
		$projeto->setNome($nome);

		return $controller->editarProjeto($projeto);

	}

	public function cadastrarProjeto($params)
	{

		$controller = new ProjetoController();

		$nome = $params["nome"];
		$autor = $params["autor"];
		$descricao = $params["descricao"];

		$projeto = new Projeto();
		$projeto->setNome($nome);
		$projeto->setAutor($autor);
		$projeto->setDescricao($descricao);

		return $controller->cadastrarProjeto($projeto);

	}
	
	public function isProfessorOrientador($params)
	{
		
		$login = $params["login"];
		$id_projeto = $params["id_projeto"];
		
		$controller = new ProjetoController();
		$result = $controller->isProfessorOrientador($login, $id_projeto);
		
		return $result[0]["result"] > 0;
		
	}
	
	public function doesIdeiaHasOrientationRequest($params)
	{
		
		$id_ideia = $params["id_ideia"];
		$id_equipe = $params["id_equipe"];
		$id_professor = $params["id_professor"];
		
		$controller = new ProjetoController();
		$result = $controller->doesIdeiaHasOrientationRequest($id_ideia, $id_equipe, $id_professor);
		
		return $result[0]["result"] > 0;
		
	}
	
	public function deleteSprint($params)
	{
		
		$id = $params["id"];
		$sprint = new Sprint();
		$sprint->setId($id);
		
		$controller = new SprintController();
		return $controller->deleteSprint($sprint);
		
	}
	
	public function definirDatasSprint($params)
	{
		
		$controller = new SprintController();
	
		$id = $params["id"];
		$nome = $params["nome"];
		$status = $params["status"];
		$descricao = $params["descricao"];
		$dataInicio = $params["datainicio"];
		$dataFim = $params["datafim"];
		$idProjeto = $params["idprojeto"];
	
		$sprint = new Sprint();
		$sprint->setId($id);
		$sprint->setNome($nome);
		$sprint->setStatus($status);
		$sprint->setDescricao($descricao);
		$sprint->setDataInicio($dataInicio);
		$sprint->setDataFim($dataFim);
		$sprint->setIdProjeto($idProjeto);
	
	
		return $controller->definirDatas($sprint);
		
	}
	
	public function alterarStatusSprint($params)
	{
		
		$controller = new SprintController();
	
		$id = $params["id"];
		$nome = $params["nome"];
		$status = $params["status"];
		$descricao = $params["descricao"];
		$dataInicio = $params["datainicio"];
		$dataFim = $params["datafim"];
		$idProjeto = $params["idprojeto"];
	
		$sprint = new Sprint();
		$sprint->setId($id);
		$sprint->setNome($nome);
		$sprint->setStatus($status);
		$sprint->setDescricao($descricao);
		$sprint->setDataInicio($dataInicio);
		$sprint->setDataFim($dataFim);
		$sprint->setIdProjeto($idProjeto);
	
	
		return $controller->alterarStatus($sprint);
		
	}
	
	public function getOrientacoesByProfessor($params)
	{
		
		$id_professor = $params["id_professor"];
		
		$controller = new ProjetoController();
		return $controller->getOrientacoesByProfessor($id_professor);
		
	}
	
	public function solicitarOrientacao($params)
	{
		
		$id_projeto = $params["id_projeto"];
		$id_professor = $params["id_professor"];
		$id_equipe = $params["id_equipe"];
		$nome_projeto = $params["nome_projeto"];
		$nome_equipe = $params["nome_equipe"];
		$nome_professor = $params["nome_professor"];
		$email_professor = $params["email_professor"];
		
		$controller = new ProjetoController();
		return $controller->solicitarOrientacao($id_projeto, $nome_projeto, $nome_equipe, $nome_professor, $email_professor, $id_equipe, $id_professor);
		
	}

}

?>