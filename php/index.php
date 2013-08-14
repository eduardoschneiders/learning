<?php
class Pessoa{

	var $nome;
	var $idade;
	var $fumante;

	function __construct($name, $idade, $fuma){
		$this->nome = $name;
		$this->idade = $idade;
		$this->fumante = $fuma;
	}

}

$jose = new Pessoa($_POST['nome'], $_POST['idade'], $_POST['fumante']);


?>

<form method="post">
	nome: <input type="text" name="nome" ></br>
	idade:<input type="text" name="idade"></br>
	não <input type="radio" name="fumante" value="0">
	sim <input type="radio" name="fumante" value="1">
	<input type="submit" value="gravar">
</form>