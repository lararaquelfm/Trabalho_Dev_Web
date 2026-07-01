<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modelo.aux_camp_time.AuxCampTime"%>
<%@page import="modelo.campeonato.Campeonato"%>
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
    <title>Administrador</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/barra_navegacao_adm.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/auxCampTimeAdm.css">
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
                <a href="<%= request.getContextPath()%>/admin/ListarAuxCampTime">Relacionar Campeonato Time</a>
            </div>
            <a href="<%= request.getContextPath()%>/admin/ListarRelatorio">Relatorios</a>
        </div>

        <div class="conteudo" style="flex: 1; min-width: 0;">
            <div id="pag">
                <div id="cabecalho">
                    <h1>Times por Campeonato</h1>
                    <div class="pesquisa">
                        <img src="<%= request.getContextPath() %>/imagens/search.svg" alt="lupa">
                        <input type="text" id="campoBusca" placeholder="Buscar..." onkeyup="filtrarTabela()">
                    </div>
                    <button onclick="abrirModalInserir()">
                        <img src="<%= request.getContextPath() %>/imagens/mais.svg" alt="mais">
                        <strong>Vincular time</strong>
                    </button>
                </div>

                <%
                    String msg = (String) request.getAttribute("msg");
                    if (msg != null) {
                %>
                    <div class="msg-sucesso"><%= msg %></div>
                <% } %>

                <%
                    List<Time> times = (List<Time>) request.getAttribute("times");
                    List<Campeonato> campeonatos = (List<Campeonato>) request.getAttribute("campeonatos");
                %>

                <div id="tabela">
                    <table id="tabelaVinculos">
                        <thead>
                            <tr>
                                <th>Campeonato</th>
                                <th>Time</th>
                                <th>Ano</th>
                                <th>A&ccedil;&otilde;es</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<AuxCampTime> vinculos = (List<AuxCampTime>) request.getAttribute("vinculos");
                                if (vinculos != null && !vinculos.isEmpty()) {
                                    for (AuxCampTime v : vinculos) {
                                        String nomeCamp = String.valueOf(v.getIdCampeonato());
                                        if (campeonatos != null) {
                                            for (Campeonato c : campeonatos) {
                                                if (c.getId() == v.getIdCampeonato()) { nomeCamp = c.getNome(); break; }
                                            }
                                        }
                                        String nomeTime = String.valueOf(v.getIdTime());
                                        if (times != null) {
                                            for (Time t : times) {
                                                if (t.getId() == v.getIdTime()) { nomeTime = t.getNome(); break; }
                                            }
                                        }
                            %>
                            <tr>
                                <td><%= nomeCamp %></td>
                                <td><%= nomeTime %></td>
                                <td><%= v.getAno() %></td>
                                <td>
                                    <a href="<%= request.getContextPath() %>/admin/DeletarAuxCampTime?id_campeonato=<%= v.getIdCampeonato() %>&id_time=<%= v.getIdTime() %>"
                                       onclick="return confirm('Deseja realmente remover este v\u00ednculo?')">
                                        <button>
                                            <img src="<%= request.getContextPath() %>/imagens/lixeira_preta.svg" alt="deletar">
                                        </button>
                                    </a>
                                    <button onclick="abrirModalEditar('<%= v.getIdCampeonato() %>', '<%= v.getIdTime() %>', '<%= v.getAno() %>')">
                                        <img src="<%= request.getContextPath() %>/imagens/editar.svg" alt="editar">
                                    </button>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="4">Nenhum v&iacute;nculo cadastrado.</td>
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
            <h2 id="modalTitulo">Vincular Time a Campeonato</h2>
            <form method="POST" id="modalForm" action="">
                <input type="hidden" id="idCampeonatoOriginal" name="id_campeonato_original">
                <input type="hidden" id="idTimeOriginal" name="id_time_original">

                <label>Campeonato:</label>
                <select name="id_campeonato" id="campoCampeonato" required>
                    <option value="">Selecione...</option>
                    <%
                        if (campeonatos != null) {
                            for (Campeonato c : campeonatos) {
                    %>
                    <option value="<%= c.getId() %>"><%= c.getNome() %></option>
                    <%
                            }
                        }
                    %>
                </select>

                <label>Time:</label>
                <select name="id_time" id="campoTime" required>
                    <option value="">Selecione...</option>
                    <%
                        if (times != null) {
                            for (Time t : times) {
                    %>
                    <option value="<%= t.getId() %>"><%= t.getNome() %></option>
                    <%
                            }
                        }
                    %>
                </select>

                <label>Ano:</label>
                <input type="number" name="ano" id="campoAno" min="1900" max="2100" required>

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
            document.getElementById('modalTitulo').textContent = 'Vincular Time a Campeonato';
            document.getElementById('modalForm').action = ctxPath + '/admin/InserirAuxCampTime';
            document.getElementById('campoCampeonato').value = '';
            document.getElementById('campoTime').value = '';
            document.getElementById('campoAno').value = '';
            document.getElementById('campoCampeonato').disabled = false;
            document.getElementById('campoTime').disabled = false;
            document.getElementById('modalOverlay').classList.add('aberto');
        }

        function abrirModalEditar(idCampeonato, idTime, ano) {
            document.getElementById('modalTitulo').textContent = 'Editar V\u00ednculo';
            document.getElementById('modalForm').action = ctxPath + '/admin/AtualizarAuxCampTime';
            document.getElementById('campoCampeonato').value = idCampeonato;
            document.getElementById('campoTime').value = idTime;
            document.getElementById('campoAno').value = ano;
            document.getElementById('campoCampeonato').disabled = true;
            document.getElementById('campoTime').disabled = true;
            document.getElementById('idCampeonatoOriginal').value = idCampeonato;
            document.getElementById('idTimeOriginal').value = idTime;
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
            document.querySelectorAll('#tabelaVinculos tbody tr').forEach(function(linha) {
                linha.style.display = linha.textContent.toLowerCase().includes(busca) ? '' : 'none';
            });
        }
    </script>
</body>
</html>
<%
}
%>
