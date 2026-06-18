package modelo.campeonato;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.Conexao;

public class CampeonatoDAO {
    
    Connection connection = null;
    
    public List<Campeonato> obterTodos() {
        List<Campeonato> resultado = new ArrayList<Campeonato>();
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT id, nome FROM campeonato;");
            while (resultSet.next()) {
                Campeonato campeonato = new Campeonato();
                campeonato.setId(resultSet.getInt("id"));
                campeonato.setNome(resultSet.getString("foto"));
                resultado.add(campeonato);
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
    
    public Campeonato obter(int id) {
        Campeonato campeonato = null;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT id, nome FROM campeonato WHERE id = ?;");
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                campeonato = new Campeonato();
                campeonato.setId(resultSet.getInt("id"));
                campeonato.setNome(resultSet.getString("nome"));
            }
            resultSet.close();
            preparedStatement.close();
            statement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
        return campeonato;
    }
    
    public boolean inserir(String nome) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO campeonato (nome) VALUES (?)");
            preparedStatement.setString(1, nome);
            sucesso = (preparedStatement.executeUpdate() == 1);
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
        return sucesso;
    }
    
    public boolean atualizar(int id, String nome){
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE campeonato SET nome = ? WHERE id = ?");
            preparedStatement.setString(1, nome);
            preparedStatement.setInt(2, id);
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
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM campeonato WHERE id = ?");
            preparedStatement.setInt(1, id);
            sucesso = (preparedStatement.executeUpdate() == 1);
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            return false;
        }
        return sucesso;
    }
}
