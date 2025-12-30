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
	<button onclick="history.back()"> Voltar </button> <br>

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
				    <select name="remetente" id="remetente" onchange="sincronizarFiltroClientes('remetente',  'destinatario') ; filtrarProdutosPorCliente();" required>
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
			    <select name="produto" id="produto" onchange="atualizarInfoProduto()" required disabled>
			        <option value="">Selecione o produto</option>
			        <c:forEach items="${produtos}" var="produto">
			            <option value="${produto.idProduto}"
			                    data-valor="${produto.valor}"
			                    data-peso="${produto.peso}"
			                    data-descricao="${produto.descricao}"
			                    data-estoque="${produto.volume}"
			                    data-cliente="${produto.cliente != null ? produto.cliente.idCliente : ''}">
			                ${produto.nome}
			            </option>
			        </c:forEach>
			    </select>
			    
			    <div id="dados-selecionados" style="margin-top: 10px; font-size: 12px; color: #555;">
			        Peso: <span id="display-peso">0</span> | 
			        Valor Unitário: R$ <span id="display-valor">0.00</span> <br>
			        Estoque Atual: <span id="display-estoque" style="font-weight: bold; color: #2c3e50;">0</span> <br>
			        
			        <div id="container-descricao" style="display: none;">
			            Descrição: <span id="display-descricao"></span>
			        </div>
			    </div>
			</td>
				
				<td>
					<input type="number" name="quantidade" id="quantidade" min="1" value="1" onchange="calcularFrete()">
				</td>
				
				<td>
				    <label for="frete" style="display:block; font-size: 15px;">
                	<strong> Frete (10% sobre o total) </strong>
				    </label>
				    <div style="position: relative; display: flex; align-items: center;">
				        <span style="position: absolute; left: 10px;">R$</span>
				        <input type="text" name="frete" id="frete" readonly 
				               style="padding-left: 35px; border: 1px solid #ddd;" 
				               value="0,00">
				    </div>
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
	<div style="margin-top: 10px; text-align:center;">
		<a href="adm.jsp"> Tela Principal </a> - <a href="entrega?acao=listar"> Entregas Cadastradas </a>
	</div>
	
	<script type="text/javascript">
		
	function atualizarInfoProduto() {
	    const select = document.getElementById('produto');
	    const opcaoSelecionada = select.options[select.selectedIndex];
	    
	    if (!select.value || select.value === "") {
	        resetarCampos();
	        return;
	    }

	    const valor = opcaoSelecionada.getAttribute('data-valor');
	    const peso = opcaoSelecionada.getAttribute('data-peso');
	    const estoque = opcaoSelecionada.getAttribute('data-estoque');
	    const descricao = opcaoSelecionada.getAttribute('data-descricao');
	    
	    const displayPeso = document.getElementById('display-peso');
	    const displayValor = document.getElementById('display-valor');
	    const displayEstoque = document.getElementById('display-estoque');
	    const displayDesc = document.getElementById('display-descricao');
	    const containerDesc = document.getElementById('container-descricao');
	    const inputQuantidade = document.getElementById('quantidade');

	    if (displayEstoque) {
	        displayEstoque.innerText = estoque; 
	    }

	    if (parseInt(estoque) <= 0) {
	        alert("Produto sem estoque!");
	        select.value = "";
	        resetarCampos();
	        return;
	    }

	    inputQuantidade.disabled = false; 
	    inputQuantidade.value = 1;        
	    inputQuantidade.max = estoque; 

	    let pesoNum = parseFloat(peso);
	    displayPeso.innerText = (pesoNum < 1) ? (pesoNum * 1000).toFixed(0) + " gramas" : pesoNum + " kg";
	    
	    displayValor.innerText = valor;

	    if (descricao && descricao.trim() !== "" && descricao !== "null") {
	        displayDesc.innerText = descricao;
	        containerDesc.style.display = "block";
	    } else {
	        displayDesc.innerText = "";
	        containerDesc.style.display = "none";
	    }
	    
	    calcularFrete();
	}

	function calcularFrete() {
	    const valor = parseFloat(document.getElementById('produto').selectedOptions[0].dataset.valor);
	    const qtd = parseInt(document.getElementById('quantidade').value);
	    const frete = (valor * qtd) * 0.10;

	    document.getElementById('frete').value = frete.toLocaleString('pt-BR', {
	        minimumFractionDigits: 2
	    });
	}

	
	function resetarCampos() {
	    document.getElementById('display-peso').innerText = "0";
	    document.getElementById('display-valor').innerText = "0.00";
	    document.getElementById('display-estoque').innerText = "0"; 
	    document.getElementById('display-descricao').innerText = "";
	    
	    document.getElementById('container-descricao').style.display = "none";
	    
	    const inputQtd = document.getElementById('quantidade');
	    inputQtd.value = 0; 
	    inputQtd.disabled = true;
	    
	    document.getElementById("frete").value = "0,00"; 
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
	
	function filtrarProdutosPorCliente() {
	    const selectCliente = document.getElementById("remetente");
	    const selectProduto = document.getElementById("produto");
	    const clienteSelecionado = selectCliente.value;

	    if (clienteSelecionado === "") {
	        selectProduto.disabled = true;
	        resetarCampos();
	        return;
	    }

	    selectProduto.disabled = false;
	    selectProduto.value = "";

	    for (let option of selectProduto.options) {
	        if (option.value === "") continue;
	        const clienteProduto = option.dataset.cliente;
	        const produtoSemCliente = !clienteProduto || clienteProduto === "null";
	        const produtoDoCliente = clienteProduto === clienteSelecionado;

	        if (produtoSemCliente || produtoDoCliente) {
	            option.hidden = false;
	            option.disabled = false;
	        } else {
	            option.hidden = true;
	            option.disabled = true;
	        }
	    }

	    resetarCampos(); 
	}

	</script>
</body>
</html>