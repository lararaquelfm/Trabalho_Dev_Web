<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modelo.time.Time"%>
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
    <style>
        /* CSS padronizado idêntico ao de Campeonatos */
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
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb; border-radius: 8px;
            padding: 10px 15px; margin-top: 10px;
            font-family: "Poppins", sans-serif;
        }

        .modal-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.5); z-index: 999;
            justify-content: center; align-items: center;
        }
        .modal-overlay.aberto { display: flex; }
        .modal {
            background: white;
            border-radius: 15px;
            padding: 30px; width: 400px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.3);
            font-family: "Poppins", sans-serif;
        }
        .modal h2 { margin-top: 0; color: #170b9b; }
        .modal label { display: block; margin-top: 12px; font-weight: bold; font-size: 0.9em; }
        .modal input[type="text"],
        .modal input[type="number"],
        .modal select {
            width: 100%;
            padding: 8px 10px;
            border: 1.5px solid gray; border-radius: 8px;
            font-family: "Poppins", sans-serif; font-size: 1em;
            box-sizing: border-box; margin-top: 4px;
        }
        .modal-botoes { display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px; }
        .btn-cancelar {
            background: none;
            border: 1.5px solid gray; border-radius: 50px;
            padding: 8px 20px; cursor: pointer;
            font-family: "Poppins", sans-serif; font-size: 1em;
        }
        .btn-salvar {
            background-color: #170b9b;
            color: white; border: none;
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
                <a href="Times">Times</a>
            </div>
        </div>

        <div class="conteudo" style="width: 85%">
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
                                    <a href="<%= request.getContextPath() %>/adm/DeletarTimeServlet?id=<%= t.getId() %>"
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
            document.getElementById('formTime').action = ctxPath + '/adm/InserirTimeServlet';
            document.getElementById('campoTimeId').value = '';
            document.getElementById('campoTimeNome').value = '';
            document.getElementById('campoTimeNacionalidade').value = '';
            document.getElementById('modalTime').classList.add('aberto');
        }

        function abrirModalEditarTime(id, nome, nacionalidade) {
            document.getElementById('tituloTime').textContent = 'Editar Time';
            document.getElementById('formTime').action = ctxPath + '/adm/AtualizarTimeServlet';
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