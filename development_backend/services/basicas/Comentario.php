<?php
class Comentario {
	private $id;
	private $autor;
	private $descricao;
	private $dataCadastro;
	private $idProjeto;

	public function getId() {

		return $this->id;

	} 

	public function getAutor() {

		return $this->autor;

	}

	public function getDescricao() {

		return $this->descricao;

	}
	public function getDataCadastro() {

		return $this->dataCadastro;

	}

	public function getIdProjeto() {

		return $this->idProjeto;

	}


	// sets

	public function setId($id) {

		$this->id = $id;

	}

	public function setAutor($autor) {

		$this->autor = $autor;

	}

	public function setDescricao($descricao) {
		$this->descricao = $descricao;

	}

	public function setDataCadastro($dataCadastro) {

		$this->dataCadastro = $dataCadastro;

	}

	public function setIdProjeto($idProjeto) {

		$this->idProjeto = $idProjeto;

	}


}
?>
