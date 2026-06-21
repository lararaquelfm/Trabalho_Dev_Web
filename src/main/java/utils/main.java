package utils;

import modelo.usuario.UsuarioDAO;
import static utils.Utils.gerarSHA256;

public class main {
    public static void main(String[] args){
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