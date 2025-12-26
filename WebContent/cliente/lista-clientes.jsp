<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.List, model.Cliente"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Clientes Cadastrados</title>

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

    <h1 style="text-align: center"> Clientes Cadastrados </h1>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Tipo</th>
                <th>Nome / Razão Social</th>
                <th>CPF / CNPJ</th>
                <th>ID Endereço</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${clientes}" var="cliente">
                <tr>
                    <td>${cliente.idCliente}</td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty cliente.razaoSocial}">
                                <span class="tipo-cliente">Jurídica</span>
                            </c:when>
                            <c:otherwise>
                                <span class="tipo-cliente">Física</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty cliente.razaoSocial}">
                                <strong>${cliente.razaoSocial}</strong><br>
                                <small>Responsavel: ${cliente.nome}</small>
                            </c:when>
                            <c:otherwise>
                                ${cliente.nome}
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>${cliente.documentoFormatado}</td>
                    <td>
                        <span style="background: #eee; padding: 2px 8px; border-radius: 10px;">
                            #${cliente.endereco_id}
                        </span>
                    </td>
                    <td>
                        <a href="/TartarugaCometa/cliente?acao=buscarCliente&idCliente=${cliente.idCliente}"> Editar </a> 
                        | 
                        <a onclick="return excluir()" href="/TartarugaCometa/cliente?acao=deletarCliente&idCliente=${cliente.idCliente}"> Excluir </a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <br>
    <div style="margin-top: 10px;">
        <a href="adm.jsp"> Tela Principal </a> | 
        <a href="cliente?acao=cadastrar"> Novo Cliente </a> | 
        <a href="endereco?acao=listar"> Ver Endereços </a>
    </div>

    <script type="text/javascript">
        function excluir(){
            var confirmacao = confirm("Tem certeza de que deseja excluir este cliente?");
            
            if(confirmacao){
                alert("Cliente excluído com sucesso!");
                return true;
            } else {
                return false;
            }
        }
    </script>
     
</body>
</html>