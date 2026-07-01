package controle.carrinho;


import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;
import utils.CarrinhoCookieUtil;

    public class RemoverCarrinhoServlet extends HttpServlet {
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        int idProduto = Integer.parseInt(request.getParameter("id"));
 
        Map<Integer, Integer> itens = CarrinhoCookieUtil.obterItens(request);
        itens.remove(idProduto);
 
        Cookie cookie = CarrinhoCookieUtil.criarCookie(itens);
        response.addCookie(cookie);
 
        response.sendRedirect(request.getContextPath() + "/secure/Carrinho");
        }
    }
