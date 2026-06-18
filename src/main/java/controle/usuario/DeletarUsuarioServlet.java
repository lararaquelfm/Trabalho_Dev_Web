package controle.usuario;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.usuario.UsuarioDAO;

public class DeletarUsuarioServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("id"));
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        boolean sucesso = usuarioDAO.remover(id);
        if (sucesso) {
            request.setAttribute("mensagem", "Sua conta foi deletada com sucesso");
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
            requestDispatcher.forward(request, response);
        } else {
            request.setAttribute("mensagem", "Não foi possível deletar sua conta");
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/homepage.jsp");
            requestDispatcher.forward(request, response);
        }
    }
    
}
