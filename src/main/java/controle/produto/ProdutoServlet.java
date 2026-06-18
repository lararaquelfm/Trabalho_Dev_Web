package controle.produto;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import modelo.produto.Produto;
import modelo.produto.ProdutoDAO;

public class ProdutoServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Produto> produtos = new ProdutoDAO().obterTodos();
        request.setAttribute("produtos", produtos);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/produto/produtos.jsp");
        requestDispatcher.forward(request, response);
    }
}
