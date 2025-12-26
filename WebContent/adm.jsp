<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tartaruga Cometa</title>

<style type="text/css">
    #titulo{
    	text-align:center;
    	color: green;
    }

	table{
		width: 100%;
		border-collapse: collapse;
        margin: 20px 0;
        font-family: Arial, sans-serif;
        font-size: 14px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
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
	<h1 id=titulo> TARTARUGA COMETA </h1>

	<h2 style="text-align:center">Escolha uma função da respectiva classe: </h2>
	<table>
		<tr>
			<th> <strong> Cliente </strong> </th>
			<th> <strong> Endereço </strong> </th>
			<th> <strong> Produto </strong> </th>
			<th> <strong> Entrega </strong> </th>
		</tr>
		
		<tr>
			<td> <a href="/TartarugaCometa/cliente?acao=listar"> Listar </a> </td>
			<td> <a href="/TartarugaCometa/endereco?acao=listar"> Listar </a> </td>
			<td> <a href="/TartarugaCometa/produto?acao=listar"> Listar </a> </td>
			<td> <a href="/TartarugaCometa/entrega?acao=listar"> Listar </a> </td>
			
		
		</tr>
		<tr>
			<td> <a href="/TartarugaCometa/cliente?acao=cadastrar"> Cadastrar </a> </td>
			<td> <a href="/TartarugaCometa/endereco?acao=cadastrar">  </a> </td>
			<td> <a href="/TartarugaCometa/produto?acao=cadastrar"> Cadastrar </a> </td>
			<td> <a href="/TartarugaCometa/entrega?acao=cadastrar"> Cadastrar </a> </td>
			
		</tr>
	</table>
</body>
</html>