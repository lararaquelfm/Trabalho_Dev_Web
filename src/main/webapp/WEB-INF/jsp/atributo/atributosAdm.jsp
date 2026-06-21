<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modelo.atributo.Atributo"%>
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
    <title>Administrador - Atributos</title>
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
            <a href="MyProfileAdm?id=<%= usuario.getId() %>">Editar Dados</a>
            <a href="HomepageAdm">Dashboard</a>
            <a href="ComprasAdm.html">Compras</a>
            <a href="CadastrosAdm.html">Cadastros</a>
            <a href="Produto">Itens</a>
            <a href="ListarCategoria">Categorias</a>
            <a href="Competicoes">Competições</a>
            <div id="ativo">
                <img src="<%= request.getContextPath() %>/imagens/arrowright.svg" alt="seta direita">
                <a href="ListarAtributos">Atributos</a>
            </div>
        </div>

        <div class="conteudo" style="flex: 1; min-width: 0;">
            <div id="pag">
                <div id="cabecalho">
                    <h1>Atributos</h1>
                    <div class="pesquisa">
                        <img src="<%= request.getContextPath() %>/imagens/search.svg" alt="lupa">
                        <input type="text" id="campoBusca" placeholder="Buscar atributo" onkeyup="filtrarTabela()">
                    </div>
                    <button onclick="abrirModalAtributo()">
                        <img src="<%= request.getContextPath() %>/imagens/mais.svg" alt="mais">
                        <strong>Novo atributo</strong>
                    </button>
                </div>

                <%
                    String msg = (String) request.getAttribute("msg");
                    if (msg != null) {
                %>
                    <div class="msg-sucesso"><%= msg %></div>
                <% } %>

                <div id="tabela">
                    <table id="tabelaAtributos">
                        <thead>
                            <tr>
                                <th>Atributo</th>
                                <th>Tabela</th>
                                <th>ID</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Atributo> atributos = (List<Atributo>) request.getAttribute("atributos");
                                if (atributos != null && !atributos.isEmpty()) {
                                    for (Atributo t : atributos) {
                            %>
                            <tr>
                                <td><%= t.getAtributo() %></td>
                                <td><%= t.getTabela() %></td>
                                <td><%= t.getId() %></td>
                                <td>
                                    <a href="<%= request.getContextPath() %>/DeletarAtributo?id=<%= t.getId() %>"
                                       onclick="return confirm('Deseja realmente remover este atributo?')">
                                        <button>
                                            <img src="<%= request.getContextPath() %>/imagens/lixeira_preta.svg" alt="deletar">
                                        </button>
                                    </a>
                                    <button onclick="abrirModalEditarAtributo(
                                        '<%= t.getId() %>',
                                        '<%= t.getAtributo().replace("'", "\\'") %>',
                                        '<%= t.getTabela().replace("'", "\\'") %>'
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
                                <td colspan="4">Nenhum atributo cadastrado.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <%-- Modal: Criar / Editar Atributos --%>
    <div class="modal-overlay" id="modalAtributo">
        <div class="modal">
            <h2 id="tituloAtributo">Novo Atributo</h2>
            <form method="POST" id="formAtributo" action="">
                <input type="hidden" name="id" id="campoAtributoId">

                <label>Atributo:</label>
                <input type="text" name="atributo" id="campoAtributoAtributo" required>

                <label>Tabela:</label>
                <input type="text" name="tabela" id="campoAtributoTabela" required>

                <div class="modal-botoes">
                    <button type="button" class="btn-cancelar" onclick="fecharModalAtributo()">Cancelar</button>
                    <button type="submit" class="btn-salvar">Salvar</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const ctxPath = '<%= request.getContextPath() %>';

        function abrirModalAtributo() {
            document.getElementById('tituloAtributo').textContent = 'Novo Atributo';
            document.getElementById('formAtributo').action = ctxPath + '/InserirAtributo';
            document.getElementById('campoAtributoId').value = '';
            document.getElementById('campoAtributoAtributo').value = '';
            document.getElementById('campoAtributoTabela').value = '';
            document.getElementById('modalAtributo').classList.add('aberto');
        }

        function abrirModalEditarAtributo(id, atributo, tabela) {
            document.getElementById('tituloAtributo').textContent = 'Editar Atributo';
            document.getElementById('formAtributo').action = ctxPath + '/AtualizarAtributo';
            document.getElementById('campoAtributoId').value = id;
            document.getElementById('campoAtributoAtributo').value = atributo;
            document.getElementById('campoAtributoTabela').value = tabela;
            document.getElementById('modalAtributo').classList.add('aberto');
        }

        function fecharModalAtributo() {
            document.getElementById('modalAtributo').classList.remove('aberto');
        }

        document.getElementById('modalAtributo').addEventListener('click', function(e) {
            if (e.target === this) fecharModalAtributo();
        });

        function filtrarTabela() {
            const busca = document.getElementById('campoBusca').value.toLowerCase();
            const linhas = document.querySelectorAll('#tabelaAtributos tbody tr');
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