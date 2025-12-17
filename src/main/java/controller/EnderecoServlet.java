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
import dao.EnderecoDAO;
import model.Cliente;
import model.Endereco;


@WebServlet("/endereco")
public class EnderecoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//menu com escolhas das funções do ENDERECO
		
		String acao = request.getParameter("acao");
		
		switch (acao) {
		case "listar":
			listarEndereco(request, response);
			break;
		case "cadastrar":
			request.getRequestDispatcher("/endereco/form-endereco.jsp").forward(request, response);
			break;
		case "salvarCadastro":
			cadastrarEndereco_Cliente(request, response);
			break;
		case "buscarEndereco":
			buscarEndereco(request, response);
			break;
		case "editarEndereco":
			editarEndereco(request, response);
			break;
		case "deletarEndereco":
			deletarEndereco(request, response);
			break;
		default:
			System.out.println("Opção Invalida!");
			break;
		}		
		
		System.out.println(acao);     
	}

	protected void listarEndereco(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Listando os endereços cadastrados");
		
		EnderecoDAO enderecoDAO = new EnderecoDAO();
		ArrayList<Endereco> lista = enderecoDAO.listar();
		
		request.setAttribute("enderecos", lista);
		
		RequestDispatcher rd = request.getRequestDispatcher("/endereco/lista-enderecos.jsp");
		rd.forward(request, response);
	}
	
	protected void cadastrarEndereco_Cliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Cadastrando cliente com endereço");

		//Chamando a sessão e chamando o cliente que ta na sessão
		HttpSession session = request.getSession();
		Cliente cliente = (Cliente) session.getAttribute("clienteTemp");
		
		Endereco endereco = new Endereco();
		
		endereco.setCep(request.getParameter("cep"));
		endereco.setRua(request.getParameter("rua"));
		endereco.setNumero(request.getParameter("numero"));
		endereco.setBairro(request.getParameter("bairro"));
		endereco.setCidade(request.getParameter("cidade"));
		endereco.setEstado(request.getParameter("estado"));
		endereco.setComplemento(request.getParameter("complemento"));
		
		EnderecoDAO enderecoDAO = new EnderecoDAO();
		ClienteDAO clienteDAO = new ClienteDAO();
		
		// ORDEM CORRETA PARA SALVAR CADASTRAR O ENDERECO
		enderecoDAO.cadastrar(endereco);
		
		if(cliente != null) {
			cliente.setEnderecoCliente(endereco); //COLOCAR O ENDERECO NO CLIENTE
			clienteDAO.cadastrar(cliente); //FINALIZANDO CRIANDO O CLIENTE COM O ENDERECO
		}
		
		session.removeAttribute("clienteTemp");
		
		response.sendRedirect("endereco?acao=listar");
	}
	
	protected void editarEndereco(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Editando endereço");
		
		String novoCep = request.getParameter("cep");
		String novaRua = request.getParameter("rua");
		String novoNumero = request.getParameter("numero");
		String novoBairro = request.getParameter("bairro");
		String novaCidade = request.getParameter("cidade");
		String novoEstado = request.getParameter("estado");
		String novoComple = request.getParameter("complemento");
		String paramId = request.getParameter("idEndereco");
		
		Integer idEndereco = Integer.valueOf(paramId);
		
		EnderecoDAO enderecoDAO = new EnderecoDAO();
		
		enderecoDAO.atualizar(novoCep ,novaRua, novoNumero, novoBairro, novaCidade, novoEstado, novoComple, idEndereco);
		
		response.sendRedirect("endereco?acao=listar");
	}
	
	protected void buscarEndereco (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String paramId = request.getParameter("idEndereco");
		Integer idEndereco = Integer.parseInt(paramId);
		
		EnderecoDAO enderecoDAO = new EnderecoDAO();
		
		Endereco endereco = enderecoDAO.buscarPorId(idEndereco);
		
		if(endereco != null) {
			request.setAttribute("endereco", endereco);
			
			RequestDispatcher rd = request.getRequestDispatcher("/endereco/editar-endereco.jsp");
			rd.forward(request, response);
		}
	}
	
	protected void deletarEndereco(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String paramId = request.getParameter("idEndereco");
		Integer idEndereco = Integer.parseInt(paramId);
		
		EnderecoDAO enderecoDAO = new EnderecoDAO();
		
		enderecoDAO.apagar(idEndereco);
		
		response.sendRedirect("endereco?acao=listar");
	}
}