package modelo.relatorio;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import modelo.produto.Produto;
import utils.Conexao;

public class RelatorioDAO {
    Connection connection = null;
    
    public List<RelCompras> relatorioCompras(LocalDate dataInicio, LocalDate dataFim){
        List<RelCompras> resultado = new ArrayList<RelCompras>();
        try {
            connection = Conexao.getConexao();
            PreparedStatement preparedStatement = connection.prepareStatement(  "SELECT u.id, u.nome, COUNT(u.id) as qnt_compras\n" +
                                                                                "From aux_venda_produto AS avp\n" +
                                                                                "INNER JOIN venda AS V ON v.id = avp.id_venda \n" +
                                                                                "INNER JOIN usuario AS u ON v.id_usuario = u.id\n" +
                                                                                "WHERE v.data_hora BETWEEN ? AND ? \n" +
                                                                                "GROUP BY u.id, u.nome \n" +
                                                                                "ORDER BY qnt_compras");
            preparedStatement.setDate(1, Date.valueOf(dataInicio));
            preparedStatement.setDate(2, Date.valueOf(dataFim));
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                RelCompras relCompras = new RelCompras();
                relCompras.setId(resultSet.getInt("id"));
                relCompras.setNome(resultSet.getString("nome"));
                relCompras.setQntCompras(resultSet.getInt("qnt_compras"));
                
                resultado.add(relCompras);
            }
            resultSet.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
        return resultado;
        
    }
    
    public List<Produto> relatorioFaltaEstoque() {
        List<Produto> resultado = new ArrayList<Produto>();
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT \n" +
                                                        "id,\n" +
                                                        "descricao, \n" +
                                                        "id_time, \n" +
                                                        "id_categoria,\n" +
                                                        "preco,\n" +
                                                        "tamanho,\n" +
                                                        "quantidade\n" +
                                                        "FROM produto \n" +
                                                        "WHERE quantidade <= 0\n" +
                                                        "ORDER BY descricao;");
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
    
    public List<RelFaturamento> relatorioFaturamento(LocalDate dataInicio, LocalDate dataFim){
        List<RelFaturamento> resultado = new ArrayList<RelFaturamento>();
        try {
            connection = Conexao.getConexao();
            PreparedStatement preparedStatement = connection.prepareStatement(  "SELECT data_hora::DATE as data, SUM(quantidade * preco) as valor_total\n" +
                                                                                "FROM aux_venda_produto as avp\n" +
                                                                                "INNER JOIN venda as v ON avp.id_venda = v.id\n" +
                                                                                "WHERE v.data_hora BETWEEN ? AND ?\n" +
                                                                                "GROUP BY data_hora::DATE\n" +
                                                                                "ORDER BY data;");
            preparedStatement.setDate(1, Date.valueOf(dataInicio));
            preparedStatement.setDate(2, Date.valueOf(dataFim));
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                RelFaturamento relFaturamento = new RelFaturamento();
                relFaturamento.setData(LocalDate.parse(resultSet.getString("data")));
                relFaturamento.setValorTotal(resultSet.getDouble("valor_total"));
                resultado.add(relFaturamento);
            }
            resultSet.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
        return resultado;
        
    }
}
