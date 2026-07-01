package controle.venda;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import modelo.aux_venda_produto.AuxVendaProduto;
import modelo.aux_venda_produto.AuxVendaProdutoDAO;
import modelo.usuario.Usuario;
import modelo.venda.Venda;
import modelo.venda.VendaDAO;

public class MinhasComprasServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        VendaDAO vendaDAO = new VendaDAO();
        List<Venda> vendas = vendaDAO.obterPorUsuario(usuario.getId());

        AuxVendaProdutoDAO auxVendaProdutoDAO = new AuxVendaProdutoDAO();
        List<List<AuxVendaProduto>> itensPorVenda = new ArrayList<List<AuxVendaProduto>>();
        for (Venda venda : vendas) {
            itensPorVenda.add(auxVendaProdutoDAO.obterPorVenda(venda.getId()));
        }

        request.setAttribute("vendas", vendas);
        request.setAttribute("itensPorVenda", itensPorVenda);

        RequestDispatcher rd = request.getRequestDispatcher("/minhasCompras.jsp");
        rd.forward(request, response);
    }
}