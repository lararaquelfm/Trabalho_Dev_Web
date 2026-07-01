<%@page import="modelo.usuario.Usuario"%>
<%@page import="modelo.produto.Produto"%>
<%@page import="modelo.foto.Foto"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    Produto produto = (Produto) request.getAttribute("produto");
    List<Produto> variacoes = (List<Produto>) request.getAttribute("variacoes");
    List<Foto> fotos = (List<Foto>) request.getAttribute("fotos");
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title><%= produto.getDescricao() %></title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/barra_navegacao.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/verProduto.css">
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
            <a href="<%= request.getContextPath() %>/secure/Carrinho">
                <img id="carrinho" src="<%= request.getContextPath() %>/imagens/carrinho.svg" style="width: 100%; height: auto;" alt="ft de carrinho">
            </a>
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
            <a><img src="<%= request.getContextPath() %>/imagens/arrowright.svg" alt="">Meus pedidos</a>
            <a href="<%= request.getContextPath() %>/secure/MyProfile?id=<%= usuario.getId() %>"><img src="<%= request.getContextPath() %>/imagens/arrowright.svg" alt="">Meus dados</a>
            <div class="sair">
                <a href="<%= request.getContextPath() %>/secure/Logout" style="padding-top: 35px; padding-bottom: 20px;"><img src="<%= request.getContextPath() %>/imagens/logout.svg" alt="">Sair</a>
            </div>
            <div class="deletar">
                <a href="<%= request.getContextPath() %>/secure/DeletarUsuario?id=<%= usuario.getId() %>"><img src="<%= request.getContextPath() %>/imagens/lixeira_preta.svg" alt="">Deletar perfil</a>
            </div>
        </div>
    </div>

    <div id="produtoDetalhe">
        <div class="container">
            <div class="card">
                <div class="carrossel">
                    <button type="button" id="btnSetaEsquerda" class="seta seta-esquerda" disabled>&#10094;</button>
                    <%
                        if (fotos != null && !fotos.isEmpty()) {
                    %>
                    <img id="imgProduto" src="<%= request.getContextPath() %>/MostrarFoto?id=<%= fotos.get(0).getId() %>" class="produto-img" alt="<%= produto.getDescricao() %>">
                    <%
                        } else {
                    %>
                    <img id="imgProduto" src="<%= request.getContextPath() %>/imagens/Image-not-found.png" class="produto-img" alt="Sem foto disponível">
                    <%
                        }
                    %>
                    <button type="button" id="btnSetaDireita" class="seta seta-direita">&#10095;</button>
                </div>
            </div>
            <div class="info">
                <h3 class="nome"><%= produto.getDescricao() %></h3>
                <h3 class="preço">R$ <%= String.format("%.2f", produto.getPreco()).replace(".", ",") %></h3>
                <h3 class="linha">___________________________________________________________</h3>
                <h3 class="tamanho">Tamanho:</h3>
                <div class="tamanhos">
                    <%
                        if (variacoes != null) {
                            for (Produto v : variacoes) {
                                String classeIndisponivel = (v.getQuantidade() == 0) ? "indisponivel" : "";
                    %>
                        <div class="tam <%= classeIndisponivel %>" data-id="<%= v.getId() %>" data-estoque="<%= v.getQuantidade() %>">
                            <%= v.getTamanho() %>
                        </div>
                    <%
                            }
                        }
                    %>
                </div>
                <div class="botoes_compra">
                    <input type="hidden" id="produtoIdSelecionado" value="">
                    <button class="comprar" id="btnComprar" disabled>Comprar agora</button>
                    <button class="add_carrinho" id="btnAddCarrinho" disabled>
                        Adicionar ao carrinho
                        <img src="<%= request.getContextPath() %>/imagens/carrinho.svg" style="width: 1em; vertical-align: middle;" alt="ft de carrinho">
                    </button>
                </div>
                <p id="avisoTamanho" class="aviso" style="display:none;">Selecione um tamanho antes de continuar.</p>
            </div>
        </div>
    </div>

    <script>
        function toggleMenu(event) {
            if (event) event.preventDefault();
            const menu = document.getElementById("Menu");
            menu.classList.toggle("active");
        }

        let produtoIdSelecionado = null;
        const contextPath = "<%= request.getContextPath() %>";

        // ---- Carrossel de fotos ----
        const fotoIds = [
            <%
                if (fotos != null) {
                    for (int i = 0; i < fotos.size(); i++) {
            %>
            <%= fotos.get(i).getId() %><%= (i < fotos.size() - 1) ? "," : "" %>
            <%
                    }
                }
            %>
        ];
        let indiceFotoAtual = 0;

        function atualizarCarrossel() {
            if (fotoIds.length === 0) {
                return;
            }
            document.getElementById('imgProduto').src = contextPath + "/MostrarFoto?id=" + fotoIds[indiceFotoAtual];
            document.getElementById('btnSetaEsquerda').disabled = (indiceFotoAtual === 0);
            document.getElementById('btnSetaDireita').disabled = (indiceFotoAtual === fotoIds.length - 1);
        }

        const btnSetaEsquerda = document.getElementById('btnSetaEsquerda');
        const btnSetaDireita = document.getElementById('btnSetaDireita');

        if (fotoIds.length > 1) {
            btnSetaEsquerda.addEventListener('click', function () {
                if (indiceFotoAtual > 0) {
                    indiceFotoAtual--;
                    atualizarCarrossel();
                }
            });
            btnSetaDireita.addEventListener('click', function () {
                if (indiceFotoAtual < fotoIds.length - 1) {
                    indiceFotoAtual++;
                    atualizarCarrossel();
                }
            });
        } else {
            // só uma foto (ou nenhuma) - esconde as setas
            btnSetaEsquerda.style.display = 'none';
            btnSetaDireita.style.display = 'none';
        }
        atualizarCarrossel();
        // ---- Fim do carrossel ----

        document.querySelectorAll('.tam').forEach(function (el) {
            el.addEventListener('click', function () {
                var estoque = parseInt(el.getAttribute('data-estoque'));
                if (estoque <= 0) {
                    return;
                }
                document.querySelectorAll('.tam').forEach(function (t) {
                    t.classList.remove('selecionado');
                });
                el.classList.add('selecionado');
                produtoIdSelecionado = el.getAttribute('data-id');
                document.getElementById('produtoIdSelecionado').value = produtoIdSelecionado;

                document.getElementById('btnComprar').disabled = false;
                document.getElementById('btnAddCarrinho').disabled = false;
                document.getElementById('avisoTamanho').style.display = 'none';
            });
        });

        document.getElementById('btnAddCarrinho').addEventListener('click', function () {
            if (!produtoIdSelecionado) {
                document.getElementById('avisoTamanho').style.display = 'block';
                return;
            }
            window.location.href = contextPath + "/secure/AdicionarCarrinho?id=" + produtoIdSelecionado;
        });

        document.getElementById('btnComprar').addEventListener('click', function () {
            if (!produtoIdSelecionado) {
                document.getElementById('avisoTamanho').style.display = 'block';
                return;
            }
            window.location.href = contextPath + "/secure/ComprarAgora?id=" + produtoIdSelecionado;
        });
    </script>
</body>
</html>
