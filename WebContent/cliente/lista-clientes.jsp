<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.List, model.Cliente"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Clientes</title>
</head>
<body>
	<h1> Clientes Cadastrados: <br> </h1>
	
	<ul>
		<c:forEach items="${clientes}" var="cliente">
			<li>
				Nome: ${cliente.nome} <br>
				<c:if test="${empty cliente.razaoSocial}">
					CPF: ${cliente.cpfCnpj} 
				</c:if>
				
				<c:if test="${not empty cliente.razaoSocial}">
					CNPJ: ${cliente.cpfCnpj} <br>
					Razão Social: ${cliente.razaoSocial}
				</c:if> <br>
				Endereco_ID: ${cliente.endereco_id} <br>
				
				<a href="/TartarugaCometa/cliente?acao=buscarCliente&idCliente=${cliente.idCliente}"> Editar </a> -
				<a onclick="return excluir()" href="/TartarugaCometa/cliente?acao=deletarCliente&idCliente=${cliente.idCliente}"> Excluir </a>
			</li> <br>
		</c:forEach>
	</ul>
	
	<a href="adm.jsp"> Tela Principal </a> - <a href="cliente?acao=cadastrar"> Adicionar novo cliente </a> - <a href="endereco?acao=listar"> Endereços Cadastrados </a>	
	 	
	 <script type="text/javascript">
		function excluir(){
			var confirmacao = confirm("Tem certeza de que deseja excluir este cliente?");
			
			if(confirmacao){
				alert("Cliente excluido com sucesso!")
				return true;
			} else {
				return false;
			}
		}
	</script>
	 
</body>
</html>