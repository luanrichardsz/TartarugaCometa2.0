<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	

<c:url value="/endereco" var="editarEndereco"/>	

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editando Endereço</title>
</head>
<body>

		<button onclick="history.back()"> Voltar </button> <br> <br>

		<form action="endereco" method="post">
		
		<input type="hidden" name="acao" value="editarEndereco"/>
		
		ID: <input type="text"  value="${endereco.idEndereco}" name="idEndereco" readonly/> <br>
		CEP: <input type="text" value="${endereco.cep}" name="cep"/> <br>
		Rua: <input type="text" value="${endereco.rua}" name="rua"/> <br>
		Número <input type="text" value="${endereco.numero}" name="numero"/> <br>
		Bairro: <input type="text" value="${endereco.bairro}" name="bairro"/> <br>
		Cidade: <input type="text" value="${endereco.cidade}" name="cidade"/> <br>
		Estado: <input type="text" value="${endereco.estado}" name="estado" /> <br>
		Complemento: <input type="text" value="${endereco.complemento}" name="complemento" /> <br>
		
		<input type="submit">
		
	</form>
</body>
</html>