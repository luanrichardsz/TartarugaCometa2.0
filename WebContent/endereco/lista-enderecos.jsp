<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.List, model.Endereco"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Endereços Cadastrados</title>

<style>
	table {
	    width: 99%;
	    border-collapse: collapse;
	    margin: 20px 0;
	    font-family: Arial, sans-serif;
	    font-size: 14px;
	    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
	    border-radius: 12px;
	}
	
	th {
	    color: black;
	    padding: 12px;
	    border: 1px solid #34495e;
	    text-align: center;
	    background-color: #f8f9fa;
	}
	
	td {	
	    padding: 10px;
	    border: 1px solid #ddd;
	    vertical-align: middle;
	    text-align: center;
	}

</style>
</head>
<body>

	<h1 style="text-align: center"> Endereços Cadastrados </h1>
	
	<table>
        <thead>
            <tr>
                <th>ID</th>
                <th>CEP</th>
                <th>Logradouro</th>
                <th>Bairro</th>
                <th>Localidade</th>
                <th>Complemento</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${enderecos}" var="endereco">
                <tr>
                    <td>${endereco.idEndereco}</td>
                    <td><strong>${endereco.cepFormatado}</strong></td>
                    <td>
                        ${endereco.rua}, ${endereco.numero}
                    </td>
                    <td>${endereco.bairro}</td>
                    <td>
                        ${endereco.cidade} - ${endereco.estado}
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty endereco.complemento}">
                                ${endereco.complemento}
                            </c:when>
                            <c:otherwise>
                                <span style="color: #999; font-style: italic;">Nenhum</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="/TartarugaCometa/endereco?acao=buscarEndereco&idEndereco=${endereco.idEndereco}">
                            Editar
                        </a> 
                        | 
                        <a onclick="return excluir()" 
                           href="/TartarugaCometa/endereco?acao=deletarEndereco&idEndereco=${endereco.idEndereco}">
                            Excluir
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
	
    <br>
	<a href="adm.jsp"> Tela Principal </a>

	<script type="text/javascript">
		function excluir() {
			var confirmacao = confirm("Tem certeza de que deseja excluir este endereço?");
			
			if (confirmacao) {
				alert("Endereço excluído com sucesso!");
				return true;
			} else {
				return false;
			}
		}
	</script>
</body>
</html>