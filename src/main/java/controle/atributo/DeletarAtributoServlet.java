package controle.atributo;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.util.List;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.atributo.Atributo;
import modelo.atributo.AtributoDAO;

/**
 *
 * @author tktgu
 */
@WebServlet(name = "InserirAtributoServlet", urlPatterns = {"/DeletarAtributo"})
public class DeletarAtributoServlet extends HttpServlet {
    
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException{        

        int id = Integer.parseInt(request.getParameter("id"));
        AtributoDAO dao = new AtributoDAO();
        boolean sucesso = dao.remover(id);
        request.setAttribute("msg", sucesso ? "Atributo removido com sucesso!" : "Erro ao remover atributo");
        List<Atributo> atributos = dao.obterTodos();
        request.setAttribute("atributos", atributos);
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/atributo/atributosAdm.jsp");
        rd.forward(request, response);
    }
}
