package controle.categoria;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import modelo.categoria.Categoria;
import modelo.categoria.CategoriaDAO;

@WebServlet(name = "ListarCategoriaServlet", urlPatterns = {"/ListarCategoria"})
public class ListarCategoriaServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CategoriaDAO dao = new CategoriaDAO();
        List<Categoria> categorias = dao.obterTodos();
        request.setAttribute("categorias", categorias);

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/categoria/categoriasAdm.jsp");
        rd.forward(request, response);
    }
}