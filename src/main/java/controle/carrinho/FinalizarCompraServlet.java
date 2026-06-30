package controle.carrinho;

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
import java.util.Map;
import modelo.aux_venda_produto.AuxVendaProdutoDAO;
import modelo.produto.Produto;
import modelo.produto.ProdutoDAO;
import modelo.usuario.Usuario;
import modelo.venda.VendaDAO;
import utils.CarrinhoCookieUtil;

public class FinalizarCompraServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        Map<Integer, Integer> itensCookie = CarrinhoCookieUtil.obterItens(request);

        if (itensCookie.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/secure/Carrinho");
            return;
        }

        ProdutoDAO produtoDAO = new ProdutoDAO();

        // Primeiro confere se tem estoque suficiente pra TODOS os itens,
        // antes de mexer em qualquer coisa no banco
        Map<Integer, Produto> produtosValidados = new HashMap<Integer, Produto>();
        for (Map.Entry<Integer, Integer> entry : itensCookie.entrySet()) {
            Produto produto = produtoDAO.obter(entry.getKey());
            if (produto == null || produto.getQuantidade() < entry.getValue()) {
                request.setAttribute("mensagem",
                        "Não foi possível finalizar a compra: estoque insuficiente para "
                        + (produto != null ? produto.getDescricao() : "um dos itens") + ".");
                RequestDispatcher rd = request.getRequestDispatcher("/secure/Carrinho");
                rd.forward(request, response);
                return;
            }
            produtosValidados.put(entry.getKey(), produto);
        }

        // Cria a venda
        VendaDAO vendaDAO = new VendaDAO();
        int idVenda = vendaDAO.inserirRetornandoId(LocalDateTime.now(), usuario.getId());

        if (idVenda == -1) {
            request.setAttribute("mensagem", "Erro ao finalizar a compra. Tente novamente.");
            RequestDispatcher rd = request.getRequestDispatcher("/secure/Carrinho");
            rd.forward(request, response);
            return;
        }

        AuxVendaProdutoDAO auxVendaProdutoDAO = new AuxVendaProdutoDAO();
        for (Map.Entry<Integer, Integer> entry : itensCookie.entrySet()) {
            int idProduto = entry.getKey();
            int quantidade = entry.getValue();
            Produto produto = produtosValidados.get(idProduto);

            auxVendaProdutoDAO.inserir(idVenda, idProduto, quantidade, produto.getPreco());
            produtoDAO.baixarEstoque(idProduto, quantidade);
        }

        Cookie cookieVazio = CarrinhoCookieUtil.criarCookie(new HashMap<Integer, Integer>());
        cookieVazio.setMaxAge(0);
        response.addCookie(cookieVazio);

        response.sendRedirect(request.getContextPath() + "/secure/MinhasCompras");
    }
}