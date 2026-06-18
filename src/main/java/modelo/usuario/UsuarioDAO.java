package modelo.usuario;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.Conexao;

public class UsuarioDAO {
    
    Connection connection = null;
    
    public List<Usuario> obterTodos() {
        List<Usuario> resultado = new ArrayList<Usuario>();
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT id, login, nome, senha, email, endereco, admin FROM usuario;");
            while (resultSet.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(resultSet.getInt("id"));
                usuario.setLogin(resultSet.getString("login"));
                usuario.setNome(resultSet.getString("nome"));
                usuario.setSenha(resultSet.getString("senha"));
                usuario.setEmail(resultSet.getString("email"));
                usuario.setEndereco(resultSet.getString("endereco"));
                usuario.setAdministrador(resultSet.getBoolean("admin"));
                resultado.add(usuario);
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
    
    public Usuario obter(int id) {
        Usuario usuario = null;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT id, login, nome, senha, email, endereco, admin FROM usuario WHERE id = ?;");
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                usuario = new Usuario();
                usuario.setId(resultSet.getInt("id"));
                usuario.setLogin(resultSet.getString("login"));
                usuario.setNome(resultSet.getString("nome"));
                usuario.setSenha(resultSet.getString("senha"));
                usuario.setEmail(resultSet.getString("email"));
                usuario.setEndereco(resultSet.getString("endereco"));
                usuario.setAdministrador(resultSet.getBoolean("admin"));
            }
            resultSet.close();
            preparedStatement.close();
            statement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
        return usuario;
    }
    
    public Usuario obterEmail(String email) {
        Usuario usuario = null;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT id, login, nome, senha, email, endereco, admin FROM usuario WHERE email = ?;");
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                usuario = new Usuario();
                usuario.setId(resultSet.getInt("id"));
                usuario.setLogin(resultSet.getString("login"));
                usuario.setNome(resultSet.getString("nome"));
                usuario.setSenha(resultSet.getString("senha"));
                usuario.setEmail(resultSet.getString("email"));
                usuario.setEndereco(resultSet.getString("endereco"));
                usuario.setAdministrador(resultSet.getBoolean("admin"));
            }
            resultSet.close();
            preparedStatement.close();
            statement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
        return usuario;
    }
    
    public Usuario obterLogin(String login) {
        Usuario usuario = null;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT id, login, nome, senha, email, endereco, admin FROM usuario WHERE login = ?;");
            preparedStatement.setString(1, login);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                usuario = new Usuario();
                usuario.setId(resultSet.getInt("id"));
                usuario.setLogin(resultSet.getString("login"));
                usuario.setNome(resultSet.getString("nome"));
                usuario.setSenha(resultSet.getString("senha"));
                usuario.setEmail(resultSet.getString("email"));
                usuario.setEndereco(resultSet.getString("endereco"));
                usuario.setAdministrador(resultSet.getBoolean("admin"));
            }
            resultSet.close();
            preparedStatement.close();
            statement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
        return usuario;
    }
    
    public boolean inserir(String nome, String endereco, String email, String login, String senha) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO usuario (nome, endereco, email, login, senha, admin) VALUES (?, ?, ?, ?, ?, false)");
            preparedStatement.setString(1, nome);
            preparedStatement.setString(2, endereco);
            preparedStatement.setString(3, email);
            preparedStatement.setString(4, login);
            preparedStatement.setString(5, senha);
            sucesso = (preparedStatement.executeUpdate() == 1);
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
        return sucesso;
    }
    
    public boolean inserirAdm(String nome, String endereco, String email, String login, String senha) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO usuario (nome, endereco, email, login, senha, admin) VALUES (?, ?, ?, ?, ?, true)");
            preparedStatement.setString(1, nome);
            preparedStatement.setString(2, endereco);
            preparedStatement.setString(3, email);
            preparedStatement.setString(4, login);
            preparedStatement.setString(5, senha);
            sucesso = (preparedStatement.executeUpdate() == 1);
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
        return sucesso;
    }
    
    public boolean atualizar(int id, String nome, String endereco, String email, String login){
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE usuario SET nome = ?, endereco = ?, email = ?, login = ? WHERE id = ?");
            preparedStatement.setString(1, nome);
            preparedStatement.setString(2, endereco);
            preparedStatement.setString(3, email);
            preparedStatement.setString(4, login);
            preparedStatement.setInt(5, id);
            sucesso = (preparedStatement.executeUpdate() == 1);
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
        return sucesso;
    }
    
    public boolean atualizarTudo(int id, String nome, String endereco, String email, String login, String senha){
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE usuario SET nome = ?, endereco = ?, email = ?, login = ?, senha = ? WHERE id = ?");
            preparedStatement.setString(1, nome);
            preparedStatement.setString(2, endereco);
            preparedStatement.setString(3, email);
            preparedStatement.setString(4, login);
            preparedStatement.setString(5, senha);
            preparedStatement.setInt(6, id);
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
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM usuario WHERE id = ?");
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