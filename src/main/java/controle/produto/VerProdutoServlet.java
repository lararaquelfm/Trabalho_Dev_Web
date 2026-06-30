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

public class VerProdutoServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        ProdutoDAO produtoDAO = new ProdutoDAO();

        Produto produtoBase = produtoDAO.obter(id);
        List<Produto> variacoes = produtoDAO.obterVariacoes(
            produtoBase.getDescricao(),
            produtoBase.getIdTime(),
            produtoBase.getIdCategoria()
        );

        request.setAttribute("produto", produtoBase);
        request.setAttribute("variacoes", variacoes);

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/produto/verProduto.jsp");
        requestDispatcher.forward(request, response);
    }
}