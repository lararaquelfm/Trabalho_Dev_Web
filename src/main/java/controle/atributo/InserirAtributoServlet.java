/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controle.atributo;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import modelo.atributo.Atributo;
import modelo.atributo.AtributoDAO;

/**
 *
 * @author tktgu
 */
@WebServlet(name = "InserirAtributoServlet", urlPatterns = {"/InserirAtributo"})
public class InserirAtributoServlet extends HttpServlet {
    
     @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String atributo = request.getParameter("atributo");
        String tabela = request.getParameter("tabela");
        
        AtributoDAO dao = new AtributoDAO();
        boolean sucesso = dao.inserir(atributo, tabela);

        request.setAttribute("msg", sucesso
                ? "Atributo inserido com sucesso!"
                : "Erro ao inserir atributo.");

        List<Atributo> atributos = dao.obterTodos();
        request.setAttribute("atributos", atributos);

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/atributo/atributosAdm.jsp");
        rd.forward(request, response);
       }
}
