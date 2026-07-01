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
    
    public List<AuxVendaProduto> obterPorVenda(int id_venda) {
        List<AuxVendaProduto> resultado = new ArrayList<>();

        try {
            connection = Conexao.getConexao();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM aux_venda_produto WHERE id_venda = ?");
            preparedStatement.setInt(1, id_venda);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                AuxVendaProduto aux = new AuxVendaProduto();
                aux.setIdVenda(resultSet.getInt("id_venda"));
                aux.setIdProduto(resultSet.getInt("id_produto"));
                aux.setQuantidade(resultSet.getInt("quantidade"));
                aux.setPreco(resultSet.getDouble("preco"));
                resultado.add(aux);
            }

            resultSet.close();
            preparedStatement.close();
            connection.close();

        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }

        return resultado;
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
    
    public double faturamentoMes() {
        double total = 0;
        try {
            connection = Conexao.getConexao();
            PreparedStatement preparedStatement = connection.prepareStatement(
                    "SELECT COALESCE(SUM(a.preco * a.quantidade), 0) AS total \n" +
                    "FROM aux_venda_produto a \n" +
                    "JOIN venda v ON v.id = a.id_venda \n" +
                    "WHERE EXTRACT(MONTH FROM v.data_hora) = EXTRACT(MONTH FROM CURRENT_DATE) \n" +
                    "AND EXTRACT(YEAR FROM v.data_hora) = EXTRACT(YEAR FROM CURRENT_DATE)");
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                total = resultSet.getDouble("total");
            }
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return 0;
        }
        return total;
    }

    public int[] vendasPorMes() {
        int[] meses = new int[13];
        try {
            connection = Conexao.getConexao();
            PreparedStatement preparedStatement = connection.prepareStatement(
                    "SELECT EXTRACT(MONTH FROM v.data_hora) AS mes, SUM(a.quantidade) AS total \n" +
                    "FROM aux_venda_produto a \n" +
                    "JOIN venda v ON v.id = a.id_venda \n" +
                    "WHERE EXTRACT(YEAR FROM v.data_hora) = EXTRACT(YEAR FROM CURRENT_DATE) \n" +
                    "GROUP BY EXTRACT(MONTH FROM v.data_hora)");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                meses[resultSet.getInt("mes")] = resultSet.getInt("total");
            }
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return meses;
        }
        return meses;
    }
    
    public boolean removerPorVenda(int id_venda) {
        try {
            connection = Conexao.getConexao();

            PreparedStatement ps = connection.prepareStatement(
                "DELETE FROM aux_venda_produto WHERE id_venda = ?"
            );

            ps.setInt(1, id_venda);

            ps.executeUpdate();

            ps.close();
            connection.close();

            return true;

        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }
}
