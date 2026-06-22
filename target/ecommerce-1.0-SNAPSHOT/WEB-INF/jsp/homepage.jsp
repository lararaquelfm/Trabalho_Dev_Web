<%@page import="modelo.foto.FotoDAO"%>
<%@page import="modelo.foto.Foto"%>
<%@page import="modelo.produto.Produto"%>
<%@page import="java.util.List"%>
<%@include file="homepageCabecalho.jsp" %>
<body>
<div id="barraNavegacao">
    <div class="botoes">
        <a onclick="toggleMenu()" alt="Menu"><img id="profile" src="${pageContext.request.contextPath}/imagens/profile.svg" style="width: 100%; height: auto" alt="ft de perfil"></a>
    </div>
    <div class="botoes">
        <a >
        <img id="home" src="${pageContext.request.contextPath}/imagens/home.svg" style="width: 100%; height: auto" alt="ft da home">
    </a>
    </div>
    <div class="botoes">
        <a >
            <img id="carrinho" src="${pageContext.request.contextPath}/imagens/carrinho.svg" style="width: 100%; height: auto; " alt="ft de carrinho"></a>
    </div>

        <div class="linhavertical"></div>
        <span class="bemvindo">Bem-vindo(a), <%= usuario.getNome() %>!</span>
        <div class="pesquisa">
            <a href="PaginaPesquisa.html">
                <img src="${pageContext.request.contextPath}/imagens/search.svg" style="width: 100%; height: auto" alt="lupa de pesquisa">
                <input type="text" class="desativar" style="width: 100%; height: 100%;">  
            </a>
        </div>
</div>
    
        <div id="Menu" class="menulateral">
            <div class="itens_menu_lateral">
                <a ><img src="${pageContext.request.contextPath}/imagens/arrowright.svg" alt="">Meus pedidos</a>
                <a href="MyProfile?id=<%= usuario.getId() %>"><img src="${pageContext.request.contextPath}/imagens/arrowright.svg" alt="">Meus dados</a>
                <div class="sair">
                    <a href="Logout" style="padding-top: 35px; padding-bottom: 20px;"><img src="${pageContext.request.contextPath}/imagens/logout.svg" alt="">Sair</a> 
                </div>
                <div class="deletar">
                    <a href="DeletarUsuario?id=<%= usuario.getId() %>"><img src="${pageContext.request.contextPath}/imagens/delete.svg" alt="">Deletar perfil</a>
                </div>
            </div>
    
        </div>

        <img id="background" src="${pageContext.request.contextPath}/imagens/background.png" style="width: 100%; height: auto" alt="background da pagina">
<div id="camisas">
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
                    <p><%= c.getDescricao()%></p>
                    <h1>R$: <%= c.getPreco()%></h1>
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
</body>
</html> 

<% }%>