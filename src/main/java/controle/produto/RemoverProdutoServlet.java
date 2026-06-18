package controle.produto;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import modelo.foto.Foto;
import modelo.foto.FotoDAO;
import modelo.produto.ProdutoDAO;

public class RemoverProdutoServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        FotoDAO fotoDAO = new FotoDAO();
        List<Foto> fotos = fotoDAO.obterPeloProduto(id);
        if(!fotos.isEmpty()){
            for (int i = 0; i < fotos.size(); i++){
                Path path = Paths.get(fotos.get(i).getFoto());
                Files.deleteIfExists(path);
                fotoDAO.remover(fotos.get(i).getId());
            }
        }
        ProdutoDAO produtoDAO = new ProdutoDAO();
        boolean sucesso = produtoDAO.remover(id);
        if (sucesso) {
            request.setAttribute("mensagem", "Produto removido com sucesso");
        } else {
            request.setAttribute("mensagem", "Não foi possível remover o produto");
        }
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("Produto");
        requestDispatcher.forward(request, response);
    }

}
