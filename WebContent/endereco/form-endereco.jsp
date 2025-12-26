<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastro de Endereço</title>
</head>
<body>
	
	<h1 style="text-align: center">Cadastrar Endereço</h1>
	
	<form action="/TartarugaCometa/endereco?acao=salvarCadastro" method="post">
		
		CEP<span style="color: red">*</span>: <input type="text" name="cep" pattern="[\d\D]{9}" maxlength="9" oninput="mascaraCEP(this)" required/> <br>
		Rua<span style="color: red">*</span>: <input type="text" name="rua" pattern="^[A-Za-zÀ-ÿ\s]+$" title="Somente letras" required/> <br>
		Número: <input type="text" name="numero" pattern="\d{1,5}[a-zA-Z]?"/> <br>
		Bairro<span style="color: red">*</span>: <input type="text" name="bairro" pattern="^[A-Za-zÀ-ÿ\s]+$" title="Somente letras" required /> <br>
		Cidade<span style="color: red">*</span>: <input type="text" name="cidade" pattern="^[A-Za-zÀ-ÿ\s]+$" title="Somente letras" required /> <br>
		Estado<span style="color: red">*</span>: <input type="text" name="estado" pattern="^[A-Za-zÀ-ÿ\s]+$" title="Somente letras" required /> <br>
		Complemento: <input type="text" name="complemento" pattern="^[A-Za-zÀ-ÿ\s]+$" title="Somente letras" /> <br>
		
		<input type="submit">
		
	</form> <br>
	
	<a href="adm.jsp"> Tela Principal </a> - <a href="endereco?acao=listar"> Endereços Cadastrados </a> 
	
	<script type="text/javascript">
	    function mascaraCEP(input) {
	        let v = input.value.replace(/\D/g, "");
	        v = v.replace(/^(\d{5})(\d)/, "$1-$2");
	        input.value = v;
	    }
	</script>
	
</body>
</html>