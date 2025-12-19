<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.List, model.Endereco"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Endereços Cadastrados</title>
</head>
<body>
	<h1> Endereços Cadastrados: <br></h1>
	
	<ul>
		<c:forEach items="${enderecos}" var="endereco">
			<li>
				CEP: ${endereco.cep} <br>
				Rua: ${endereco.rua} <br>
				Número: ${endereco.numero} <br>
				Bairro: ${endereco.bairro} <br>
				Cidade: ${endereco.cidade} <br>
				Estado: ${endereco.estado} <br>
				Complemento: ${endereco.complemento} <br>
				<a href="/TartarugaCometa/endereco?acao=buscarEndereco&idEndereco=${endereco.idEndereco}"> Editar </a> - 
				<a onclick="return excluir()" href="/TartarugaCometa/endereco?acao=deletarEndereco&idEndereco=${endereco.idEndereco}"> Excluir </a>
				
			</li> <br>
		</c:forEach>
	</ul>
	
	<a href="adm.jsp"> Tela Principal </a> - <a href="endereco?acao=cadastrar"> Adicionar novo endereço </a>

	<script type="text/javascript">
		function excluir{
			var confirmacao = confirm("Tem certeza de que deseja excluir este endereço?");
			
			if(confirmacao){
				alert("Endereço excluido com sucesso!")
				return true;
			} else {
				return false;
			}
		}
	</script>
</body>
</html>