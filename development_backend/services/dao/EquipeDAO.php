<?php
require_once '../util/DBConnection.php';
require_once '../phpmailer/class.phpmailer.php';

class EquipeDAO {

	public function salvarEquipe($equipe) 
	{

		$nome = addslashes($equipe->getNome());
		$descricao = addslashes($equipe->getDescricao());
		$lider = addslashes($equipe->getLider());
		$equipe->setNomeMembro($lider);

		$query = "insert into equipe (nome, descricao, lider, criador) values ('$nome', '$descricao', '$lider', '$lider')";

		try {

			$mySQL = new DBConnection();
			if($mySQL->genericQuery($query)) return $this->salvarMembro($equipe);
			else return false;

		} catch (Exception $e) {

			throw $e->getMessage();

		}

		return $query;

	}
	
	public function convidarParaEquipe($equipe, $lider, $user)
	{
		
		$nome_equipe = $equipe->getNome();
		$nome_user = $user->getNome();
		$nome_lider = $lider->getNome();
		
		$id_usuario = $user->getId();
		$id_equipe = $equipe->getId();
		
		$email_user = $user->getEmail();
		$email_lider = $lider->getEmail();
		
		$assunto = "Pineapple Ideas : Convite para entrar na equipe $nome_equipe";
		$mensagem = "Olá $nome_user, <br/>Você está recebendo esse e-mail porque <i>$nome_lider</i> o convidou para participar da equipe <b>$nome_equipe</b>.";
		$mensagem .= "<br/>Para aceitar o convite, <a href='http://projects.guinetik.com/public/pineapple/' target='_blank'>acesse o sistema</a> e clique em Notificações.";
		$mensagem .= "<br/><br/><br/>---";
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
		$mail->AddAddress($email_user);
		$mail->IsHTML(true);
		$mail->Subject = utf8_decode($assunto);
		$mail->Body = utf8_decode($mensagem);
		$mail->SMTPAuth = true; // Usa autentica‹o SMTP? (opcional)
		$mail->Username = "pineapple.ideas@gmail.com";
		$mail->Password = 'pine123apple'; // Senha do servidor SMTP
		$mail->AddBCC('pineapple.ideas@gmail.com', 'Pineapple Ideas');
		
		
		try 
		{
		
			$mySQL = new DBConnection();
			if($mail->Send())
			{
				
				$query = "INSERT INTO equipe_convites (id_usuario, id_equipe) VALUES ($id_usuario, $id_equipe)";
				return $mySQL->genericQuery($query);
				
			}
		
		} catch (Exception $e) {
		
			return $e->getMessage();
		
		}
		
	}
	
	public function getAlunosConvidados($equipe)
	{
		
		$id = $equipe->getId();
		$status = "AGUARDANDO_RESPOSTA";
		$query = "SELECT DISTINCT u.* FROM usuario u INNER JOIN equipe_convites c ON u.id = c.id_usuario WHERE c.id_equipe = $id AND c.status = '$status'";
		
		try {
		
			$mySQL = new DBConnection();
			return $mySQL->consulta($query);
		
		} catch (Exception $e) {
		
			return $e->getMessage();
		
		}
		
	}
	
	public function getMeusConvites($usuario)
	{
		
		$id_usuario = $usuario->getId();
		
		$query = "SELECT DISTINCT c.id, e.nome, e.id AS id_equipe, c.status FROM equipe e INNER JOIN equipe_convites c ON e.id = c.id_equipe WHERE c.id_usuario = $id_usuario AND c.status = 'AGUARDANDO_RESPOSTA'";
		
		try {
		
			$mySQL = new DBConnection();
			return $mySQL->consulta($query);
		
		} catch (Exception $e) {
		
			return $e->getMessage();
		
		}
		
	}
	
	public function salvarMembro($equipe) 
	{

		$nomeMembro = addslashes($equipe->getNomeMembro());
		$nome = addslashes($equipe->getNome());

		$query = "insert into equipe_usuario (nomeMembro, nomeEquipe) values ('$nomeMembro', '$nome')";

		try {

			$mySQL = new DBConnection();
			return $mySQL->genericQuery($query);

		} catch (Exception $e) {

			return $e->getMessage();

		}

	}
	
	public function aceitarConvite($equipe, $id_convite)
	{
		
		$query = "update equipe_convites set status = 'CONVITE_ACEITO' where id = $id_convite"; 
		
		try {
		
			$mySQL = new DBConnection();
			if($mySQL->genericQuery($query))
			{
				return $this->salvarMembro($equipe);
				
			} else 
			{
				
				return false;
				
			}
		
		} catch (Exception $e) {
		
			return $e->getMessage();
		
		}
		
	}
	
	public function recusarConvite($id_convite)
	{
		
		$query = "update equipe_convites set status = 'CONVITE_RECUSADO' where id = $id_convite";
		
		try 
		{
		
			$mySQL = new DBConnection();
			return $mySQL->genericQuery($query);
		
		} catch (Exception $e) {
		
			return $e->getMessage();
		
		}
		
	}
	
	public function removeUsuarioFromEquipe($equipe, $usuario)
	{		
		$nome = addslashes($usuario);
		$nome_equipe = addslashes($equipe);
		
		$query = "DELETE FROM equipe_usuario WHERE nomeMembro = '$usuario' and nomeEquipe = '$nome_equipe'";
		
		try {
		
			$mySQL = new DBConnection();
			return $mySQL->genericQuery($query);
		
		} catch (Exception $e) {
		
			return $e->getMessage();
		
		}
		
	}
	
	public function removerEquipe($equipe, $id)
	{
		$nome_equipe = addslashes($equipe);
	
		$query = "DELETE FROM equipe_usuario WHERE nomeEquipe ='$nome_equipe'";
		$query2 = "DELETE FROM equipe WHERE id = $id";
	
		try {
	
			$mySQL = new DBConnection();
			if($mySQL->genericQuery($query))
			{
				
				return $mySQL->genericQuery($query2);
				
			} else 
			{
				
				return false;
				
			}
	
		} catch (Exception $e) {
	
			return $e->getMessage();
	
		}
	
	}

	public function getEquipes($equipe) 
	{

		$nomeMembro = $equipe->getNomeMembro();
		$query = "select equipe.id, equipe.nome, equipe.descricao, equipe.lider from equipe, equipe_usuario where equipe_usuario.nomeEquipe = equipe.nome and equipe_usuario.nomeMembro = '$nomeMembro'";

		try {

			$mySQL = new DBConnection();
			return $mySQL->consulta($query);

		} catch (Exception $e) {

			throw $e->getMessage();

		}

		return $query;

	}
	
	public function getEquipeById($id_equipe)
	{
		
		$query = "select * from equipe where id = $id_equipe";
		
		try {
		
			$mySQL = new DBConnection();
			return $mySQL->consulta($query);
		
		} catch (Exception $e) {
		
			throw $e->getMessage();
		
		}
		
		return $query;
		
	}
	
	
	public function getEquipesWhereUserIsLeader($usuario) 
	{

		$nomeMembro = $usuario->getNome();
		$query = "select equipe.id, equipe.nome, equipe.descricao, equipe.lider from equipe where equipe.lider = '$nomeMembro'";

		try {

			$mySQL = new DBConnection();
			return $mySQL->consulta($query);

		} catch (Exception $e) {

			throw $e->getMessage();

		}

		return $query;

	}

	public function getItemMembros($equipe) 
	{

		$nome = $equipe->getNome();
		
		$query = "SELECT u.id, u.nome, u.email, u.imagem FROM usuario u INNER JOIN equipe_usuario e ON u.nome = e.nomeMembro WHERE e.nomeEquipe = '$nome'";

		try {

			$mySQL = new DBConnection();
			return $mySQL->consulta($query);

		} catch (Exception $e) {

			return $e->getMessage();

		}

	}

	public function getNomeEquipe($usuario) {

		$nome = $usuario->getNome();
		$query = "select equipe.nome from equipe, equipe_usuario where equipe_usuario.nomeEquipe = equipe.nome and equipe_usuario.nomeMembro = '$nome'";

		try {

			$mySQL = new DBConnection();
			return $mySQL->consulta($query);

		} catch (Exception $e) {

			throw $e->getMessage();

		}

		return $query;

	}
	
		public function getNomeEquipeEspecial($equipe) {

		$nome = $equipe->getNome();
		$query = "select equipe.nome from equipe where equipe.nome like '%$nome%'";

		try {

			$mySQL = new DBConnection();
			return $mySQL->consulta($query);

		} catch (Exception $e) {

			throw $e->getMessage();

		}

		return $query;

	}

	public function getNomeAlunos() {

		$query = "select id, nome, email, imagem from usuario where entidade = 'Aluno'";

		try {

			$mySQL = new DBConnection();
			return $mySQL->consulta($query);

		} catch (Exception $e) {

			return $e->getMessage();

		}

	}
	
	public function getAllEquipes()
	{
		
		$query = "select e.*, u.imagem as imagem_criador, u2.imagem as imagem_lider from equipe e INNER JOIN usuario u ON u.nome = e.criador INNER JOIN usuario u2 ON u2.nome = e.lider";
		
		try {
		
			$mySQL = new DBConnection();
			return $mySQL->consulta($query);
		
		} catch (Exception $e) {
		
			return $e->getMessage();
		
		}
		
	}

	public function delegarLider($equipe) {

		$id = $equipe->getId();
		$lider = $equipe->getLider();
		$query = "update equipe set lider = '$lider' where id = $id";

		try {

			$mySQL = new DBConnection();
			return $mySQL->genericQuery($query);

		} catch (Exception $e) {

			return $e->getMessage();

		}

	}

}
?>