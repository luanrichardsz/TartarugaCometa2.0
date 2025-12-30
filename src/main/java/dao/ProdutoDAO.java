package dao;

import bd.ConnectionFactory;
import model.Cliente;
import model.Produto;

import java.sql.*;
import java.util.ArrayList;

public class ProdutoDAO {

    private ConnectionFactory connection;

    public ProdutoDAO() {
        this.connection = new ConnectionFactory();
    }

    public void cadastrar(Produto produto, Integer idCliente){
        String sql = "INSERT INTO Produto (nome, peso, volume, valor, descricao, cliente_id) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = connection.getConnection()){
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, produto.getNome());
            ps.setDouble(2, produto.getPeso());
            ps.setInt(3, produto.getVolume());
            ps.setDouble(4, produto.getValor());
            ps.setString(5, produto.getDescricao());
            
            if (idCliente != null) {
                ps.setInt(6, idCliente);
            } else {
                ps.setNull(6, Types.INTEGER);
            }

            System.out.println("Produto Cadastrado");


            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                produto.setIdProduto(rs.getInt(1));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao cadastrar produto", e);
        }
    }

    public ArrayList<Produto> listar(){
        String sql = "SELECT p.idProduto, p.nome, p.peso, p.volume, p.valor, p.descricao, c.idCliente, c.nome AS cliente_nome, c.razaoSocial FROM Produto AS p LEFT JOIN Cliente AS c ON c.idcliente = p.cliente_id WHERE p.ativo = TRUE ORDER BY idProduto ASC	";

        ArrayList<Produto> produtos = new ArrayList<>();

        try (Connection conn = connection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

               while (rs.next()) {
                   Produto produto = new Produto();

                   produto.setIdProduto(rs.getInt("idProduto"));
                   produto.setNome(rs.getString("nome"));
                   produto.setPeso(rs.getDouble("peso"));
                   produto.setVolume(rs.getInt("volume"));
                   produto.setValor(rs.getDouble("valor"));
                   produto.setDescricao(rs.getString("descricao"));

                   int idCliente = rs.getInt("idCliente");
                   if (!rs.wasNull()) {
                       Cliente cliente = new Cliente();
                       cliente.setIdCliente(idCliente);
                       cliente.setNome(rs.getString("cliente_nome"));
                       cliente.setRazaoSocial(rs.getString("razaoSocial"));
                       produto.setCliente(cliente);
                   }

                   produtos.add(produto);
               }

           } catch (SQLException e) {
               throw new RuntimeException("Erro ao listar produtos", e);
           }

           return produtos;
       }

    public ArrayList<Produto> listarPorCliente(int idCliente) {
        ArrayList<Produto> produtos = new ArrayList<>();
        
        // VERIFIQUE ESTA LINHA: O "?" deve estar logo após o "cliente_id ="
        String sql = "SELECT idproduto, nome, peso, volume, valor, descricao " +
                     "FROM Produto WHERE cliente_id = ? AND ativo = TRUE " + 
                     "ORDER BY idproduto ASC";
        
        try (Connection conn = connection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idCliente); // O erro acontece aqui se o SQL acima não tiver o "?"
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Produto produto = new Produto();
                produto.setIdProduto(rs.getInt("idproduto"));
                produto.setNome(rs.getString("nome"));
                produto.setPeso(rs.getDouble("peso"));
                produto.setVolume(rs.getInt("volume"));
                produto.setValor(rs.getDouble("valor"));
                produto.setDescricao(rs.getString("descricao"));

                Cliente cliente = new Cliente();
                cliente.setIdCliente(idCliente);
                produto.setCliente(cliente);

                produtos.add(produto);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro ao listar produtos por cliente", e);
        }

        return produtos;
    }
    
    public void atualizar(String nome, double peso, int volume, double valor, String descricao, Integer idCliente, int idProduto) {

        String sql;

        if (idCliente != null) {
            sql = "UPDATE Produto SET nome=?, peso=?, volume=?, valor=?, descricao=?, cliente_id=? WHERE idproduto=?";
        } else {
            sql = "UPDATE Produto SET nome=?, peso=?, volume=?, valor=?, descricao=? WHERE idproduto=?";
        }

        try (Connection conn = connection.getConnection()) {

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, nome);
            ps.setDouble(2, peso);
            ps.setInt(3, volume);
            ps.setDouble(4, valor);
            ps.setString(5, descricao);

            if (idCliente != null) {
                ps.setInt(6, idCliente);
                ps.setInt(7, idProduto);
            } else {
                ps.setInt(6, idProduto);
            }

            ps.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }



    public void apagar(int idProduto){
    	String sql = "UPDATE Produto SET ativo = FALSE WHERE idproduto = ?";
    	
        try (Connection cnn = connection.getConnection()){
            PreparedStatement ps = cnn.prepareStatement(sql);

            ps.setInt(1, idProduto);
            ps.execute();
            System.out.println("Produto com o ID: " + idProduto + " Deletado com Sucesso!");

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public Produto buscarPorId(int idProduto){
        String sql = "SELECT idproduto, nome, peso, volume, valor, descricao, cliente_id FROM Produto WHERE idProduto = ?";

        try(Connection cnn = connection.getConnection()) {
            PreparedStatement ps = cnn.prepareStatement(sql);

            ps.setInt(1, idProduto);

            ResultSet rs = ps.executeQuery();

            idProduto = 0;

            while (rs.next()){
            	Produto produto = new Produto();
            	
                produto.setIdProduto(rs.getInt("idProduto"));
                produto.setNome(rs.getString("nome"));
                produto.setPeso(rs.getDouble("peso"));
                produto.setVolume(rs.getInt("volume"));
                produto.setValor(rs.getDouble("valor"));
                produto.setDescricao(rs.getString("descricao"));
                
                Integer clienteId = rs.getObject("cliente_id", Integer.class);
                if (clienteId != null) {
                    Cliente cliente = new Cliente();
                    cliente.setIdCliente(clienteId);
                    produto.setCliente(cliente);
                }
                
                return produto;
                
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return null;
    }

}
