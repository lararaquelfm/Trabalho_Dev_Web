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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/barra_navegacao.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/minhasCompras.css">
</head>
<body>

<div id="barraNavegacao">
    <div class="botoes">
        <a onclick="toggleMenu(event)" alt="Menu"><img id="profile" src="<%= request.getContextPath() %>/imagens/profile.svg" style="width: 100%; height: auto" alt="ft de perfil"></a>
    </div>
    <div class="botoes">
        <a href="<%= request.getContextPath() %>/secure/Homepage">
            <img id="home" src="<%= request.getContextPath() %>/imagens/home.svg" style="width: 100%; height: auto" alt="ft da home">
        </a>
    </div>
    <div class="botoes">
        <a href="<%= request.getContextPath() %>/secure/Carrinho">
            <img id="carrinho" src="<%= request.getContextPath() %>/imagens/carrinho.svg" style="width: 100%; height: auto" alt="ft de carrinho">
        </a>
    </div>
    <div class="linhavertical"></div>
    <span class="bemvindo">Bem-vindo(a), <%= usuario.getNome() %>!</span>
    <div class="pesquisa">
        <a href="<%= request.getContextPath() %>/secure/PaginaPesquisa">
            <img src="<%= request.getContextPath() %>/imagens/search.svg" style="width: 100%; height: auto" alt="lupa de pesquisa">
            <input type="text" class="desativar" style="width: 100%; height: 100%;">
        </a>
    </div>
</div>

<div id="Menu" class="menulateral">
    <div class="itens_menu_lateral">
        <a href="<%= request.getContextPath() %>/secure/MinhasCompras"><img src="<%= request.getContextPath() %>/imagens/arrowright.svg" alt="">Meus pedidos</a>
        <a href="<%= request.getContextPath() %>/secure/MyProfile?id=<%= usuario.getId() %>"><img src="<%= request.getContextPath() %>/imagens/arrowright.svg" alt="">Meus dados</a>
        <div class="sair">
            <a href="<%= request.getContextPath() %>/secure/Logout" style="padding-top: 35px; padding-bottom: 20px;"><img src="<%= request.getContextPath() %>/imagens/logout.svg" alt="">Sair</a>
        </div>
        <div class="deletar">
            <a href="<%= request.getContextPath() %>/secure/DeletarUsuario?id=<%= usuario.getId() %>"><img src="<%= request.getContextPath() %>/imagens/lixeira_preta.svg" alt="">Deletar perfil</a>
        </div>
    </div>
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

<script>
    function toggleMenu(event) {
        if (event) event.preventDefault();
        document.getElementById("Menu").classList.toggle("active");
    }
</script>

</body>
</html>
<% } else { %>
<jsp:forward page="/IrLogin" />
<% } %>
