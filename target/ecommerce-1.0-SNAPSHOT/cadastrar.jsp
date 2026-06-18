<%@include file="cadastrarCabecalho.jsp" %>
<body>
    <main class="container-cadastro">
        <% if (request.getAttribute("mensagem") != null) { %>
        <div class="mensagem" id="aviso" role="alert">
            <strong><%= request.getAttribute("mensagem") %></strong>
            <button onClick="fecharDiv()">
                <img id="login" src="${pageContext.request.contextPath}/imagens/arrowright.svg" class="seta">
            </button>
        </div>
        <% }%>
        <section class="cartao-cadastro">
            <h1>CADASTRO</h1>
            <form action="Cadastrar" method="post">
                <div class="campo">
                    <label for="formControlNome">Nome:</label>
                <input type="text" name="nome" id="formControlNome" placeholder="Digite o seu nome" required>
                </div>
                
                <div class="campo">
                        <label for="formControlEndereco">Endereço:</label>
                        <input type="text" name="endereco" id="formControlEndereco" placeholder="Digite o seu endereço" required>
                </div>
                               
                <div class="campo">
                    <label for="formControlEmail">E-mail:</label>
                    <input type="text" name="email" id="formControlEmail" placeholder="Digite o seu e-mail" required>
                </div>

                <div class="campo">
                    <label for="formControlLogin">Login:</label>
                    <input type="text" name="login" id="formControlLogin" placeholder="Digite o seu login" required>
                </div>

                <div class="campo">
                    <label for="formControlSenha">Senha</label>
                    <input type="password" name="senha" id="formControlSenha" placeholder="Digite sua senha" required>
                </div>
                <div class="container-botao">
                    <input type="submit" class="botao-cadastrar" value="Cadastrar" />
                </div>
            </form>
        </section>
    </main>
</body>
</html>