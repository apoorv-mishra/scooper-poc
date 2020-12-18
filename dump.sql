--
-- PostgreSQL database dump
--

-- Dumped from database version 11.8 (Ubuntu 11.8-1.pgdg18.04+1)
-- Dumped by pg_dump version 11.8 (Ubuntu 11.8-1.pgdg18.04+1)

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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: todos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.todos (
    id integer NOT NULL,
    user_id integer,
    name text NOT NULL,
    done boolean DEFAULT false,
    deadline timestamp with time zone,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.todos OWNER TO postgres;

--
-- Name: todos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.todos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.todos_id_seq OWNER TO postgres;

--
-- Name: todos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.todos_id_seq OWNED BY public.todos.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    email text NOT NULL,
    salt text NOT NULL,
    hash text NOT NULL,
    jwt text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: todos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.todos ALTER COLUMN id SET DEFAULT nextval('public.todos_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: todos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.todos (id, user_id, name, done, deadline, created_at, updated_at) FROM stdin;
1	1	Run	f	\N	2020-12-18 18:17:07.730205+05:30	2020-12-18 18:17:07.730205+05:30
2	1	Lift	f	\N	2020-12-18 18:17:10.522977+05:30	2020-12-18 18:17:10.522977+05:30
4	1	Kill	t	\N	2020-12-18 18:17:13.809772+05:30	2020-12-18 18:17:13.809772+05:30
3	1	Fight	t	2020-12-19 00:00:00+05:30	2020-12-18 18:17:12.586897+05:30	2020-12-18 18:17:12.586897+05:30
5	2	Water	f	\N	2020-12-18 18:17:47.81666+05:30	2020-12-18 18:17:47.81666+05:30
6	2	Eat	f	\N	2020-12-18 18:17:50.945329+05:30	2020-12-18 18:17:50.945329+05:30
7	2	Cycle	f	\N	2020-12-18 18:17:54.033413+05:30	2020-12-18 18:17:54.033413+05:30
8	2	Code	t	2020-12-25 00:00:00+05:30	2020-12-18 18:17:55.977243+05:30	2020-12-18 18:17:55.977243+05:30
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, first_name, last_name, email, salt, hash, jwt, created_at, updated_at) FROM stdin;
1	John	Cena	john@cena.com	1rUcfzmIf1zj6NMOBNy746LY92uEQL/X9ueyRL7qTn35dEy0LXhDtzQHbxmconkmTGKLtldtqLKdo4rAfurFZA==	2/U4oq91BGgTYOfuWEeFHP78s1BNLwtHwC/weqEn/iEKGZ88zse+W+UIuaFS39vH6csEoUikTHiG54KXqaR50Wt6cYi5tq++DK6jW8u49u7BA7XNLr4PhWSi3jS/10LeOeizGhguI15UFwb4cYXHrtcPTsNCV5P648phcH0I4J8=	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImpvaG5AY2VuYS5jb20iLCJpYXQiOjE2MDgyOTU2MjN9.wBCvTbcGYiMGl4nAciNR_bh0tfvrfuGYKUiorC5Sdcg	2020-12-18 18:17:03.924113+05:30	2020-12-18 18:17:03.924113+05:30
2	John	Smith	john@smith.com	RKYrrslABWeEwVnz+tPRZUT962nkaMDLJMGOYtUu7dDVhSZ+p+frFHuj7PWjj8vNTyKlqxgDtXLoSziWifZmYA==	f2u3btt6faeg3uXpobSDS92hlZoycCJ1uIz7QWLBw091gBbOZutgenTeyQrqZelF/P0D5esvTLSMyq6Z9Ty7px9U6MJz3ro7Q2/Ofj/tE5groWZ1U0SPWilEzNsZ1i+QvG3KnIIJPRI3ohz7t7/+hQPfYJ4ELHhIfHBDkbJsIio=	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImpvaG5Ac21pdGguY29tIiwiaWF0IjoxNjA4Mjk1NjYzfQ.VPUHALJ3wfI4r3865NyZOzh4PMGD7T9StXnOfXPnmyU	2020-12-18 18:17:43.820776+05:30	2020-12-18 18:17:43.820776+05:30
\.


--
-- Name: todos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.todos_id_seq', 8, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: todos todos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.todos
    ADD CONSTRAINT todos_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_jwt_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_jwt_key UNIQUE (jwt);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: todos todos_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.todos
    ADD CONSTRAINT todos_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

