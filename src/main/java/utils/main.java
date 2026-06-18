package utils;

import modelo.usuario.UsuarioDAO;
import static utils.Utils.gerarSHA256;

public class main {
    public static void main(String[] args){
        String nome = "Gabriel";
        String endereco = "rua do adm";
        String email = "adm@gmail.com";
        String login = "adm";
        String senha =  gerarSHA256("adm");
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        System.out.println("");
        usuarioDAO.inserirAdm(nome, endereco, email, login, senha);
       
    }
}