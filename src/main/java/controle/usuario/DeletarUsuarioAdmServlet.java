
package controle.usuario;

import java.util.List;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.usuario.UsuarioDAO;
import modelo.usuario.Usuario;

@WebServlet(name = "DeletarUsuarioAdmServlet", urlPatterns = {"/DeletarUsuarioAdm"})
public class DeletarUsuarioAdmServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    
        Integer id = Integer.parseInt(request.getParameter("id"));
        UsuarioDAO dao = new UsuarioDAO();
        boolean sucesso = dao.remover(id);
        request.setAttribute("msg", sucesso ? "Cadastro removido com sucesso!" : "Erro ao remover cadastro");
        List<Usuario> usuarios = dao.obterTodos();
        request.setAttribute("usuarios", usuarios);
        
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/usuario/cadastrosAdm.jsp");
        rd.forward(request, response);
    }
}
