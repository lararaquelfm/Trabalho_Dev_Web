<%@page import="modelo.produto.Produto"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.usuario.Usuario"%>
<%
if (session.getAttribute("usuario") != null && session.getAttribute("usuario") instanceof Usuario) {
    Usuario usuario = (Usuario) session.getAttribute("usuario");
%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Carrinho</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Contrail+One&display=swap" rel="stylesheet">
</head>
<style>
    html, body{
        margin: 0;
        font-family: "Contrail One", sans-serif;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    #cabecalho {
        background-color: #170b9b;
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        height: 6vh;
        padding-left: 1%;
    }

    .botoes{
        width: 40px;
        position: relative;
        margin-right: 1%;
        cursor: pointer;
        img{
            width: 100%;
        }
    }

    .linhavertical{
        border-left: 3.1px solid white;
        height: 20px;
        margin: 0 15px;
        display: inline-block;
    }

    .bemvindo{
        font-size: 120%;
        color: #FFFF;
    }

    .pesquisa{
        position: relative;
        margin-left: auto;
        margin-right: 2%;
        width: 30%;
        max-width: 400px;
        height: 30px;
        img{
            position: absolute;
            left: 1%;
            margin-top: 6px;
        }
        input{
            border-radius: 15px;
            padding-left: 30px;
            width: 100%;
            height: 100%;
        }
    }

    #camisas{
        margin-left: 2%;
        margin-right: 2%;
        display: flex;
        flex-wrap: wrap;
        flex-direction: column;
        gap: 10px;
        padding: 10px;
        padding-bottom: 120px;
    }

    .camisa{
        background-color: white;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        width: calc(95%);
        color: black;
        border: 1px solid black;
        border-radius: 15px;
        padding: 15px;
        display: flex;
        align-items: center;
        gap: 30px;
    }

    .camisa img {
        max-width: 100px;
        height: auto;
    }

    .camisa-detalhes h1 {
        font-size: 1.45rem;
        margin: 0;
    }

    .lado-direito {
        display: flex;
        flex-direction: column;
        align-items: flex-end;
        margin-left: auto;
        gap: 20px;
    }

    .camisa-controles {
        display: flex;
        align-items: center;
        gap: 15px;
        margin: 0;
    }

    .camisa-detalhes p{
        font-family: sans-serif;
        font-size: 1.2rem;
        margin: 0;
        text-align: right;
    }

    .camisa-detalhes {
        display: flex;
        flex-direction: row;
        align-items: flex-start;
        width: 100%;
        justify-content: space-between;
    }

    .lado-esquerdo {
        display: flex;
        flex-direction: column;
        gap: 10px;
    }

    .controle-item {
        display: flex;
        justify-content: center;
        align-items: center;
        width: 36px;
        height: 36px;
        background-color: #170b9b;
        border-radius: 50%;
        color: white;
        font-weight: bold;
        font-size: 1.2rem;
        cursor: pointer;
        border: none;
        padding: 0;
        text-decoration: none;
    }

    .controle-item img {
        width: 30px;
        display: block;
    }

    #concluir {
        position: fixed;
        background-color: white;
        bottom: 0;
        left: 0;
        z-index: 10;
        display: flex;
        flex-wrap: wrap;
        height: 12%;
        margin-bottom: 0;
        border: 1px solid black;
        align-items: center;
        width: 100%;
        box-sizing: border-box;
    }

    #concluir .lado-direito {
        margin-left: auto;
        margin-right: 2%;
        display: flex;
        flex-direction: column;
        align-items: flex-end;
        gap: 10px;
    }

    .botao-finalizar {
        color: white;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #170b9b;
        border-radius: 10px;
        margin: 0;
        height: 40px;
        width: 200px;
        cursor: pointer;
        text-decoration: none;
    }

    .valor-total {
        font-family: sans-serif;
        font-size: 1.2rem;
        text-align: left;
        margin: 0;
    }

    .carrinho-vazio {
        text-align: center;
        margin-top: 10%;
        font-size: 1.5rem;
        color: gray;
    }
</style>
<body>

<div id="cabecalho">
    <div class="botoes">
        <a href="<%= request.getContextPath()%>/secure/Homepage">
            <img src="${pageContext.request.contextPath}/imagens/home.svg" alt="ft da home">
        </a>
    </div>
    <div class="botoes">
        <a href="<%= request.getContextPath()%>/secure/MyProfile?id=<%= usuario.getId() %>">
            <img src="${pageContext.request.contextPath}/imagens/profile.svg" alt="ft de perfil">
        </a>
    </div>
    <div class="botoes">
        <img src="${pageContext.request.contextPath}/imagens/carrinho.svg" alt="ft de carrinho">
    </div>
    <div class="linhavertical"></div>
    <span class="bemvindo">Bem-vindo(a), <%= usuario.getNome() %>!</span>
</div>

<%
String mensagem = (String) request.getAttribute("mensagem");
if (mensagem != null) {
%>
    <p style="text-align: center; color: red; font-family: sans-serif; margin-top: 10px;"><%= mensagem %></p>
<%
}
%>

<%
List<Produto> produtos = (List<Produto>) request.getAttribute("produtos");
List<Integer> quantidades = (List<Integer>) request.getAttribute("quantidades");
Double valorTotal = (Double) request.getAttribute("valorTotal");

if (produtos == null || produtos.isEmpty()) {
%>
    <p class="carrinho-vazio">Seu carrinho está vazio.</p>
<%
} else {
%>
<div id="camisas">
    <%
    for (int i = 0; i < produtos.size(); i++) {
        Produto p = produtos.get(i);
        int quantidade = quantidades.get(i);
        double totalItem = p.getPreco() * quantidade;
    %>
        <div class="camisa">
            <img src="<%= request.getContextPath() %>/MostrarProduto?id=<%= p.getId() %>" alt="<%= p.getDescricao() %>">

            <div class="camisa-detalhes">
                <div class="lado-esquerdo">
                    <h1><%= p.getDescricao() %></h1>
                    <p style="font-family: sans-serif; text-align: left;">Tamanho: <%= p.getTamanho() %></p>
                </div>

                <div class="lado-direito">
                    <div class="camisa-controles">
                        <a class="controle-item" href="<%= request.getContextPath() %>/secure/RemoverCarrinho?id=<%= p.getId() %>">
                            <img src="${pageContext.request.contextPath}/imagens/lixeira.png" alt="Remover">
                        </a>
                        <a class="controle-item" href="<%= request.getContextPath() %>/secure/AtualizarQuantidadeCarrinho?id=<%= p.getId() %>&quantidade=<%= quantidade - 1 %>">-</a>
                        <div class="controle-item" style="background-color: white; color: black; cursor: default;"><%= quantidade %></div>
                        <a class="controle-item" href="<%= request.getContextPath() %>/secure/AtualizarQuantidadeCarrinho?id=<%= p.getId() %>&quantidade=<%= quantidade + 1 %>">+</a>
                    </div>
                    <p><strong>Total:</strong> R$ <%= String.format("%.2f", totalItem) %></p>
                </div>
            </div>
        </div>
    <%
    }
    %>
</div>

<div id="concluir">
    <div class="lado-direito">
        <div class="botao-finalizar" onclick="window.location.href='<%= request.getContextPath() %>/secure/FinalizarCompra'">
            <p>Finalizar Compra</p>
        </div>
        <p class="valor-total"><strong>Total</strong>: R$ <%= String.format("%.2f", valorTotal) %></p>
    </div>
</div>
<%
}
%>

</body>
</html>
<% } else { %>
<jsp:forward page="/IrLogin" />
<% } %>
