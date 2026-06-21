package controle.categoria;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.categoria.CategoriaDAO;

@WebServlet(name = "DeletarCategoriaServlet", urlPatterns = {"/DeletarCategoria"})
public class DeletarCategoriaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                CategoriaDAO dao = new CategoriaDAO();
                boolean sucesso = dao.remover(id);

                if (sucesso) {
                    request.setAttribute("msg", "Categoria removida com sucesso!");
                } else {
                    request.setAttribute("msg", "Não foi possível remover a categoria.");
                }
                
            } catch (NumberFormatException e) {
                request.setAttribute("msg", "ID inválido.");
            }
        } else {
            request.setAttribute("msg", "ID não informado.");
        }

        // Redireciona de volta para o listar, que recarrega a lista do banco
        request.getRequestDispatcher("/ListarCategoria")
               .forward(request, response);
    }
}