package controle.usuario;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import modelo.produto.Produto;
import modelo.produto.ProdutoDAO;
import modelo.usuario.Usuario;
import modelo.usuario.UsuarioDAO;
import utils.Utils;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String login = request.getParameter("login");
        String senha = request.getParameter("senha");
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuario = usuarioDAO.obterLogin(login);
        boolean sucesso = (usuario != null && usuario.getSenha().equals(Utils.gerarSHA256(senha)));
        if (sucesso) {
            HttpSession session = request.getSession(true);
            session.setAttribute("usuario", usuario);
            RequestDispatcher requestDispatcher;
            if(usuario.isAdministrador()){
                requestDispatcher = request.getRequestDispatcher("/admin/HomepageAdm");
            }else{
                List<Produto> produtos = new ProdutoDAO().obterEstoque();
                request.setAttribute("produtos", produtos);
                requestDispatcher = request.getRequestDispatcher("/secure/Homepage");
            }
            requestDispatcher.forward(request, response);
        } else {
            request.setAttribute("mensagem", "Login ou senha incorreta");
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("login.jsp");
            requestDispatcher.forward(request, response);
        }
    }

}
