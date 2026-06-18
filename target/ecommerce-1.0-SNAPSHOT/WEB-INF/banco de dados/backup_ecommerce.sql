--
-- PostgreSQL database dump
--

-- Dumped from database version 16.14 (Ubuntu 16.14-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.14 (Ubuntu 16.14-0ubuntu0.24.04.1)

-- Started on 2026-06-17 21:00:05 -03

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
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 24581)
-- Name: atributo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.atributo (
    id smallint NOT NULL,
    atributo character varying NOT NULL,
    tabela character varying NOT NULL
);


--
-- TOC entry 216 (class 1259 OID 24586)
-- Name: atributo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.atributo_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 216
-- Name: atributo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.atributo_id_seq OWNED BY public.atributo.id;


--
-- TOC entry 217 (class 1259 OID 24587)
-- Name: aux_campeonato_time; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aux_campeonato_time (
    id_campeonato integer NOT NULL,
    id_time integer NOT NULL,
    ano integer
);


--
-- TOC entry 218 (class 1259 OID 24590)
-- Name: aux_filtro_atibuto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aux_filtro_atibuto (
    id_atributo integer,
    id_filtro integer
);


--
-- TOC entry 219 (class 1259 OID 24593)
-- Name: aux_venda_produto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.aux_venda_produto (
    id_venda integer NOT NULL,
    id_produto integer NOT NULL,
    quantidade integer NOT NULL,
    preco numeric NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 24598)
-- Name: campeonato; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.campeonato (
    id integer NOT NULL,
    nome character varying NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 24603)
-- Name: campeonato_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.campeonato_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 221
-- Name: campeonato_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.campeonato_id_seq OWNED BY public.campeonato.id;


--
-- TOC entry 222 (class 1259 OID 24604)
-- Name: categoria; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categoria (
    id integer NOT NULL,
    estilo character varying NOT NULL,
    temporada character varying NOT NULL,
    nome character varying NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 24609)
-- Name: categoria_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categoria_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 223
-- Name: categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categoria_id_seq OWNED BY public.categoria.id;


--
-- TOC entry 224 (class 1259 OID 24610)
-- Name: filtro; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.filtro (
    id smallint NOT NULL,
    checked boolean NOT NULL,
    nome character varying NOT NULL
);


--
-- TOC entry 225 (class 1259 OID 24615)
-- Name: filtro_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.filtro_id_seq
    AS smallint
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 225
-- Name: filtro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.filtro_id_seq OWNED BY public.filtro.id;


--
-- TOC entry 226 (class 1259 OID 24616)
-- Name: fotos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fotos (
    id integer NOT NULL,
    foto character varying NOT NULL,
    id_produto integer
);


--
-- TOC entry 227 (class 1259 OID 24621)
-- Name: fotos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.fotos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 227
-- Name: fotos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.fotos_id_seq OWNED BY public.fotos.id;


--
-- TOC entry 228 (class 1259 OID 24622)
-- Name: produto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.produto (
    id integer NOT NULL,
    descricao character varying NOT NULL,
    preco numeric NOT NULL,
    tamanho character varying NOT NULL,
    quantidade integer NOT NULL,
    id_time integer NOT NULL,
    id_categoria integer NOT NULL
);


--
-- TOC entry 229 (class 1259 OID 24627)
-- Name: produto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.produto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 229
-- Name: produto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.produto_id_seq OWNED BY public.produto.id;


--
-- TOC entry 230 (class 1259 OID 24628)
-- Name: time; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."time" (
    id integer NOT NULL,
    nome character varying NOT NULL,
    nacionalidade character varying NOT NULL
);


--
-- TOC entry 231 (class 1259 OID 24633)
-- Name: time_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.time_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 231
-- Name: time_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.time_id_seq OWNED BY public."time".id;


--
-- TOC entry 232 (class 1259 OID 24634)
-- Name: usuario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usuario (
    id integer NOT NULL,
    email character varying NOT NULL,
    admin boolean DEFAULT false NOT NULL,
    endereco character varying NOT NULL,
    login character varying NOT NULL,
    senha character varying NOT NULL,
    nome character varying NOT NULL
);


--
-- TOC entry 233 (class 1259 OID 24640)
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 233
-- Name: usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.usuario_id_seq OWNED BY public.usuario.id;


--
-- TOC entry 234 (class 1259 OID 24641)
-- Name: venda; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.venda (
    id integer NOT NULL,
    data_hora timestamp without time zone NOT NULL,
    id_usuario integer NOT NULL
);


--
-- TOC entry 235 (class 1259 OID 24644)
-- Name: venda_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.venda_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 235
-- Name: venda_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.venda_id_seq OWNED BY public.venda.id;


--
-- TOC entry 3339 (class 2604 OID 24645)
-- Name: atributo id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.atributo ALTER COLUMN id SET DEFAULT nextval('public.atributo_id_seq'::regclass);


--
-- TOC entry 3340 (class 2604 OID 24646)
-- Name: campeonato id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campeonato ALTER COLUMN id SET DEFAULT nextval('public.campeonato_id_seq'::regclass);


--
-- TOC entry 3341 (class 2604 OID 24647)
-- Name: categoria id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoria ALTER COLUMN id SET DEFAULT nextval('public.categoria_id_seq'::regclass);


--
-- TOC entry 3342 (class 2604 OID 24648)
-- Name: filtro id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.filtro ALTER COLUMN id SET DEFAULT nextval('public.filtro_id_seq'::regclass);


--
-- TOC entry 3343 (class 2604 OID 24649)
-- Name: fotos id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fotos ALTER COLUMN id SET DEFAULT nextval('public.fotos_id_seq'::regclass);


--
-- TOC entry 3344 (class 2604 OID 24650)
-- Name: produto id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.produto ALTER COLUMN id SET DEFAULT nextval('public.produto_id_seq'::regclass);


--
-- TOC entry 3345 (class 2604 OID 24651)
-- Name: time id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."time" ALTER COLUMN id SET DEFAULT nextval('public.time_id_seq'::regclass);


--
-- TOC entry 3346 (class 2604 OID 24652)
-- Name: usuario id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id SET DEFAULT nextval('public.usuario_id_seq'::regclass);


--
-- TOC entry 3348 (class 2604 OID 24653)
-- Name: venda id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.venda ALTER COLUMN id SET DEFAULT nextval('public.venda_id_seq'::regclass);


--
-- TOC entry 3350 (class 2606 OID 24655)
-- Name: atributo atributo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.atributo
    ADD CONSTRAINT atributo_pkey PRIMARY KEY (id);


--
-- TOC entry 3352 (class 2606 OID 24657)
-- Name: aux_campeonato_time aux_campeonato_time_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aux_campeonato_time
    ADD CONSTRAINT aux_campeonato_time_pkey PRIMARY KEY (id_campeonato, id_time);


--
-- TOC entry 3354 (class 2606 OID 24659)
-- Name: aux_venda_produto aux_venda_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aux_venda_produto
    ADD CONSTRAINT aux_venda_produto_pkey PRIMARY KEY (id_venda, id_produto);


--
-- TOC entry 3356 (class 2606 OID 24661)
-- Name: campeonato campeonato_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.campeonato
    ADD CONSTRAINT campeonato_pkey PRIMARY KEY (id);


--
-- TOC entry 3358 (class 2606 OID 24663)
-- Name: categoria categoria_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categoria
    ADD CONSTRAINT categoria_pkey PRIMARY KEY (id);


--
-- TOC entry 3360 (class 2606 OID 24665)
-- Name: filtro filtro_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.filtro
    ADD CONSTRAINT filtro_pkey PRIMARY KEY (id);


--
-- TOC entry 3362 (class 2606 OID 24667)
-- Name: fotos fotos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fotos
    ADD CONSTRAINT fotos_pkey PRIMARY KEY (id);


--
-- TOC entry 3372 (class 2606 OID 24669)
-- Name: venda pk_venda; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT pk_venda PRIMARY KEY (id) INCLUDE (id);


--
-- TOC entry 3364 (class 2606 OID 24671)
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3366 (class 2606 OID 24673)
-- Name: time time_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."time"
    ADD CONSTRAINT time_pkey PRIMARY KEY (id);


--
-- TOC entry 3368 (class 2606 OID 24675)
-- Name: usuario unique_login; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT unique_login UNIQUE (login);


--
-- TOC entry 3370 (class 2606 OID 24677)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 3375 (class 2606 OID 24678)
-- Name: aux_filtro_atibuto fk_atributo; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aux_filtro_atibuto
    ADD CONSTRAINT fk_atributo FOREIGN KEY (id_atributo) REFERENCES public.atributo(id);


--
-- TOC entry 3373 (class 2606 OID 24683)
-- Name: aux_campeonato_time fk_campeonato; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aux_campeonato_time
    ADD CONSTRAINT fk_campeonato FOREIGN KEY (id_campeonato) REFERENCES public.campeonato(id);


--
-- TOC entry 3380 (class 2606 OID 24688)
-- Name: produto fk_categoria; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT fk_categoria FOREIGN KEY (id_categoria) REFERENCES public.categoria(id) NOT VALID;


--
-- TOC entry 3376 (class 2606 OID 24693)
-- Name: aux_filtro_atibuto fk_filtro; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aux_filtro_atibuto
    ADD CONSTRAINT fk_filtro FOREIGN KEY (id_filtro) REFERENCES public.filtro(id);


--
-- TOC entry 3377 (class 2606 OID 24698)
-- Name: aux_venda_produto fk_produto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aux_venda_produto
    ADD CONSTRAINT fk_produto FOREIGN KEY (id_produto) REFERENCES public.produto(id);


--
-- TOC entry 3379 (class 2606 OID 24703)
-- Name: fotos fk_produto; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fotos
    ADD CONSTRAINT fk_produto FOREIGN KEY (id_produto) REFERENCES public.produto(id) NOT VALID;


--
-- TOC entry 3374 (class 2606 OID 24708)
-- Name: aux_campeonato_time fk_time; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aux_campeonato_time
    ADD CONSTRAINT fk_time FOREIGN KEY (id_time) REFERENCES public."time"(id);


--
-- TOC entry 3381 (class 2606 OID 24713)
-- Name: produto fk_time; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT fk_time FOREIGN KEY (id_time) REFERENCES public."time"(id) NOT VALID;


--
-- TOC entry 3382 (class 2606 OID 24718)
-- Name: venda fk_usuario; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


--
-- TOC entry 3378 (class 2606 OID 24723)
-- Name: aux_venda_produto fk_venda; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.aux_venda_produto
    ADD CONSTRAINT fk_venda FOREIGN KEY (id_venda) REFERENCES public.venda(id);


--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2026-06-17 21:00:05 -03

--
-- PostgreSQL database dump complete
--

