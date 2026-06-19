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
 
@WebServlet(name = "ListarAuxCampTimeServlet", urlPatterns = {"/adm/ListarAuxCampTimeServlet"})

public class ListarAuxCampTimeServlet extends HttpServlet {
    
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        
        AuxCampTimeDAO dao = new AuxCampTimeDAO();
        List<AuxCampTime> vinculos = dao.obterTodos();
        request.setAttribute("vinculos", vinculos);

        List<Time> times = new TimeDAO().obterTodos();
        List<Campeonato> campeonatos = new CampeonatoDAO().obterTodos();
        
        request.setAttribute("times", times);
        request.setAttribute("campeonatos", campeonatos);
        
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/aux_camp_time/auxCampTimeAdm.jsp");
        rd.forward(request, response);        
    }
    
}