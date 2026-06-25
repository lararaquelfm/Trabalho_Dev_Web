<%@page import="modelo.usuario.Usuario"%>
<%@page import="modelo.produto.ProdutoDAO"%>
<%@page import="modelo.produto.Produto"%>
<%@page import="java.util.List"%>
<%@page import="modelo.categoria.Categoria"%>
<%@page import="modelo.time.Time"%>
<%@page import="modelo.foto.Foto" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("usuario") != null && session.getAttribute("usuario") instanceof Usuario) {
        Usuario usuario = (Usuario) session.getAttribute("usuario"); 
        int id = Integer.parseInt(request.getParameter("id"));
        ProdutoDAO produtoDAO = new ProdutoDAO();
        Produto produto = (Produto) produtoDAO.obter(id);
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
        <img id="profile" src="imagens/profile.svg" style="width: 3%; height: auto" alt="ft de perfil">
        <h1>Administrador: <%= usuario.getNome() %></h1>
    </div>
    <div class="plado">
        <div class="menu" style="width:15%;">
            <a href="<%= request.getContextPath()%>/admin/MyProfileAdm?id=<%= usuario.getId() %>">Editar Dados</a>
            <a href="<%= request.getContextPath()%>/admin/HomepageAdm">Dashboard</a>
            <a href="">Compras</a>
            <a href="">Cadastros</a>
            <div id="ativo">
                <img src="imagens/arrowright.svg" alt="seta direita">
                <a href="<%= request.getContextPath()%>/admin/Produto">Itens</a>
            </div>
            <a href="<%= request.getContextPath()%>/admin/ListarCategoria">Categorias</a>
            <a href="<%= request.getContextPath()%>/admin/Competicoes">Tabelas</a>
        </div>
        <div id="conteudo" style="width: 85%">
            <div id="pag">
                <div id="cabecalho">
                    <h1>Adicionar Foto</h1>
                </div>
                <form action="<%= request.getContextPath()%>/admin/AdicionarFotoBD?id=<%= produto.getId() %>" method="post" enctype="multipart/form-data">
                    <section class="card">
                    <div class="grade2">
                        <div class="col">
                            <div class="campo">
                                <strong>Id do Produto: <%=  produto.getId()%></strong>
                                <input type="hidden" name="id" value="<%= produto.getId()%>"
                            </div>
                            <div class="campo">
                                <strong>Descrição: <%=  produto.getDescricao()%></strong>
                            </div>
                        
                            <div class="campo">
                                <strong>Foto: </strong>
                                <input type="file" name="foto" class="form-control" id="formControlFoto" placeholder="Foto do Produto">
                            </div>
                        </div>
                    <input type="submit" class="botao-enviar" value="Adicionar Foto" />
                    </div>
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