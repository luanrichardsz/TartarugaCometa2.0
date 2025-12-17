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

    public void cadastrar(Entrega entrega, ArrayList<ProdutoEntrega> mercadorias) throws ClassNotFoundException {
        String sql = "INSERT INTO Entrega (realizada, clienteRemetente_ID, clienteDestinatario_ID) VALUES (?, ?, ?)";

        try (Connection conn = connection.getConnection()){
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setBoolean(1, entrega.isRealizada());
            ps.setInt(2, entrega.getClienteDestinatario().getIdCliente());
            ps.setInt(3, entrega.getClienteRemetente().getIdCliente());

            System.out.println("Dados dos Clientes e Dados da Entrega Cadastrado");

            ps.executeUpdate();

            //Pegar o ID da Entrega que foi criada
            int idEntrega = -1;
            try (java.sql.ResultSet rs = ps.getGeneratedKeys()){
                if (rs.next()){
                    idEntrega = rs.getInt(1);
                } else {
                    throw new SQLException("Falha ao criar ID da Entrega, nenhum retornado");
                }
            }

            //Preparar o insert da table produto_entrega
            String sqlProdutoEntrega = "INSERT INTO Produto_Entrega (entrega_ID, produto_ID, quantidade) VALUES (?, ?, ?)";
            PreparedStatement psProdutoEntrega = conn.prepareStatement(sqlProdutoEntrega);

            //Laço de repetição para adicionar Produtos da lista
            for(ProdutoEntrega p : mercadorias) {
                psProdutoEntrega.setInt(1, idEntrega);
                psProdutoEntrega.setInt(2, p.getProduto().getIdProduto());
                psProdutoEntrega.setInt(3, p.getQuantidade());

                psProdutoEntrega.executeUpdate();
            }

            System.out.println("Mercadoria cadastrada em Entrega!");

        } catch (SQLException e){
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Entrega> listar() throws ClassNotFoundException{
        String sqlEntrega = "SELECT * FROM Entrega";

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

                //Validação para os IDs
                if(idEntrega != ultimoIdEntrega){
                    Cliente remetente = new Cliente();
                    Cliente destinatario = new Cliente();

                    //Settando os IDs dos Clientes
                    remetente.setIdCliente(remetente_id);
                    destinatario.setIdCliente(destinatario_id);

                    //Adicionando a nova Entrega na lista Entrega
                    entregaAtual = new Entrega(realizada, remetente, destinatario);

                    //Settando o ID da Entrega
                    entregaAtual.setIdEntrega(idEntrega);

                    //Adicionando na lista
                    entregas.add(entregaAtual);

                    //Mudando o valor da variavel ultimoIdEntrega
                    ultimoIdEntrega = idEntrega;
                }

                //SELECT do ProdutoEntrega
                String sqlProdutosEntrega = "SELECT * FROM Produto_Entrega AS proEnt LEFT JOIN Produto AS p ON p.idproduto = proEnt.produto_id WHERE entrega_id = ?";
                PreparedStatement psProEnt = conn.prepareStatement(sqlProdutosEntrega);
                psProEnt.setInt(1, idEntrega);
                ResultSet rsProEnt = psProEnt.executeQuery();

                while(rsProEnt.next()){
                    int idProduto = rsProEnt.getInt("produto_ID");
                    String nomeProduto = rsProEnt.getString("nome");
                    int quantidade = rsProEnt.getInt("quantidade");

                    if (idProduto != 0){
                        ProdutoEntrega proEnt = new ProdutoEntrega();
                        Produto p = new Produto();

                        //Settando o ID Produto e os atributos da classe Produto_Entrega
                        p.setNome(nomeProduto);
                        p.setIdProduto(idProduto);
                        proEnt.setProduto(p);
                        proEnt.setQuantidade(quantidade);

                        //Adicionando Produto na Entrega
                        entregaAtual.getProdutos().add(proEnt);
                    }
                }
            }
        } catch (SQLException e){
            throw new RuntimeException(e);
        }

        System.out.println(entregas);
        return entregas;
    }

    public void atualizar (boolean realizada, int idEntrega) throws ClassNotFoundException{
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