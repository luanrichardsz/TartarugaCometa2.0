package dao;

import bd.ConnectionFactory;
import model.Cliente;
import model.Endereco;

import java.sql.*;
import java.util.ArrayList;

public class ClienteDAO {
    //Construtor para chamar a conexão com o banco de dados
    private ConnectionFactory connection;
    Endereco endereco = new Endereco();

    public ClienteDAO() {
        this.connection = new ConnectionFactory();
    }

    public void cadastrar(Cliente cliente){
        String sql = "INSERT INTO cliente (nome, cpf_cnpj, razaoSocial, isFisico, Endereco_ID) VALUES (?, ?, ?, ?, ?)";

        try(Connection conn = connection.getConnection()){
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, cliente.getNome());
            ps.setString(2, cliente.getCpfCnpj());
            ps.setString(3, cliente.getRazaoSocial());
            ps.setBoolean(4, cliente.isFisico());
            ps.setInt(5, cliente.getEnderecoCliente().getIdEndereco());

            System.out.println("Cliente Cadastrado");

            ps.execute();

            //Pegar o ID da Entrega que foi criada
            int idCliente = -1;
            try (ResultSet rs = ps.getGeneratedKeys()){
                if (rs.next()){
                    idCliente = rs.getInt(1);
                    cliente.setIdCliente(idCliente);
                } else {
                    throw new SQLException("Falha ao criar ID do cliente, nenhum retornado");
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Cliente> listar(){
        String sql = "SELECT idCliente ,nome, cpf_Cnpj, razaoSocial from Cliente";

        ArrayList<Cliente> clientes = new ArrayList<>();

        try(Connection cnn = connection.getConnection()){
            PreparedStatement ps = cnn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()){
            	int idCliente = rs.getInt("idCliente");
                String nome = rs.getString("nome");
                String cpfCnpj = rs.getString("cpf_Cnpj");
                String razaoSocial = rs.getString("razaoSocial");

                clientes.add(new Cliente(idCliente ,nome, cpfCnpj, razaoSocial, endereco));
            }
        } catch (Exception e){
            throw new RuntimeException(e);
        }
        return clientes;
    }

    public void apagar(int idCliente){
        String sqlEntrega  = "DELETE FROM Entrega WHERE clienteremetente_id = ? OR clientedestinatario_id = ?";
        String sqlEndereco = "SELECT Endereco_ID FROM Cliente WHERE idCliente = ?";
        String sqlDeleteEndereco = "DELETE FROM Endereco WHERE idendereco = ?;";
        String sqlDeleteCliente   = "DELETE FROM Cliente WHERE idCliente = ?";

        //Deletando a Entrega
        try(Connection cnn = connection.getConnection()){
            PreparedStatement psEntrega = cnn.prepareStatement(sqlEntrega);
            psEntrega.setInt(1, idCliente);
            psEntrega.setInt(2, idCliente);

            psEntrega.execute();

            System.out.println("Apagando Entregas Referente ao Cliente");
        } catch (Exception e) {
            throw new RuntimeException(e);
        };

        //Buscando e Deletando o ID Endereco
        try(Connection cnn = connection.getConnection()){
            //Executando a SQL de Busca de Endereco_ID no Cliente
            PreparedStatement psEndereco = cnn.prepareStatement(sqlEndereco);
            psEndereco.setInt(1, idCliente);
            ResultSet rsEndereco = psEndereco.executeQuery();

            int idEndereco = 0;
            //Armazenando na variavel idEndereco
            while (rsEndereco.next()) {
                idEndereco = rsEndereco.getInt("Endereco_ID");
            }

            //Deletando o cliente com o Endereco_ID ja armazenado em outra variavel
            PreparedStatement ps = cnn.prepareStatement(sqlDeleteCliente);
            ps.setInt(1, idCliente);
            ps.execute();
            System.out.println("Cliente Deletado com Sucesso!");

            // Deletendo o Endereco quando for diferente de 0
            if (idEndereco != 0) {
                PreparedStatement psDeleteEndereco = cnn.prepareStatement(sqlDeleteEndereco);
                psDeleteEndereco.setInt(1, idEndereco);
                psDeleteEndereco.execute();
                System.out.println("Endereço Relacionado ao Cliente Deletado com Sucesso!");
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void atualizar(String nome, int idCliente) {
    	String sql = "UPDATE Cliente SET nome = ? WHERE idCliente = ?";
    	
    	try (Connection conn = connection.getConnection()){
    		PreparedStatement ps = conn.prepareStatement(sql);
    		
    		ps.setString(1, nome);
    		ps.setInt(2, idCliente);
    		
    		ps.execute();
    		
    		System.out.println("Cliente com ID: " + idCliente + " atualizado");
    		
    	} catch (Exception e) {
			throw new RuntimeException(e);
		}
    }
    
    public Cliente buscarPorId(int idCliente){
        String sql = "SELECT idCliente, nome, cpf_Cnpj, razaoSocial FROM Cliente WHERE idCliente = ?";

        try (Connection conn = connection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, idCliente);

            ResultSet rs = ps.executeQuery();

            idCliente = 0;

            while (rs.next()){
            	Cliente cliente = new Cliente();
            	
                cliente.setIdCliente(rs.getInt("idCliente"));
                cliente.setNome(rs.getString("nome"));
                cliente.setCpfCnpj(rs.getString("cpf_Cnpj"));
                cliente.setRazaoSocial(rs.getString("razaoSocial"));
                
                return cliente;
                
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return null;
    }
}