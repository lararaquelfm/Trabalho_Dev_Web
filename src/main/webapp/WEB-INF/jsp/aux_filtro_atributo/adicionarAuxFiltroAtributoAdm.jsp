<%@page import="modelo.atributo.Atributo"%>
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
            <a href="">Compras</a>
            <a href="">Cadastros</a>
            <a href="<%= request.getContextPath()%>/admin/Produto">Itens</a>
            <a href="<%= request.getContextPath()%>/admin/ListarCategoria">Categorias</a>
            <a href="<%= request.getContextPath()%>/admin/Competicoes">Tabelas</a>
            <a href="<%= request.getContextPath()%>/admin/ListarCampeonato">Campeonatos</a>
            <div id="ativo">
                <img src="<%= request.getContextPath() %>/imagens/arrowright.svg" alt="seta direita">
                <a href="<%= request.getContextPath()%>/admin/ListarAuxFiltroAtributo">Relacionar Filtro e Atributo</a>
            </div>
            <a href="<%= request.getContextPath()%>/admin/ListarRelatorio">Relatorios</a>
        </div>
        <div id="conteudo" style="width: 85%">
            <div id="pag">
                <div id="cabecalho">
                    <h1>Adicionar Relação</h1>
                </div>
                <form action="<%= request.getContextPath()%>/admin/AdicionarAuxFiltroAtributoBD" method="post">
                    <section class="card">
                    <div class="grade">
                        <div class="col">
                            <div class="campo">
                                <label for="formControlCategoria" class="form-label"><strong>Filtro:</strong></label>
                                <select name="filtroId" style="background: url(${pageContext.request.contextPath}/imagens/arrowdown.svg) no-repeat center right 10px;">
                                    <option value="">Selecione...</option>
                                    <%
                                        List<Filtro> filtros = (List<Filtro>) request.getAttribute("filtros");
                                        for (Filtro filtro : filtros) {
                                    %>
                                    <option value="<%= filtro.getId() %>"><%= filtro.getNome() %></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <div class="campo">
                            <label for="formControlCategoria" class="form-label"><strong>Atributo: </strong></label>
                            <select name="atributoId" style="background: url(${pageContext.request.contextPath}/imagens/arrowdown.svg) no-repeat center right 10px;">
                                <option value="">Selecione...</option>
                                <%
                                    List<Atributo> atributos = (List<Atributo>) request.getAttribute("atributos");
                                    for (Atributo atributo : atributos) {
                                %>
                                <option value="<%= atributo.getId() %>"><%= atributo.getAtributo() %></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <input type="submit" class="botao-enviar" value="Inserir nova relação" />
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