--
-- PostgreSQL database dump
--

-- Dumped from database version 16.14 (Ubuntu 16.14-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.14 (Ubuntu 16.14-0ubuntu0.24.04.1)

-- Started on 2026-06-17 20:59:42 -03

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3516 (class 0 OID 24581)
-- Dependencies: 215
-- Data for Name: atributo; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3521 (class 0 OID 24598)
-- Dependencies: 220
-- Data for Name: campeonato; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3531 (class 0 OID 24628)
-- Dependencies: 230
-- Data for Name: time; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public."time" (id, nome, nacionalidade) VALUES (1, 'Seleção Brasileira', 'Brasil');


--
-- TOC entry 3518 (class 0 OID 24587)
-- Dependencies: 217
-- Data for Name: aux_campeonato_time; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3525 (class 0 OID 24610)
-- Dependencies: 224
-- Data for Name: filtro; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3519 (class 0 OID 24590)
-- Dependencies: 218
-- Data for Name: aux_filtro_atibuto; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3523 (class 0 OID 24604)
-- Dependencies: 222
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.categoria (id, estilo, temporada, nome) VALUES (1, 'retrô', '2002', 'copa de 2002');


--
-- TOC entry 3529 (class 0 OID 24622)
-- Dependencies: 228
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.produto (id, descricao, preco, tamanho, quantidade, id_time, id_categoria) VALUES (48, 'Camisa Retrô 2002 Seleção Brasileira I', 229.9, 'G', 50, 1, 1);


--
-- TOC entry 3533 (class 0 OID 24634)
-- Dependencies: 232
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.usuario (id, email, admin, endereco, login, senha, nome) VALUES (1, 'jg@gmail.com', false, 'qweqwe', 'jg', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'joao gabriel');
INSERT INTO public.usuario (id, email, admin, endereco, login, senha, nome) VALUES (3, 'adm@gmail.com', true, 'rua do adm', 'adm', '86f65e28a754e1a71b2df9403615a6c436c32c42a75a10d02813961b86f1e428', 'Gabriel');


--
-- TOC entry 3535 (class 0 OID 24641)
-- Dependencies: 234
-- Data for Name: venda; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3520 (class 0 OID 24593)
-- Dependencies: 219
-- Data for Name: aux_venda_produto; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3527 (class 0 OID 24616)
-- Dependencies: 226
-- Data for Name: fotos; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.fotos (id, foto, id_produto) VALUES (25, '/home/jg/arquivos_ecommerce/imagens/1|48.jpeg', 48);
INSERT INTO public.fotos (id, foto, id_produto) VALUES (26, '/home/jg/arquivos_ecommerce/imagens/2|48.jpeg', 48);
INSERT INTO public.fotos (id, foto, id_produto) VALUES (27, '/home/jg/arquivos_ecommerce/imagens/3|48.jpeg', 48);
INSERT INTO public.fotos (id, foto, id_produto) VALUES (28, '/home/jg/arquivos_ecommerce/imagens/4|48.jpeg', 48);
INSERT INTO public.fotos (id, foto, id_produto) VALUES (29, '/home/jg/arquivos_ecommerce/imagens/5|48.jpeg', 48);
INSERT INTO public.fotos (id, foto, id_produto) VALUES (30, '/home/jg/arquivos_ecommerce/imagens/6|48.jpeg', 48);


--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 216
-- Name: atributo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.atributo_id_seq', 1, false);


--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 221
-- Name: campeonato_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.campeonato_id_seq', 1, false);


--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 223
-- Name: categoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categoria_id_seq', 1, true);


--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 225
-- Name: filtro_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.filtro_id_seq', 1, false);


--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 227
-- Name: fotos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.fotos_id_seq', 30, true);


--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 229
-- Name: produto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.produto_id_seq', 48, true);


--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 231
-- Name: time_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.time_id_seq', 1, true);


--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 233
-- Name: usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.usuario_id_seq', 3, true);


--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 235
-- Name: venda_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.venda_id_seq', 1, false);


-- Completed on 2026-06-17 20:59:42 -03

--
-- PostgreSQL database dump complete
--

