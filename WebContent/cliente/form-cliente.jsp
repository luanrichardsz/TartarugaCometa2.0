<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html5>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastrar Cliente</title>
</head>
<body>
	<h1 style="text-align: center"> Cadastrar Clientes </h1>
	
	<label>Escolha o tipo da conta:</label>
	
	<select onchange="tipoFormulario(this.value)">
	  <option value=""> Selecione uma opção </option>
	  <option value="fisica">Fisica</option>
	  <option value="juridica">Juridica</option>
	</select> 
	
	<br><br>
	
	<form id="formFisica" action="/TartarugaCometa/cliente?acao=salvarTemp" method="post" hidden>
		
		Nome: <input type="text" name="nomeCliente" pattern="^[A-Za-zÀ-ÿ\s]+$" maxlength="50" title="Somente letras" required style="width: 25ch"> <br>
		CPF: <input type="text" name="cpfCnpj" pattern="\d{11}" title="O CPF deve conter 11 digitos e somente números" maxlength="11" required > <br>
		<button type="submit"> Salvar </button>
		
	</form>
	
	<form id="formJuridica" action="/TartarugaCometa/cliente?acao=salvarTemp" method="post" hidden>
		Nome: <input type="text" name="nomeCliente"  maxlength="50" pattern="^[A-Za-zÀ-ÿ\s]+$" title="Somente letras" style="width: 25ch" required> <br>
		CNPJ: <input type="text" name="cpfCnpj" pattern="\d{14}" maxlength="14" title="O CNPJ deve conter 14 digitos e somente números" required > <br>
		Razão Social: <input type="text" name="razaoSocial" required style="width: 30ch"> <br>
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