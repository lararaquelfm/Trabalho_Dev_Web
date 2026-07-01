package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexao {
    public static Connection getConexao() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException ex) {
            System.out.println("Erro ao carregar Driver");
            throw new SQLException(ex);
        }
        String JDBC_URL = "jdbc:postgresql://localhost:5432/ecommerce";
        String JDBC_USUARIO = "postgres";
        String JDBC_SENHA = "SENHA";
        return DriverManager.getConnection(JDBC_URL, JDBC_USUARIO, JDBC_SENHA);
    }
}
