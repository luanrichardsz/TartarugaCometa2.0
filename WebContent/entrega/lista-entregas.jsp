<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List, model.Entrega" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Entregas</title>

<style>
table{
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
    border-radius:14px;
    text-align: center;
}

td {	
    padding: 10px;
    border: 1px solid #ddd;
    vertical-align: middle;
    text-align: center;
    border-radius: 14px;	
}
</style>
</head>
<body>

<h1> Entregas Cadastradas </h1>

<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Destinatário</th>
            <th>Remetente</th>
            <th>Produtos</th>
            <th>Frete</th>
            <th>Status</th>
            <th>Valor Total</th>
            <th>Ações</th>
        </tr>
    </thead>

    <tbody>
        <c:forEach items="${entregas}" var="entrega">

            <c:set var="totalEntrega" value="0" />

            <tr>
                <td>${entrega.idEntrega}</td>

                <td>
                    <c:if test="${not empty entrega.clienteRemetente.razaoSocial}">
                        ${entrega.clienteRemetente.razaoSocial}
                    </c:if>
                    <c:if test="${empty entrega.clienteRemetente.razaoSocial}">
                        ${entrega.clienteRemetente.nome}
                    </c:if>
                </td>

                <td>
                    <c:if test="${not empty entrega.clienteDestinatario.razaoSocial}">
                        ${entrega.clienteDestinatario.razaoSocial}
                    </c:if>
                    <c:if test="${empty entrega.clienteDestinatario.razaoSocial}">
                        ${entrega.clienteDestinatario.nome}
                    </c:if>
                </td>

                <td>
                    <c:forEach items="${entrega.produtos}" var="produtoEntrega">

                        <c:set var="subtotalProduto"
                               value="${produtoEntrega.quantidade * produtoEntrega.produto.valor}" />

                        <c:set var="totalEntrega"
                               value="${totalEntrega + subtotalProduto + produtoEntrega.frete}" />

                        <div style="margin-bottom: 6px;">
                            <strong>${produtoEntrega.produto.nome}</strong><br>
                            Quantidade: ${produtoEntrega.quantidade}<br>
                            Subtotal:
                            <fmt:formatNumber value="${subtotalProduto}"
                                              type="currency"
                                              currencySymbol="R$" />
                        </div>

                    </c:forEach>
                </td>

                <td>
                    <c:forEach items="${entrega.produtos}" var="produtoEntrega">
                        <div>
                            <fmt:formatNumber value="${produtoEntrega.frete}"
                                              type="currency"
                                              currencySymbol="R$" />
                        </div>
                    </c:forEach>
                </td>

                <td>
                    <c:choose>
                        <c:when test="${entrega.realizada}">
                            <span style="color: green;">Entregue</span>
                        </c:when>
                        <c:otherwise>
                            <span style="color: orange;">Pendente</span>
                        </c:otherwise>
                    </c:choose>
                </td>

                <td>
                    <strong>
                        <fmt:formatNumber value="${totalEntrega}"
                                          type="currency"
                                          currencySymbol="R$" />
                    </strong>
                </td>

                <td>
                    <c:if test="${entrega.realizada == false}">
					    <a id="concluir" href="/TartarugaCometa/entrega?acao=editarStatus&idEntrega=${entrega.idEntrega}&realizada=true">
					        Concluir |
					    </a>
					</c:if>
                    
                    <a onclick="return excluir(${entrega.realizada})"
                       href="/TartarugaCometa/entrega?acao=deletar&idEntrega=${entrega.idEntrega}&realizada=${entrega.realizada}">
                        Excluir
                    </a>
                </td>
            </tr>

        </c:forEach>
    </tbody>
</table>

<br>

		<a href="adm.jsp"> Tela Principal </a> - <a href="entrega?acao=cadastrar"> Nova Entrega </a>

	<script>
	    function excluir(foiRealizada) {
	        if (!foiRealizada) {
	            alert("A entrega não pode ser excluída porque ainda não foi realizada!");
	            return false;
	        }
	        
	        return confirm("Tem certeza de que deseja excluir esta entrega?");
	    }	
	</script>

</body>
</html>
