package bd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.management.RuntimeErrorException;

public class ConnectionFactory {
    String URL = "jdbc:postgresql://localhost:5432/tartaruga_cometa";
    String USERNAME = "postgres";
    String PASSWORD = "1234";

    public Connection getConnection() {
        try {
        	Class.forName("org.postgresql.Driver");
            return DriverManager.getConnection(URL, USERNAME, PASSWORD);
          
        }
        catch (ClassNotFoundException e){
        	throw new RuntimeException("Driver não encontrado", e);
        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
