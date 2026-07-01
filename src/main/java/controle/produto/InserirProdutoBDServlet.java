package controle.produto;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.produto.ProdutoDAO;

public class InserirProdutoBDServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = -1;
        if (request.getParameter("id") != null && request.getParameter("id").trim().length() > 0) {
            id = Integer.parseInt(request.getParameter("id"));
        }
        String descricao = request.getParameter("descricao");
        String tamanho = request.getParameter("tamanho");
        double preco = Double.parseDouble(request.getParameter("preco"));
        int quantidade = Integer.parseInt(request.getParameter("quantidade"));
        int categoriaId = Integer.parseInt(request.getParameter("categoriaId"));
        int timeId = Integer.parseInt(request.getParameter("timeId"));
        
        ProdutoDAO produtoDAO = new ProdutoDAO();
        boolean sucesso = false;
        if (id == -1) {
            sucesso = produtoDAO.inserir(descricao, preco, tamanho, quantidade, timeId, categoriaId);
        } else {
            sucesso = produtoDAO.atualizar(descricao, preco, tamanho, quantidade, timeId, categoriaId, id);
        }
        if (sucesso) {
            request.setAttribute("mensagem", "Produto salvo com sucesso");
        } else {
            request.setAttribute("mensagem", "Não foi possível salvar o produto");
        }
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("Produto");
        requestDispatcher.forward(request, response);
    }

}
