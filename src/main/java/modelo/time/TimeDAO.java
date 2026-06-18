package modelo.time;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import modelo.usuario.Usuario;
import utils.Conexao;

public class TimeDAO {
    Connection connection = null;
    
    public List<Time> obterTodos() {
        List<Time> resultado = new ArrayList<Time>();
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT id, nacionalidade, nome FROM \"time\";");
            while (resultSet.next()) {
                Time time = new Time();
                time.setId(resultSet.getInt("id"));
                time.setNacionalidade(resultSet.getString("nacionalidade"));
                time.setNome(resultSet.getString("nome"));
                resultado.add(time);
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
    
    public Time obter(int id) {
        Time time = null;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT id, nacionalidade, nome FROM \"time\" WHERE id = ?;");
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                time = new Time();
                time.setId(resultSet.getInt("id"));
                time.setNacionalidade(resultSet.getString("nacionalidade"));
                time.setNome(resultSet.getString("nome"));
            }
            resultSet.close();
            preparedStatement.close();
            statement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
        return time;
    }
    
    public boolean inserir(String nome, String nacionalidade) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO time (nome, nacionalidade) VALUES (?, ?)");
            preparedStatement.setString(1, nome);
            preparedStatement.setString(2, nacionalidade);
            sucesso = (preparedStatement.executeUpdate() == 1);
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
        return sucesso;
    }
    
    public boolean atualizar(int id, String nome, String nacionalidade){
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE time SET nome = ?, nacionalidade = ? WHERE id = ?");
            preparedStatement.setString(1, nome);
            preparedStatement.setString(2, nacionalidade);
            preparedStatement.setInt(3, id);
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
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM time WHERE id = ?");
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