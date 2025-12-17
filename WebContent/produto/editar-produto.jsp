<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	

<c:url value="/produto" var="editarProduto"/>	
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editando Produto</title>
</head>
<body>
	
	<button onclick="history.back()"> Voltar </button> <br> <br>
	
	<form action="produto" method="post">
		<input type="hidden" name="acao" value="editarProduto"/>
		
		ID: <input type="text" value="${produto.idProduto}" name="idProduto" readonly/> <br>
		Nome: <input type="text" value="${produto.nome}" name="nomeProduto"/> <br>
		Peso: <input type="text" value="${produto.peso}" name="peso"> <br>
		Volume: <input type="text" value="${produto.volume}" name="volume"> <br>
		Valor: <input type="text" value="${produto.valor}" name="valor"> <br>
		
		<input type="submit">
	</form>
	
</body>
</html>