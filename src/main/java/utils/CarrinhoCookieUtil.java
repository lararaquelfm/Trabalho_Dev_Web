package utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import java.util.LinkedHashMap;
import java.util.Map;

public class CarrinhoCookieUtil {

    public static final String NOME_COOKIE = "carrinho";

    
    public static Map<Integer, Integer> obterItens(HttpServletRequest request) {
        Map<Integer, Integer> itens = new LinkedHashMap<Integer, Integer>();
        Cookie[] cookies = request.getCookies();
        for (int i = 0; cookies != null && i < cookies.length; i++) {
            Cookie c = cookies[i];
            if (c.getName().equals(NOME_COOKIE)) {
                String valor = c.getValue();
                if (valor != null && !valor.isEmpty()) {
                    String[] pares = valor.split("_");
                    for (String par : pares) {
                        String[] partes = par.split(":");
                        if (partes.length == 2) {
                            try {
                                int idProduto = Integer.parseInt(partes[0]);
                                int quantidade = Integer.parseInt(partes[1]);
                                itens.put(idProduto, quantidade);
                            } catch (NumberFormatException ex) {
                            }
                        }
                    }
                }
                break;
            }
        }
        return itens;
    }

    public static String montarValorCookie(Map<Integer, Integer> itens) {
        StringBuilder sb = new StringBuilder();
        for (Map.Entry<Integer, Integer> entry : itens.entrySet()) {
            if (sb.length() > 0) {
                sb.append("_");
            }
            sb.append(entry.getKey()).append(":").append(entry.getValue());
        }
        return sb.toString();
    }

    public static Cookie criarCookie(Map<Integer, Integer> itens) {
        Cookie cookie = new Cookie(NOME_COOKIE, montarValorCookie(itens));
        cookie.setPath("/");
        cookie.setMaxAge(60 * 60 * 24 * 30); 
        return cookie;
    }
}