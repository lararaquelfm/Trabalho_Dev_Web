package modelo.produto;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.Conexao;

public class ProdutoDAO {
    
    Connection connection = null;
    
    public List<Produto> obterTodos() {
        List<Produto> resultado = new ArrayList<Produto>();
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT id, descricao, preco, tamanho, quantidade, id_time, id_categoria FROM produto;");
            while (resultSet.next()) {
                Produto produto = new Produto();
                produto.setId(resultSet.getInt("id"));
                produto.setDescricao(resultSet.getString("descricao"));
                produto.setPreco(resultSet.getDouble("preco"));
                produto.setTamanho(resultSet.getString("tamanho"));
                produto.setQuantidade(resultSet.getInt("quantidade"));
                produto.setIdTime(resultSet.getInt("id_time"));
                produto.setIdCategoria(resultSet.getInt("id_categoria"));
                resultado.add(produto);
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
    
    public List<Produto> obterEstoque() {
        List<Produto> resultado = new ArrayList<Produto>();
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT \n" +
                                                        "    MAX(id) AS id,\n" +
                                                        "    descricao, \n" +
                                                        "    id_time, \n" +
                                                        "    id_categoria,\n" +
                                                        "    MIN(preco) AS preco,\n" +
                                                        "    STRING_AGG(DISTINCT tamanho, ', ' ORDER BY tamanho) AS tamanho,\n" +
                                                        "    SUM(quantidade) AS quantidade\n" +
                                                        "FROM produto \n" +
                                                        "WHERE quantidade > 0\n" +
                                                        "GROUP BY descricao, id_time, id_categoria;");
            while (resultSet.next()) {
                Produto produto = new Produto();
                produto.setId(resultSet.getInt("id"));
                produto.setDescricao(resultSet.getString("descricao"));
                produto.setPreco(resultSet.getDouble("preco"));
                produto.setTamanho(resultSet.getString("tamanho"));
                produto.setQuantidade(resultSet.getInt("quantidade"));
                produto.setIdTime(resultSet.getInt("id_time"));
                produto.setIdCategoria(resultSet.getInt("id_categoria"));
                resultado.add(produto);
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
    
    public List<Produto> obterFiltro(String tabela, String atributo) {
        List<Produto> resultado = new ArrayList<Produto>();
        try {
            connection = Conexao.getConexao();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT \n" +
                                                        "    MAX(id) AS id,\n" +
                                                        "    descricao, \n" +
                                                        "    id_time, \n" +
                                                        "    id_categoria,\n" +
                                                        "    MIN(preco) AS preco,\n" +
                                                        "    STRING_AGG(DISTINCT tamanho, ', ' ORDER BY tamanho) AS tamanho,\n" +
                                                        "    SUM(quantidade) AS quantidade\n" +
                                                        "FROM " +  tabela + " \n" +
                                                        "WHERE quantidade > 0\n" +
                                                        "AND " + atributo + " \n" +
                                                        "GROUP BY descricao, id_time, id_categoria;");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Produto produto = new Produto();
                produto.setId(resultSet.getInt("id"));
                produto.setDescricao(resultSet.getString("descricao"));
                produto.setPreco(resultSet.getDouble("preco"));
                produto.setTamanho(resultSet.getString("tamanho"));
                produto.setQuantidade(resultSet.getInt("quantidade"));
                produto.setIdTime(resultSet.getInt("id_time"));
                produto.setIdCategoria(resultSet.getInt("id_categoria"));
                resultado.add(produto);
            }
            resultSet.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
        return resultado;
    }
    
    public List<Produto> obterPorDescricao(String descricao) {
        if (descricao == null || descricao.trim().length() == 0) {
            descricao = "%";
        } else {
            descricao = "%" + descricao + "%";
        }
        List<Produto> resultado = new ArrayList<Produto>();
        try {
            connection = Conexao.getConexao();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT \n" +
                                                        "    MAX(id) AS id,\n" +
                                                        "    descricao, \n" +
                                                        "    id_time, \n" +
                                                        "    id_categoria,\n" +
                                                        "    MIN(preco) AS preco,\n" +
                                                        "    STRING_AGG(DISTINCT tamanho, ', ' ORDER BY tamanho) AS tamanho,\n" +
                                                        "    SUM(quantidade) AS quantidade\n" +
                                                        "FROM produto \n" +
                                                        "WHERE UPPER(descricao) LIKE UPPER(?)\n" +
                                                        "GROUP BY descricao, id_time, id_categoria;");
            preparedStatement.setString(1, descricao);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Produto produto = new Produto();
                produto.setId(resultSet.getInt("id"));
                produto.setDescricao(resultSet.getString("descricao"));
                produto.setPreco(resultSet.getDouble("preco"));
                produto.setTamanho(resultSet.getString("tamanho"));
                produto.setQuantidade(resultSet.getInt("quantidade"));
                produto.setIdTime(resultSet.getInt("id_time"));
                produto.setIdCategoria(resultSet.getInt("id_categoria"));
                resultado.add(produto);
            }
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            return null;
        }
        return resultado;
    }

    public Produto obter(int id) {
        Produto produto = null;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT id, descricao, preco, tamanho, quantidade, id_time, id_categoria FROM produto WHERE id = ?");
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                produto = new Produto();
                produto.setId(resultSet.getInt("id"));
                produto.setDescricao(resultSet.getString("descricao"));
                produto.setPreco(resultSet.getDouble("preco"));
                produto.setTamanho(resultSet.getString("tamanho"));
                produto.setQuantidade(resultSet.getInt("quantidade"));
                produto.setIdTime(resultSet.getInt("id_time"));
                produto.setIdCategoria(resultSet.getInt("id_categoria"));
            }
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
        return produto;
    }

    public boolean inserir(String descricao, double preco, String tamanho, int quantidade, int id_time, int id_categoria) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO produto (descricao, preco, tamanho, quantidade, id_time, id_categoria) VALUES (?, ?, ?, ?, ?, ?)");
            preparedStatement.setString(1, descricao);
            preparedStatement.setDouble(2, preco);
            preparedStatement.setString(3, tamanho);
            preparedStatement.setInt(4, quantidade);
            preparedStatement.setInt(5, id_time);
            preparedStatement.setInt(6, id_categoria);
            sucesso = (preparedStatement.executeUpdate() == 1);
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
        return sucesso;
    }

    public boolean atualizar(String descricao, double preco, String tamanho, int quantidade, int id_time, int id_categoria, int id) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE produto SET descricao = ?, preco = ?, tamanho = ?, quantidade = ?, id_time = ?, id_categoria = ? WHERE id = ?");
            preparedStatement.setString(1, descricao);
            preparedStatement.setDouble(2, preco);
            preparedStatement.setString(3, tamanho);
            preparedStatement.setInt(4, quantidade);
            preparedStatement.setInt(5, id_time);
            preparedStatement.setInt(6, id_categoria);
            preparedStatement.setInt(7, id);
            sucesso = (preparedStatement.executeUpdate() == 1);
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            return false;
        }
        return sucesso;
    }

    public boolean remover(int id) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM produto WHERE id = ?");
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