<%@page import="modelo.aux_venda_produto.AuxVendaProduto"%>
<%@page import="modelo.produto.Produto"%>
<%@page import="modelo.produto.ProdutoDAO"%>
<%@page import="modelo.venda.Venda"%>
<%@page import="java.util.List"%>
<%@page import="java.time.format.DateTimeFormatter"%>
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
    <title>Minhas Compras</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Contrail+One&display=swap" rel="stylesheet">
</head>
<style>
    html, body{
        margin: 0;
        font-family: "Contrail One", sans-serif;
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

    h1.titulo {
        margin-left: 2%;
        font-size: 2rem;
    }

    #pedidos {
        margin-left: 2%;
        margin-right: 2%;
        display: flex;
        flex-direction: column;
        gap: 20px;
        padding-bottom: 40px;
    }

    .pedido {
        background-color: white;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        border: 1px solid black;
        border-radius: 15px;
        padding: 15px 20px;
        font-family: sans-serif;
    }

    .pedido-cabecalho {
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #ddd;
        padding-bottom: 10px;
        margin-bottom: 10px;
    }

    .pedido-cabecalho h2 {
        font-family: "Contrail One", sans-serif;
        margin: 0;
        font-size: 1.3rem;
    }

    .pedido-item {
        display: flex;
        justify-content: space-between;
        padding: 6px 0;
    }

    .pedido-total {
        text-align: right;
        font-weight: bold;
        margin-top: 10px;
        padding-top: 10px;
        border-top: 1px solid #ddd;
    }

    .sem-compras {
        text-align: center;
        margin-top: 10%;
        font-size: 1.5rem;
        color: gray;
        font-family: sans-serif;
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
        <a href="<%= request.getContextPath()%>/secure/Carrinho">
            <img src="${pageContext.request.contextPath}/imagens/carrinho.svg" alt="ft de carrinho">
        </a>
    </div>
    <div class="linhavertical"></div>
    <span class="bemvindo">Bem-vindo(a), <%= usuario.getNome() %>!</span>
</div>

<h1 class="titulo">Minhas Compras</h1>

<%
List<Venda> vendas = (List<Venda>) request.getAttribute("vendas");
List<List<AuxVendaProduto>> itensPorVenda = (List<List<AuxVendaProduto>>) request.getAttribute("itensPorVenda");
ProdutoDAO produtoDAO = new ProdutoDAO();
DateTimeFormatter formatador = DateTimeFormatter.ofPattern("dd/MM/yyyy 'às' HH:mm");

if (vendas == null || vendas.isEmpty()) {
%>
    <p class="sem-compras">Você ainda não fez nenhuma compra.</p>
<%
} else {
%>
<div id="pedidos">
    <%
    for (int i = 0; i < vendas.size(); i++) {
        Venda venda = vendas.get(i);
        List<AuxVendaProduto> itens = itensPorVenda.get(i);
        double totalVenda = 0;
    %>
        <div class="pedido">
            <div class="pedido-cabecalho">
                <h2>Pedido #<%= venda.getId() %></h2>
                <span><%= venda.getDataHora().format(formatador) %></span>
            </div>
            <%
            if (itens != null) {
                for (AuxVendaProduto item : itens) {
                    Produto produto = produtoDAO.obter(item.getIdProduto());
                    double totalItem = item.getPreco() * item.getQuantidade();
                    totalVenda += totalItem;
            %>
                <div class="pedido-item">
                    <span><%= produto != null ? produto.getDescricao() : "Produto removido" %> (x<%= item.getQuantidade() %>)</span>
                    <span>R$ <%= String.format("%.2f", totalItem) %></span>
                </div>
            <%
                }
            }
            %>
            <p class="pedido-total">Total: R$ <%= String.format("%.2f", totalVenda) %></p>
        </div>
    <%
    }
    %>
</div>
<%
}
%>

</body>
</html>
<% } else { %>
<jsp:forward page="/IrLogin" />
<% } %>
