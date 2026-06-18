<%@include file="loginCabecalho.jsp" %>
<body>
    <main class="container-login">
        <% if (request.getAttribute("mensagem") != null) { %>
        <div class="mensagem" id="aviso" role="alert">
            <strong><%= request.getAttribute("mensagem") %></strong>
            <button onClick="fecharDiv()">
                <img id="login" src="${pageContext.request.contextPath}/imagens/arrowright.svg" class="seta">
            </button>
        </div>
        <% }%>
        <section class="cartao-login">
            <h1>LOGIN</h1>
            <form action="Login" method="post">
                 <!-- Essa div é só gambiarra para um bug no campo de input -->
                <div class="campo">
                </div>
                <div class="campo">
                    <label>Login:</label>
                    <input type="text" name="login" id="formControlLogin" placeholder="Digite seu login" required>
                </div>
                <div class="campo">
                    <label>Senha:</label>
                    <input type="password" name="senha" id="formControlSenha" placeholder="Digite sua senha" required>
                </div>
                <div class="container-botoes">
                    <input type="submit" class="botao-entrar" value="Entrar" />
                    <a href="cadastrar.jsp" class="botao-ir-cadastro">NÃO TENHO CADASTRO</a>
                </div>
            </form>
        </section>
    </main>
</body>
</html>