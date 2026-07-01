package controle.carrinho;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;
import utils.CarrinhoCookieUtil;
 
public class AtualizarQuantidadeCarrinhoServlet extends HttpServlet{
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        
        int idProduto = Integer.parseInt(request.getParameter("id"));
        int quantidade = Integer.parseInt(request.getParameter("quantidade"));

        Map<Integer, Integer> itens = CarrinhoCookieUtil.obterItens(request);
        
         if (quantidade <= 0) {
            itens.remove(idProduto);
        } else {
            itens.put(idProduto, quantidade);
        }
         
           Cookie cookie = CarrinhoCookieUtil.criarCookie(itens);
        response.addCookie(cookie);
 
        response.sendRedirect(request.getContextPath() + "/secure/Carrinho");
    }
}
                
    

