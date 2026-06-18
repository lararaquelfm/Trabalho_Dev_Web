package modelo.aux_camp_time;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.Conexao;

public class AuxCampTimeDAO {
    
    Connection connection = null;

    public List<AuxCampTime> obterTodos() {
        List<AuxCampTime> resultado = new ArrayList<AuxCampTime>();
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT id_campeonato, id_time, ano FROM aux_campeonato_time;");
            while (resultSet.next()) {
                AuxCampTime auxCampTime = new AuxCampTime();
                auxCampTime.setIdCampeonato(resultSet.getInt("id_campeonato"));
                auxCampTime.setIdTime(resultSet.getInt("id_time"));
                auxCampTime.setAno(resultSet.getInt("ano"));
                resultado.add(auxCampTime);
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

    public AuxCampTime obter(int id_campeonato, int id_time) {
        AuxCampTime auxCampTime = null;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT id_campeonato, id_time, ano FROM aux_campeonato_time WHERE id_campeonato = ? AND id_time = ?");
            preparedStatement.setInt(1, id_campeonato);
            preparedStatement.setInt(2, id_time);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                auxCampTime = new AuxCampTime();
                auxCampTime.setIdCampeonato(resultSet.getInt("id_campeonato"));
                auxCampTime.setIdTime(resultSet.getInt("id_time"));
                auxCampTime.setAno(resultSet.getInt("ano"));
            }
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
        return auxCampTime;
    }

    public boolean inserir(int id_campeonato, int id_time, int ano) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO aux_campeonato_time (id_campeonato, id_time, ano) VALUES (?, ?, ?)");
            preparedStatement.setInt(1, id_campeonato);
            preparedStatement.setInt(2, id_time);
            preparedStatement.setInt(3, ano);
            sucesso = (preparedStatement.executeUpdate() == 1);
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
        return sucesso;
    }

    public boolean atualizar(int id_campeonato, int id_time, int ano) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE aux_campeonato_time SET ano = ? WHERE id_campeonato = ? AND id_time = ?");
            preparedStatement.setInt(1, ano);
            preparedStatement.setInt(2, id_campeonato);
            preparedStatement.setInt(3, id_time);
            sucesso = (preparedStatement.executeUpdate() == 1);
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            return false;
        }
        return sucesso;
    }

    public boolean remover(int id_campeonato, int id_time) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM aux_campeonato_time WHERE id_campeonato = ? AND id_time = ?");
            preparedStatement.setInt(1, id_campeonato);
            preparedStatement.setInt(2, id_time);
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