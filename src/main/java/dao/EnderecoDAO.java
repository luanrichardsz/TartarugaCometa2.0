package dao;

import bd.ConnectionFactory;
import model.Endereco;

import java.sql.*;
import java.util.ArrayList;

public class EnderecoDAO {

    private ConnectionFactory connection;

    public EnderecoDAO() {
        this.connection = new ConnectionFactory();
    }

    public void cadastrar(Endereco endereco){
        String sql = "INSERT INTO endereco (cep, rua, numero, bairro, cidade, estado, complemento) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = connection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            ps.setString(1, endereco.getCep());
            ps.setString(2, endereco.getRua());
            ps.setString(3, endereco.getNumero());
            ps.setString(4, endereco.getBairro());
            ps.setString(5, endereco.getCidade());
            ps.setString(6, endereco.getEstado());
            ps.setString(7, endereco.getComplemento());

            System.out.println("Endereco Cadastrado");

            ps.executeUpdate(); //retorna um INTEIRO com as linhas modificadas

            //Buscar o ID gerado
            try(ResultSet rs = ps.getGeneratedKeys()){
                if(rs.next()){ //tentando mover o cursos para a proxima linha
                    int idGerado  = rs.getInt(1); // pegando a primeira coluna (ID)
                    endereco.setIdEndereco(idGerado); //salvando o id no objeto
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ArrayList<Endereco> listar(){
        String sql = "SELECT idEndereco, cep, rua, numero, bairro, cidade, estado, complemento FROM endereco ORDER BY idendereco ASC";

        ArrayList<Endereco> enderecos = new ArrayList<>();

        try(Connection conn = connection.getConnection()){
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()){
            	int idEndereco = rs.getInt("idEndereco");
            	String cep = rs.getString("cep");
                String rua = rs.getString("rua");
                String numero = rs.getString("numero");
                String bairro = rs.getString("bairro");
                String cidade = rs.getString("cidade");
                String estado = rs.getString("estado");
                String complemento = rs.getString("complemento");

                enderecos.add(new Endereco(idEndereco ,cep, rua ,numero, bairro, cidade, estado, complemento));
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

//        System.out.println(enderecos);
        return enderecos;
    }

    public void atualizar(String cep, String rua, String numero, String bairro, String cidade, String estado, String complemento, int idEndereco){
        String sql = "UPDATE Endereco SET cep = ?, rua = ?, numero = ?, bairro = ?, cidade = ?, estado = ?, complemento = ? WHERE idEndereco = ?";

        try (Connection cnn = connection.getConnection()){
            PreparedStatement ps = cnn.prepareStatement(sql);

            ps.setString(1, cep);
            ps.setString(2, rua);
            ps.setString(3, numero);
            ps.setString(4, bairro);
            ps.setString(5, cidade);
            ps.setString(6, estado);
            ps.setString(7, complemento);

            ps.setInt(8, idEndereco);

            ps.execute();

            System.out.println("Endereco com o ID: " + idEndereco + " atualizado");

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void apagar(int idEndereco){
        String sqlDeleteEndereco = "DELETE FROM Endereco WHERE idEndereco = ?";

        //Deletando Endereço
        try (Connection cnn = connection.getConnection()){
            PreparedStatement ps = cnn.prepareStatement(sqlDeleteEndereco);

            ps.setInt(1, idEndereco);
            ps.execute();

            System.out.println("Endereco apagado");

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Endereco buscarPorId(int idEndereco){
        String sql = "SELECT * FROM Endereco WHERE idendereco = ?";

        try (Connection conn = connection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, idEndereco);

            ResultSet rs = ps.executeQuery();

            idEndereco = 0;

            while (rs.next()){
            	Endereco endereco = new Endereco();
            	
                endereco.setIdEndereco(rs.getInt("idendereco"));
                endereco.setCep(rs.getString("cep"));
                endereco.setRua(rs.getString("rua"));
                endereco.setNumero(rs.getString("numero"));
                endereco.setBairro(rs.getString("bairro"));
                endereco.setCidade(rs.getString("cidade"));
                endereco.setEstado(rs.getString("estado"));
                endereco.setComplemento(rs.getString("complemento"));
                
                return endereco;
            } 
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return null;
    }
}