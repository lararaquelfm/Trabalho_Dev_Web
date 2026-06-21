<%@page import="modelo.usuario.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
Usuario usuario = (Usuario) request.getAttribute("usuario");
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrador</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/barra_navegacao_adm.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/myProfileAdm.css">
</head>
<body>
<body>
    <div class="pcima">
            <img id="profile" src="${pageContext.request.contextPath}/imagens/profile.svg" style="width: 3%; height: auto" alt="ft de perfil">
            <h1>Administrador: <%= usuario.getNome() %></h1>
    </div>
    <div class="plado">
        <div class="menu" style="width:15%;">
            <div id="ativo">
                <img src="${pageContext.request.contextPath}/imagens/arrowright.svg" alt="seta direita">
                <a href="MyProfileAdm?id=<%= usuario.getId() %>">Editar Dados</a>
            </div>
            <a href="HomepageAdm">Dashboard</a>
            <a href="ComprasAdm.html">Compras</a>
            <a href="CadastrosAdm.html">Cadastros</a>
            <a href="Produto">Itens</a>
            <a href="ListarCategoria">Categorias</a>
            <a href="Competicoes">Competições</a>       
        </div>
        <div class="conteudo" style="width: 85%">
            <div id="pag">
                <% if (request.getAttribute("mensagem") != null) { %>
                <div class="mensagem" id="aviso" role="alert">
                    <strong><%= request.getAttribute("mensagem") %></strong>
                    <button onClick="fecharDiv()">
                        <img id="login" src="${pageContext.request.contextPath}/imagens/arrowright.svg" class="seta">
                    </button>
                </div>
                <% }%>
                <main class="container">
                    <% if (request.getAttribute("mensagem") != null) { %>
                    <div class="mensagem" id="aviso" role="alert">
                        <strong><%= request.getAttribute("mensagem") %></strong>
                        <button onClick="fecharDiv()">
                            <img id="login" src="${pageContext.request.contextPath}/imagens/arrowright.svg" class="seta">
                        </button>
                    </div>
                    <% }%>
                    <h1>Dados do administrador</h1>
                    <p>Acesse, altere ou exclua seus dados</p>
                    <form action="AtualizarUsuario" method="post">
                        <input type="hidden" name="id" value="<%= usuario.getId() %>" />
                        <section class="card">
                            <div class="grade">
                                <div class="col">
                                    <div class="campo">
                                        <strong>Nome:</strong>
                                        <input type="text" name="nome" id="profileControlNome" placeholder="<%= usuario.getNome() %>" value="<%= usuario.getNome() %>" required>   
                                    </div>  
                                    <div class="campo">
                                        <strong>Endereço:</strong>
                                        <input type="text" name="endereco" id="profileControlEndereco" placeholder="<%= usuario.getEndereco()%>" value="<%= usuario.getEndereco()%>" required>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="campo">
                                         <strong>E-mail:</strong>
                                         <input type="text" name="email" id="profileControlEmail" placeholder="<%= usuario.getEmail()%>" value="<%= usuario.getEmail()%>" required>
                                    </div>
                                    <div class="campo">
                                        <strong>Senha:</strong>
                                        <input type="password" name="senha" id="profileControlSenha" placeholder="Digite a nova senha ou deixe o campo vazio" value="">
                                    </div>
                                    <div class="campo">
                                        <strong>Login:</strong>
                                        <input type="text" name="login" id="profileControlLogin" placeholder="<%= usuario.getLogin() %>" value="<%= usuario.getLogin() %>" required>
                                    </div>
                                </div>
                            </div>
                            
                            <div style="display: flex; gap: 25px;">
                                <input type="submit" class="botao-alterar" value="Alterar Dados" />
                                <a href="DeletarUsuario?id=<%= usuario.getId() %>" class="botao-deletar"><img src="${pageContext.request.contextPath}/imagens/delete.svg" alt="">Deletar perfil</a>
                            </div>
                        </section>
                    </form> 
                </main>
            </div>                       
        </div>
    </div>
</body>
<script>
    function fecharDiv(){
        let div = document.getElementById("aviso");
        if (div.style.display === "none"){
            div.style.display = "flex";
        }else{
            div.style.display = "none";
        }
    }
</script>
</html>