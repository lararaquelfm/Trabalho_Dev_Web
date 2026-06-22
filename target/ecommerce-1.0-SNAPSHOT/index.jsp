<%@page import="modelo.foto.FotoDAO"%>
<%@page import="modelo.foto.Foto"%>
<%@page import="modelo.produto.Produto"%>
<%@page import="java.util.List"%>
<%@include file="indexCabecalho.jsp" %>
<body>
<div id="barraNavegacao">
        <div class="botoes">
            <a href="login.jsp" class="imagem_texto_login">
                <img id="login" src="${pageContext.request.contextPath}/imagens/profile.svg" class="profile" alt="ft da home">
                <img id="login" src="${pageContext.request.contextPath}/imagens/arrowright.svg" class="seta" alt="ft de seta">
                <span>Faça seu login</span>
            </a>
        </div>
        <div class="pesquisa">
            <a href="PaginaPesquisa.html">
                <img src="${pageContext.request.contextPath}/imagens/search.svg" style="width: 100%; height: auto" alt="lupa de pesquisa">
                <input type="text" class="desativar" style="width: 100%; height: 100%;">  
            </a>
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
<script>
    function toggleMenu(event) {
        if (event) event.preventDefault();
        const menu = document.getElementById("Menu");
        menu.classList.toggle("active");
    }
</script>

</body>
</html> 