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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/barra_navegacao.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/carrinho.css">
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
        <img id="carrinho" src="<%= request.getContextPath() %>/imagens/carrinho.svg" style="width: 100%; height: auto" alt="ft de carrinho">
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
                            <img src="<%= request.getContextPath() %>/imagens/lixeira.png" alt="Remover">
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
