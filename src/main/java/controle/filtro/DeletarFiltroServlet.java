/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controle.filtro;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import modelo.filtro.Filtro;
import modelo.filtro.FiltroDAO;

/**
 *
 * @author tktgu
 */
@WebServlet(name = "DeletarFiltroServlet", urlPatterns = {"/DeletarFiltro"})
public class DeletarFiltroServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
       int id = Integer.parseInt(request.getParameter("id"));
       FiltroDAO dao = new FiltroDAO();
       
       boolean sucesso = dao.remover(id);
       
       request.setAttribute("msg", sucesso ? "Filtro removido com sucesso!" : "Erro ao remover filtro!");
       
        List<Filtro> filtros = dao.obterTodos();
        request.setAttribute("filtros", filtros);
       
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/filtro/filtrosAdm.jsp");
        rd.forward(request, response);
    }
}
