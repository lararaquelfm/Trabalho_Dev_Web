package modelo.venda;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDateTime;
import utils.Conexao;

public class VendaDAO {

    Connection connection = null;

    public List<Venda> obterTodos() {
        List<Venda> resultado = new ArrayList<Venda>();
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT id, data_hora, id_usuario FROM venda;");
            while (resultSet.next()) {
                Venda venda = new Venda();
                venda.setId(resultSet.getInt("id"));
                venda.setDataHora(resultSet.getTimestamp("data_hora").toLocalDateTime());
                venda.setIdUsuario(resultSet.getInt("id_usuario"));
                resultado.add(venda);
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

    // Busca somente as vendas de um usuário específico (usado em "Minhas Compras")
    public List<Venda> obterPorUsuario(int idUsuario) {
        List<Venda> resultado = new ArrayList<Venda>();
        try {
            connection = Conexao.getConexao();
            PreparedStatement preparedStatement = connection.prepareStatement(
                "SELECT id, data_hora, id_usuario FROM venda WHERE id_usuario = ? ORDER BY data_hora DESC"
            );
            preparedStatement.setInt(1, idUsuario);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                Venda venda = new Venda();
                venda.setId(resultSet.getInt("id"));
                venda.setDataHora(resultSet.getTimestamp("data_hora").toLocalDateTime());
                venda.setIdUsuario(resultSet.getInt("id_usuario"));
                resultado.add(venda);
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

    public Venda obter(int id) {
        Venda venda = null;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT id, data_hora, id_usuario FROM venda WHERE id = ?");
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                venda = new Venda();
                venda.setId(resultSet.getInt("id"));
                venda.setDataHora(resultSet.getTimestamp("data_hora").toLocalDateTime());
                venda.setIdUsuario(resultSet.getInt("id_usuario"));
            }
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
        return venda;
    }

    public boolean inserir(LocalDateTime data_hora, int id_usuario) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO venda (data_hora, id_usuario) VALUES (?, ?)");
            Timestamp temp = Timestamp.valueOf(data_hora);
            preparedStatement.setTimestamp(1, temp);
            preparedStatement.setInt(2, id_usuario);
            sucesso = (preparedStatement.executeUpdate() == 1);
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
        return sucesso;
    }

    // Igual ao inserir() acima, mas devolve o ID gerado pela venda.
    // Precisamos desse ID na hora de finalizar a compra, pra usar como
    // id_venda em cada linha de aux_venda_produto.
    public int inserirRetornandoId(LocalDateTime data_hora, int id_usuario) {
        int idGerado = -1;
        try {
            connection = Conexao.getConexao();
            PreparedStatement preparedStatement = connection.prepareStatement(
                "INSERT INTO venda (data_hora, id_usuario) VALUES (?, ?) RETURNING id"
            );
            Timestamp temp = Timestamp.valueOf(data_hora);
            preparedStatement.setTimestamp(1, temp);
            preparedStatement.setInt(2, id_usuario);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                idGerado = resultSet.getInt("id");
            }
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return -1;
        }
        return idGerado;
    }

    public boolean atualizar(LocalDateTime data_hora, int id_usuario, int id) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE venda SET data_hora = ?, id_usuario = ? WHERE id = ?");
            Timestamp temp = Timestamp.valueOf(data_hora);
            preparedStatement.setTimestamp(1, temp);
            preparedStatement.setInt(2, id_usuario);
            preparedStatement.setInt(3, id);
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
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM venda WHERE id = ?");
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