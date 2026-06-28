package controle.produto;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import modelo.atributo.Atributo;
import modelo.atributo.AtributoDAO;
import modelo.aux_filtro_atributo.AuxFiltroAtributo;
import modelo.aux_filtro_atributo.AuxFiltroAtributoDAO;
import modelo.filtro.Filtro;
import modelo.filtro.FiltroDAO;
import modelo.produto.Produto;
import modelo.produto.ProdutoDAO;

public class PaginaPesquisaServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int filtroId = -1;
        if (request.getParameter("filtroId") != null && request.getParameter("filtroId").trim().length() > 0) {
            filtroId = Integer.parseInt(request.getParameter("filtroId"));
        }
        List<Filtro> filtros = new FiltroDAO().obterTodos();
        List<Atributo> atributos = new AtributoDAO().obterTodos();
        List<AuxFiltroAtributo> auxFiltroAtributos = new AuxFiltroAtributoDAO().obterTodos();
        List<Produto> produtos = null;
        if (filtroId == -1){
            produtos = new ProdutoDAO().obterEstoque();
        } else {
            AuxFiltroAtributo auxFiltroAtributo = new AuxFiltroAtributoDAO().obterFiltro(filtroId);
            if (auxFiltroAtributo != null){
                Atributo atributo = new AtributoDAO().obter(auxFiltroAtributo.getIdAtributo());
                if (atributos != null){
                    produtos = new ProdutoDAO().obterFiltro(atributo.getTabela(), atributo.getAtributo());
                }
            }
            if (produtos == null) {
                produtos = new ProdutoDAO().obterEstoque();
            }
        }
        request.setAttribute("produtos", produtos);
        request.setAttribute("filtros", filtros);
        request.setAttribute("atributos", atributos);
        request.setAttribute("auxFiltroAtributos", auxFiltroAtributos);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/WEB-INF/jsp/paginaPesquisa.jsp");
        requestDispatcher.forward(request, response);
    }

}