<%@page import="modelo.usuario.Usuario"%>
<%@page import="java.util.List"%>
<%@page import="modelo.aux_filtro_atributo.AuxFiltroAtributo"%>
<%@page import="modelo.filtro.Filtro"%>
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/barra_navegacao_adm.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adicionarProduto.css">
</head>
<body>
     <div class="pcima">
        <img id="profile" src="${pageContext.request.contextPath}/imagens/profile.svg" style="width: 3%; height: auto" alt="ft de perfil">
        <h1>Administrador</h1>
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
        <div id="conteudo" style="width: 85%">
            <div id="pag">
                <div id="cabecalho">
                    <h1>Relatório Compras</h1>
                </div>
                <form action="<%= request.getContextPath()%>/admin/RelatorioCompras" method="post">
                    <section class="card">
                    <div class="grade">
                        <div class="col">
                            <div class="campo">
                                <strong>Data de início:</strong>
                                <input type="date" name="dataInicio" id="profileControldatai" required>
                            </div>
                        </div>
                        <div class="col">
                            <div class="campo">
                                <strong>Data de fim</strong>
                                <input type="date" name="dataFim" id="profileControldataf" required>
                            </div>
                        </div>
                    </div>
                    <input type="submit" class="botao-enviar" value="Gerar Relatório" />
                    </section>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
<%
    }  
%>