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

@WebServlet(name = "InserirTimeServlet", urlPatterns = {"/InserirTime"})
public class InserirTimeServlet extends HttpServlet {
    
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String nome  = request.getParameter("nome");
        String nacionalidade = request.getParameter("nacionalidade");
        TimeDAO dao = new TimeDAO();
        boolean sucesso = dao.inserir(nome, nacionalidade);
        
        request.setAttribute("msg", sucesso ? "Time inserido com sucesso" : "Erro ao inserir o time");
        List<Time> times = dao.obterTodos();
        request.setAttribute("times", times);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/time/timesAdm.jsp");
        rd.forward(request, response);
    }

}