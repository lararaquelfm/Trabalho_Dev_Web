<%@page import="modelo.usuario.Usuario"%>
<%@page import="java.util.Comparator"%>
<%@page import="modelo.foto.FotoDAO"%>
<%@page import="modelo.foto.Foto"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/barra_navegacao_adm.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/produtos.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/mensagem.css">
</head>
<body>
        <div class="pcima">
            <img id="profile" src="${pageContext.request.contextPath}/imagens/profile.svg" style="width: 3%; height: auto" alt="ft de perfil">
            <h1>Administrador: <%= usuario.getNome() %></h1>
        </div>
        <div class="plado">
            <div class="menu" style="width:15%;">
                <a href="<%= request.getContextPath()%>/admin/MyProfileAdm?id=<%= usuario.getId() %>">Editar Dados</a>
                <a href="<%= request.getContextPath()%>/admin/HomepageAdm">Dashboard</a>
                <a href="">Compras</a>
                <a href="">Cadastros</a>
                <div id="ativo">
                    <img src="${pageContext.request.contextPath}/imagens/arrowright.svg" alt="seta direita">
                    <a href="<%= request.getContextPath()%>/admin/Produto">Itens</a>
                </div>
                <a href="<%= request.getContextPath()%>/admin/ListarCategoria">Categorias</a>
                <a href="<%= request.getContextPath()%>/admin/Competicoes">Tabelas</a>
            </div>
            <div class="conteudo" style="width: 85%">
                <div id="pag">
                    <h1 
                    style="margin-top: 20px;
                    margin-left: 20px;
                    font-size: 3.5em;
                    display: inline-block;">
                        Fotos
                    </h1>
                    <% if (request.getAttribute("mensagem") != null) { %>
                    <div class="mensagem" id="aviso" role="alert">
                        <strong><%= request.getAttribute("mensagem") %></strong>
                        <button onClick="fecharDiv()">
                            <img id="login" src="${pageContext.request.contextPath}/imagens/arrowright.svg" class="seta">
                        </button>
                    </div>
                    <% }%>
                    <div id="itens">
                    <%  
                        FotoDAO fotoDAO = new FotoDAO();
                        int id = Integer.parseInt(request.getParameter("id"));
                        List<Foto> fotos = (List<Foto>) fotoDAO.obterPeloProduto(id);
                        fotos.sort(Comparator.comparingInt(foto -> {
                            String nomeArquivo = new File(foto.getFoto()).getName();
                            String[] partes = nomeArquivo.split("_");
                            return Integer.parseInt(partes[0].trim());
                        }));
                        if (fotos != null && !fotos.isEmpty()) {
                            for (int i = 0; i < fotos.size(); i++) {
                                Foto c = fotos.get(i);
                        %>
                        <div class="itens-detalhes">
                            <img src="<%= request.getContextPath() %>/MostrarFoto?id=<%= c.getId()%>" class="itens-img" alt="Camiseta">
                            <div class="lado-esquerdo">
                                <h1 style="white-space: nowrap; overflow-x: auto; max-width: 100%; padding-bottom: 8px;"><strong>Foto <%= i+1%></strong></h1>
                            </div>

                            <div class="lado-direito">
                                <a href="<%= request.getContextPath()%>/admin/RemoverFoto?id=<%= c.getId()%>" class="botao-editar">
                                    <img src="${pageContext.request.contextPath}/imagens/lixeira_preta.svg" alt="icone para deletar">
                                </a>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    <%
                        } else {
                    %>
                    <div style='display: flex; justify-content: center; width: 100%'>
                        <div style='display: block; justify-content: center;'>
                            <h1 style='font-size: 3em; white-space: nowrap;'>Ainda não há nenhuma foto cadastrada ao produto</h1>
                            <div style="display: flex; justify-content: center; padding-top: 10px;">
                                <h1 style='font-size: 1.5em; color: #808080;'>Clique no botão abaixo para adicionar uma foto ao produto</h1>
                            </div>
                            <div style="display: flex; justify-content: center; padding: 20px;">
                                <a href="<%= request.getContextPath()%>/admin/AdicionarFoto?id=<%= id %>" style="display: flex; align-items: center; justify-content: center; width: 75px; height: 75px; background-color: #170b9b; border-radius: 50%;">
                                    <img src="${pageContext.request.contextPath}/imagens/mais.svg" alt="Adicionar" style="width: 50%; height: auto;">
                                </a>
                            </div>
                        </div>
                    </div>
                    <% 
                        }
                    %>
                </div>                       
            </div>
        </div>
</body>
<script>
    function fecharDiv(){
        let div = document.getElementById("aviso");
        if (div.style.display === "none"){
            div.style.display = "flex";
        }else{
            div.style.display = "none";
        }
    }
</script>
</html>
<%
    }  
%>