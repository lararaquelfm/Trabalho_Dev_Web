package controle.foto;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import modelo.foto.FotoDAO;
import modelo.produto.ProdutoDAO;
import utils.Utils;

public class AdicionarFotoServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        request.setAttribute("id", id);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/produto/adicionarFoto.jsp");
        requestDispatcher.forward(request, response);
    }

}
