package controle.aux_filtro_atributo;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import modelo.aux_filtro_atributo.AuxFiltroAtributo;
import modelo.aux_filtro_atributo.AuxFiltroAtributoDAO;

public class ListarAuxFiltroAtributoServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<AuxFiltroAtributo> auxFiltroAtributo = new AuxFiltroAtributoDAO().obterTodos();
        request.setAttribute("aux_filtro_atributo", auxFiltroAtributo);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/aux_filtro_atributo/auxFiltroAtributoAdm.jsp");
        requestDispatcher.forward(request, response);
    }
}
