/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controle.aux_venda_produto;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import modelo.venda.VendaDAO;
import modelo.venda.Venda;

@WebServlet(name = "ListarPorVendasServlet", urlPatterns = {"/ListarPorVendas"})
public class ListarPorVendasServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
        VendaDAO vendaDAO = new VendaDAO();
        List<Venda> vendas = vendaDAO.obterTodos();
        request.setAttribute("vendas", vendas);

        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/vendas/vendasAdm.jsp");
        rd.forward(request, response);

    }
}
