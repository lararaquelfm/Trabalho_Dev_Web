<%@page import="modelo.usuario.Usuario"%>
<%@include file="myProfileCabecalho.jsp" %>
<%
Usuario usuarioBean = (Usuario) request.getAttribute("usuario");
%>
<body>
    <div id="barraNavegacao">
        <div class="botoes">
           <a onclick="toggleMenu()" alt="Menu"><img id="profile" src="${pageContext.request.contextPath}/imagens/profile.svg" style="width: 100%; height: auto" alt="ft de perfil"></a>
        </div>
        <div class="botoes">
            <div class="botoes">
    <a href="Homepage">
        <img id="home" src="imagens/home.svg" style="width: 100%; height: auto" alt="ft de favorito">
    </a>
            </div>
        </div>
        <div class="botoes">
            <a >
                <img id="carrinho" src="imagens/carrinho.svg" style="width: 100%; height: auto" alt="ft de carrinho"></a>
        </div>
        <div class="pesquisa">
            <img src="imagens/search.svg" style="width: 100%; height: auto" alt="lupa de pesquisa">
            <input type="text" style="width: 100%; height: 100%;">
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

   <main class="container">
       <% if (request.getAttribute("mensagem") != null) { %>
        <div class="mensagem" id="aviso" role="alert">
            <strong><%= request.getAttribute("mensagem") %></strong>
            <button onClick="fecharDiv()">
                <img id="login" src="${pageContext.request.contextPath}/imagens/arrowright.svg" class="seta">
            </button>
        </div>
        <% }%>
        <h1>Meu perfil</h1>
        <p>Acesse ou altere seus dados</p>
        <form action="AtualizarUsuario" method="post">
            <input type="hidden" name="id" value="<%= usuarioBean.getId() %>" />
            <section class="card">
            <div class="grade">
                <div class="col">
                    <div class="campo">
                        <strong>Nome:</strong>
                        <input type="text" name="nome" id="profileControlNome" placeholder="<%= usuarioBean.getNome() %>" value="<%= usuarioBean.getNome() %>" required>   
                    </div>  
                    <div class="campo">
                        <strong>Endereço:</strong>
                        <input type="text" name="endereco" id="profileControlEndereco" placeholder="<%= usuarioBean.getEndereco()%>" value="<%= usuarioBean.getEndereco()%>" required>
                    </div>
                </div>
                <div class="col">
                    <div class="campo">
                        <strong>E-mail:</strong>
                        <input type="text" name="email" id="profileControlEmail" placeholder="<%= usuarioBean.getEmail()%>" value="<%= usuarioBean.getEmail()%>" required>
                    </div>
                    <div class="campo">
                        <strong>Senha:</strong>
                        <input type="password" name="senha" id="profileControlSenha" placeholder="Digite a nova senha ou deixe o campo vazio" value="">
                    </div>
                    <div class="campo">
                        <strong>Login:</strong>
                        <input type="text" name="login" id="profileControlLogin" placeholder="<%= usuarioBean.getLogin() %>" value="<%= usuarioBean.getLogin() %>" required>
                    </div>
                </div>
            </div>
            <input type="submit" class="botao-alterar" value="Alterar Dados" />
            </section>
        </form> 
    </main>
</body>
</html>
<% } %>