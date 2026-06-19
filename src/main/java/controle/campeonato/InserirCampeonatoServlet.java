package controle.campeonato;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import modelo.campeonato.Campeonato;
import modelo.campeonato.CampeonatoDAO;

@WebServlet(name = "InserirCampeonatoServlet", urlPatterns = {"/adm/InserirCampeonatoServlet"})
public class InserirCampeonatoServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nome = request.getParameter("nome");

        CampeonatoDAO dao = new CampeonatoDAO();
        boolean sucesso = dao.inserir(nome);

        request.setAttribute("msg", sucesso
                ? "Campeonato inserido com sucesso!"
                : "Erro ao inserir campeonato.");

        List<Campeonato> campeonatos = dao.obterTodos();
        request.setAttribute("campeonatos", campeonatos);

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/campeonato/campeonatosAdm.jsp");
        rd.forward(request, response);
       }
}