package controle.homepage;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import modelo.produto.Produto;
import modelo.produto.ProdutoDAO;
import modelo.aux_venda_produto.AuxVendaProdutoDAO;
import modelo.relatorio.RelatorioDAO;

public class HomepageAdmServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProdutoDAO produtoDAO = new ProdutoDAO();
        AuxVendaProdutoDAO auxDAO = new AuxVendaProdutoDAO();

        Produto maisVendido = produtoDAO.produtoMaisVendido();
        double faturamento = auxDAO.faturamentoMes();
        int[] vendasPorMes = auxDAO.vendasPorMes();
        List<Produto> emFalta = new RelatorioDAO().relatorioFaltaEstoque();

        request.setAttribute("maisVendido", maisVendido);
        request.setAttribute("faturamento", faturamento);
        request.setAttribute("vendasPorMes", vendasPorMes);
        request.setAttribute("emFalta", emFalta);

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/homepageAdm.jsp");
        requestDispatcher.forward(request, response);
    }
}