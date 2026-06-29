/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controle.usuario;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import modelo.usuario.Usuario;
import modelo.usuario.UsuarioDAO;

/**
 *
 * @author tktgu
 */
@WebServlet(name = "ListarTodosUsuariosServlet", urlPatterns = {"/ListarTodosUsuarios"})
public class ListarTodosUsuariosServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        UsuarioDAO dao = new UsuarioDAO();
        
        List<Usuario> times = dao.obterTodos();
        request.setAttribute("usuarios", times);
        
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/usuario/cadastrosAdm.jsp");
        rd.forward(request, response);
    }

}