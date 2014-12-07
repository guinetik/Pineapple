<?php

class DBConnection
{
	
	var $con;
//	
//	var $host = "localhost";
//	var $usuario = "pineapple";
//	var $senha = "masterkey";
//	var $banco = "pineapple_bd";

	var $host = "internal-db.s51599.gridserver.com";
	var $usuario = "db51599_pineuser";
	var $senha = "pine123apple";
	var $banco = "db51599_pineapple";
	
	function DBConnection()
	{
		
		$this->con= mysql_connect($this->host, $this->usuario, $this->senha);
		mysql_select_db($this->banco, $this->con);
		mysql_set_charset('utf8',$this->con);
	 
	}
	
	function consulta($q)
	{
		
		mysql_query("SET CHARACTER SET 'utf8'", $this->con);
		$rs = mysql_query($q);
		return $this->order($rs);
		
	}
	
	function genericQuery($q)
	{
		
		mysql_query("SET CHARACTER SET 'utf8'", $this->con);
		return mysql_query($q);
		
	}
	
	function isNaN( $var ) 
	{
		
		return !preg_match ("/^[-]?[0-9]+([\.][0-9]+)?$/", $var);
		
	}

	function order($query){
		$dados = array();
		$i = 0;
		while($l = mysql_fetch_array($query)){
			$dados[$i] = array();
			foreach($l as $campo => $valor){
				if($this->isNaN($campo)){
					$dados[$i][strtolower($campo)] = $valor;
				}
			}
		$i++;
		}
	return $dados;
   }
	
}

?>