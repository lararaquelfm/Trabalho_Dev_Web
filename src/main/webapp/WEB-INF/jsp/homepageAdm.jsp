<%@include file="homepageAdmCabecalho.jsp" %>
<body>
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
            <a href="">Compras</a>
            <a href="">Cadastros</a>
            <a href="<%= request.getContextPath()%>/admin/Produto">Itens</a>
            <a href="<%= request.getContextPath()%>/admin/ListarCategoria">Categorias</a>
            <a href="<%= request.getContextPath()%>/admin/Competicoes">Tabelas</a>       
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
                        <h3>R$: 777,77</h3>
                    </div>
                </div>
                <div class="dados">
                    <div class="titulo">
                        <p>Produto mais vendido</p>
                    </div>
                    <div id="camisaV">
                        <div class="camisa">
                            <div class="foto">
                                <img src="<%= request.getContextPath() %>/imagens/camisa.png">
                            </div>
                            <div id="descricao">
                                <p style="font-size: 17px;"><strong>Camisa da Seleção Brasileira</strong></p>
                                <p>Preço: R$ 777,77</p>
                                <p>Vendas: 999 unid.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="dados">
                    <div class="titulo">
                        <p>Visitas ao site hoje</p>
                    </div>
                    <div class="cont">
                        <h3>145 visitas</h3>
                    </div>
                </div>
                <div class="dados-chart">
                    <div class="titulo">
                        <p>Vendas por mês</p>
                    </div>
                </div>
                <div class="dados">
                    <div class="titulo">
                        <p>Vendas por time</p>
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