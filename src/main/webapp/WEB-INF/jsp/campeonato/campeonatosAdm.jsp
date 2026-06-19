<%@include file="/WEB-INF/jsp/homepageAdmCabecalho.jsp"%>
<%@page import="java.util.List"%>
<%@page import="modelo.campeonato.Campeonato"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrador - Campeonatos</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@0,100;0,400;0,500;0,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/barra_navegacao_adm.css">
    <style>
        #pag { margin: 0 auto; width: 90%; }
        #cabecalho { height: 15%; width: 100%; display: flex; gap: 20px; align-items: center; justify-content: flex-start; }
        #cabecalho h1 { margin-top: 20px; font-size: 3.5em; display: inline-block; }
        #cabecalho .pesquisa { position: relative; width: 33%; height: 40px; }
        #cabecalho .pesquisa img { max-width: 7%; position: absolute; left: 1.5%; margin-top: 0.9%; }
        #cabecalho .pesquisa input { font-size: 1.5em; border: 1.5px solid gray; border-radius: 50px; padding-left: 10%; width: 100%; height: 93%; font-family: "Poppins", sans-serif; }
        #cabecalho button { display: flex; justify-content: center; align-items: center; margin-left: 50px; border-radius: 50px; background-color: #170b9b; color: white; width: 20%; height: 40px; font-size: 1.2em; cursor: pointer; font-family: "Poppins", sans-serif; border: none; gap: 8px; }
        #cabecalho button img { width: 2em; }
        #tabela { margin-top: 3%; }
        #tabela table { width: 80%; border-collapse: collapse; margin-top: 20px; }
        #tabela th, #tabela td { border: 1px solid gray; padding: 10px; text-align: center; font-family: "Poppins", sans-serif; }
        #tabela th { background-color: #170b9b; color: white; font-weight: bold; }
        #tabela button { width: 30%; cursor: pointer; border: none; background: none; }
        #tabela button img { width: 75%; }
        .msg-sucesso { background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; border-radius: 8px; padding: 10px 15px; margin-top: 10px; font-family: "Poppins", sans-serif; }
        .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 999; justify-content: center; align-items: center; }
        .modal-overlay.aberto { display: flex; }
        .modal { background: white; border-radius: 15px; padding: 30px; width: 400px; box-shadow: 0 4px 20px rgba(0,0,0,0.3); font-family: "Poppins", sans-serif; }
        .modal h2 { margin-top: 0; color: #170b9b; }
        .modal label { display: block; margin-top: 12px; font-weight: bold; font-size: 0.9em; }
        .modal input[type="text"] { width: 100%; padding: 8px 10px; border: 1.5px solid gray; border-radius: 8px; font-family: "Poppins", sans-serif; font-size: 1em; box-sizing: border-box; margin-top: 4px; }
        .modal-botoes { display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px; }
        .btn-cancelar { background: none; border: 1.5px solid gray; border-radius: 50px; padding: 8px 20px; cursor: pointer; font-family: "Poppins", sans-serif; font-size: 1em; }
        .btn-salvar { background-color: #170b9b; color: white; border: none; border-radius: 50px; padding: 8px 20px; cursor: pointer; font-family: "Poppins", sans-serif; font-size: 1em; }
    </style>
</head>
<body>
    <div class="pcima">
        <img id="profile" src="<%= request.getContextPath() %>/imagens/profile.svg" style="width: 3%; height: auto" alt="ft de perfil">
        <h1>Administrador</h1>
    </div>
    <div class="plado">
        <div class="menu" style="width:15%;">
            <a href="<%= request.getContextPath() %>/HomepageAdm">Dashboard</a>
            <a href="#">Compras</a>
            <a href="#">Cadastros</a>
            <a href="<%= request.getContextPath() %>/Produto">Itens</a>
            <a href="<%= request.getContextPath() %>/adm/ListarCategoriaServlet">Categorias</a>
            <a href="<%= request.getContextPath() %>/adm/ListarTimeServlet">Times</a>
            <div id="ativo">
                <img src="<%= request.getContextPath() %>/imagens/arrowright.svg" alt="seta direita">
                <a href="<%= request.getContextPath() %>/adm/ListarCampeonatoServlet">Campeonatos</a>
            </div>
        </div>

        <div class="conteudo" style="width: 85%">
            <div id="pag">
                <div id="cabecalho">
                    <h1>Campeonatos</h1>
                    <div class="pesquisa">
                        <img src="<%= request.getContextPath() %>/imagens/search.svg" alt="lupa">
                        <input type="text" id="campoBusca" placeholder="Buscar campeonato" onkeyup="filtrarTabela()">
                    </div>
                    <button onclick="abrirModalInserir()">
                        <img src="<%= request.getContextPath() %>/imagens/mais.svg" alt="mais">
                        <strong>Adicionar campeonato</strong>
                    </button>
                </div>

                <%
                    String msg = (String) request.getAttribute("msg");
                    if (msg != null) {
                %>
                    <div class="msg-sucesso"><%= msg %></div>
                <% } %>

                <div id="tabela">
                    <table id="tabelaCampeonatos">
                        <thead>
                            <tr>
                                <th>Nome</th>
                                <th>ID</th>
                                <th>Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Campeonato> campeonatos = (List<Campeonato>) request.getAttribute("campeonatos");
                                if (campeonatos != null && !campeonatos.isEmpty()) {
                                    for (Campeonato c : campeonatos) {
                            %>
                            <tr>
                                <td><%= c.getNome() %></td>
                                <td><%= c.getId() %></td>
                                <td>
                                    <a href="<%= request.getContextPath() %>/adm/DeletarCampeonatoServlet?id=<%= c.getId() %>"
                                       onclick="return confirm('Deseja realmente remover este campeonato?')">
                                        <button>
                                            <img src="<%= request.getContextPath() %>/imagens/lixeira_preta.svg" alt="deletar">
                                        </button>
                                    </a>
                                    <button onclick="abrirModalEditar(
                                        '<%= c.getId() %>',
                                        '<%= c.getNome().replace("'", "\\'") %>'
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
                                <td colspan="3">Nenhum campeonato cadastrado.</td>
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
            <h2 id="modalTitulo">Novo Campeonato</h2>
            <form method="POST" id="modalForm" action="">
                <input type="hidden" name="id" id="campoId">
                <label>Nome:</label>
                <input type="text" name="nome" id="campoNome" required>
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
            document.getElementById('modalTitulo').textContent = 'Novo Campeonato';
            document.getElementById('modalForm').action = ctxPath + '/adm/InserirCampeonatoServlet';
            document.getElementById('campoId').value = '';
            document.getElementById('campoNome').value = '';
            document.getElementById('modalOverlay').classList.add('aberto');
        }

        function abrirModalEditar(id, nome) {
            document.getElementById('modalTitulo').textContent = 'Editar Campeonato';
            document.getElementById('modalForm').action = ctxPath + '/adm/AtualizarCampeonatoServlet';
            document.getElementById('campoId').value = id;
            document.getElementById('campoNome').value = nome;
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
            const linhas = document.querySelectorAll('#tabelaCampeonatos tbody tr');
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
