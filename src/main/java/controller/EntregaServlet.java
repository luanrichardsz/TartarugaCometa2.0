package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ClienteDAO;
import dao.EntregaDAO;
import dao.ProdutoDAO;
import model.Cliente;
import model.Entrega;
import model.Produto;
import model.ProdutoEntrega;

@WebServlet("/entrega")
public class EntregaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String acao = request.getParameter("acao");
		
		switch (acao) {
		case "listar":
			listarEntregas(request, response);
			break;
		case "cadastrar":
			cadastrarEntrega(request, response);
			break;
		case "salvarEntrega":
			salvarEntrega(request, response);
			break;
		case "editarStatus":
			editarStatus(request, response);
			break;
		case "deletar":
			deletarEntrega(request, response);
			break;
		default:
			break;
		}
	}

	protected void cadastrarEntrega(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ClienteDAO clienteDAO = new ClienteDAO();
		ProdutoDAO produtoDAO = new ProdutoDAO();
		
		ArrayList<Cliente> listaClientes = clienteDAO.listar();
		ArrayList<Produto> listaProdutos = produtoDAO.listar();
		
		request.setAttribute("clientes", listaClientes);
		request.setAttribute("produtos", listaProdutos);
		
		RequestDispatcher rd = request.getRequestDispatcher("/entrega/form-entrega.jsp");
		rd.forward(request, response);
	}
	
	protected void salvarEntrega(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    int idRemetente = Integer.parseInt(request.getParameter("remetente"));
	    int idDestinatario = Integer.parseInt(request.getParameter("destinatario"));
	    int idProduto = Integer.parseInt(request.getParameter("produto"));
	    int quantidade = Integer.parseInt(request.getParameter("quantidade"));
	    double frete = Double.parseDouble(request.getParameter("frete"));

	    Cliente remetente = new Cliente();
	    remetente.setIdCliente(idRemetente);

	    Cliente destinatario = new Cliente();
	    destinatario.setIdCliente(idDestinatario);

	  	Entrega entrega = new Entrega(false, remetente, destinatario);

	    Produto produto = new Produto();
	    produto.setIdProduto(idProduto);

	    ProdutoEntrega produtoEntrega = new ProdutoEntrega();
	    produtoEntrega.setProduto(produto);
	    produtoEntrega.setQuantidade(quantidade);
	    produtoEntrega.setFrete(frete);

	    ArrayList<ProdutoEntrega> mercadorias = new ArrayList<>();
	    mercadorias.add(produtoEntrega);

	    EntregaDAO entregaDAO = new EntregaDAO();
	    entregaDAO.cadastrar(entrega, mercadorias);

	    response.sendRedirect("entrega?acao=listar");
	}

	protected void listarEntregas (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Listando entregas");
		
		
		EntregaDAO entregaDAO = new EntregaDAO();
		ArrayList<Entrega> lista = entregaDAO.listar();
		
		request.setAttribute("entregas", lista);
		
		RequestDispatcher rd = request.getRequestDispatcher("entrega/lista-entregas.jsp");
		rd.forward(request, response);
	}
	
	protected void editarStatus(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    try {
	        int idEntrega = Integer.parseInt(request.getParameter("idEntrega"));
	        boolean realizada = Boolean.parseBoolean(request.getParameter("realizada"));

	        EntregaDAO entregaDAO = new EntregaDAO();
	        entregaDAO.atualizar(realizada, idEntrega);
	        
	        response.sendRedirect("entrega?acao=listar");

	    } catch (NumberFormatException e) {
	        throw new ServletException("Erro ao alterar status da entrega", e);
	    }
	}
	
	protected void deletarEntrega(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
		
		int idEntrega = Integer.parseInt(request.getParameter("idEntrega"));
		boolean realizada = Boolean.parseBoolean(request.getParameter("realizada"));
		
		System.out.println(realizada);
		
		EntregaDAO entregaDAO = new EntregaDAO();
		
		if( realizada == false ) {
			entregaDAO.apagar(idEntrega);
		}
				
		response.sendRedirect("entrega?acao=listar");
	}

}
