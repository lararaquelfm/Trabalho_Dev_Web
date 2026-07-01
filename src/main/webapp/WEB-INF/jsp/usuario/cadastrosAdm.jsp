
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modelo.usuario.Usuario"%>
<%
if (session.getAttribute("usuario") != null && session.getAttribute("usuario") instanceof Usuario) {
    Usuario usuario = (Usuario) session.getAttribute("usuario");
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrador - Cadastros</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/barra_navegacao_adm.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/cadastrosAdm.css">
</head>
<body>
    <div id="cabecalhoAdm">
        <div class="pcima">
            <img id="profile" src="<%= request.getContextPath() %>/imagens/profile.svg" style="width: 3%; height: auto" alt="ft de perfil">
            <h1>Administrador: <%= usuario.getNome() %></h1>
        </div>
        <div class="plado">
            <div class="menu" style="width:15%;">
            <a href="<%= request.getContextPath()%>/admin/MyProfileAdm?id=<%= usuario.getId() %>">Editar Dados</a>
            <a href="<%= request.getContextPath()%>/admin/HomepageAdm">Dashboard</a>
            <a href="">Compras</a>
            <div id="ativo">
                <img src="<%= request.getContextPath() %>/imagens/arrowright.svg" alt="seta direita">
                <a href="<%= request.getContextPath()%>/admin/ListarTodosUsuarios">Cadastros</a>
            </div>
            <a href="<%= request.getContextPath()%>/admin/Produto">Itens</a>
            <a href="<%= request.getContextPath()%>/admin/ListarCategoria">Categorias</a>
            <a href="<%= request.getContextPath()%>/admin/Competicoes">Tabelas</a>
            <a href="<%= request.getContextPath()%>/admin/ListarRelatorio">Relatorios</a>
            
            </div>
            <div class="conteudo" style="width: 85%">
                <div class="cabecalhocadastro">
                    <h1>Cadastros</h1>
                    <div class="pesquisar">
                        <img src="<%= request.getContextPath() %>/imagens/search.svg" style="width: 26px">
                        <input id="campoBusca" type="text" placeholder="Buscar cadastro por nome" onkeyup="filtrarCadastro()" style="width: 100%; height: 100%">
                    </div>
                </div>
                    
                <%
                    List<Usuario> usuarios = (List<Usuario>) request.getAttribute("usuarios");
                    if (usuarios != null && !usuarios.isEmpty()) {
                        for (Usuario u : usuarios) {
                %>
                <div class="Cadastro">
                    <p class="nome"><span class = "dados"><b>Nome: </b></span><%= u.getNome() %></p>
                    <p><span class = "dados"><b>Endereço: </b></span> <%= u.getEndereco() %> </p>
                    <p><span class = "dados"><b>E-mail: </b></span> <%= u.getEmail() %> </p>
                    <p><span class = "dados"><b>Login: </b></span> <%= u.getLogin() %></p>
                    <div classs="acoes">
                        <a href="<%= request.getContextPath() %>/admin/DeletarUsuarioAdm?id=<%= u.getId() %>"
                                       onclick="return confirm('Deseja realmente remover este cadastro?')">
                            <button style="border: none; background: transparent; padding: 0; cursor: pointer; padding: 5px; margin-left: 5px">
                                            <img src="<%= request.getContextPath() %>/imagens/lixeira_preta.svg" alt="deletar">
                            </button>
                        </a>
                    </div>
                </div>
                
                <%      }
                    }else{
                    
                %>
                <p>Nenhum usuário foi cadastrado</p>
                
                <% } %>
            </div>
        </div>
    </div>
    <script>
        function filtrarCadastro() {
            const busca = document.getElementById('campoBusca').value.toLowerCase();
            const cadastros = document.querySelectorAll('.Cadastro');
            cadastros.forEach(function(cadastro) {
                const nome = cadastro.querySelector(".nome").textContent.toLowerCase();
                cadastro.style.display = nome.includes(busca)? '': "none";
            });
        }
    </script>
</body>
</html>
<%
    } else {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
%>