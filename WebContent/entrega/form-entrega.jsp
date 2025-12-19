<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	

<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastrar Entrega</title>

<style type="text/css">
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
        text-align: left;
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

    table select, table input {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box; 
    }
</style>

</head>
<body>

	<h1 style="text-align:center"> Cadastrar Entrega </h1>

	<form action="entrega?acao=salvarEntrega" method="post">

		<table>
			<tr>
				<th> Cliente Remetente </th>
				<th> Produto </th>
				<th> Quantidade </th>
				<th> Frete </th>
				<th> Cliente Destinatario </th>
			</tr>
		
		<!-- 	
			<tr>
				<td> Opções com todos os clientes </td>
				<td> Opções com todos os produtos(Opção se tiver mais de um produto) </td>
				<td> Entrada para a quantidade de produtos </td>
				<td> Calcular 20% do valor da compra (produto.valor * produtoEntrega.quantidade) - 20% = frete </td>
				<td> Opções com todos os clientes </td> 
			</tr>
		 -->
			 
			<tr>
				<td>
				    <select name="remetente" id="remetente" required>
				        <option value="">Selecione um cliente</option>
				        
				        <c:forEach items="${clientes}" var="cliente">
				            <option value="${cliente.idCliente}">
				                <c:if test="${not empty cliente.razaoSocial }"> ${cliente.razaoSocial} </c:if>
				                <c:if test="${empty cliente.razaoSocial }"> ${cliente.nome} </c:if>
				            </option>
				        </c:forEach>
				    </select>
				</td>
				
				<td>
					<select name="produto" id="produto" onchange="calcularFrete()" required>
					    <option value=""> Selecione o produto </option>
					    <c:forEach items="${produtos}" var="produto">
					        <option value="${produto.idProduto}" data-valor="${produto.valor}">
					            ${produto.nome}
					        </option>
					    </c:forEach>
					</select>
				</td>
				
				<td>
					<input type="number" name="quantidade" id="quantidade" min="1" value="1" onchange="calcularFrete()">

				</td>
				
				<td>
					<input type="number" name="frete" id="frete" readonly> 
				</td>
				
				<td>
				    <select name="destinatario" id="destinatario" onchange="apagarRemetente()" required>
				        <option value="">Selecione um cliente</option>
				        
				        <c:forEach items="${clientes}" var="cliente">
				            <option value="${cliente.idCliente}">
				                <c:if test="${not empty cliente.razaoSocial }"> ${cliente.razaoSocial} </c:if>
				                <c:if test="${empty cliente.razaoSocial }"> ${cliente.nome} </c:if>
				            </option>
				        </c:forEach>
				    </select>
				</td>
				<td> <input type="submit"> </td>
			</tr>
		</table>
	</form>
	
	<a href="adm.jsp"> Tela Principal </a> - <a href="entrega?acao=listar"> Entregas Cadastradas </a>
	
	
	<script type="text/javascript">
		
	function calcularFrete() {

	    const produtoSelect = document.getElementById("produto");
	    const opcaoSelect = produtoSelect.options[produtoSelect.selectedIndex];

	    const valorProduto = parseFloat(opcaoSelect.dataset.valor);
	    const quantidade = parseInt(document.getElementById("quantidade").value);

	    if (isNaN(valorProduto) || isNaN(quantidade)) {
	        document.getElementById("frete").value = 0;
	        return;
	    }

	    const totalCompra = valorProduto * quantidade;
	    const frete = totalCompra * 0.10;

	    console.log(totalCompra);

	    document.getElementById("frete").value = frete.toFixed(2);
	}
	
	function apagarRemetente() {
	    const remetenteSelect = document.getElementById("remetente");
	    const destinatarioSelect = document.getElementById("destinatario");

	    const remetenteId = remetenteSelect.value;

	    for (let option of destinatarioSelect.options) {
	        option.disabled = false;

	        if (option.value === remetenteId && remetenteId !== "") {
	            option.disabled = true;
	        }
	    }

	    if (destinatarioSelect.value === remetenteId) {
	        destinatarioSelect.value = "";
	    }
	}
	</script>
</body>
</html>