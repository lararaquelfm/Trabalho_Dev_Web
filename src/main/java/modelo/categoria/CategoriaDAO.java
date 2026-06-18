package modelo.categoria;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.Conexao;

public class CategoriaDAO {
    
    Connection connection = null;
    
    public List<Categoria> obterTodos() {
        List<Categoria> resultado = new ArrayList<Categoria>();
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT id, temporada, nome, estilo FROM categoria;");
            while (resultSet.next()) {
                Categoria categoria = new Categoria();
                categoria.setId(resultSet.getInt("id"));
                categoria.setTemporada(resultSet.getString("temporada"));
                categoria.setNome(resultSet.getString("nome"));
                categoria.setEstilo(resultSet.getString("estilo"));
                resultado.add(categoria);
            }
            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
        return resultado;
    }
    
    public Categoria obter(int id) {
        Categoria categoria = null;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT id, temporada, nome, estilo FROM categoria WHERE id = ?;");
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                categoria = new Categoria();
                categoria.setId(resultSet.getInt("id"));
                categoria.setTemporada(resultSet.getString("temporada"));
                categoria.setNome(resultSet.getString("nome"));
                categoria.setEstilo(resultSet.getString("estilo"));
            }
            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
        return categoria;
    }
    
    public boolean inserir(String nome, String temporada, String estilo) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO categoria (temporada, nome, estilo) VALUES (?, ?, ?)");
            preparedStatement.setString(1, temporada);
            preparedStatement.setString(2, nome);
            preparedStatement.setString(3, estilo);
            sucesso = (preparedStatement.executeUpdate() == 1);
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
        return sucesso;
    }
    
    public boolean atualizar(int id, String nome, String estilo, String temporada){
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE categoria SET temporada = ?, nome = ?, estilo = ? WHERE id = ?");
            preparedStatement.setString(1, temporada);
            preparedStatement.setString(2, nome);
            preparedStatement.setString(3, estilo);
            preparedStatement.setInt(4, id);
            sucesso = (preparedStatement.executeUpdate() == 1);
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
        return sucesso;
    }
    
    public boolean remover(int id) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM categoria WHERE id = ?");
            preparedStatement.setInt(1, id);
            sucesso = (preparedStatement.executeUpdate() == 1);
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
        return sucesso;
    }
}