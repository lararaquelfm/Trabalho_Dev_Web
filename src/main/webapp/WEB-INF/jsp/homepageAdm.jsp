<%@page import="modelo.foto.FotoDAO"%>
<%@page import="modelo.foto.Foto"%>
<%@page import="java.util.List"%>
<%@page import="modelo.produto.Produto"%>
<%@page import="java.util.Map"%>
<%@include file="homepageAdmCabecalho.jsp" %>
<body>
    <%
    Produto maisVendido = (Produto) request.getAttribute("maisVendido");
    double faturamento = (Double) request.getAttribute("faturamento");
    int[] vendasPorMes = (int[]) request.getAttribute("vendasPorMes");
    List<Produto> emFalta = (List<Produto>) request.getAttribute("emFalta");
    %>
     <div class="pcima">
        <img id="profile" src="<%= request.getContextPath() %>/imagens/profile.svg" style="width: 3%; height: auto" alt="ft de perfil">
        <h1>Administrador: <%= usuario.getNome() %></h1>
    </div>
    
    <div class="plado">
        <div class="menu" style="width:15%;">
            <a href="<%= request.getContextPath()%>/admin/MyProfileAdm?id=<%= usuario.getId() %>">Editar Dados</a>
            <div id="ativo">
                <img src="<%= request.getContextPath() %>/imagens/arrowright.svg" alt="seta direita">
                <a href="HomepageAdm">Dashboard</a>
            </div>
            <a href="<%= request.getContextPath()%>/admin/ListarPorVendas">Compras</a>
            <a href="<%= request.getContextPath()%>/admin/ListarTodosUsuarios">Cadastros</a>
            <a href="<%= request.getContextPath()%>/admin/Produto">Itens</a>
            <a href="<%= request.getContextPath()%>/admin/ListarCategoria">Categorias</a>
            <a href="<%= request.getContextPath()%>/admin/Competicoes">Tabelas</a>       
            <a href="<%= request.getContextPath()%>/admin/ListarRelatorio">Relatorios</a>
        </div>
        
        <div id="conteudo" style="width: 85%">
            <div id="pag">
                <div id="cabecalho">
                    <h1>Dados</h1>
                </div>
                <div class="dados">
                    <div class="titulo">
                        <p>Lucro mensal</p>
                    </div>
                    <div class="cont">
                        <div class="cont">
                            <h3>R$ <%= String.format(java.util.Locale.forLanguageTag("pt-BR"), "%.2f", faturamento) %></h3>
                        </div>
                    </div>
                </div>
                <div class="dados">
                    <div class="titulo">
                        <p>Produto mais vendido</p>
                    </div>
                    <div id="camisaV">
                        <div class="camisa">
                            <div class="foto">
                            <% 
                            List<Foto> fotos = new FotoDAO().obterPeloProduto(maisVendido.getId());
                            if (fotos.isEmpty()){
                            %>
                                <img src="${pageContext.request.contextPath}/imagens/Image-not-found.png" class="itens-img" alt="Camiseta">
                            <%
                            } else {
                            %>
                                <img src="<%= request.getContextPath() %>/MostrarProduto?id=<%= maisVendido.getId()%>" class="itens-img" alt="Camiseta">
                            <%
                            }
                            %>
                            </div>
                            <div id="descricao">
                                <% if (maisVendido != null) { %>
                                    <p style="font-size: 17px;"><strong><%= maisVendido.getDescricao() %></strong></p>
                                    <p>Preço: R$ <%= String.format(java.util.Locale.forLanguageTag("pt-BR"), "%.2f", maisVendido.getPreco()) %></p>
                                    <p>Vendas: <%= maisVendido.getTotalVendido() %> unid.</p>
                                <% } else { %>
                                    <p>Nenhuma venda registrada.</p>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="dados">
                    <div class="titulo">
                        <p>Produtos Esgotados</p>
                    </div>
                    <div class="cont">
                        <h3><%= emFalta.size() %></h3>
                    </div>
                </div>
                <div class="dados-chart">
                    <div class="titulo">
                        <p>Vendas por mês</p>
                    </div>
                    <div class="cont">
                        <div id="grafico_coluna">
                            <%
                                String[] nomesMes = {"", "Jan","Fev","Mar","Abr","Maio","Jun","Jul","Ago","Set","Out","Nov","Dez"};
                                int maxVenda = 1;
                                for (int m = 1; m <= 12; m++) {
                                    if (vendasPorMes[m] > maxVenda) maxVenda = vendasPorMes[m];
                                }
                            %>
                            <div id="colunas">
                                <ul class="axis">
                                    <li><%= maxVenda %></li>
                                    <li><%= (int)(maxVenda * 0.75) %></li>
                                    <li><%= (int)(maxVenda * 0.5) %></li>
                                    <li><%= (int)(maxVenda * 0.25) %></li>
                                    <li>0</li>
                                </ul>
                                <table class="charts-css column data-spacing-5 show-labels show-4-secondary-axes show-data-on-hover">
                                    <thead>
                                        <tr>
                                            <th scope="col">Mês</th>
                                            <th scope="col">Vendas</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <% for (int m = 1; m <= 12; m++) {
                                               double size = (double) vendasPorMes[m] / maxVenda; %>
                                            <tr>
                                                <th scope="row"><%= nomesMes[m] %></th>
                                                <td style="--size: <%= size %>;"><%= vendasPorMes[m] %></td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<%
    }
%>