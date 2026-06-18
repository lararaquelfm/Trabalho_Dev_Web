package controle.usuario;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.usuario.UsuarioDAO;
import utils.Utils;

public class AtualizarUsuarioServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String nome = request.getParameter("nome");
        String endereco = request.getParameter("endereco");
        String email = request.getParameter("email");
        String login = request.getParameter("login");
        String senha = request.getParameter("senha");
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        boolean sucesso = false;
        if (senha.equals("")){
            sucesso = usuarioDAO.atualizar(id, nome, endereco, email, login);
        }else{
            senha =  Utils.gerarSHA256(senha);
            sucesso = usuarioDAO.atualizarTudo(id, nome, endereco, email, login, senha);
        }   
        if (sucesso) {
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuarioDAO.obter(id));
            request.setAttribute("mensagem", "Seu dados foram atualizados com sucesso");
        } else {
            request.setAttribute("mensagem", "Não foi possível atualizar seus dados");
        }
        if (usuarioDAO.obter(id).isAdministrador()){
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/HomepageAdm");
            requestDispatcher.forward(request, response);
        } else {
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/Homepage");
            requestDispatcher.forward(request, response);
        }
    }

}
