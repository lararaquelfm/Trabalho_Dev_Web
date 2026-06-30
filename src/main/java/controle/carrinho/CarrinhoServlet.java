package controle.carrinho;
 
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import modelo.produto.Produto;
import modelo.produto.ProdutoDAO;
import utils.CarrinhoCookieUtil;
 

public class CarrinhoServlet extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        Map<Integer, Integer> itensCookie = CarrinhoCookieUtil.obterItens(request);
        ProdutoDAO produtoDAO = new ProdutoDAO();
        List<Produto> produtosCarrinho = new ArrayList<Produto>();
           
         List<Integer> quantidades = new ArrayList<Integer>();
        double valorTotal = 0;
        
         for (Map.Entry<Integer, Integer> entry : itensCookie.entrySet()) {
            Produto produto = produtoDAO.obter(entry.getKey());
            if (produto != null) {
                int quantidade = entry.getValue();
                produtosCarrinho.add(produto);
                quantidades.add(quantidade);
                valorTotal += produto.getPreco() * quantidade;
            }
        }
         
        
        request.setAttribute("produtos", produtosCarrinho);
        request.setAttribute("quantidades", quantidades);
        request.setAttribute("valorTotal", valorTotal);
 
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/carrinho.jsp");
        requestDispatcher.forward(request, response);
        
    }
}
