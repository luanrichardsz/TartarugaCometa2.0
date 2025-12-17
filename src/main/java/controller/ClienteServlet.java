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

import dao.ClienteDAO;
import model.Cliente;

@WebServlet("/cliente")
public class ClienteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String acao = request.getParameter("acao");
		
		switch(acao) {
		case "listar":
			listarCliente(request, response);
			break;
		case "cadastrar":
			request.getRequestDispatcher("/cliente/form-cliente.jsp").forward(request, response);
			break;
		case "salvarTemp":
			salvarCliente(request, response);
			break;
		case "buscarCliente":
			buscarCliente(request, response);
			break;
		case "editarCliente":
			editarCliente(request, response);
			break;
		case "deletarCliente":
			deletarCliente(request, response);
			break;
		default:
			System.out.println("Opção Invalida!");
			break;
		}
		
		System.out.println(acao);
	}
	
	protected void listarCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Listando Clientes");
		
		ClienteDAO clienteDAO = new ClienteDAO();
		ArrayList<Cliente> lista = clienteDAO.listar();
		
		request.setAttribute("clientes", lista);
		
		RequestDispatcher rd = request.getRequestDispatcher("cliente/lista-clientes.jsp");
		rd.forward(request, response);
	}
	protected void salvarCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Cadastrando cliente");
				
		Cliente cliente = new Cliente();
		
		cliente.setNome(request.getParameter("nomeCliente"));
		cliente.setCpfCnpj(request.getParameter("cpfCnpj"));
		cliente.setRazaoSocial(request.getParameter("razaoSocial"));
		cliente.tipoCliente();
		
		HttpSession session = request.getSession();
		
		session.setAttribute("clienteTemp", cliente);
		
		response.sendRedirect("endereco?acao=cadastrar");
	}
	
	protected void buscarCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String paramId = request.getParameter("idCliente");
		Integer idCliente = Integer.parseInt(paramId);
		
		ClienteDAO clienteDAO = new ClienteDAO();
		
		Cliente cliente = clienteDAO.buscarPorId(idCliente);
		
		System.out.println(idCliente);

		if(cliente != null) {
			request.setAttribute("cliente", cliente);
			
			RequestDispatcher rd = request.getRequestDispatcher("/cliente/editar-cliente.jsp");
			rd.forward(request, response);
		}
	}
	
	protected void editarCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Editando Cliente");
		
		String novoNome = request.getParameter("nomeCliente");
		String paramId = request.getParameter("idCliente");
		
		Integer idCliente = Integer.parseInt(paramId);
		
		ClienteDAO clienteDAO = new ClienteDAO();
		
		clienteDAO.atualizar(novoNome, idCliente);
		
		response.sendRedirect("cliente?acao=listar");
	}
	
	protected void deletarCliente (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Deletando Cliente");
		
		String paramId = request.getParameter("idCliente");
		Integer idCliente = Integer.parseInt(paramId);
		
		System.out.println(idCliente);
		
		ClienteDAO clienteDAO = new ClienteDAO();
		
		clienteDAO.apagar(idCliente);
		
		response.sendRedirect("cliente?acao=listar");
	}
}