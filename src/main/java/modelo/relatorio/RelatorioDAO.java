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
import utils.Conexao;

public class RelatorioDAO {
    Connection connection = null;
    
    public List<RelCompras> relatorioCompras(LocalDate dataInicio, LocalDate dataFim){
        List<RelCompras> resultado = new ArrayList<RelCompras>();
        try {
            connection = Conexao.getConexao();
            PreparedStatement preparedStatement = connection.prepareStatement(   "SELECT u.id, u.nome, COUNT(u.id) as qnt_compras\n" +
                                                            "From aux_venda_produto AS avp\n" +
                                                            "INNER JOIN venda AS V ON v.id = avp.id_venda \n" +
                                                            "INNER JOIN usuario AS u ON v.id_usuario = u.id\n" +
                                                            "WHERE v.data_hora BETWEEN ? AND ? \n" +
                                                            "GROUP BY u.id");
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
}
