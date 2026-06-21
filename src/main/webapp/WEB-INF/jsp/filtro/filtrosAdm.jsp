<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modelo.filtro.Filtro"%>
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
    <title>Administrador - Filtros</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/barra_navegacao_adm.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/filtrosAdm.css">
</head>
<body>

    <div class="pcima">
        <img id="profile" src="<%= request.getContextPath() %>/imagens/profile.svg" style="width: 3%; height: auto" alt="ft de perfil">
        <h1>Administrador: <%= usuario.getNome() %></h1>
    </div>

    <div class="plado">
        <div class="menu">
            <a href="MyProfileAdm?id=<%= usuario.getId() %>">Editar Dados</a>
            <a href="HomepageAdm">Dashboard</a>
            <a href="ComprasAdm.html">Compras</a>
            <a href="CadastrosAdm.html">Cadastros</a>
            <a href="Produto">Itens</a>
            <a href="ListarCategoria">Categorias</a>
            <a href="Competicoes">Competições</a>
            <div id="ativo">
                <img src="<%= request.getContextPath() %>/imagens/arrowright.svg" alt="seta direita">
                <a href="ListarFiltro">Filtros</a>
            </div>
        </div>

        <div class="conteudo" style="flex: 1; min-width: 0;">
            <div id="pag">
                <div id="cabecalho">
                    <h1>Filtros</h1>
                    <div class="pesquisa">
                        <img src="<%= request.getContextPath() %>/imagens/search.svg" alt="lupa">
                        <input type="text" id="campoBusca" placeholder="Buscar filtro" onkeyup="filtrarTabela()">
                    </div>
                    <button onclick="abrirModalFiltro()">
                        <img src="<%= request.getContextPath() %>/imagens/mais.svg" alt="mais">
                        <strong>Novo filtro</strong>
                    </button>
                </div>

                <%
                    String msg = (String) request.getAttribute("msg");
                    if (msg != null) {
                %>
                    <div class="msg-sucesso"><%= msg %></div>
                <% } %>

                <div id="tabela">
                    <table id="tabelaFiltros">
                        <thead>
                            <tr>
                                <th>Nome</th>
                                <th>ID</th>
                                <th>Check</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Filtro> filtros = (List<Filtro>) request.getAttribute("filtros");
                                if (filtros != null && !filtros.isEmpty()) {
                                    for (Filtro t : filtros) {
                            %>
                            <tr>
                                <td><%= t.getNome() %></td>
                                <td><%= t.getId() %></td>
                                <td><%= t.getChecked() %></td>
                                <td>
                                    <a href="<%= request.getContextPath() %>/DeletarFiltro?id=<%= t.getId() %>"
                                       onclick="return confirm('Deseja realmente remover este filtro?')">
                                        <button>
                                            <img src="<%= request.getContextPath() %>/imagens/lixeira_preta.svg" alt="deletar">
                                        </button>
                                    </a>
                                    <button onclick="abrirModalEditarFiltro(
                                        '<%= t.getId() %>',
                                        '<%= t.getNome().replace("'", "\\'") %>',
                                        '<%= String.valueOf(t.getChecked())%>'
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
                                <td colspan="4">Nenhum filtro cadastrado.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <%-- Modal: Criar / Editar Filtro --%>
    <div class="modal-overlay" id="modalFiltro">
        <div class="modal">
            <h2 id="tituloFiltro">Novo Filtro</h2>
            <form method="POST" id="formFiltro" action="">
                <input type="hidden" name="id" id="campoFiltroId">

                <label>Nome:</label>
                <input type="text" name="nome" id="campoFiltroNome" required>

                <label>Checked:</label>
                <input type="text" name="checked" id="campoFiltroChecked" required>

                <div class="modal-botoes">
                    <button type="button" class="btn-cancelar" onclick="fecharModalFiltro()">Cancelar</button>
                    <button type="submit" class="btn-salvar">Salvar</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const ctxPath = '<%= request.getContextPath() %>';

        function abrirModalFiltro() {
            document.getElementById('tituloFiltro').textContent = 'Novo Filtro';
            document.getElementById('formFiltro').action = ctxPath + '/InserirFiltro';
            document.getElementById('campoFiltroId').value = '';
            document.getElementById('campoFiltroNome').value = '';
            document.getElementById('campoFiltroChecked').value = '';
            document.getElementById('modalFiltro').classList.add('aberto');
        }

        function abrirModalEditarFiltro(id, nome, checked) {
            document.getElementById('tituloFiltro').textContent = 'Editar Filtro';
            document.getElementById('formFiltro').action = ctxPath + '/AtualizarFiltro';
            document.getElementById('campoFiltroId').value = id;
            document.getElementById('campoFiltroNome').value = nome;
            document.getElementById('campoFiltroChecked').value = checked;
            document.getElementById('modalFiltro').classList.add('aberto');
        }

        function fecharModalFiltro() {
            document.getElementById('modalFiltro').classList.remove('aberto');
        }

        document.getElementById('modalFiltro').addEventListener('click', function(e) {
            if (e.target === this) fecharModalFiltro();
        });

        function filtrarTabela() {
            const busca = document.getElementById('campoBusca').value.toLowerCase();
            const linhas = document.querySelectorAll('#tabelaFiltros tbody tr');
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