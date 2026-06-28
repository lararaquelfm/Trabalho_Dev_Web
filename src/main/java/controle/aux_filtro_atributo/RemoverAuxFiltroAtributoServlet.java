
package controle.aux_filtro_atributo;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.aux_filtro_atributo.AuxFiltroAtributoDAO;

public class RemoverAuxFiltroAtributoServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int filtroId = Integer.parseInt(request.getParameter("filtro"));
        int atributoId = Integer.parseInt(request.getParameter("atributo"));
        AuxFiltroAtributoDAO auxFiltroAtributoDAO = new AuxFiltroAtributoDAO();
        boolean sucesso = auxFiltroAtributoDAO.remover(filtroId, atributoId);
        if (sucesso) {
            request.setAttribute("mensagem", "Relação removida com sucesso");
        } else {
            request.setAttribute("mensagem", "Não foi possível remover a relação");
        }
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/admin/ListarAuxFiltroAtributo");
        requestDispatcher.forward(request, response);
    }

}
