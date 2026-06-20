<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modelo.campeonato.Campeonato"%>
<%@page import="modelo.aux_camp_time.AuxCampTime"%>
<%@page import="modelo.time.Time"%>
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
    <style>
        /* O menu ocupa 10% (definido no CSS global).
           O conteudo ocupa o restante automaticamente.
           Usamos overflow:hidden para não vazar. */
        

        #pag { width: 95%; margin: 0 auto; }

        #cabecalho {
            width: 100%;
            display: flex;
            gap: 12px;
            align-items: center;
            justify-content: flex-start;
            flex-wrap: nowrap;
            padding: 16px 0 8px 0;
        }
        #cabecalho h1 {
            font-size: 2.2em;
            margin: 0;
            white-space: nowrap;
        }
        #cabecalho .pesquisa {
            position: relative;
            width: 220px;
            flex-shrink: 0;
            height: 38px;
        }
        #cabecalho .pesquisa img {
            width: 16px;
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
        }
        #cabecalho .pesquisa input {
            font-size: 0.95em;
            border: 1.5px solid gray;
            border-radius: 50px;
            padding-left: 34px;
            width: 100%;
            height: 100%;
            font-family: "Poppins", sans-serif;
            box-sizing: border-box;
        }
        #cabecalho button {
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 50px;
            background-color: #170b9b;
            color: white;
            height: 38px;
            padding: 0 16px;
            font-size: 0.95em;
            cursor: pointer;
            font-family: "Poppins", sans-serif;
            border: none;
            gap: 6px;
            white-space: nowrap;
            flex-shrink: 0;
        }
        #cabecalho button img { width: 1.4em; }
        #cabecalho button.btn-verde { background-color: #2e7d32; }

        #tabela { margin-top: 3%; }
        #tabela table { width: 80%; border-collapse: collapse; margin-top: 20px; }
        #tabela th, #tabela td {
            border: 1px solid gray;
            padding: 10px;
            text-align: center;
            font-family: "Poppins", sans-serif;
        }
        #tabela th { background-color: #170b9b; color: white; font-weight: bold; }
        #tabela button { width: 30%; cursor: pointer; border: none; background: none; }
        #tabela button img { width: 75%; }

        .msg-sucesso {
            background-color: #d4edda; color: #155724;
            border: 1px solid #c3e6cb; border-radius: 8px;
            padding: 10px 15px; margin-top: 10px;
            font-family: "Poppins", sans-serif;
        }

        .modal-overlay {
            display: none; position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.5); z-index: 999;
            justify-content: center; align-items: center;
        }
        .modal-overlay.aberto { display: flex; }
        .modal {
            background: white; border-radius: 15px;
            padding: 30px; width: 400px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
            font-family: "Poppins", sans-serif;
        }
        .modal h2 { margin-top: 0; color: #170b9b; }
        .modal label { display: block; margin-top: 12px; font-weight: bold; font-size: 0.9em; }
        .modal input[type="text"],
        .modal input[type="number"],
        .modal select {
            width: 100%; padding: 8px 10px;
            border: 1.5px solid gray; border-radius: 8px;
            font-family: "Poppins", sans-serif; font-size: 1em;
            box-sizing: border-box; margin-top: 4px;
        }
        .modal-botoes { display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px; }
        .btn-cancelar {
            background: none; border: 1.5px solid gray; border-radius: 50px;
            padding: 8px 20px; cursor: pointer;
            font-family: "Poppins", sans-serif; font-size: 1em;
        }
        .btn-salvar {
            background-color: #170b9b; color: white; border: none;
            border-radius: 50px; padding: 8px 20px; cursor: pointer;
            font-family: "Poppins", sans-serif; font-size: 1em;
        }
    </style>
</head>
<body>

    <div class="pcima">
        <img id="profile" src="<%= request.getContextPath() %>/imagens/profile.svg" style="width: 3%; height: auto" alt="ft de perfil">
        <h1>Administrador</h1>
    </div>

    <div class="plado">
        <div class="menu" style="width:15%;">
            <a href="HomepageAdm">Dashboard</a>
            <a href="ComprasAdm.html">Compras</a>
            <a href="CadastrosAdm.html">Cadastros</a>
            <a href="Produto">Itens</a>
            <a href="Categorias">Categorias</a>
            <a href="Competicoes">Competições</a>
            <div id="ativo">
                <img src="<%= request.getContextPath() %>/imagens/arrowright.svg" alt="seta direita">
                <a href="Campeonatos">Campeonatos</a>
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
                    <button onclick="abrirModalCampeonato()">
                        <img src="<%= request.getContextPath() %>/imagens/mais.svg" alt="mais">
                        <strong>Novo campeonato</strong>
                    </button>
                    <button class="btn-verde" onclick="abrirModalVincularTime()">
                        <img src="<%= request.getContextPath() %>/imagens/mais.svg" alt="mais">
                        <strong>Adicionar time</strong>
                    </button>
                </div>

                <%
                    String msg = (String) request.getAttribute("msg");
                    if (msg != null) {
                %>
                    <div class="msg-sucesso"><%= msg %></div>
                <% } %>

                <%
                    List<Campeonato> campeonatos = (List<Campeonato>) request.getAttribute("campeonatos");
                    List<Time> times = (List<Time>) request.getAttribute("times");
                %>

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

    <%-- Modal: Criar / Editar Campeonato --%>
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

    <%-- Modal: Vincular Time ao Campeonato --%>
    <div class="modal-overlay" id="modalVinculo">
        <div class="modal">
            <h2 id="tituloVinculo">Adicionar Time ao Campeonato</h2>
            <form method="POST" id="formVinculo" action="">
                <input type="hidden" id="idCampeonatoOriginal" name="id_campeonato_original">
                <input type="hidden" id="idTimeOriginal"       name="id_time_original">

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
                    <button type="button" class="btn-cancelar" onclick="fecharModalVinculo()">Cancelar</button>
                    <button type="submit" class="btn-salvar">Salvar</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const ctxPath = '<%= request.getContextPath() %>';

        function abrirModalCampeonato() {
            document.getElementById('tituloCampeonato').textContent = 'Novo Campeonato';
            document.getElementById('formCampeonato').action = ctxPath + '/adm/InserirCampeonatoServlet';
            document.getElementById('campoCampId').value = '';
            document.getElementById('campoCampNome').value = '';
            document.getElementById('modalCampeonato').classList.add('aberto');
        }
        function abrirModalEditarCampeonato(id, nome) {
            document.getElementById('tituloCampeonato').textContent = 'Editar Campeonato';
            document.getElementById('formCampeonato').action = ctxPath + '/adm/AtualizarCampeonatoServlet';
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

        function abrirModalVincularTime() {
            document.getElementById('tituloVinculo').textContent = 'Adicionar Time ao Campeonato';
            document.getElementById('formVinculo').action = ctxPath + '/adm/InserirAuxCampTimeServlet';
            document.getElementById('campoCampeonato').value = '';
            document.getElementById('campoTime').value = '';
            document.getElementById('campoAno').value = '';
            document.getElementById('campoCampeonato').disabled = false;
            document.getElementById('campoTime').disabled = false;
            document.getElementById('modalVinculo').classList.add('aberto');
        }
        function abrirModalEditarVinculo(idCampeonato, idTime, ano) {
            document.getElementById('tituloVinculo').textContent = 'Editar Vínculo';
            document.getElementById('formVinculo').action = ctxPath + '/adm/AtualizarAuxCampTimeServlet';
            document.getElementById('campoCampeonato').value = idCampeonato;
            document.getElementById('campoTime').value = idTime;
            document.getElementById('campoAno').value = ano;
            document.getElementById('campoCampeonato').disabled = true;
            document.getElementById('campoTime').disabled = true;
            document.getElementById('idCampeonatoOriginal').value = idCampeonato;
            document.getElementById('idTimeOriginal').value = idTime;
            document.getElementById('modalVinculo').classList.add('aberto');
        }
        function fecharModalVinculo() {
            document.getElementById('modalVinculo').classList.remove('aberto');
        }
        document.getElementById('modalVinculo').addEventListener('click', function(e) {
            if (e.target === this) fecharModalVinculo();
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
