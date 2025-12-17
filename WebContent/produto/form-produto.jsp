<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastrar Produto</title>
</head>
<body>
	
	<h1 style="text-align: center">Cadastrar Produto</h1>
	
	<form action="/TartarugaCometa/produto?acao=salvarCadastro" method="post">
		
		Nome do Produto: <input type="text" name="nome" required/> <br>
		Peso: <input type="text" name="peso" placeholder="00.00 kg" required/> <br>
		Volume: <input type="text" name="volume" placeholder="00.00 m³" required/> <br>
		Valor: <input type="text" name="valor" placeholder="R$ 00.00" required> <br>
		
		<input type="submit"> 
		
	</form> <br>
	
	<a href="adm.jsp"> Tela Principal </a> - <a href="produto?acao=listar"> Produtos Cadastrados </a>
	
</body>
</html>