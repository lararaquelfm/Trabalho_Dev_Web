<%@page import="modelo.aux_filtro_atributo.AuxFiltroAtributoDAO"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.ArrayList"%>
<%@page import="modelo.atributo.AtributoDAO"%>
<%@page import="modelo.filtro.FiltroDAO"%>
<%@page import="modelo.aux_filtro_atributo.AuxFiltroAtributo"%>
<%@page import="modelo.atributo.Atributo"%>
<%@page import="modelo.filtro.Filtro"%>
<%@page import="modelo.produto.Produto"%>
<%@page import="modelo.foto.FotoDAO"%>
<%@page import="modelo.foto.Foto"%>
<%@page import="java.util.List"%>
<%@page import="modelo.usuario.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
if (session.getAttribute("usuario") != null && session.getAttribute("usuario") instanceof Usuario) {
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    String filtroAtivo = request.getParameter("filtroId");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="barra_navegacao.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/barra_navegacao.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/paginaPesquisa.css">
    <title>Pesquisa</title>
</head>
<body>
    <div id="barraNavegacao">
        <div class="botoes">
            <a onclick="toggleMenu()" alt="Menu">
                <img id="profile" src="${pageContext.request.contextPath}/imagens/profile.svg" style="width: 100%; height: auto" alt="ft de perfil">
            </a>
        </div>
        <div class="botoes">
            <a href="<%= request.getContextPath() %>/secure/Homepage">
                <img id="home" src="${pageContext.request.contextPath}/imagens/home.svg" style="width: 100%; height: auto" alt="ft da home">
            </a>
        </div>
        <div class="botoes">
            <a >
                <img id="carrinho" src="${pageContext.request.contextPath}/imagens/carrinho.svg" style="width: 100%; height: auto; " alt="ft de carrinho"></a>
        </div>

        <form action="<%= request.getContextPath()%>/secure/BuscaProdutoServlet">
            <div class="pesquisa" style="margin-top: -17px; margin-left: 57%;">
                <img src="${pageContext.request.contextPath}/imagens/search.svg" style="width: 100%; height: auto" alt="lupa de pesquisa">
                <input type="text" name="descricao" style="width: 100%; height: 100%;">  
            </div>
        </form>
          
    </div>
                    
    <div id="Menu" class="menulateral">
        <div class="itens_menu_lateral">
            <a ><img src="${pageContext.request.contextPath}/imagens/arrowright.svg" alt="">Meus pedidos</a>
            <a href="<%= request.getContextPath()%>/secure/MyProfile?id=<%= usuario.getId() %>"><img src="${pageContext.request.contextPath}/imagens/arrowright.svg" alt="">Meus dados</a>
            <div class="sair">
                <a href="<%= request.getContextPath()%>/secure/Logout" style="padding-top: 35px; padding-bottom: 20px;"><img src="${pageContext.request.contextPath}/imagens/logout.svg" alt="">Sair</a> 
            </div>
            <div class="deletar">
                <a href="<%= request.getContextPath()%>/secure/DeletarUsuario?id=<%= usuario.getId() %>"><img src="${pageContext.request.contextPath}/imagens/delete.svg" alt="">Deletar perfil</a>
            </div>
        </div>

    </div>

    <div id="PesquisaFiltro">
        <div class="filtragens" style="width: 20%">
        <%
        List<Filtro> filtros = (List<Filtro>) request.getAttribute("filtros");
        List<Atributo> atributos = (List<Atributo>) request.getAttribute("atributos");
        List<AuxFiltroAtributo> auxFiltroAtributos = (List<AuxFiltroAtributo>) request.getAttribute("auxFiltroAtributos");
        Set<String> tabelasUnicas = new LinkedHashSet<>();
        for (var filtro : filtros) {
            String[] dados = filtro.getNome().split("\\|");
            tabelasUnicas.add(dados[0]);
        }
        List<String> tabelas = new ArrayList<>(tabelasUnicas);
        if (filtros != null && !filtros.isEmpty()) {
            for (int i = 0; i < tabelas.size(); i++){
        %>
            <div class="cat">
                <h1><%= tabelas.get(i) %></h1>
                <div class="lista">
                    <%
                    for (var filtro : filtros){
                        if (filtro.getNome().split("\\|")[0].equals(tabelas.get(i))){
                            boolean checked = filtroAtivo != null && filtroAtivo.equals(String.valueOf(filtro.getId()));
                            AuxFiltroAtributoDAO auxFiltroAtributoDAO = new AuxFiltroAtributoDAO();
                            AuxFiltroAtributo auxFiltroAtributo = auxFiltroAtributoDAO.obterFiltro(filtro.getId());
                    %>
                            <div class="opcao">
                                <input type="checkbox"
                                       id="filtro_<%= filtro.getId() %>"
                                       value="<%= filtro.getId() %>"
                                       class="filtro-check"
                                       <%= checked ? "checked" : "" %>
                                       >
                                <label for="filtro_<%= filtro.getId() %>"><%= filtro.getNome().split("\\|")[1] %></label>
                            </div>
                    <%
                        }
                    }    
                    %>
                </div>
            </div>
        <%
            }
        }
        %>
        </div>
        <div class="camisasFiltros" style="width: 80%">
            <div class="bloco">
                    <%
                    List<Produto> produtos = (List<Produto>) request.getAttribute("produtos");
                        if (produtos != null && !produtos.isEmpty()) {
                            for (int i = 0; i < produtos.size(); i++) {
                                Produto c = produtos.get(i);
                    %>
                                <div class="camisa">
                                <% 
                                List<Foto> fotos = new FotoDAO().obterPeloProduto(c.getId());
                                if (fotos.isEmpty()){
                                %>
                                    <img src="${pageContext.request.contextPath}/imagens/Image-not-found.png" class="itens-img" alt="Camiseta">
                                <%
                                } else {
                                %>
                                    <img src="<%= request.getContextPath() %>/MostrarProduto?id=<%= c.getId()%>" class="itens-img" alt="Camiseta">
                                <%
                                }
                                %>
                                    <p style=" padding: 2px; white-space: nowrap; overflow: auto; text-overflow: ellipsis;"><%= c.getDescricao()%></p>
                                    <h1>R$: <%= String.format("%.2f", c.getPreco())%></h1>
                                    <button>
                                        Adicionar ao carrinho
                                        <img src="${pageContext.request.contextPath}/imagens/carrinho.svg" alt="ft de carrinho">
                                    </button>
                                </div>
                    <%
                            }
                        }
                    %>
            </div>            
        </div>
    </div>    
</body>
<script>
    function toggleMenu(event) {
        if (event) event.preventDefault();
        const menu = document.getElementById("Menu");
        menu.classList.toggle("active");
    }
    
    document.querySelectorAll('.filtro-check').forEach(checkbox => {
    checkbox.addEventListener('change', function() {
        if (this.checked) {
            document.querySelectorAll('.filtro-check').forEach(outros => {
                if (outros !== this) outros.checked = false;
            });

            const filtroId = this.value;

            window.location.href = "<%= request.getContextPath() %>/secure/PaginaPesquisa?filtroId=" + filtroId;
        } else {
            window.location.href = "<%= request.getContextPath() %>/secure/PaginaPesquisa";
        }
    });
});
</script>
</html>
<%
    }  
%>