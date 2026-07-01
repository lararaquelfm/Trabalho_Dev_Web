package controle.venda;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.HashMap;
import modelo.aux_venda_produto.AuxVendaProdutoDAO;
import modelo.produto.Produto;
import modelo.produto.ProdutoDAO;
import modelo.usuario.Usuario;
import modelo.venda.VendaDAO;
import utils.CarrinhoCookieUtil;

public class ComprarAgoraServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        int idProduto = Integer.parseInt(request.getParameter("id"));

        int quantidade = 1;
        String quantidadeParam = request.getParameter("quantidade");
        if (quantidadeParam != null && !quantidadeParam.isEmpty()) {
            quantidade = Integer.parseInt(quantidadeParam);
        }

        ProdutoDAO produtoDAO = new ProdutoDAO();
        Produto produto = produtoDAO.obter(idProduto);

        if (produto == null || produto.getQuantidade() < quantidade) {
            request.setAttribute("mensagem",
                    "Não foi possível concluir a compra: estoque insuficiente para "
                    + (produto != null ? produto.getDescricao() : "este produto") + ".");
            RequestDispatcher rd = request.getRequestDispatcher("/secure/VerProduto?id=" + idProduto);
            rd.forward(request, response);
            return;
        }

        VendaDAO vendaDAO = new VendaDAO();
        int idVenda = vendaDAO.inserirRetornandoId(LocalDateTime.now(), usuario.getId());

        if (idVenda == -1) {
            request.setAttribute("mensagem", "Erro ao finalizar a compra. Tente novamente.");
            RequestDispatcher rd = request.getRequestDispatcher("/secure/VerProduto?id=" + idProduto);
            rd.forward(request, response);
            return;
        }

        AuxVendaProdutoDAO auxVendaProdutoDAO = new AuxVendaProdutoDAO();
        auxVendaProdutoDAO.inserir(idVenda, idProduto, quantidade, produto.getPreco());
        produtoDAO.baixarEstoque(idProduto, quantidade);

        Cookie cookieVazio = CarrinhoCookieUtil.criarCookie(new HashMap<Integer, Integer>());
        cookieVazio.setMaxAge(0);
        response.addCookie(cookieVazio);

        response.sendRedirect(request.getContextPath() + "/secure/MinhasCompras");
    }
}