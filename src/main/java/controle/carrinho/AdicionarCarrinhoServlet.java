package controle.carrinho;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;
import utils.CarrinhoCookieUtil;

public class AdicionarCarrinhoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idProduto = Integer.parseInt(request.getParameter("id"));

        // quantidade é opcional, default 1 (caso o botão não mande esse parâmetro)
        int quantidadeAdicionar = 1;
        String quantidadeParam = request.getParameter("quantidade");
        if (quantidadeParam != null && !quantidadeParam.isEmpty()) {
            quantidadeAdicionar = Integer.parseInt(quantidadeParam);
        }

        Map<Integer, Integer> itens = CarrinhoCookieUtil.obterItens(request);

        if (itens.containsKey(idProduto)) {
            itens.put(idProduto, itens.get(idProduto) + quantidadeAdicionar);
        } else {
            itens.put(idProduto, quantidadeAdicionar);
        }

        Cookie cookie = CarrinhoCookieUtil.criarCookie(itens);
        response.addCookie(cookie);

        response.sendRedirect(request.getContextPath() + "/secure/Carrinho");
    }
}