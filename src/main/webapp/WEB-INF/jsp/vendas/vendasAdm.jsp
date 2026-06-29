<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.format.DateTimeFormatter"%>

<%
DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
%>

<%@page import="modelo.venda.Venda"%>
<%@page import="modelo.venda.VendaDAO"%>

<%@page import="modelo.aux_venda_produto.AuxVendaProduto"%>
<%@page import="modelo.aux_venda_produto.AuxVendaProdutoDAO"%>

<%@page import="modelo.usuario.Usuario"%>
<%@page import="modelo.usuario.UsuarioDAO"%>

<%@page import="modelo.produto.Produto"%>
<%@page import="modelo.produto.ProdutoDAO"%>

<%
if (session.getAttribute("usuario") != null && session.getAttribute("usuario") instanceof Usuario) {
    Usuario usuario = (Usuario) session.getAttribute("usuario");
%>

<%
List<Venda> vendas = (List<Venda>) request.getAttribute("vendas");
AuxVendaProdutoDAO auxDAO = new AuxVendaProdutoDAO();
UsuarioDAO usuarioDAO = new UsuarioDAO();
ProdutoDAO produtoDAO = new ProdutoDAO();
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrador - Compras</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/barra_navegacao_adm.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/vendasAdm.css">
</head>
<body>
    <div id="cabecalhoAdm">
        <div class="pcima">
            <img id="profile" src="<%= request.getContextPath() %>/imagens/profile.svg" style="width: 3%; height: auto" alt="ft de perfil">
            <h1>Administrador: <%= usuario.getNome() %></h1>
        </div>
        <div class="plado">
            <div class="menu" style="width:15%;">
            <a href="<%= request.getContextPath()%>/admin/MyProfileAdm?id=<%= usuario.getId() %>">Editar Dados</a>
            <a href="<%= request.getContextPath()%>/admin/HomepageAdm">Dashboard</a>
            <div id="ativo">
                <img src="<%= request.getContextPath() %>/imagens/arrowright.svg" alt="seta direita">
                <a href="<%= request.getContextPath()%>/admin/ListarPorVendas">Compras</a>
            </div>
            <a href="<%= request.getContextPath()%>/admin/ListarTodosUsuarios">Cadastros</a>
            <a href="<%= request.getContextPath()%>/admin/Produto">Itens</a>
            <a href="<%= request.getContextPath()%>/admin/ListarCategoria">Categorias</a>
            <a href="<%= request.getContextPath()%>/admin/Competicoes">Tabelas</a>
            </div>
            
            <div class="conteudo" style="width: 85%" display: flex; flex-direction: column; align-items: center;>
                <div class="cabecalhocompras">
                    <h1>Compras</h1>
                    <div class="filtrar">
                        <img src="<%= request.getContextPath() %>/imagens/filter.svg" style="width: 26px; color: gray">
                        <select name="Filtro" id="filtragem" style="width: 100%; height: 100%" onchange="filtrarCadastro()">
                            <option value="selec">Selecione um filtro</option>
                            <option value="semana">Há uma semana</option>
                            <option value="mes">Há um mês</option>
                            <option value="ano">Há um ano</option>
                            <option value="mais">Há mais de um ano</option>
                        </select>
                    </div>
                </div>
                      
<%
if(vendas != null && !vendas.isEmpty()){ 
    for (Venda venda : vendas) {
        List<AuxVendaProduto> itens = auxDAO.obterPorVenda(venda.getId());
        for (AuxVendaProduto item : itens) {
            Produto produto = produtoDAO.obter(item.getIdProduto());
            Usuario comprador = usuarioDAO.obter(venda.getIdUsuario());
%>

                <div class="Compras" data-data="<%= venda.getDataHora() %>">
                    <div class="div1 " style="width:40%">
                        <p><span class = "%dados"><b>Id Venda: </b></span><%= venda.getId() %> </p>
                        <p><span class = "%dados"><b>Item: </b></span><%= produto.getDescricao() %> </p>
                        <p><span class = "dados"><b>Quantidade: </b></span> <%= item.getQuantidade()%>  </p>
                        <p><span class = "dados"><b>Preço total: </b></span> <%= item.getPreco() %> </p>
                    </div>
                    <div class="div2" style="width: 60%">
                        <p><span class = "dados"><b>Nome do comprador: </b></span> <%= comprador.getNome()%> </p>
                        <p><span class = "dados"><b>Endereço: </b></span> <%= comprador.getEndereco()%> </p>
                        <p><span class = "dados"><b>E-mail: </b></span> <%= comprador.getEmail()%> </p>
                        <p><span class = "dados"><b>Data da compra: </b></span> <%= venda.getDataHora().format(formato) %> </p>
                    </div>
                    <p><div class="acoes">
                        <a href="<%= request.getContextPath() %>/admin/DeletarAuxVendaProduto?id_venda=<%= venda.getId() %>"
                            onclick="return confirm('Deseja realmente remover esta venda?')" style="text-decoration:none;">
                            <img src="<%= request.getContextPath() %>/imagens/lixeira_preta.svg" alt="deletar" style="cursor:pointer;">
                        </a>
                        </div></p>
                </div>
<%
        }
    }
}else{
%>
<p style="padding: 2px; margin-left: 5%;">Nenhuma venda foi cadastrada</p>
<%
    }
%>
            </div>
        </div>
    </div>
            
   <script>
        function filtrarCadastro() {
            const filtro = document.getElementById("filtragem").value;
            const hoje = new Date();

            document.querySelectorAll(".Compras").forEach(card => {
                const dataStr = card.dataset.data;
                const data = new Date(dataStr);

                let diffMeses = (hoje - data) / (1000 * 60 * 60 * 24 * 30);
                let mostrar = false;
                if (filtro === "selec") {
                    mostrar = true;
                }if (filtro === "semana" && diffMeses <= 0.25) {
                    mostrar = true;
                }if (filtro === "mes" && diffMeses <= 1) {
                    mostrar = true;
                }if (filtro === "ano" && diffMeses <= 12) {
                    mostrar = true;
                }if (filtro === "mais" && diffMeses > 12) {
                    mostrar = true;
                }

                card.style.display = mostrar ? "flex" : "none";
                if (mostrar) {
                    card.style.flexDirection = "row";
                }
            });
        }
    </script>
</body>
</html>
<%
    } else {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
%>