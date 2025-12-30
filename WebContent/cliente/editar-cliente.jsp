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
		Nome: <input type="text" value="${cliente.nome}" name="nomeCliente" pattern="^[A-Za-zÀ-ÿ\s]+$" maxlength="50" title="Somente letras" oninput="somenteLetras(this)" style="width: 25ch"> <br>
	<c:if test="${empty cliente.razaoSocial}">
		CPF: <input type="text" value="${cliente.documentoFormatado}" name="cpfCnpj" oninput="mascaraCPF(this)" readonly>
	</c:if>
		
	<c:if test="${not empty cliente.razaoSocial}">
		CNPJ: <input type="text" value="${cliente.documentoFormatado}" name="cpfCnpj" readonly><br>
		Razão Social: <input type="text" value="${cliente.razaoSocial}" name="razaoSocial" style="width: 25ch" readonly>
	</c:if> <br>
	
		<input type="submit">
	</form>
	
</body>
</html>