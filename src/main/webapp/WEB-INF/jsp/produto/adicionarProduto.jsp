<%@page import="modelo.usuario.Usuario"%>
<%@page import="java.util.List"%>
<%@page import="modelo.categoria.Categoria"%>
<%@page import="modelo.time.Time"%>
<%@page import="modelo.foto.Foto" %>
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
        <div class="menu" style="width:15%;">
            <a href="<%= request.getContextPath()%>/admin/MyProfileAdm?id=<%= usuario.getId() %>">Editar Dados</a>
            <a href="<%= request.getContextPath()%>/admin/HomepageAdm">Dashboard</a>
            <a href="<%= request.getContextPath()%>/admin/ListarPorVendas">Compras</a>
            <a href="<%= request.getContextPath()%>/admin/ListarTodosUsuarios">Cadastros</a>
            <div id="ativo">
                <img src="${pageContext.request.contextPath}/imagens/arrowright.svg" alt="seta direita">
                <a href="<%= request.getContextPath()%>/admin/ItensAdm.html">Itens</a>
            </div>
            <a href="<%= request.getContextPath()%>/admin/ListarCategoria">Categorias</a>
            <a href="<%= request.getContextPath()%>/admin/Competicoes">Tabelas</a>
            <a href="<%= request.getContextPath()%>/admin/ListarRelatorio">Relatorios</a>
        </div>
        <div id="conteudo" style="width: 85%">
            <div id="pag">
                <div id="cabecalho">
                    <h1>Adicionar Item</h1>
                </div>
                <form action="<%= request.getContextPath()%>/admin/InserirProdutoBD" method="post">
                    <section class="card">
                    <div class="grade">
                        <div class="col">
                            <div class="campo">
                                <strong>Descrição:</strong>
                                <input type="text" name="descricao" id="profileControlDescricao" placeholder="Digite a descrição do produto" value="" required>   
                            </div>  
                            <div class="campo">
                                <strong>Tamanho:</strong>
                                <input type="text" name="tamanho" id="profileControlTamanho" placeholder="Digite o tamanho do produto" value="" required>
                            </div>
                            <div class="campo">
                                <strong>Preço:</strong>
                                <input type="text" name="preco" id="profileControlPreco" placeholder="Digite o preço do produto" value="" required>
                            </div>
                            <div class="campo">
                                <strong>Quantidade:</strong>
                                <input type="number" name="quantidade" id="profileControlQuantidade" placeholder="Digite a quantidade do produto" value="" required>
                            </div>
                        </div>
                        <div class="col">
                            <div class="campo">
                                <label for="formControlCategoria" class="form-label"><strong>Categoria:</strong></label>
                                <select name="categoriaId" style="background: url(${pageContext.request.contextPath}/imagens/arrowdown.svg) no-repeat center right 10px;">
                                    <option value="">Selecione...</option>
                                    <%
                                        List<Categoria> categorias = (List<Categoria>) request.getAttribute("categorias");
                                        for (Categoria categoria : categorias) {
                                    %>
                                    <option value="<%= categoria.getId() %>"><%= categoria.getNome() %></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div> 
                            <div class="campo">
                                <label for="formControlTime" class="form-label"><strong>Time:</strong></label>
                                <select name="timeId" style="background: url(${pageContext.request.contextPath}/imagens/arrowdown.svg) no-repeat center right 10px;">
                                    <option value="">Selecione...</option>
                                    <%
                                        List<Time> times = (List<Time>) request.getAttribute("times");
                                        for (Time time : times) {
                                    %>
                                    <option value="<%= time.getId() %>"><%= time.getNome() %></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                    </div>
                    <input type="submit" class="botao-enviar" value="Inserir novo produto" />
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