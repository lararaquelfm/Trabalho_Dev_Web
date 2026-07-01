package controle.relatorio;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ListarRelatorioServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/relatorio/relatorios.jsp");
        requestDispatcher.forward(request, response);
    }
}
