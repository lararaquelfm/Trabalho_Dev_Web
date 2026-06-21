package controle.aux_camp_time;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import modelo.aux_camp_time.AuxCampTime;
import modelo.aux_camp_time.AuxCampTimeDAO;
import modelo.campeonato.CampeonatoDAO;
import modelo.time.TimeDAO;

@WebServlet(name = "DeletarAuxCampTimeServlet", urlPatterns = {"/DeletarAuxCampTime"})
public class DeletarAuxCampTimeServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idCampeonato = Integer.parseInt(request.getParameter("id_campeonato"));
        int idTime       = Integer.parseInt(request.getParameter("id_time"));

        AuxCampTimeDAO dao = new AuxCampTimeDAO();
        boolean sucesso = dao.remover(idCampeonato, idTime);

        request.setAttribute("msg", sucesso
                ? "Vínculo removido com sucesso!"
                : "Erro ao remover vínculo.");

        List<AuxCampTime> vinculos = dao.obterTodos();
        request.setAttribute("vinculos", vinculos);
        request.setAttribute("times", new TimeDAO().obterTodos());
        request.setAttribute("campeonatos", new CampeonatoDAO().obterTodos());

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/aux_camp_time/auxCampTimeAdm.jsp");
        rd.forward(request, response);
    }
}   