<?php
require_once '../util/DBConnection.php';
require_once '../phpmailer/class.phpmailer.php';

class ProjetoDAO {

	public function getProjetos() {

		$query = "select p.*, u.imagem from projeto p inner join usuario u on p.autor = u.nome where p.equipe = '' or p.equipe = '-'  order by p.dataCadastro DESC";

		try {

			$mySQL = new DBConnection();
			return $mySQL->consulta($query);

		} catch (Exception $e) {

			throw $e->getMessage();

		}

		return $query;

	}
	
	public function getAllProjects()
	{
		
		$query = "select * from projeto where orientador != '-'";

		try {

			$mySQL = new DBConnection();
			return $mySQL->consulta($query);

		} catch (Exception $e) {

			return $e->getMessage();

		}

	}

	public function getUltimasIdeias() {

		$query = "select p.*, u.imagem from projeto p inner join usuario u on p.autor = u.nome where p.equipe = '' or p.equipe = '-'  order by p.dataCadastro DESC LIMIT 3";

		try {

			$mySQL = new DBConnection();
			return $mySQL->consulta($query);

		} catch (Exception $e) {

			throw $e->getMessage();

		}

		return $query;

	}

	public function getMinhasIdeias($usuario)
	{

		$query = "select p.*, u.imagem from projeto p inner join usuario u on p.autor = u.nome where p.equipe = '' or p.equipe = '-' and p.autor = '$usuario' order by p.dataCadastro DESC";

		try {

			$mySQL = new DBConnection();
			return $mySQL->consulta($query);

		} catch (Exception $e) {

			throw $e->getMessage();

		}

		return $query;

	}

	public function editarProjeto($projeto)
	{

		$descricao = addslashes($projeto->getDescricao());
		$nome = addslashes($projeto->getNome());
		$query = "update projeto set descricao = '$descricao' where nome = '$nome'";

		try
		{

			$mySQL = new DBConnection();
			return $mySQL->genericQuery($query);

		} catch (Exception $e)
		{

			return $e->getMessage();

		}

	}
	
	public function deletarProjeto($projeto)
	{
		
		$id_projeto = $projeto->getId();
		
		$query = "DELETE FROM projeto WHERE id = $id_projeto";

		try
		{

			$mySQL = new DBConnection();
			return $mySQL->genericQuery($query);

		} catch (Exception $e)
		{

			return $e->getMessage();

		}
		
	}

	public function getProjetosEquipe($equipe) {

		$nome = $equipe->getNome();

		$query = "select * from projeto where equipe ='$nome'";

		try {

			$mySQL = new DBConnection();
			return $mySQL->consulta($query);

		} catch (Exception $e) {

			throw $e->getMessage();

		}

		return $query;

	}

	public function getProjetosProfessor($usuario) {

		$nome = $usuario->getNome();

		$query = "select * from projeto where orientador ='$nome'";

		try {

			$mySQL = new DBConnection();
			return $mySQL->consulta($query);

		} catch (Exception $e) {

			throw $e->getMessage();

		}

		return $query;

	}
	
	public function getProjetosById($id_projeto)
	{
		
		$query = "select * from projeto where id = $id_projeto";

		try {

			$mySQL = new DBConnection();
			return $mySQL->consulta($query);

		} catch (Exception $e) {

			throw $e->getMessage();

		}

		return $query;
		
	}
	
	public function reenviarSolicitacao($id_orientacao)
	{
		
		$query = "UPDATE equipe_orientacoes SET status = 'ORIENTACAO_REENVIADA' WHERE id = $id_orientacao";
		
		try 
		{
			
			
			$mySQL = new DBConnection();
			return $mySQL->genericQuery($query);

		} catch (Exception $e) 
		{

			return $e->getMessage();

		}
		
	}

	public function cadastrarProjeto($projeto)
	{

		$nome = addslashes($projeto->getNome());
		$autor = addslashes($projeto->getAutor());
		$descricao = addslashes($projeto->getDescricao());

		$query = "insert into projeto (nome, autor, descricao, status) values ('$nome', '$autor', '$descricao', 'Inicio')";

		try {

			$mySQL = new DBConnection();
			return $mySQL->genericQuery($query);

		} catch (Exception $e) {

			return $e->getMessage();

		}

		return $query;

	}
	
	public function avisarLideres($id_projeto)
	{
		
		$query = "SELECT e.nome AS nome_equipe, u.nome AS nome_lider, u.email AS email_lider, p.nome AS nome_projeto, u2.nome AS nome_professor FROM equipe_orientacoes o INNER JOIN equipe e ON o.equipe = e.id INNER JOIN usuario u ON u.nome = e.lider INNER JOIN projeto p ON p.id = o.projeto INNER JOIN usuario u2 ON u2.id = o.professor WHERE o.projeto = $id_projeto";
				
		try 
		{

			$mySQL = new DBConnection();
			$results = $mySQL->genericQuery($query);
			
			if(count($results) > 0)
			{
				
				for($x=0; $x< count($equipes); $x++)
				{
						
					$nome_equipe = $results[$x]["nome_equipe"];
					$nome_lider = $results[$x]["nome_lider"];
					$email_lider = $results[$x]["email_lider"];
					$nome_projeto = $results[$x]["nome_projeto"];
					$nome_professor = $results[$x]["nome_professor"];
					
					$assunto = "Pineapple Ideas: Orientação Recusada";
					$mensagem = "Olá $nome_lider, <br/>Você está recebendo esse e-mail porque o professor <i>$nome_professor</i> recusou a orientação do projeto <b>$nome_projeto</b> para a equipe <i>$nome_equipe</i>.";
					$mensagem .= "<br/><a href='http://projects.guinetik.com/public/pineapple/' target='_blank'>Acesse o sistema</a> e verifique se a ideia ainda está disponível e peça a orientação de outro professor.<br/>";
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
					$mail->AddAddress($email_professor);
					$mail->IsHTML(true);
					$mail->Subject = ($assunto);
					$mail->Body = ($mensagem);
					$mail->SMTPAuth = true; // Usa autentica‹o SMTP? (opcional)
					$mail->Username = "pineapple.ideas@gmail.com";
					$mail->Password = 'pine123apple'; // Senha do servidor SMTP
					$mail->AddBCC('pineapple.ideas@gmail.com', 'Pineapple Ideas');
					
					$mail->Send();
						
				}
				
			}
			

		} catch (Exception $e) {

			return $e->getMessage();

		}
		
	}

	public function orientarProjeto($projeto) 
	{

		$id = $projeto->getId();
		$equipe = addslashes($projeto->getEquipe());
		$orientador = addslashes($projeto->getOrientador());
		$dataFim = addslashes($projeto->getDataFim());
		$dataInicio = addslashes($projeto->getDataInicio());

		$query = "UPDATE projeto SET projeto.equipe ='$equipe', projeto.orientador = '$orientador', projeto.dataInicio = '$dataInicio', projeto.dataFim = '$dataFim' WHERE projeto.id = $id";
		$query2 = "delete from equipe_orientacoes where projeto = $id";
		
		try 
		{
			
			$this->avisarLideres($id);
			
			$mySQL = new DBConnection();
			if($mySQL->genericQuery($query))
			{
				return $mySQL->genericQuery($query2);
				
			} else 
			{
				
				return "error query 1";
				
			}

		} catch (Exception $e) 
		{

			return $e->getMessage();

		}

	}
	
	public function getSolicitacoesMudanca($usuario)
	{
		
		$nome = $usuario->getNome();
		$query = "select * from equipe where lider = '$nome'";
		try 
		{
			
			
			$mySQL = new DBConnection();
			$result_equipes = $mySQL->consulta($query);
			$ids = array();
			for($x=0; $x< count($result_equipes); $x++)
			{
				
				array_push($ids, $result_equipes[$x]["id"]);
					
				
			}
			
			$query2 = "SELECT o.id as id_orientacao, o.professor as id_professor, o.projeto as id_projeto, o.equipe as id_equipe, u.login as professor, u.nome as nomeprofessor, e.nome as equipe, p.nome as projeto, o.status FROM equipe_orientacoes o INNER JOIN equipe e ON e.id = o.equipe INNER JOIN projeto p on p.id = o.projeto INNER JOIN usuario u ON u.id = o.professor WHERE o.equipe IN (" . implode(",", $ids) . ")";
			return $mySQL->consulta($query2);
			

		} catch (Exception $e) 
		{

			return $e->getMessage();

		}
		
	}
	
	public function solicitarMudanca($id_orientacao)
	{
		
		$query = "UPDATE equipe_orientacoes SET status = 'SOLICITACAO_DE_MUDANCA_ENVIADA' WHERE id = $id_orientacao";

try
{

$mySQL = new DBConnection();
return $mySQL->genericQuery($query);

} catch (Exception $e)
{

return $e->getMessage();

}
		
	}
	
	public function recusarOrientacao($id_orientacao)
	{
		
		$query = "SELECT e.nome AS nome_equipe, u.nome AS nome_lider, u.email AS email_lider, p.nome AS nome_projeto, u2.nome AS nome_professor FROM equipe_orientacoes o INNER JOIN equipe e ON o.equipe = e.id INNER JOIN usuario u ON u.nome = e.lider INNER JOIN projeto p ON p.id = o.projeto INNER JOIN usuario u2 ON u2.id = o.professor WHERE o.id = $id_orientacao";
		$query2 = "UPDATE equipe_orientacoes SET status = 'SOLICITACAO_RECUSADA' WHERE id = $id_orientacao";
		
		try
		{
			$mySQL = new DBConnection();
			$results = $mySQL->consulta($query);
			
			if(count($results) > 0)
			{
				
				$result = false;	
				
				for($x=0; $x< count($results); $x++)
				{
						
					$nome_equipe = $results[$x]["nome_equipe"];
					$nome_lider = $results[$x]["nome_lider"];
					$email_lider = $results[$x]["email_lider"];
					$nome_projeto = $results[$x]["nome_projeto"];
					$nome_professor = $results[$x]["nome_professor"];
					
					$assunto = "Pineapple Ideas: Orientação Recusada";
					$mensagem = "Olá $nome_lider, <br/>Você está recebendo esse e-mail porque o professor <i>$nome_professor</i> recusou a orientação do projeto <b>$nome_projeto</b> para a equipe <i>$nome_equipe</i>.";
					$mensagem .= "<br/><a href='http://projects.guinetik.com/public/pineapple/' target='_blank'>Acesse o sistema</a> e verifique se a ideia ainda está disponível e peça a orientação de outro professor.<br/>";
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
					$mail->AddAddress($email_lider);
					$mail->IsHTML(true);
					$mail->Subject = ($assunto);
					$mail->Body = ($mensagem);
					$mail->SMTPAuth = true; // Usa autentica‹o SMTP? (opcional)
					$mail->Username = "pineapple.ideas@gmail.com";
					$mail->Password = 'pine123apple'; // Senha do servidor SMTP
					$mail->AddBCC('pineapple.ideas@gmail.com', 'Pineapple Ideas');
					
					$result = $mail->Send();
						
				}

				if($result == true)
				{
					
					try 
					{
						$mySQL = new DBConnection();
						return $mySQL->genericQuery($query2);
			
					} catch (Exception $e) {
			
						return $e->getMessage();
			
					}
					
				}
				
			}
		
		} catch (Exception $e) {
		
			return $e->getMessage();
		
		}
		
	}

	public function definirDatas($projeto) {

		$id = $projeto->getId();
		$dataInicio = $projeto->getDataInicio();
		$dataFim = $projeto->getDataFim();

		$query = "UPDATE projeto SET projeto.dataInicio ='$dataInicio', projeto.dataFim = '$dataFim' WHERE projeto.id = $id";
		
		try 
		{
			$mySQL = new DBConnection();
			return $mySQL->genericQuery($query);

		} catch (Exception $e) {

			return $e->getMessage();

		}

	}
	
	public function alterarStatus($projeto)
	{
		
		$id = $projeto->getId();
		$status = $projeto->getStatus();
		$query = "UPDATE projeto SET projeto.status ='$status' WHERE projeto.id = $id";
		
		try
		{
			$mySQL = new DBConnection();
			return $mySQL->genericQuery($query);
		
		} catch (Exception $e) {
		
			return $e->getMessage();
		
		}
		
	}
	
	public function isProfessorOrientador($login, $id_projeto)
	{
		
		$query = "select count(*) as result from projeto where orientador ='$login' and id = $id_projeto";
		
		try
		{
			$mySQL = new DBConnection();
			return $mySQL->consulta($query);
		
		} catch (Exception $e) {
		
			return $e->getMessage();
		
		}
		
	}
	
	public function doesIdeiaHasOrientationRequest($id_ideia, $id_equipe, $id_professor)
	{
				
		$query = "select count(*) as result from equipe_orientacoes where projeto = $id_ideia and equipe = $id_equipe and professor = $id_professor";
		
		try
		{
			$mySQL = new DBConnection();
			return $mySQL->consulta($query);
		
		} catch (Exception $e) {
		
			return $e->getMessage();
		
		}
		
	}
	
	public function getOrientacoesByProfessor($id_professor)
	{
				
		$query = "SELECT o.id as id_orientacao, o.professor as id_professor, o.projeto as id_projeto, o.equipe as id_equipe, u.login as professor, e.nome as equipe, p.nome as projeto, o.status FROM equipe_orientacoes o INNER JOIN equipe e ON e.id = o.equipe INNER JOIN projeto p on p.id = o.projeto INNER JOIN usuario u ON u.id = o.professor WHERE o.professor = $id_professor and (o.status = 'AGUARDANDO_RESPOSTA' OR o.status = 'ORIENTACAO_REENVIADA')";
		
		try
		{
			
			$mySQL = new DBConnection();
			return $mySQL->consulta($query);
		
		} catch (Exception $e) {
		
			return $e->getMessage();
		
		}
		
	}
	
	public function solicitarOrientacao($id_projeto, $nome_projeto, $nome_equipe, $nome_professor, $email_professor, $id_equipe, $id_professor)
	{
				
		$query = "insert into equipe_orientacoes (professor, projeto, equipe) values ($id_professor, $id_projeto, $id_equipe)";
		
		$assunto = "Pineapple Ideas : Convite para orientar o projeto $nome_projeto";
		$mensagem = "Olá $nome_professor, <br/>Você está recebendo esse e-mail porque a equipe <i>$nome_equipe</i> o convidou para orientar o projeto <b>$nome_projeto</b>.";
		$mensagem .= "<br/>Para aceitar o convite, <a href='http://projects.guinetik.com/public/pineapple/' target='_blank'>acesse o sistema</a> e clique em Notificações.<br/>";
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
		$mail->AddAddress($email_professor);
		$mail->IsHTML(true);
		$mail->Subject = ($assunto);
		$mail->Body = ($mensagem);
		$mail->SMTPAuth = true; // Usa autentica‹o SMTP? (opcional)
		$mail->Username = "pineapple.ideas@gmail.com";
		$mail->Password = 'pine123apple'; // Senha do servidor SMTP
		$mail->AddBCC('pineapple.ideas@gmail.com', 'Pineapple Ideas');
		
		try
		{
			if($mail->Send())
			{
				
				$mySQL = new DBConnection();
				return $mySQL->genericQuery($query);
				
			} else 
			{
				
				return "erro ao enviar o email";
				
			}
		
		} catch (Exception $e) {
		
			return $e->getMessage();
		
		}
		
	}

}
?>