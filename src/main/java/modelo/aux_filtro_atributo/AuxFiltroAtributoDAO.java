package modelo.aux_filtro_atributo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.Conexao;

public class AuxFiltroAtributoDAO {
    
    Connection connection = null;

    public List<AuxFiltroAtributo> obterTodos() {
        List<AuxFiltroAtributo> resultado = new ArrayList<AuxFiltroAtributo>();
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT id_filtro, id_atributo FROM aux_filtro_atributo;");
            while (resultSet.next()) {
                AuxFiltroAtributo auxFiltroAtributo = new AuxFiltroAtributo();
                auxFiltroAtributo.setIdFiltro(resultSet.getInt("id_filtro"));
                auxFiltroAtributo.setIdAtributo(resultSet.getInt("id_atributo"));
                resultado.add(auxFiltroAtributo);
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

    public AuxFiltroAtributo obterFiltro(int id_filtro) {
        AuxFiltroAtributo auxFiltroAtributo = null;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT id_filtro, id_atributo FROM aux_filtro_atributo WHERE id_filtro = ?");
            preparedStatement.setInt(1, id_filtro);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                auxFiltroAtributo = new AuxFiltroAtributo();
                auxFiltroAtributo.setIdFiltro(resultSet.getInt("id_filtro"));
                auxFiltroAtributo.setIdAtributo(resultSet.getInt("id_atributo"));
            }
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
        return auxFiltroAtributo;
    }

    public boolean inserir(int id_filtro, int id_atributo) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO aux_filtro_atributo (id_filtro, id_atributo) VALUES (?, ?)");
            preparedStatement.setInt(1, id_filtro);
            preparedStatement.setInt(2, id_atributo);
            sucesso = (preparedStatement.executeUpdate() == 1);
            preparedStatement.close();
            connection.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
        return sucesso;
    }
    
    public boolean remover(int id_filtro, int id_atributo) {
        boolean sucesso = false;
        try {
            connection = Conexao.getConexao();
            Statement statement = connection.createStatement();
            PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM aux_filtro_atributo WHERE id_filtro = ? AND id_atributo = ?");
            preparedStatement.setInt(1, id_filtro);
            preparedStatement.setInt(2, id_atributo);
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