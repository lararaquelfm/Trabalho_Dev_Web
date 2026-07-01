package controle.produto;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.Comparator;
import java.util.List;
import modelo.foto.Foto;
import modelo.foto.FotoDAO;
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

        FotoDAO fotoDAO = new FotoDAO();
        List<Foto> fotos = fotoDAO.obterPeloProduto(produtoBase.getId());
        fotos.sort(Comparator.comparingInt(foto -> {
            String nomeArquivo = new File(foto.getFoto()).getName();
            String[] partes = nomeArquivo.split("_");
            return Integer.parseInt(partes[0].trim());
        }));

        request.setAttribute("produto", produtoBase);
        request.setAttribute("variacoes", variacoes);
        request.setAttribute("fotos", fotos);

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/produto/verProduto.jsp");
        requestDispatcher.forward(request, response);
    }
}