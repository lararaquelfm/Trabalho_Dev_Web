<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        #pag { width: 90%; margin: 0 auto; }

        #cabecalho {
            width: 100%;
            display: flex;
            gap: 20px;
            align-items: center;
            justify-content: flex-start;
            padding: 16px 0 8px 0;
        }
        #cabecalho h1 {
            font-size: 2.2em;
            margin: 0;
            white-space: nowrap;
        }

        .cards {
            display: flex;
            gap: 30px;
            margin-top: 40px;
            flex-wrap: wrap;
        }

        .card {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 16px;
            background-color: #f5f5f5;
            border: 2px solid #e0e0e0;
            border-radius: 16px;
            width: 220px;
            height: 180px;
            cursor: pointer;
            text-decoration: none;
            color: #170b9b;
            font-family: "Poppins", sans-serif;
            font-weight: bold;
            font-size: 1.2em;
            transition: background-color 0.2s, border-color 0.2s, transform 0.1s;
        }
        .card:hover {
            background-color: #170b9b;
            border-color: #170b9b;
            color: white;
            transform: translateY(-3px);
        }
        .card img {
            width: 48px;
            height: 48px;
            filter: invert(13%) sepia(90%) saturate(3000%) hue-rotate(235deg);
        }
        .card:hover img {
            filter: brightness(0) invert(1);
        }
    </style>
</head>
<body>

    <div class="pcima">
        <img id="profile" src="<%= request.getContextPath() %>/imagens/profile.svg" style="width: 3%; height: auto" alt="ft de perfil">
        <h1>Administrador</h1>
    </div>

    <div class="plado">
        <div class="menu">
            <a href="HomepageAdm">Dashboard</a>
            <a href="ComprasAdm.html">Compras</a>
            <a href="CadastrosAdm.html">Cadastros</a>
            <a href="Produto">Itens</a>
            <a href="Categorias">Categorias</a>
            <div id="ativo">
                <img src="<%= request.getContextPath() %>/imagens/arrowright.svg" alt="seta direita">
                <a href="Competicoes">Competições</a>
            </div>
        </div>

        <div class="conteudo" style="width: 85%">
            <div id="pag">
                <div id="cabecalho">
                    <h1>Competições</h1>
                </div>

                <div class="cards">
                    <a class="card" href="Times">Times</a>
                    <a class="card" href="Campeonatos">Campeonatos</a>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
