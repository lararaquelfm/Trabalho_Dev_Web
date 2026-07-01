<%@page import="modelo.usuario.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
if (session.getAttribute("usuario") != null && session.getAttribute("usuario") instanceof Usuario) {
    Usuario usuario = (Usuario) session.getAttribute("usuario");
%>
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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/competicoesAdm.css">
</head>
<body>

    <div class="pcima">
        <img id="profile" src="<%= request.getContextPath() %>/imagens/profile.svg" style="width: 3%; height: auto" alt="ft de perfil">
        <h1>Administrador: <%= usuario.getNome() %></h1>
    </div>

    <div class="plado">
        <div class="menu">
            <a href="<%= request.getContextPath()%>/admin/MyProfileAdm?id=<%= usuario.getId() %>">Editar Dados</a>
            <a href="<%= request.getContextPath()%>/admin/HomepageAdm">Dashboard</a>
            <a href="<%= request.getContextPath()%>/admin/ListarPorVendas">Compras</a>
            <a href="<%= request.getContextPath()%>/admin/ListarTodosUsuarios">Cadastros</a>
            <a href="<%= request.getContextPath()%>/admin/Produto">Itens</a>
            <a href="<%= request.getContextPath()%>/admin/ListarCategoria">Categorias</a>
            <a href="<%= request.getContextPath()%>/admin/Competicoes">Tabelas</a>
            <div id="ativo">
                <img src="<%= request.getContextPath() %>/imagens/arrowright.svg" alt="seta direita">
                <a href="<%= request.getContextPath()%>/admin/ListarRelatorio">Relatorios</a>
            </div>
        </div>

        <div class="conteudo" style="flex: 1; min-width: 0;">
            <div id="pag">
                <div id="cabecalho">
                    <h1>Relatórios Gerenciais</h1>
                </div>

                <div class="cards">
                    <a class="card" href="<%= request.getContextPath()%>/admin/TotalComprasCliente" style="text-align: center; padding: 5px;">Total de Compras Por Cliente</a>
                    <a class="card" href="<%= request.getContextPath()%>/admin/ProdutosEmFalta" style="text-align: center; padding: 5px;">Produtos Em Falta No Estoque</a>
                    <a class="card" href="<%= request.getContextPath()%>/admin/ValorTotalDias" style="text-align: center; padding: 5px;">Valor Total Recebido Por Dia</a
                </div>
            </div>
        </div>
    </div>

</body>
</html>
<%
}
%>