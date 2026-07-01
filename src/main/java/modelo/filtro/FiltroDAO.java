/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo.filtro;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.Conexao;

/**
 *
 * @author tktgu
 */
public class FiltroDAO {
    Connection connection = null;
    
    public List<Filtro> obterTodos() {
        List<Filtro> resultado = new ArrayList<Filtro>();
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT id, nome, checked FROM filtro;");
            while (resultSet.next()) {
                Filtro filtro = new Filtro();
                filtro.setId(resultSet.getInt("id"));
                filtro.setNome(resultSet.getString("nome"));
                filtro.setChecked(resultSet.getBoolean("checked"));
                resultado.add(filtro);
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
    
    public List<Filtro> obterTodosAtivos() {
        List<Filtro> resultado = new ArrayList<Filtro>();
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT id, nome, checked FROM filtro WHERE checked = true;");
            while (resultSet.next()) {
                Filtro filtro = new Filtro();
                filtro.setId(resultSet.getInt("id"));
                filtro.setNome(resultSet.getString("nome"));
                filtro.setChecked(resultSet.getBoolean("checked"));
                resultado.add(filtro);
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
    
    public Filtro obter(int id) {
        Filtro filtro = null;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT id, nome, checked FROM filtro WHERE id = ?;");
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                filtro = new Filtro();
                filtro.setId(resultSet.getInt("id"));
                filtro.setNome(resultSet.getString("nome"));
                filtro.setChecked(resultSet.getBoolean("checked"));
            }
            resultSet.close();
            preparedStatement.close();
            statement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
        return filtro;
    }
    
    public boolean inserir(String nome, boolean checked) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO filtro (nome, checked) VALUES (?, ?)");
            preparedStatement.setString(1, nome);
            preparedStatement.setBoolean(2, checked);
            sucesso = (preparedStatement.executeUpdate() == 1);
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
        return sucesso;
    }
    
    public boolean atualizar(int id, String nome, boolean checked){
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE filtro SET nome = ?, checked = ? WHERE id = ?");
            preparedStatement.setString(1, nome);
            preparedStatement.setBoolean(2, checked);
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
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM filtro WHERE id = ?");
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
