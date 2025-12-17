package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ProdutoDAO;
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
		
		RequestDispatcher rd = request.getRequestDispatcher("/produto/lista-produtos.jsp");
		rd.forward(request, response);
	}
	
	protected void cadastrarProduto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Cadastrando um produto");
		
		Produto produto = new Produto();
		
		produto.setNome(request.getParameter("nome"));
		produto.setPeso(Double.parseDouble(request.getParameter("peso")));
		produto.setVolume(Double.parseDouble(request.getParameter("volume")));
		produto.setValor(Double.parseDouble(request.getParameter("valor")));
		
		ProdutoDAO produtoDAO = new ProdutoDAO();
		
		produtoDAO.cadastrar(produto);
		
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
		System.out.println("Editando Produto");
		
		String novoNome = request.getParameter("nomeProduto");
		String paramPeso = request.getParameter("peso");
		String paramVolume = request.getParameter("volume");
		String paramValor = request.getParameter("valor");
		String paramId = request.getParameter("idProduto");
		
		Double novoPeso = Double.parseDouble(paramPeso);
		Double novoVolume = Double.parseDouble(paramVolume);
		Double novoValor = Double.parseDouble(paramValor);
		Integer idProduto = Integer.parseInt(paramId);
		
		ProdutoDAO produtoDAO = new ProdutoDAO();
		
		produtoDAO.atualizar(novoNome, novoPeso, novoVolume, novoValor, idProduto);
		
		response.sendRedirect("produto?acao=listar");
	}
}
