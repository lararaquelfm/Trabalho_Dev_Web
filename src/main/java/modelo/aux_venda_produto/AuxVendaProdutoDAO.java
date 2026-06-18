package modelo.aux_venda_produto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.Conexao;

public class AuxVendaProdutoDAO {
    
    Connection connection = null;
    
    public List<AuxVendaProduto> obterTodos() {
        List<AuxVendaProduto> resultado = new ArrayList<AuxVendaProduto>();
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT id_venda, id_produto, quantidade, preco FROM aux_venda_produto;");
            while (resultSet.next()) {
                AuxVendaProduto auxCampTime = new AuxVendaProduto();
                auxCampTime.setIdVenda(resultSet.getInt("id_venda"));
                auxCampTime.setIdProduto(resultSet.getInt("id_produto"));
                auxCampTime.setQuantidade(resultSet.getInt("quantidade"));
                auxCampTime.setPreco(resultSet.getDouble("preco"));
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

    public AuxVendaProduto obter(int id_venda, int id_produto) {
        AuxVendaProduto auxVendaProduto = null;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT quantidade, preco FROM aux_venda_produto WHERE id_venda = ? AND id_produto = ?");
            preparedStatement.setInt(1, id_venda);
            preparedStatement.setInt(2, id_produto);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                auxVendaProduto = new AuxVendaProduto();
                auxVendaProduto.setIdVenda(id_venda);
                auxVendaProduto.setIdProduto(id_produto);
                auxVendaProduto.setQuantidade(resultSet.getInt("quantidade"));
                auxVendaProduto.setPreco(resultSet.getDouble("preco"));
            }
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
        return auxVendaProduto;
    }

    public boolean inserir(int id_venda, int id_produto, int quantidade, double preco) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO aux_venda_produto (id_venda, id_produto, quantidade, preco) VALUES (?, ?, ?, ?)");
            preparedStatement.setInt(1, id_venda);
            preparedStatement.setInt(2, id_produto);
            preparedStatement.setInt(3, quantidade);
            preparedStatement.setDouble(4, preco);
            sucesso = (preparedStatement.executeUpdate() == 1);
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
        return sucesso;
    }

    public boolean atualizar(int id_venda, int id_produto, int quantidade, double preco) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE aux_venda_produto SET quantidade = ?, preco = ? WHERE id_venda = ? AND id_produto = ?");
            preparedStatement.setInt(1, quantidade);
            preparedStatement.setDouble(2, preco);
            preparedStatement.setInt(3, id_venda);
            preparedStatement.setInt(4, id_produto);
            sucesso = (preparedStatement.executeUpdate() == 1);
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            return false;
        }
        return sucesso;
    }

    public boolean remover(int id_venda, int id_produto) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM aux_venda_produto WHERE id_venda = ? AND id_produto = ?");
            preparedStatement.setInt(1, id_venda);
            preparedStatement.setInt(2, id_produto);
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
