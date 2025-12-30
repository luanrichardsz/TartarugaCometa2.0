<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List, model.Produto"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Produtos</title>

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

	<h1 style="text-align: center">
	    <c:choose>
	        <c:when test="${not empty sessionScope.clienteLogado}">
	            Produtos do Cliente:
	            <strong>
	                <c:choose>
	                    <c:when test="${not empty sessionScope.clienteLogado.razaoSocial}">
	                        ${sessionScope.clienteLogado.razaoSocial}
	                    </c:when>
	                    <c:otherwise>
	                        ${sessionScope.clienteLogado.nome}
	                    </c:otherwise>
	                </c:choose>
	            </strong>
	        </c:when>
	        <c:otherwise>
	            Produtos Cadastrados no Sistema
	        </c:otherwise>
	    </c:choose>
	</h1>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Nome do Produto</th>
            <th>Peso (kg)</th>
            <th>Volume</th>
            <th>Valor</th>
            <th>Descrição</th>
            <th>Ações</th>
        </tr>
    </thead>
    <tbody>

        <c:forEach items="${produtos}" var="produto">
            <tr>
                <td>${produto.idProduto}</td>

                <td style="text-align: left; padding-left: 20px;">
                    <strong>${produto.nome}</strong>
                </td>

                <td>
                    <fmt:formatNumber value="${produto.peso}" minFractionDigits="3" maxFractionDigits="3"/> kg
                </td>

                <td>
                    ${produto.volume} ${produto.volume > 1 ? 'unidades' : 'unidade'}
                </td>

                <td>
                    <fmt:formatNumber value="${produto.valor}" type="currency" currencySymbol="R$"/>
                </td>

                <td style="text-align: left; max-width: 250px;">
                    <c:choose>
                        <c:when test="${not empty produto.descricao}">
                            ${produto.descricao}
                        </c:when>
                        <c:otherwise>
                            <span style="color:#999;font-style:italic;">Sem descrição</span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <td>
                    <a href="/TartarugaCometa/produto?acao=buscarProduto&idProduto=${produto.idProduto}">
                        Editar
                    </a>
                    |
                    <a onclick="return excluir()"
                       href="/TartarugaCometa/produto?acao=deletarProduto&idProduto=${produto.idProduto}">
                        Excluir
                    </a>
                </td>
            </tr>
        </c:forEach>

    </tbody>
</table>

<br>

<div style="margin-top: 10px; text-align:center;">

    <c:choose>
        <c:when test="${not empty sessionScope.clienteLogado}">
            <a href="produto?acao=cadastrar">Novo Produto para este Cliente</a> |
            <a href="produto?acao=sairGerenciamento">Ver todos os produtos</a> 
        </c:when>
        <c:otherwise>
        	<a href="adm.jsp"> Tela Principal </a> |
            <a href="produto?acao=cadastrar">Novo Produto</a> |
            <a href="cliente?acao=listar"> Clientes Cadastrados </a>
        </c:otherwise>
    </c:choose>
</div>

<script>
	function excluir(){
	    var confirmacao = confirm("Tem certeza de que deseja excluir este produto?");
	    
	    if(confirmacao){
	    	alert("Produto excluído com sucesso!")
	    	return true;
	    } else {
	    	alert("Operação cancelada!")
	    	return false;
	    }
	}
</script>

</body>
</html>
