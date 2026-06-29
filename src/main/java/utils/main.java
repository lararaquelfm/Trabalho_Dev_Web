package utils;

import java.time.LocalDateTime;
import modelo.aux_venda_produto.AuxVendaProduto;
import modelo.aux_venda_produto.AuxVendaProdutoDAO;
import modelo.categoria.Categoria;
import modelo.categoria.CategoriaDAO;
import modelo.produto.Produto;
import modelo.produto.ProdutoDAO;
import modelo.time.Time;
import modelo.usuario.UsuarioDAO;
import modelo.venda.Venda;
import modelo.venda.VendaDAO;
import static utils.Utils.gerarSHA256;

public class main {
    public static void main(String[] args){
      
        /*pdao.inserir("Camisa do fortaleza", 40, "M", 4, 1, 1);
        */
      /*VendaDAO vdao= new VendaDAO();
      vdao.inserir(LocalDateTime.now().minusMonths(1), 6);*/
      
      AuxVendaProdutoDAO dao = new AuxVendaProdutoDAO();
        dao.inserir(3, 1, 4, 300);
        dao.inserir(4, 1, 4, 300);
        dao.inserir(7, 1, 4, 300);
        
        String nome = "Thayna";
        String endereco = "rua do admt";
        String email = "admt@gmail.com";
        String login = "admt";
        String senha =  gerarSHA256("admt");
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        System.out.println("");
        usuarioDAO.inserirAdm(nome, endereco, email, login, senha);
      
    }
}