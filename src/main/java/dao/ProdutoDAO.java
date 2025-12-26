package dao;

import bd.ConnectionFactory;
import model.Produto;

import java.sql.*;
import java.util.ArrayList;

public class ProdutoDAO {

    private ConnectionFactory connection;

    public ProdutoDAO() {
        this.connection = new ConnectionFactory();
    }

    public void cadastrar(Produto produto){
        String sql = "INSERT INTO Produto (nome, peso, volume, valor, descricao) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = connection.getConnection()){
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, produto.getNome());
            ps.setDouble(2, produto.getPeso());
            ps.setInt(3, produto.getVolume());
            ps.setDouble(4, produto.getValor());
            ps.setString(5, produto.getDescricao());

            System.out.println("Produto Cadastrado");

            ps.execute();

            //Pegar o ID da Entrega que foi criada
            int idProduto = -1;
            try (java.sql.ResultSet rs = ps.getGeneratedKeys()){
                if (rs.next()){
                    idProduto = rs.getInt(1);
                    produto.setIdProduto(idProduto);
                } else {
                    throw new SQLException("Falha ao criar ID do Produto, nenhum retornado");
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Produto> listar(){
        String sql = "SELECT * FROM Produto ORDER BY idProduto ASC	";

        ArrayList<Produto> produtos = new ArrayList<>();

        try(Connection conn = connection.getConnection()){
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()){
            	int idProduto = rs.getInt("idProduto");
                String nome = rs.getString("nome");
                double peso = rs.getDouble("peso");
                int volume = rs.getInt("volume");
                double valor = rs.getDouble("valor");
                String descricao = rs.getString("descricao");

                produtos.add(new Produto(idProduto, nome, peso, volume, valor, descricao));
            }
        } catch (Exception e){
            throw new RuntimeException(e);
        }

//        System.out.println(produtos);
        return produtos;
    }

    public void atualizar(String nome, double peso, int volume, double valor, String descricao, int idProduto){
        String sql = "UPDATE Produto SET nome = ?, peso = ?, volume = ?, valor = ?, descricao = ? WHERE idproduto = ?";

        try(Connection cnn = connection.getConnection()){
            PreparedStatement ps = cnn.prepareStatement(sql);

            ps.setString(1, nome);
            ps.setDouble(2, peso);
            ps.setInt(3, volume);
            ps.setDouble(4, valor);
            ps.setString(5, descricao);

            ps.setInt(6, idProduto);

            ps.execute();

            System.out.println("Produto com o ID: " + idProduto + " atualizado");

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void apagar(int idProduto){
        String sql = "DELETE FROM Produto WHERE idproduto = ?;";

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
        String sql = "SELECT * FROM Produto WHERE idProduto = ?";

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
                
                return produto;
                
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return null;
    }

}
