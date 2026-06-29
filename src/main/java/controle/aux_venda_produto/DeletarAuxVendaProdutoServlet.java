/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controle.aux_venda_produto;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import modelo.aux_venda_produto.AuxVendaProdutoDAO;
import modelo.aux_venda_produto.AuxVendaProduto;
import modelo.venda.Venda;
import modelo.venda.VendaDAO;

public class DeletarAuxVendaProdutoServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
       try {
            String idStr = request.getParameter("id_venda");

            if (idStr == null || idStr.isEmpty()) {
                throw new ServletException("ID da venda não foi enviado");
            }

            int idVenda = Integer.parseInt(idStr);
            AuxVendaProdutoDAO dao = new AuxVendaProdutoDAO();
            boolean sucesso = dao.removerPorVenda(idVenda);
            request.setAttribute("msg",sucesso ? "Venda removida com sucesso!" : "Erro ao remover venda!");

            VendaDAO vendaDAO = new VendaDAO();
            List<Venda> vendas = vendaDAO.obterTodos();

            request.setAttribute("vendas", vendas);

            RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/vendas/vendasAdm.jsp");
            rd.forward(request, response);

        } catch (NumberFormatException e) {
            throw new ServletException("ID inválido (não numérico)", e);
        }
    }
}
