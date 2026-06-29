<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modelo.categoria.Categoria"%>
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
    <title>Administrador - Categorias</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/barra_navegacao_adm.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/categoriasAdm.css">
</head>
<body>
    <div class="pcima">
        <img id="profile" src="<%= request.getContextPath() %>/imagens/profile.svg" style="width: 3%; height: auto" alt="ft de perfil">
        <h1>Administrador: <%= usuario.getNome() %></h1>
    </div>
    <div class="plado">
        <div class="menu">
            <a href="<%= request.getContextPath()%>/admin/MyProfileAdm?id=<%= usuario.getId() %>">Editar Dados</a>
            <a href="<%= request.getContextPath()%>/admin/HomepageAdm">Dashboard</a>
            <a href="">Compras</a>
            <a href="<%= request.getContextPath()%>/admin/ListarTodosUsuarios">Cadastros</a>
            <a href="<%= request.getContextPath()%>/admin/Produto">Itens</a>
            <div id="ativo">
                <img src="<%= request.getContextPath() %>/imagens/arrowright.svg" alt="seta direita">
                <a href="<%= request.getContextPath()%>/admin/Categorias">Categorias</a>
            </div>
            <a href="<%= request.getContextPath()%>/admin/Competicoes">Tabelas</a>
        </div>

        <div class="conteudo" style="flex: 1; min-width: 0;">
            <div id="pag">
                <div id="cabecalho">
                    <h1>Categorias</h1>
                    <div class="pesquisa">
                        <img src="<%= request.getContextPath() %>/imagens/search.svg" alt="lupa">
                        <input type="text" id="campoBusca" placeholder="Buscar categoria" onkeyup="filtrarTabela()">
                    </div>
                    <button onclick="abrirModalInserir()">
                        <img src="<%= request.getContextPath() %>/imagens/mais.svg" alt="mais">
                        <strong>Nova Categoria</strong>
                    </button>
                </div>

                <%
                    String msg = (String) request.getAttribute("msg");
                    if (msg != null) {
                %>
                    <div class="msg-sucesso"><%= msg %></div>
                <% } %>

                <div id="tabela">
                    <table id="tabelaCategorias">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>Temporada</th>
                                <th>Estilo</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
                                if (categorias != null && !categorias.isEmpty()) {
                                    for (Categoria c : categorias) {
                            %>
                            <tr>
                                <td><%= c.getId() %></td>
                                <td><%= c.getNome() %></td>
                                <td><%= c.getTemporada() %></td>
                                <td><%= c.getEstilo() %></td>
                                <td>
                                    <a href="<%= request.getContextPath() %>/admin/DeletarCategoria?id=<%= c.getId() %>"
                                       onclick="return confirm('Deseja realmente remover esta categoria?')">
                                        <button>
                                            <img src="<%= request.getContextPath() %>/imagens/lixeira_preta.svg" alt="deletar">
                                        </button>
                                    </a>
                                    <button onclick="abrirModalEditar(
                                        '<%= c.getId() %>',
                                        '<%= c.getNome().replace("'", "\\'") %>',
                                        '<%= c.getTemporada().replace("'", "\\'") %>',
                                        '<%= c.getEstilo().replace("'", "\\'") %>'
                                    )">
                                        <img src="<%= request.getContextPath() %>/imagens/editar.svg" alt="editar">
                                    </button>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="5">Nenhuma categoria cadastrada.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="modal-overlay" id="modalOverlay">
        <div class="modal">
            <h2 id="modalTitulo">Nova Categoria</h2>
            <form method="POST" id="modalForm" action="">
                <input type="hidden" name="id" id="campoId">

                <label>Nome:</label>
                <input type="text" name="nome" id="campoNome" required>

                <label>Temporada:</label>
                <input type="text" name="temporada" id="campoTemporada" required>
                
                <label>Estilo:</label>
                <input type="text" name="estilo" id="campoEstilo" required>

                <div class="modal-botoes">
                    <button type="button" class="btn-cancelar" onclick="fecharModal()">Cancelar</button>
                    <button type="submit" class="btn-salvar">Salvar</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const ctxPath = '<%= request.getContextPath() %>';

        function abrirModalInserir() {
            document.getElementById('modalTitulo').textContent = 'Nova Categoria';
            document.getElementById('modalForm').action = ctxPath + '/admin/InserirCategoria';
            document.getElementById('campoId').value = '';
            document.getElementById('campoNome').value = '';
            document.getElementById('campoTemporada').value = '';
            document.getElementById('campoEstilo').value = '';
            document.getElementById('modalOverlay').classList.add('aberto');
        }

        function abrirModalEditar(id, nome, temporada, estilo) {
            document.getElementById('modalTitulo').textContent = 'Editar Categoria';
            document.getElementById('modalForm').action = ctxPath + '/admin/AtualizarCategoria';
            document.getElementById('campoId').value = id;
            document.getElementById('campoNome').value = nome;
            document.getElementById('campoTemporada').value = temporada;
            document.getElementById('campoEstilo').value = estilo;
            document.getElementById('modalOverlay').classList.add('aberto');
        }

        function fecharModal() {
            document.getElementById('modalOverlay').classList.remove('aberto');
        }

        document.getElementById('modalOverlay').addEventListener('click', function(e) {
            if (e.target === this) fecharModal();
        });

        function filtrarTabela() {
            const busca = document.getElementById('campoBusca').value.toLowerCase();
            const linhas = document.querySelectorAll('#tabelaCategorias tbody tr');
            linhas.forEach(function(linha) {
                linha.style.display = linha.textContent.toLowerCase().includes(busca) ? '' : 'none';
            });
        }
    </script>
</body>
</html>
<% } %>