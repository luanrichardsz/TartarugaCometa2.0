package dao;

import bd.ConnectionFactory;
import model.*;

import java.sql.*;
import java.util.ArrayList;

public class EntregaDAO {

    private ConnectionFactory connection;

    public EntregaDAO() {
        this.connection = new ConnectionFactory();
    }

    public void cadastrar(Entrega entrega, ArrayList<ProdutoEntrega> mercadorias) {
        String sqlEntrega = "INSERT INTO Entrega (clienteRemetente_ID, clienteDestinatario_ID) VALUES (?, ?)";
        String sqlProdutoEntrega = "INSERT INTO Produto_Entrega (entrega_ID, produto_ID, quantidade, frete) VALUES (?, ?, ?, ?)";
        String sqlAtualizarEstoque = "UPDATE Produto SET volume = volume - ? WHERE idproduto = ?";
        
        try (Connection conn = connection.getConnection()) {

            try (PreparedStatement ps = conn.prepareStatement(sqlEntrega, Statement.RETURN_GENERATED_KEYS);
                 PreparedStatement psProdutoEntrega = conn.prepareStatement(sqlProdutoEntrega);
                 PreparedStatement psUpdateEstoque = conn.prepareStatement(sqlAtualizarEstoque)) {

                ps.setInt(1, entrega.getClienteDestinatario().getIdCliente());
                ps.setInt(2, entrega.getClienteRemetente().getIdCliente());
                ps.executeUpdate();

                int idEntrega = -1;
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) idEntrega = rs.getInt(1);
                }

                for (ProdutoEntrega p : mercadorias) {
                    psProdutoEntrega.setInt(1, idEntrega);
                    psProdutoEntrega.setInt(2, p.getProduto().getIdProduto());
                    psProdutoEntrega.setInt(3, p.getQuantidade());
                    psProdutoEntrega.setDouble(4, p.getFrete());
                    psProdutoEntrega.executeUpdate();

                    psUpdateEstoque.setInt(1, p.getQuantidade());
                    psUpdateEstoque.setInt(2, p.getProduto().getIdProduto()); 
                    psUpdateEstoque.executeUpdate();
                }

            } catch (SQLException e) {
                throw new SQLException("Erro na transação. Estoque pode ser insuficiente.", e);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Entrega> listar(){
        String sqlEntrega = "SELECT * FROM Entrega ORDER BY realizada ASC";

        ArrayList<Entrega> entregas = new ArrayList<>();

        try(Connection conn = connection.getConnection()){
            PreparedStatement ps = conn.prepareStatement(sqlEntrega);
            ResultSet rs = ps.executeQuery();

            Entrega entregaAtual = null;
            int ultimoIdEntrega = 0;

            while (rs.next()){
                int idEntrega = rs.getInt("idEntrega");
                boolean realizada = rs.getBoolean("realizada");
                int remetente_id = rs.getInt("clienteremetente_id");
                int destinatario_id = rs.getInt("clientedestinatario_id");

             // Validação para os IDs
                if (idEntrega != ultimoIdEntrega){

                    ClienteDAO clienteDAO = new ClienteDAO();

                    Cliente remetente = clienteDAO.buscarPorId(remetente_id);
                    Cliente destinatario = clienteDAO.buscarPorId(destinatario_id);

                    entregaAtual = new Entrega(realizada, remetente, destinatario);
                    entregaAtual.setIdEntrega(idEntrega);

                    entregas.add(entregaAtual);
                    ultimoIdEntrega = idEntrega;
                }

                //SELECT do ProdutoEntrega
                String sqlProdutosEntrega = "SELECT * FROM Produto_Entrega AS proEnt LEFT JOIN Produto AS p ON p.idproduto = proEnt.produto_id WHERE entrega_id = ?";
                PreparedStatement psProEnt = conn.prepareStatement(sqlProdutosEntrega);
                psProEnt.setInt(1, idEntrega);
                ResultSet rsProEnt = psProEnt.executeQuery();

                while (rsProEnt.next()) {
                    int idProduto = rsProEnt.getInt("produto_ID");
                    String nomeProduto = rsProEnt.getString("nome");
                    int quantidade = rsProEnt.getInt("quantidade");
                    double frete = rsProEnt.getDouble("frete");
                    double valor = rsProEnt.getDouble("valor");
                    String descricao = rsProEnt.getString("descricao");

                    if (idProduto != 0) {
                        ProdutoEntrega proEnt = new ProdutoEntrega();
                        Produto p = new Produto();

                        p.setIdProduto(idProduto);
                        p.setNome(nomeProduto);
                        p.setValor(valor);
                        p.setDescricao(descricao);

                        proEnt.setProduto(p);
                        proEnt.setQuantidade(quantidade);
                        proEnt.setFrete(frete);

                        entregaAtual.getProdutos().add(proEnt);
                    }
                }
            }
        } catch (SQLException e){
            throw new RuntimeException(e);
        }

//        System.out.println(entregas);
        return entregas;
    }

    public void atualizar (boolean realizada, int idEntrega){
        String sql = "UPDATE entrega SET realizada = ? WHERE identrega = ?";

        try(Connection cnn = connection.getConnection()) {
            PreparedStatement ps = cnn.prepareStatement(sql);

            ps.setBoolean(1, realizada);
            ps.setInt(2, idEntrega);

            ps.execute();

            System.out.println("Status da Entrega com ID: " + idEntrega + " Alterado");

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void apagar (int idEntrega){
        String sql = "DELETE FROM Entrega WHERE identrega = ?";

        try (Connection cnn = connection.getConnection()){
            PreparedStatement ps = cnn.prepareStatement(sql);

            ps.setInt(1, idEntrega);
            ps.execute();
            System.out.println("Entrega com o ID: " + idEntrega + " Deletada com Sucesso!");

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public int buscarPorId(int idEntrega){
        String sql = "SELECT idEntrega FROM Entrega WHERE idEntrega = ?";

        try (Connection cnn = connection.getConnection()) {
            PreparedStatement ps = cnn.prepareStatement(sql);

            ps.setInt(1, idEntrega);

            ResultSet rs = ps.executeQuery();

            idEntrega = 0;

            while (rs.next()){
                idEntrega = rs.getInt("idEntrega");
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return idEntrega;
    }

}