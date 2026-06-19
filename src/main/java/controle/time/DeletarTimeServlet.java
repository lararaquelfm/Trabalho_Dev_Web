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
 
@WebServlet(name = "DeletarTimeServlet", urlPatterns = {"/adm/DeletarTimeServlet"})

public class DeletarTimeServlet extends HttpServlet{
    
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{        int id = Integer.parseInt(request.getParameter("id"));
        int ide = Integer.parseInt(request.getParameter("id"));
        TimeDAO dao = new TimeDAO();
        boolean sucesso = dao.remover(ide);
        request.setAttribute("msg", sucesso ? "Time removido com sucesso!" : "Erro ao remover time");
        List<Time> times = dao.obterTodos();
        request.setAttribute("times", times);
        
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/time/timesAdm.jsp");
        rd.forward(request, response);
        
        
    }
    
    
    
}