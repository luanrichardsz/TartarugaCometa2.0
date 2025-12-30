<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editando Produto</title>
</head>
<body>
	
	<button onclick="history.back()"> Voltar </button><br><br>
	
	<form action="produto" method="post">
	    <input type="hidden" name="acao" value="editarProduto"/>
	
	    ID:
	    <input type="text" name="idProduto" value="${produto.idProduto}" readonly><br>
	
	    Nome:
	    <input type="text" name="nome"
	           value="${produto.nome}"
	           oninput="somenteLetras(this)" required><br>
	
	    Peso:
	    <input type="text" name="peso"
	           value="${produto.pesoEditavel}"
	           oninput="mascaraPeso(this)"
	           onblur="validarPesoMinimo(this)"
	           placeholder="0.000 kg"
	           maxlength="9" required>
	    <span id="msgErroPeso" style="color:red; display:none; font-size:12px;">
	        O peso mínimo permitido é 0.100 kg.
	    </span><br>
	
	    Volume:
	    <input type="number" name="volume"
	           value="${produto.volume}"
	           min="1" max="50" required><br>
	
	    Valor:
	    <input type="text" name="valor"
	           value="${produto.valorEditavel}"
	           oninput="mascaraValor(this)"
	           onblur="validarValorMinino(this)"
	           placeholder="R$ 00,00"
	           maxlength="16" required>
	    <span id="msgErroValor" style="color:red; display:none; font-size:12px;">
	        O valor mínimo permitido é R$ 10,00.
	    </span><br>
	
	    Descrição:
	    <input type="text" name="descricao" value="${produto.descricao}"><br>
	
	    <input type="submit">
	</form>

<script>
    function somenteLetras(input){
        input.value = input.value.replace(/[^A-Za-zÀ-ÿ\s]/g, "");
    }

    function mascaraPeso(input) {
        let v = input.value.replace(/\D/g, "");
        if (v === "") return;
        v = (v / 1000).toFixed(3);
        input.value = v.replace(".", ",") + " kg";
    }

    function mascaraValor(input) {
        let v = input.value.replace(/\D/g, "");
        v = (v / 100).toFixed(2).replace(".", ",");
        input.value = "R$ " + v;
    }

    function validarPesoMinimo(input) {
        let valor = parseFloat(
            input.value.replace(" kg", "").replace(",", ".")
        );
        const erro = document.getElementById("msgErroPeso");

        if (valor < 0.1) {
            erro.style.display = "inline";
            input.value = "0,100 kg";
        } else {
            erro.style.display = "none";
        }
    }

    function validarValorMinino(input) {
        let valor = parseFloat(
            input.value.replace("R$ ", "").replace(",", ".")
        );
        const erro = document.getElementById("msgErroValor");

        if (valor < 10) {
            erro.style.display = "inline";
            input.value = "R$ 10,00";
        } else {
            erro.style.display = "none";
        }
    }
</script>

</body>
</html>
