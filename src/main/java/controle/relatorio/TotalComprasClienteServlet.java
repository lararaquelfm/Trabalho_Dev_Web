package controle.relatorio;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import modelo.aux_venda_produto.AuxVendaProduto;
import modelo.aux_venda_produto.AuxVendaProdutoDAO;
import modelo.usuario.Usuario;
import modelo.usuario.UsuarioDAO;

public class TotalComprasClienteServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/relatorio/totalComprasCliente.jsp");
        requestDispatcher.forward(request, response);
    }
}
