package controle.aux_filtro_atributo;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import modelo.atributo.Atributo;
import modelo.atributo.AtributoDAO;
import modelo.filtro.Filtro;
import modelo.filtro.FiltroDAO;

public class AdicionarAuxFiltroAtributoServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Filtro> filtros = new FiltroDAO().obterTodos();
        List<Atributo> atributos = new AtributoDAO().obterTodos();
        request.setAttribute("filtros", filtros);
        request.setAttribute("atributos", atributos);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/aux_filtro_atributo/adicionarAuxFiltroAtributoAdm.jsp");
        requestDispatcher.forward(request, response);
    }
    
}
