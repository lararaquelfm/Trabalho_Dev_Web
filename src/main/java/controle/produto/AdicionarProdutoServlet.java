package controle.produto;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import modelo.categoria.Categoria;
import modelo.categoria.CategoriaDAO;
import modelo.foto.Foto;
import modelo.foto.FotoDAO;
import modelo.time.Time;
import modelo.time.TimeDAO;

public class AdicionarProdutoServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Categoria> categorias = new CategoriaDAO().obterTodos();
        List<Time> times = new TimeDAO().obterTodos();
        List<Foto> fotos = new FotoDAO().obterTodos();
        request.setAttribute("categorias", categorias);
        request.setAttribute("times", times);
        request.setAttribute("fotos", fotos);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/produto/adicionarProduto.jsp");
        requestDispatcher.forward(request, response);
    }
    
}
