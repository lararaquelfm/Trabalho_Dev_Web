package controle.homepage;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import modelo.produto.Produto;
import modelo.produto.ProdutoDAO;
import modelo.aux_venda_produto.AuxVendaProdutoDAO;

public class HomepageAdmServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProdutoDAO produtoDAO = new ProdutoDAO();
        AuxVendaProdutoDAO auxDAO = new AuxVendaProdutoDAO();

        Produto maisVendido = produtoDAO.produtoMaisVendido();
        double faturamento = auxDAO.faturamentoMes();
        int[] vendasPorMes = auxDAO.vendasPorMes();

        request.setAttribute("maisVendido", maisVendido);
        request.setAttribute("faturamento", faturamento);
        request.setAttribute("vendasPorMes", vendasPorMes);

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/homepageAdm.jsp");
        requestDispatcher.forward(request, response);
    }
}