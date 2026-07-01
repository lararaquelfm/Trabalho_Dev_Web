<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modelo.time.Time"%>
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
    <title>Administrador - Times</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/barra_navegacao_adm.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/timesAdm.css">
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
            <a href="<%= request.getContextPath()%>/admin/ListarPorVendas">Compras</a>
            <a href="<%= request.getContextPath()%>/admin/ListarTodosUsuarios">Cadastros</a>
            <a href="<%= request.getContextPath()%>/admin/Produto">Itens</a>
            <a href="<%= request.getContextPath()%>/admin/ListarCategoria">Categorias</a>
            <a href="<%= request.getContextPath()%>/admin/Competicoes">Tabelas</a>
            <div id="ativo">
                <img src="<%= request.getContextPath() %>/imagens/arrowright.svg" alt="seta direita">
                <a href="<%= request.getContextPath()%>/admin/ListarTime">Times</a>
            </div>
            <a href="<%= request.getContextPath()%>/admin/ListarRelatorio">Relatorios</a>
        </div>

        <div class="conteudo" style="flex: 1; min-width: 0;">
            <div id="pag">
                <div id="cabecalho">
                    <h1>Times</h1>
                    <div class="pesquisa">
                        <img src="<%= request.getContextPath() %>/imagens/search.svg" alt="lupa">
                        <input type="text" id="campoBusca" placeholder="Buscar time" onkeyup="filtrarTabela()">
                    </div>
                    <button onclick="abrirModalTime()">
                        <img src="<%= request.getContextPath() %>/imagens/mais.svg" alt="mais">
                        <strong>Novo time</strong>
                    </button>
                </div>

                <%
                    String msg = (String) request.getAttribute("msg");
                    if (msg != null) {
                %>
                    <div class="msg-sucesso"><%= msg %></div>
                <% } %>

                <div id="tabela">
                    <table id="tabelaTimes">
                        <thead>
                            <tr>
                                <th>Nome</th>
                                <th>Nacionalidade</th>
                                <th>ID</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Time> times = (List<Time>) request.getAttribute("times");
                                if (times != null && !times.isEmpty()) {
                                    for (Time t : times) {
                            %>
                            <tr>
                                <td><%= t.getNome() %></td>
                                <td><%= t.getNacionalidade() %></td>
                                <td><%= t.getId() %></td>
                                <td>
                                    <a href="<%= request.getContextPath() %>/admin/DeletarTime?id=<%= t.getId() %>"
                                       onclick="return confirm('Deseja realmente remover este time?')">
                                        <button>
                                            <img src="<%= request.getContextPath() %>/imagens/lixeira_preta.svg" alt="deletar">
                                        </button>
                                    </a>
                                    <button onclick="abrirModalEditarTime(
                                        '<%= t.getId() %>',
                                        '<%= t.getNome().replace("'", "\\'") %>',
                                        '<%= t.getNacionalidade().replace("'", "\\'") %>'
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
                                <td colspan="4">Nenhum time cadastrado.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <%-- Modal: Criar / Editar Time --%>
    <div class="modal-overlay" id="modalTime">
        <div class="modal">
            <h2 id="tituloTime">Novo Time</h2>
            <form method="POST" id="formTime" action="">
                <input type="hidden" name="id" id="campoTimeId">

                <label>Nome:</label>
                <input type="text" name="nome" id="campoTimeNome" required>

                <label>Nacionalidade:</label>
                <input type="text" name="nacionalidade" id="campoTimeNacionalidade" required>

                <div class="modal-botoes">
                    <button type="button" class="btn-cancelar" onclick="fecharModalTime()">Cancelar</button>
                    <button type="submit" class="btn-salvar">Salvar</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const ctxPath = '<%= request.getContextPath() %>';

        function abrirModalTime() {
            document.getElementById('tituloTime').textContent = 'Novo Time';
            document.getElementById('formTime').action = ctxPath + '/admin/InserirTime';
            document.getElementById('campoTimeId').value = '';
            document.getElementById('campoTimeNome').value = '';
            document.getElementById('campoTimeNacionalidade').value = '';
            document.getElementById('modalTime').classList.add('aberto');
        }

        function abrirModalEditarTime(id, nome, nacionalidade) {
            document.getElementById('tituloTime').textContent = 'Editar Time';
            document.getElementById('formTime').action = ctxPath + '/admin/AtualizarTime';
            document.getElementById('campoTimeId').value = id;
            document.getElementById('campoTimeNome').value = nome;
            document.getElementById('campoTimeNacionalidade').value = nacionalidade;
            document.getElementById('modalTime').classList.add('aberto');
        }

        function fecharModalTime() {
            document.getElementById('modalTime').classList.remove('aberto');
        }

        document.getElementById('modalTime').addEventListener('click', function(e) {
            if (e.target === this) fecharModalTime();
        });

        function filtrarTabela() {
            const busca = document.getElementById('campoBusca').value.toLowerCase();
            const linhas = document.querySelectorAll('#tabelaTimes tbody tr');
            linhas.forEach(function(linha) {
                linha.style.display = linha.textContent.toLowerCase().includes(busca) ? '' : 'none';
            });
        }
    </script>
</body>
</html>
<%
}
%>