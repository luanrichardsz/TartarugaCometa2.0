<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	

<c:url value="/cliente" var="editarCliente" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editando Cliente</title>
</head>
<body>
	
	<button onclick="history.back()"> Voltar </button> <br> <br>
	
	<form action="cliente" method="post">
		<input type="hidden" name="acao" value="editarCliente"/>
		
		ID: <input type="text" value="${cliente.idCliente}" name="idCliente" readonly> <br>
		Nome: <input type="text" value="${cliente.nome}" name="nomeCliente"> <br>
	<c:if test="${empty cliente.razaoSocial}">
		CPF: <input type="text" value="${cliente.cpfCnpj}" name="cpfCnpj" readonly>
	</c:if>
		
	<c:if test="${not empty cliente.razaoSocial}">
		CNPJ: <input type="text" value="${cliente.cpfCnpj}" name="cpfCnpj" readonly><br>
		Razão Social: <input type="text" value="${cliente.razaoSocial}" name="razaoSocial" readonly>
	</c:if> <br>
	
		<input type="submit">
	</form>
	
</body>
</html>