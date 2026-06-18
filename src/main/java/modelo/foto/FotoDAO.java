package modelo.foto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.Conexao;

public class FotoDAO {
    
    Connection connection = null;
    
    public List<Foto> obterTodos() {
        List<Foto> resultado = new ArrayList<Foto>();
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT id, foto, id_produto FROM fotos;");
            while (resultSet.next()) {
                Foto foto = new Foto();
                foto.setId(resultSet.getInt("id"));
                foto.setFoto(resultSet.getString("foto"));
                foto.setIdProduto(resultSet.getInt("id_produto"));
                resultado.add(foto);
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
    
    public List<Foto> obterPeloProduto(int id_produto) {
        List<Foto> resultado = new ArrayList<Foto>();
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT id, foto, id_produto FROM fotos WHERE id_produto = ?;");
            preparedStatement.setInt(1, id_produto);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Foto foto = new Foto();
                foto.setId(resultSet.getInt("id"));
                foto.setFoto(resultSet.getString("foto"));
                foto.setIdProduto(resultSet.getInt("id_produto"));
                resultado.add(foto);
            }
            resultSet.close();
            preparedStatement.close();
            statement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
        return resultado;
    }
    
    public Foto obterPeloId(int id) {
        Foto foto = null;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT id, foto, id_produto FROM fotos WHERE id = ?;");
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                foto = new Foto();
                foto.setId(resultSet.getInt("id"));
                foto.setFoto(resultSet.getString("foto"));
                foto.setIdProduto(resultSet.getInt("id_produto"));
            }
            resultSet.close();
            preparedStatement.close();
            statement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
        return foto;
    }
    
    public boolean inserir(String foto, int idProduto) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO fotos (foto, id_produto) VALUES (?, ?)");
            preparedStatement.setString(1, foto);
            preparedStatement.setInt(2, idProduto);
            sucesso = (preparedStatement.executeUpdate() == 1);
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
        return sucesso;
    }
    
    public boolean atualizar(int id, String foto, int idProduto){
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE fotos SET foto = ?, id_produto = ?  WHERE id = ?");
            preparedStatement.setString(1, foto);
            preparedStatement.setInt(2, idProduto);
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
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM fotos WHERE id = ?");
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