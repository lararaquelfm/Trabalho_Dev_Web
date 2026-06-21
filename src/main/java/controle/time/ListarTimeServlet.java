package controle.time;
 
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import modelo.time.Time;
import modelo.time.TimeDAO;

@WebServlet(name = "ListarTimeServlet", urlPatterns = {"/ListarTime"})

public class ListarTimeServlet extends HttpServlet {
    
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        TimeDAO dao = new TimeDAO();
        
        List<Time> times = dao.obterTodos();
        request.setAttribute("times", times);
        
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/time/timesAdm.jsp");
        rd.forward(request, response);
    }
}
