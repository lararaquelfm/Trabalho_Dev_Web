package controle.usuario;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.usuario.Usuario;
import modelo.usuario.UsuarioDAO;

public class MyProfileAdmServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("id"));
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuario = usuarioDAO.obter(id);
        request.setAttribute("usuario", usuario);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/myProfileAdm.jsp");
        requestDispatcher.forward(request, response);
    }

}
