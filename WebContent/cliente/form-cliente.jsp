<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastrar Cliente</title>
</head>
<body>
	<h1 style="text-align: center"> Cadastro para Clientes </h1>
	
	<label>Escolha o tipo da conta:</label>
	
	<select onchange="tipoFormulario(this.value)">
	  <option value=""> Selecione uma opção </option>
	  <option value="fisica">Fisica</option>
	  <option value="juridica">Juridica</option>
	</select> 
	
	<br><br>
	
	<form id="formFisica" action="/TartarugaCometa/cliente?acao=salvarTemp" method="post" hidden>
		
		Nome: <input type="text" name="nomeCliente" required> <br>
		CPF: <input type="text" name="cpfCnpj" required> <br>
		<button type="submit"> Salvar </button>
		
	</form>
	
	<form id="formJuridica" action="/TartarugaCometa/cliente?acao=salvarTemp" method="post" hidden>
		Nome: <input type="text" name="nomeCliente" required> <br>
		CNPJ: <input type="text" name="cpfCnpj" required> <br>
		Razão Social: <input type="text" name="razaoSocial" required> <br>
		<button type="submit"> Salvar </button>
	</form> <br>
	
	
	<a href="adm.jsp"> Tela Principal </a> - <a href="cliente?acao=listar"> Clientes Cadastrados </a>
	
	<script type="text/javascript">
		function tipoFormulario(tipoConta) {
			const fisica = document.getElementById("formFisica");
			const juridica = document.getElementById("formJuridica");
			
			fisica.hidden = true;
			juridica.hidden = true;
			
			if(tipoConta == "fisica"){
				fisica.hidden = false;
			} else if (tipoConta == "juridica"){
				juridica.hidden = false;
			}
		}
	</script>
</body>
</html>