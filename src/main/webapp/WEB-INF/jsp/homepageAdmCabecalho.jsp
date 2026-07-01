<%@page import="modelo.usuario.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.produto.Produto"%>
<%@page import="java.util.Map"%>
<%
if (session.getAttribute("usuario") != null && session.getAttribute("usuario") instanceof Usuario) {
    Usuario usuario = (Usuario) session.getAttribute("usuario"); 
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DashBoard</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/charts.css@1.2.0/dist/charts.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/barra_navegacao_adm.css">
    
    <style>
        * { box-sizing: border-box; }
        
        body, #conteudo {
            margin: 0;
            font-family: "Poppins", sans-serif !important; 
        }

        /* --- CONTAINER FLEXÍVEL (Corrige o alinhamento torto) --- */
        #pag {
            width: 90%;
            margin: 0 auto;
            display: flex;
            flex-wrap: wrap; /* Permite quebrar linha perfeitamente */
            justify-content: space-between;
        }

        #cabecalho {
            width: 100%;
            display: flex;
            gap: 20px;
            align-items: center;
            justify-content: flex-start;
            padding: 16px 0 8px 0;
            margin-bottom: 15px;
        }
        #cabecalho h1 {
            font-size: 2.2em !important;
            margin: 0 !important;
            white-space: nowrap;
        }

        /* --- CARDS (RETANGULARES COMO ANTES) --- */
        .dados {
            background-color: #fff;
            width: 32%; /* 3 cards lado a lado = ~96% */
            height: 160px; /* Altura retangular original */
            border-radius: 10px;
            box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.2);
            margin-bottom: 25px;
            display: flex;
            flex-direction: column;
        }

        .dados-chart {
            background-color: #fff;
            width: 100%; /* Card do gráfico mais largo */
            height: 330px; /* Mais alto */
            border-radius: 10px;
            box-shadow: 0px 0px 5px rgba(0, 0, 0, 0.2);
            margin-bottom: 25px;
            display: flex;
            flex-direction: column;
            overflow: auto;
        }

        /* Faz o último card "Vendas por time" ficar alto como o gráfico */
        .dados:last-of-type {
            height: 330px;
        }

        .titulo {
            margin-left: 20px;
            border-bottom: 1px solid #ccc;
        }

        .titulo p {
            font-size: 20px !important;
            font-weight: normal !important;
            margin: 15px 0 10px 0 !important;
        }

        /* --- CONTEÚDOS DOS CARDS --- */
        .cont {
            color: #170b9b;
            display: flex;
            align-items: center;
            justify-content: center;
            flex: 1; /* Centraliza perfeitamente o texto no resto do bloco */
        }
        
        .cont h3 {
            font-size: 32px;
            margin: 0;
        }

        #camisaV {
            display: flex;
            align-items: center;
            justify-content: center;
            flex: 1;
            padding: 0 15px;
        }

        .camisa {
            display: flex;
            align-items: center;
            gap: 15px;
            width: 100%;
        }

        .foto {
            width: 80px; 
            height: 90px; 
            background-color: #d9d9d9;
            border-radius: 5px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .foto img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        #descricao { flex: 1; }
        
        #descricao p {
            margin: 3px 0 !important;
            font-size: 15px !important;
        }
        #colunas {
    display: flex;
    width: 100%;
    height: 100%;
    position: relative;
}

.axis {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    list-style: none;
    margin: 0;
    padding: 0 10px 0 0; /* Espaço para não grudar no gráfico */
    height: 150%;
    font-size: 12px;
}

.charts-css.column {
    flex: 1;
    height: 100%;
    margin: 0;
}
        /* --- GRÁFICOS (MANTIDOS ORIGINAIS) --- */
        #grafico_coluna {
            height: 230px;
            width: 90%;
            margin: 0 auto;
            margin-top: 20px;
        }

        .charts-css.column td { color: transparent; }
        .charts-css.column th {
            font-weight: normal;
            font-size: 18px;
            text-align: center;
        }

        .charts-css.column td:hover {
            color: black;
            opacity: 0.8;
            filter: brightness(1.2);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        #grafico_pizza {
            height: 180px;
            width: 180px;
            margin: 0 auto;
            margin-top: 40px;
            align-items: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .charts-css.pie td {
            color: transparent;
            font-size: 30px;
            position: relative;
            margin-top: -30px;
        }
        
        .charts-css.pie tbody { background-color: transparent; }

        .legenda {
            display: flex;
            flex-direction: column;
            gap: 5px;
            font-size: 16px;
            margin-top: 10px;
        }
        
        .cor {
            display: inline-block;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            margin-right: 5px;
        }
    </style>
</head>