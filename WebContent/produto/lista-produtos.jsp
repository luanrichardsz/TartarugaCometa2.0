<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List, model.Produto" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Produtos</title>
</head>
<body>
	<h1> Produtos Cadastrados: </h1>
	
	<ul>
		<c:forEach items="${produtos}" var="produto">
		<li>
		
			Produto: ${produto.nome} <br>
			Peso: ${produto.peso} <br>
			Volume: ${produto.volume} <br>
			Valor: ${produto.valor} <br>
			
			<a href="/TartarugaCometa/produto?acao=buscarProduto&idProduto=${produto.idProduto}"> Editar </a> -
			<a onclick="return excluir()" href="/TartarugaCometa/produto?acao=deletarProduto&idProduto=${produto.idProduto}"> Excluir </a>
		</li> <br>
		</c:forEach>
	</ul>
	
	<a href="adm.jsp"> Tela Principal </a> - <a href="produto?acao=cadastrar"> Adicionar novo produto </a>
	
	
	<script type="text/javascript">
		function excluir(){
			var confirmacao = confirm("Tem certeza de que deseja excluir este produto?");
			
			if(confirmacao){
				alert("Produto excluido com sucesso!")
				return true;
			} else {
				return false;
			}
		}
	</script>
	
	
</body>
</html>