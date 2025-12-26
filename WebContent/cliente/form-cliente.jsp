<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html5>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastrar Cliente</title>
</head>
<body>
	<h1 style="text-align: center"> Cadastrar Cliente </h1>
	
	<label>Escolha o tipo da conta:</label>
	
	<select onchange="tipoFormulario(this.value)">
	  <option value=""> Selecione uma opção </option>
	  <option value="fisica">Fisica</option>
	  <option value="juridica">Juridica</option>
	</select> 
	
	<br><br>
	
	<form id="formFisica" action="/TartarugaCometa/cliente?acao=salvarTemp" method="post" hidden>
		
		Nome: <input type="text" name="nomeCliente" pattern="^[A-Za-zÀ-ÿ\s]+$" maxlength="50" title="Somente letras" oninput="somenteLetras(this)" required style="width: 25ch"> <br>
		CPF: <input type="text" name="cpfCnpj" pattern="[\d\D]{14}" title="O CPF deve conter 11 digitos e somente números" oninput="mascaraCPF(this)" maxlength="14" required > <br>
		<button type="submit"> Salvar </button>
		
	</form>
	
	<form id="formJuridica" action="/TartarugaCometa/cliente?acao=salvarTemp" method="post" hidden>
		Nome: <input type="text" name="nomeCliente"  maxlength="50" pattern="^[A-Za-zÀ-ÿ\s]+$" title="Somente letras" oninput="somenteLetras(this)" style="width: 25ch" required> <br>
		CNPJ: <input type="text" name="cpfCnpj" pattern="[\d\D]{18}" maxlength="18" title="O CNPJ deve conter 14 digitos e somente números" oninput="mascaraCNPJ(this)" required > <br>
		Razão Social: <input type="text" name="razaoSocial" oninput="somenteLetras(this)" required style="width: 30ch"> <br>
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
		
        function mascaraCPF(input) {
            let v = input.value.replace(/\D/g, "");
            if (v.length > 11) v = v.substring(0, 11);
            v = v.replace(/(\d{3})(\d)/, "$1.$2");
            v = v.replace(/(\d{3})(\d)/, "$1.$2");
            v = v.replace(/(\d{3})(\d{1,2})$/, "$1-$2");
            input.value = v;
        }

        function mascaraCNPJ(input) {
            let v = input.value.replace(/\D/g, "");
            if (v.length > 14) v = v.substring(0, 14);
            v = v.replace(/^(\d{2})(\d)/, "$1.$2");
            v = v.replace(/^(\d{2}).(\d{3})(\d)/, "$1.$2.$3");
            v = v.replace(/.(\d{3})(\d)/, ".$1/$2");
            v = v.replace(/(\d{4})(\d)/, "$1-$2");
            input.value = v;
        }
        
        function somenteLetras(input){
        	input.value = input.value.replace(/[^A-Za-zÀ-ÿ\s]/g, "");
        }
		
	</script>
</body>
</html>