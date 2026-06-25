package filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import modelo.usuario.Usuario;


public class SegurancaFiltro implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain fc) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String uri = request.getRequestURI();

        HttpSession sessao = request.getSession(false);
        Usuario usuario = null;
        if (sessao != null) {
            usuario = (Usuario) sessao.getAttribute("usuario");
        }
        
        if (uri.contains("/admin/")) {
            if (usuario != null && usuario.isAdministrador()) {
                fc.doFilter(req, res);
                return;
            }
            proibirAcesso(request, response, "Você não tem permissão de administrador");
            return;
        }

        if (uri.contains("/secure/")) {
            if (usuario != null) {
                fc.doFilter(req, res);
                return;
            }
            proibirAcesso(request, response, "Você precisa estar autenticado");
            return;
        }

        fc.doFilter(req, res);
    }

    private void proibirAcesso(HttpServletRequest request, HttpServletResponse response, String mensagem)
            throws ServletException, IOException {
        request.setAttribute("mensagem", mensagem);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/login.jsp");
        requestDispatcher.forward(request, response);
    }
    
}
