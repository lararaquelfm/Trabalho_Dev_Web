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

@WebServlet(name = "InserirCategoriaServlet", urlPatterns = {"/adm/InserirCategoriaServlet"})
public class InserirCategoriaServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nome      = request.getParameter("nome");
        String temporada = request.getParameter("temporada");
        String estilo    = request.getParameter("estilo");

        CategoriaDAO dao = new CategoriaDAO();
        boolean sucesso = dao.inserir(nome, temporada, estilo);

        request.setAttribute("msg", sucesso
                ? "Categoria inserida com sucesso!"
                : "Erro ao inserir categoria.");

        List<Categoria> categorias = dao.obterTodos();
        request.setAttribute("categorias", categorias);

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/categoria/categoriasAdm.jsp");
        rd.forward(request, response);
    }
}