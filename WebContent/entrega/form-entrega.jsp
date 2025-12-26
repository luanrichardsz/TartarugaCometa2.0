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
				    <select name="remetente" id="remetente" onchange="sincronizarFiltroClientes('remetente',  'destinatario')" required>
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
			    <select name="produto" id="produto" onchange="atualizarInfoProduto()" required>
			        <option value=""> Selecione o produto </option>
			        <c:forEach items="${produtos}" var="produto">
			            <option value="${produto.idProduto}" 
			                    data-valor="${produto.valor}" 
			                    data-peso="${produto.peso}"
			                    data-descricao="${produto.descricao}">
			                ${produto.nome}
			            </option>
			        </c:forEach>
			    </select>
			    
			    <div id="dados-selecionados" style="margin-top: 10px; font-size: 12px; color: #555;">
				    Peso: <span id="display-peso">0</span> kg | 
				    Valor Unitário: R$ <span id="display-valor">0.00</span> <br>
				    
				    <div id="container-descricao" style="display: none;">
				        Descrição: <span id="display-descricao"></span>
				    </div>
				</div>
			</td>
				
				<td>
					<input type="number" name="quantidade" id="quantidade" min="1" value="1" onchange="calcularFrete()">
				</td>
				
				<td>
					<input type="number" name="frete" id="frete" readonly> 
				</td>
				
				<td>
				    <select name="destinatario" id="destinatario" onchange="sincronizarFiltroClientes('destinatario',  'remetente')" required>
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

	function atualizarInfoProduto() {
		const select = document.getElementById('produto');
	    const opcaoSelecionada = select.options[select.selectedIndex];
	    
	    const valor = opcaoSelecionada.getAttribute('data-valor');
	    const peso = opcaoSelecionada.getAttribute('data-peso');
	    const descricao = opcaoSelecionada.getAttribute('data-descricao');
	    
	    const containerDesc = document.getElementById('container-descricao');
	    const displayDesc = document.getElementById('display-descricao');

	    if (select.value !== "") {
	        document.getElementById('display-peso').innerText = peso;
	        document.getElementById('display-valor').innerText = valor;

	        if (descricao && descricao.trim() !== "" && descricao !== "null") {
	            displayDesc.innerText = descricao;
	            containerDesc.style.display = "block"
	        } else {
	            containerDesc.style.display = "none";
	        }
	        
	        calcularFrete();
	        
	    } else {
	        document.getElementById('display-peso').innerText = "0";
	        document.getElementById('display-valor').innerText = "0.00";
	        containerDesc.style.display = "none";
	        document.getElementById("frete").value = 0;
	    }
	}
	
	function sincronizarFiltroClientes(idOrigem, idDestino) {
	    const origem = document.getElementById(idOrigem);
	    const destino = document.getElementById(idDestino);
	    
	    const valorSelecionado = origem.value;

	    for (let option of destino.options) {
	        option.disabled = false;
	        option.hidden = false;
	        option.style.display = "block"; 

	        if (option.value === valorSelecionado && valorSelecionado !== "") {
	            option.disabled = true;
	            option.hidden = true;
	            option.style.display = "none"; 
	        }
	    }

	    if (destino.value === valorSelecionado) {
	        destino.value = "";
	    }
	}
	</script>
</body>
</html>