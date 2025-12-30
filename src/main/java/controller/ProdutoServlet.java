package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ProdutoDAO;
import model.Cliente;
import model.Produto;

@WebServlet("/produto")
public class ProdutoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String acao = request.getParameter("acao");
		
		switch (acao) {
		case "listar":
			listarProduto(request, response);
			break;
		case "sairGerenciamento":
			sairGerenciamento(request, response);
			break;
		case "cadastrar":
			request.getRequestDispatcher("/produto/form-produto.jsp").forward(request, response);
			break;
		case "salvarCadastro":
			cadastrarProduto(request, response);
			break;
		case "buscarProduto":
			buscarProduto(request, response);
			break;
		case "editarProduto":
			editarProduto(request, response);
			break;
		case "deletarProduto":
			deletarProduto(request, response);
			break;
		default:
			System.out.println("Opção Invalida");
			break;
		}
		
		System.out.println(acao);
		
	}
	
	protected void listarProduto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Listando Produtos");
		
		ProdutoDAO produtoDAO = new ProdutoDAO();
		ArrayList<Produto> lista = produtoDAO.listar();
		
		request.setAttribute("produtos", lista);
		
		HttpSession session = request.getSession();
		Cliente cliente = (Cliente) session.getAttribute("clienteLogado");

	    if (cliente != null) {

	        ArrayList<Produto> produtosDoCliente = produtoDAO.listarPorCliente(cliente.getIdCliente());

	        request.setAttribute("produtos", produtosDoCliente);
	        request.setAttribute("modo", "GERENCIAMENTO");

	    } else {
	    	
	        ArrayList<Produto> todosProdutos = produtoDAO.listar();

	        request.setAttribute("produtos", todosProdutos);
	        request.setAttribute("modo", "SISTEMA");
	    }

		RequestDispatcher rd = request.getRequestDispatcher("/produto/lista-produtos.jsp");
		rd.forward(request, response);
	}
	
	protected void sairGerenciamento(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    HttpSession session = request.getSession();
	    session.removeAttribute("clienteLogado");
	    
	    response.sendRedirect("produto?acao=listar");
	}

	
	protected void cadastrarProduto(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    System.out.println("Cadastrando um produto");

	    Produto produto = new Produto();

	    String pesoComMascara = request.getParameter("peso");
	    String peso = pesoComMascara.replace(" kg", "").trim();

	    String valorComMascara = request.getParameter("valor");
	    String valor = valorComMascara.replace("R$ ", "")
	                                  .replace(".", "")
	                                  .replace(",", ".");

	    produto.setNome(request.getParameter("nome"));
	    produto.setPeso(Double.parseDouble(peso));
	    produto.setVolume(Integer.parseInt(request.getParameter("volume")));
	    produto.setValor(Double.parseDouble(valor));
	    produto.setDescricao(request.getParameter("descricao"));

	    HttpSession session = request.getSession(false);
	    Integer idCliente = null;

	    if (session != null) {
	        Cliente cliente = (Cliente) session.getAttribute("clienteLogado");
	        if (cliente != null) {
	            idCliente = cliente.getIdCliente();
	        }
	    }

	    ProdutoDAO produtoDAO = new ProdutoDAO();
	    produtoDAO.cadastrar(produto, idCliente);

	    response.sendRedirect("produto?acao=listar");
	}

	
	protected void buscarProduto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String paramId = request.getParameter("idProduto");
		Integer idProduto = Integer.parseInt(paramId);
		
		ProdutoDAO produtoDAO = new ProdutoDAO();
		
		Produto produto = produtoDAO.buscarPorId(idProduto);
		
		if(produto != null) {
			request.setAttribute("produto", produto);
			
			RequestDispatcher rd = request.getRequestDispatcher("/produto/editar-produto.jsp");
			rd.forward(request, response);
		}
	}
	
	protected void editarProduto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	    String pesoComMascara = request.getParameter("peso");
	    String pesoLimpo = pesoComMascara.replaceAll("[^0-9,]", "").replace(",", ".");

	    String valorComMascara = request.getParameter("valor");
	    String valorLimpo = valorComMascara.replaceAll("[^0-9,]", "").replace(",", ".");

	    String novoNome = request.getParameter("nome");
	    int novoVolume = Integer.parseInt(request.getParameter("volume"));
	    String novaDescricao = request.getParameter("descricao");
	    int idProduto = Integer.parseInt(request.getParameter("idProduto"));

	    double novoPeso = Double.parseDouble(pesoLimpo);
	    double novoValor = Double.parseDouble(valorLimpo);

	    ProdutoDAO produtoDAO = new ProdutoDAO();

	    produtoDAO.atualizar(novoNome, novoPeso, novoVolume, novoValor, novaDescricao, null, idProduto);

	    response.sendRedirect("produto?acao=listar");
	}
	
	protected void deletarProduto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Deletando Produto");
		
		String paramId = request.getParameter("idProduto");
		Integer idProduto = Integer.parseInt(paramId);
		
		ProdutoDAO produtoDAO = new ProdutoDAO();
		
		produtoDAO.apagar(idProduto);
		
		response.sendRedirect("produto?acao=listar");
	}
}
