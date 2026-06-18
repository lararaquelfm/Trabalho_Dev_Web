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
    <div class="camisa">
        <a href="Pagina_Blusa.html" style="text-decoration: none; color: inherit;">
            <img src="${pageContext.request.contextPath}/imagens/camisa.png" >
            <p>Descrição</p>
            <h1>Preço</h1>
            <button>
                Adicionar ao carrinho
                <img src="${pageContext.request.contextPath}/imagens/carrinho.svg" alt="ft de carrinho">
            </button>
        </div>
        </a>
    <div class="camisa">
        <img src="${pageContext.request.contextPath}/imagens/camisa.png" >
        <p>Descrição</p>
        <h1>Preço</h1>
        <button>
            Adicionar ao carrinho
            <img src="${pageContext.request.contextPath}/imagens/carrinho.svg" alt="ft de carrinho">
        </button>
    </div>

    <div class="camisa">
        <img src="${pageContext.request.contextPath}/imagens/camisa.png" >
        <p>Descrição</p>
        <h1>Preço</h1>
        <button>
            Adicionar ao carrinho
            <img src="${pageContext.request.contextPath}/imagens/carrinho.svg" alt="ft de carrinho">
        </button>
    </div>
    <div class="camisa">
        <img src="${pageContext.request.contextPath}/imagens/camisa.png" >
        <p>Descrição</p>
        <h1>Preço</h1>
        <button>
            Adicionar ao carrinho
            <img src="${pageContext.request.contextPath}/imagens/carrinho.svg" alt="ft de carrinho">
        </button>
    </div>
    <div class="camisa">
        <img src="${pageContext.request.contextPath}/imagens/camisa.png" >
        <p>Descrição</p>
        <h1>Preço</h1>
        <button>
            Adicionar ao carrinho
            <img src="${pageContext.request.contextPath}/imagens/carrinho.svg" alt="ft de carrinho">
        </button>
    </div>
</div>
<h1 id="ofertas">Ofertas</h1>
<div class="deslizar">
    <div class="e_d">
            <button class="seta direita"><img src="${pageContext.request.contextPath}/imagens/seta-direita.png" alt="seta_direita"></button>
            <button class="seta esquerda"><img src="${pageContext.request.contextPath}/imagens/seta-esquerda.png" alt="seta_esquerda "></button>
    </div>
    <div id="carrossel">
        <div class="camisa">
            <img src="${pageContext.request.contextPath}/imagens/camisa.png" >
            <p>Descrição</p>
            <h1>Preço</h1>
            <button>
                Adicionar ao carrinho
                <img src="${pageContext.request.contextPath}/imagens/carrinho.svg" alt="ft de carrinho">
            </button>
        </div>
        <div class="camisa">
            <img src="${pageContext.request.contextPath}/imagens/camisa.png" >
            <p>Descrição</p>
            <h1>Preço</h1>
            <button>
                Adicionar ao carrinho
                <img src="${pageContext.request.contextPath}/imagens/carrinho.svg" alt="ft de carrinho">
            </button>
        </div>
    
        <div class="camisa">
            <img src="${pageContext.request.contextPath}/imagens/camisa.png" >
            <p>Descrição</p>
            <h1>Preço</h1>
            <button>
                Adicionar ao carrinho
                <img src="${pageContext.request.contextPath}/imagens/carrinho.svg" alt="ft de carrinho">
            </button>
        </div>
        <div class="camisa">
            <img src="${pageContext.request.contextPath}/imagens/camisa.png" >
            <p>Descrição</p>
            <h1>Preço</h1>
            <button>
                Adicionar ao carrinho
                <img src="${pageContext.request.contextPath}/imagens/carrinho.svg" alt="ft de carrinho">
            </button>
        </div>
        <div class="camisa">
            <img src="${pageContext.request.contextPath}/imagens/camisa.png" >
            <p>Descrição</p>
            <h1>Preço</h1>
            <button>
                Adicionar ao carrinho
                <img src="${pageContext.request.contextPath}/imagens/carrinho.svg" alt="ft de carrinho">
            </button>
        </div>
        <div class="camisa">
            <img src="${pageContext.request.contextPath}/imagens/camisa.png" >
            <p>Descrição</p>
            <h1>Preço</h1>
            <button>
                Adicionar ao carrinho
                <img src="${pageContext.request.contextPath}/imagens/carrinho.svg" alt="ft de carrinho">
            </button>
        </div>
        <div class="camisa">
            <img src="${pageContext.request.contextPath}/imagens/camisa.png" >
            <p>Descrição</p>
            <h1>Preço</h1>
            <button>
                Adicionar ao carrinho
                <img src="${pageContext.request.contextPath}/imagens/carrinho.svg" alt="ft de carrinho">
            </button>
        </div>
    </div>
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