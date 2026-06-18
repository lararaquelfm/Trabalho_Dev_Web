package controle.foto;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class EditarFotoServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("id"));
        request.setAttribute("id", id);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/produto/editarFoto.jsp");
        requestDispatcher.forward(request, response);
    }
    
}
