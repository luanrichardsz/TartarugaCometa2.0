<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastrar Produto</title>
</head>
<body>
	
	<h1 style="text-align: center">Cadastrar Produto</h1>
	
	<form action="/TartarugaCometa/produto?acao=salvarCadastro" method="post">
		
		Nome do Produto<span style="color: red">*</span>: <input type="text" name="nome" oninput="somenteLetras(this)" required/> <br>
		Peso<span style="color: red">*</span>: <input type="text" name="peso" oninput="mascaraPeso(this)" onblur="validarPesoMinimo(this)" placeholder="0.000 kg" min="0.100" maxlength="9" required/> 
		<span id="msgErroPeso" style="color: red; display: none; font-size: 12px;">
		    O peso mínimo permitido é 0.100 kg.
		</span> <br>
		Volume(Uni)<span style="color: red">*</span>: <input type="number" name="volume" oninput="mascaraVolume(this)" maxlength="5" value="1" min="1" max="50" required/> <br>
		Valor<span style="color: red">*</span>: <input type="text" name="valor" oninput="mascaraValor(this)" onblur="validarValorMinino(this)" placeholder="R$ 00.00" maxlength="16" required>
		<span id="msgErroValor" style="color: red; display: none; font-size: 12px;">
		    O valor mínimo permitido é R$ 10,00.
		</span> <br>
		Descrição: <input type="text" name="descricao">
		
		<input type="submit"> 
		
	</form> <br>
	
	<a href="adm.jsp"> Tela Principal </a> - <a href="produto?acao=listar"> Produtos Cadastrados </a>
	
	
	<script type="text/javascript">
		    function somenteLetras(input){
		    	input.value = input.value.replace(/[^A-Za-zÀ-ÿ\s]/g, "");
		    }
	
			function mascaraPeso(input) {
			    let v = input.value.replace(/\D/g, "");
			    
			    if (v === "") {
			        input.value = "";
			        return;
			    }
		
			    v = (parseFloat(v) / 1000).toFixed(3);
			    
			    let valorFormatado = v + " kg";
			    input.value = valorFormatado;
		
			    let posicaoFinal = valorFormatado.length - 3; 
			    input.setSelectionRange(posicaoFinal, posicaoFinal);
			}  
		    
			function mascaraValor(input) {
			    let v = input.value.replace(/\D/g, ""); 
			    v = (v / 100).toFixed(2) + ""; 
			    v = v.replace(".", ","); 
			    v = v.replace(/(\d)(\d{3})(\d{3}),/g, "$1.$2.$3,");
			    v = v.replace(/(\d)(\d{3}),/g, "$1.$2,");
			    input.value = "R$ " + v;
			}
			
			function validarPesoMinimo(input) {
			    let valorString = input.value.replace(" kg", "").replace(",", ".");
			    let valorNumerico = parseFloat(valorString);

			    const spanErro = document.getElementById("msgErroPeso");

			    if (valorNumerico < 0.100) {
			        spanErro.style.display = "inline"; 
			        input.style.borderColor = "red";   
			        input.value = "0.100 kg";         
			    } else {
			        spanErro.style.display = "none";   
			        input.style.borderColor = "";      
			    }
			}
			
			function validarValorMinino(input) {
				let valorLimpo = input.value.replace("R$ ", "").replaceAll(".", "").replace(",", ".");
			    let valorNumerico = parseFloat(valorLimpo);

			    const spanErro = document.getElementById("msgErroValor");

			    if (valorNumerico < 10.00) {
			        spanErro.style.display = "inline"; 
			        input.style.borderColor = "red"; 
			        input.value = "R$ 10,00"
			         
			    } else {
			        spanErro.style.display = "none";   
			        input.style.borderColor = "";      
			    }
			}
		
	</script>
</body>
</html>