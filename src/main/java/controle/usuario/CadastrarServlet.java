package controle.usuario;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.usuario.UsuarioDAO;
import utils.Utils;

public class CadastrarServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nome = request.getParameter("nome");
        String endereco = request.getParameter("endereco");
        String email = request.getParameter("email");
        String login = request.getParameter("login");
        String senha = request.getParameter("senha");
        senha =  Utils.gerarSHA256(senha);
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        boolean sucesso = usuarioDAO.inserir(nome, endereco, email, login, senha);
        if (sucesso) {
            request.setAttribute("mensagem", "Usuário cadastrado com sucesso!");
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/index.jsp");
            requestDispatcher.forward(request, response);
        } else {
            request.setAttribute("mensagem", "Não foi possível realizar seu cadastro");
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/cadastrar.jsp");
            requestDispatcher.forward(request, response);
        }
    }

}
