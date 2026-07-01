<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modelo.campeonato.Campeonato"%>
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
    <title>Administrador</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/barra_navegacao_adm.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/campeonatosAdm.css">
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
                <a href="<%= request.getContextPath()%>/admin/ListarCampeonato">Campeonatos</a>
            </div>
            <a href="<%= request.getContextPath()%>/admin/ListarRelatorio">Relatorios</a>
        </div>

        <div class="conteudo" style="flex: 1; min-width: 0;">
            <div id="pag">
                <div id="cabecalho">
                    <h1>Campeonatos</h1>
                    <div class="pesquisa">
                        <img src="<%= request.getContextPath() %>/imagens/search.svg" alt="lupa">
                        <input type="text" id="campoBusca" placeholder="Buscar campeonato" onkeyup="filtrarTabela()">
                    </div>
                    <button onclick="abrirModalCampeonato()">
                        <img src="<%= request.getContextPath() %>/imagens/mais.svg" alt="mais">
                        <strong>Novo campeonato</strong>
                    </button>
                    <a class="btn-verde" href="<%= request.getContextPath() %>/admin/ListarAuxCampTime">
                        <img src="<%= request.getContextPath() %>/imagens/mais.svg" alt="mais">
                        <strong>Adicionar time</strong>
                    </a>
                </div>

                <%
                    String msg = (String) request.getAttribute("msg");
                    if (msg != null) {
                %>
                    <div class="msg-sucesso"><%= msg %></div>
                <% } %>

                <%
                    List<Campeonato> campeonatos = (List<Campeonato>) request.getAttribute("campeonatos");
                %>

                <div id="tabela">
                    <table id="tabelaCampeonatos">
                        <thead>
                            <tr>
                                <th>Nome</th>
                                <th>ID</th>
                                <th>A&ccedil;&otilde;es</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (campeonatos != null && !campeonatos.isEmpty()) {
                                    for (Campeonato c : campeonatos) {
                            %>
                            <tr>
                                <td><%= c.getNome() %></td>
                                <td><%= c.getId() %></td>
                                <td>
                                    <a href="<%= request.getContextPath() %>/admin/DeletarCampeonato?id=<%= c.getId() %>"
                                       onclick="return confirm('Deseja realmente remover este campeonato?')">
                                        <button>
                                            <img src="<%= request.getContextPath() %>/imagens/lixeira_preta.svg" alt="deletar">
                                        </button>
                                    </a>
                                    <button onclick="abrirModalEditarCampeonato('<%= c.getId() %>', '<%= c.getNome().replace("'", "\\'") %>')">
                                        <img src="<%= request.getContextPath() %>/imagens/editar.svg" alt="editar">
                                    </button>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="3">Nenhum campeonato cadastrado.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="modal-overlay" id="modalCampeonato">
        <div class="modal">
            <h2 id="tituloCampeonato">Novo Campeonato</h2>
            <form method="POST" id="formCampeonato" action="">
                <input type="hidden" name="id" id="campoCampId">
                <label>Nome:</label>
                <input type="text" name="nome" id="campoCampNome" required>
                <div class="modal-botoes">
                    <button type="button" class="btn-cancelar" onclick="fecharModalCampeonato()">Cancelar</button>
                    <button type="submit" class="btn-salvar">Salvar</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const ctxPath = '<%= request.getContextPath() %>';

        function abrirModalCampeonato() {
            document.getElementById('tituloCampeonato').textContent = 'Novo Campeonato';
            document.getElementById('formCampeonato').action = ctxPath + '/admin/InserirCampeonato';
            document.getElementById('campoCampId').value = '';
            document.getElementById('campoCampNome').value = '';
            document.getElementById('modalCampeonato').classList.add('aberto');
        }
        function abrirModalEditarCampeonato(id, nome) {
            document.getElementById('tituloCampeonato').textContent = 'Editar Campeonato';
            document.getElementById('formCampeonato').action = ctxPath + '/admin/AtualizarCampeonato';
            document.getElementById('campoCampId').value = id;
            document.getElementById('campoCampNome').value = nome;
            document.getElementById('modalCampeonato').classList.add('aberto');
        }
        function fecharModalCampeonato() {
            document.getElementById('modalCampeonato').classList.remove('aberto');
        }
        document.getElementById('modalCampeonato').addEventListener('click', function(e) {
            if (e.target === this) fecharModalCampeonato();
        });

        function filtrarTabela() {
            const busca = document.getElementById('campoBusca').value.toLowerCase();
            document.querySelectorAll('#tabelaCampeonatos tbody tr').forEach(function(linha) {
                linha.style.display = linha.textContent.toLowerCase().includes(busca) ? '' : 'none';
            });
        }
    </script>
</body>
</html>
<%
}
%>
