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
import modelo.campeonato.Campeonato;
import modelo.campeonato.CampeonatoDAO;
import modelo.time.Time;
import modelo.time.TimeDAO;

@WebServlet(name = "AtualizarAuxCampTimeServlet", urlPatterns = {"/adm/AtualizarAuxCampTimeServlet"})
public class AtualizarAuxCampTimeServlet extends HttpServlet {
//so da pra atualizar o ano porque time e campeonato sao id 
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idCampeonato = Integer.parseInt(request.getParameter("id_campeonato_original"));
        int idTime       = Integer.parseInt(request.getParameter("id_time_original"));
        int ano          = Integer.parseInt(request.getParameter("ano"));

        AuxCampTimeDAO dao = new AuxCampTimeDAO();
        boolean sucesso = dao.atualizar(idCampeonato, idTime, ano);

        request.setAttribute("msg", sucesso
                ? "Vínculo atualizado com sucesso!"
                : "Erro ao atualizar vínculo.");

        List<AuxCampTime> vinculos = dao.obterTodos();
        request.setAttribute("vinculos", vinculos);
        request.setAttribute("times", new TimeDAO().obterTodos());
        request.setAttribute("campeonatos", new CampeonatoDAO().obterTodos());

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/aux_camp_time/auxCampTimeAdm.jsp");
        rd.forward(request, response);
    }
}