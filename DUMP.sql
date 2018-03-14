--
-- PostgreSQL database dump
--

-- Dumped from database version 10.3
-- Dumped by pg_dump version 10.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: available; Type: TABLE; Schema: public; Owner: andrew
--

CREATE TABLE public.available (
    zip integer,
    city character varying(40),
    state_name character varying(15)
);


ALTER TABLE public.available OWNER TO andrew;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: andrew
--

CREATE TABLE public.customers (
    id integer NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    phone character varying(20) NOT NULL,
    street_1 character varying(40),
    street_2 character varying(40),
    city character varying(40),
    state_name character varying(15),
    zip integer,
    date_created timestamp without time zone
);


ALTER TABLE public.customers OWNER TO andrew;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: andrew
--

CREATE SEQUENCE public.customers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customers_id_seq OWNER TO andrew;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andrew
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: logins; Type: TABLE; Schema: public; Owner: andrew
--

CREATE TABLE public.logins (
    id integer NOT NULL,
    customer_id integer,
    phone character varying(20),
    code integer,
    date_sent timestamp without time zone,
    expiration timestamp without time zone
);


ALTER TABLE public.logins OWNER TO andrew;

--
-- Name: logins_id_seq; Type: SEQUENCE; Schema: public; Owner: andrew
--

CREATE SEQUENCE public.logins_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logins_id_seq OWNER TO andrew;

--
-- Name: logins_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andrew
--

ALTER SEQUENCE public.logins_id_seq OWNED BY public.logins.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: andrew
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    customer_id integer,
    route_id integer,
    date_placed timestamp without time zone,
    total_price integer,
    product_id integer,
    product_qty integer,
    charge_status integer,
    status_id integer,
    status_update timestamp without time zone
);


ALTER TABLE public.orders OWNER TO andrew;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: andrew
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO andrew;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andrew
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: potential; Type: TABLE; Schema: public; Owner: andrew
--

CREATE TABLE public.potential (
    zip integer,
    city character varying(40),
    state_name character varying(15),
    date_entered timestamp without time zone
);


ALTER TABLE public.potential OWNER TO andrew;

--
-- Name: products; Type: TABLE; Schema: public; Owner: andrew
--

CREATE TABLE public.products (
    id integer NOT NULL,
    product_name character varying(50),
    price integer
);


ALTER TABLE public.products OWNER TO andrew;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: andrew
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO andrew;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andrew
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: routes; Type: TABLE; Schema: public; Owner: andrew
--

CREATE TABLE public.routes (
    id integer NOT NULL,
    squire_id integer,
    date_created timestamp without time zone,
    status_id integer
);


ALTER TABLE public.routes OWNER TO andrew;

--
-- Name: routes_id_seq; Type: SEQUENCE; Schema: public; Owner: andrew
--

CREATE SEQUENCE public.routes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.routes_id_seq OWNER TO andrew;

--
-- Name: routes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andrew
--

ALTER SEQUENCE public.routes_id_seq OWNED BY public.routes.id;


--
-- Name: squires; Type: TABLE; Schema: public; Owner: andrew
--

CREATE TABLE public.squires (
    id integer NOT NULL,
    email character varying(50),
    password character varying(255),
    user_type integer
);


ALTER TABLE public.squires OWNER TO andrew;

--
-- Name: squires_id_seq; Type: SEQUENCE; Schema: public; Owner: andrew
--

CREATE SEQUENCE public.squires_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.squires_id_seq OWNER TO andrew;

--
-- Name: squires_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andrew
--

ALTER SEQUENCE public.squires_id_seq OWNED BY public.squires.id;


--
-- Name: templates; Type: TABLE; Schema: public; Owner: andrew
--

CREATE TABLE public.templates (
    id integer NOT NULL,
    message_head text,
    message_body text
);


ALTER TABLE public.templates OWNER TO andrew;

--
-- Name: templates_id_seq; Type: SEQUENCE; Schema: public; Owner: andrew
--

CREATE SEQUENCE public.templates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.templates_id_seq OWNER TO andrew;

--
-- Name: templates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andrew
--

ALTER SEQUENCE public.templates_id_seq OWNED BY public.templates.id;


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: andrew
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: logins id; Type: DEFAULT; Schema: public; Owner: andrew
--

ALTER TABLE ONLY public.logins ALTER COLUMN id SET DEFAULT nextval('public.logins_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: andrew
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: andrew
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: routes id; Type: DEFAULT; Schema: public; Owner: andrew
--

ALTER TABLE ONLY public.routes ALTER COLUMN id SET DEFAULT nextval('public.routes_id_seq'::regclass);


--
-- Name: squires id; Type: DEFAULT; Schema: public; Owner: andrew
--

ALTER TABLE ONLY public.squires ALTER COLUMN id SET DEFAULT nextval('public.squires_id_seq'::regclass);


--
-- Name: templates id; Type: DEFAULT; Schema: public; Owner: andrew
--

ALTER TABLE ONLY public.templates ALTER COLUMN id SET DEFAULT nextval('public.templates_id_seq'::regclass);


--
-- Data for Name: available; Type: TABLE DATA; Schema: public; Owner: andrew
--

COPY public.available (zip, city, state_name) FROM stdin;
84780	washington	ut
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: andrew
--

COPY public.customers (id, first_name, last_name, phone, street_1, street_2, city, state_name, zip, date_created) FROM stdin;
1	Matt	Pelo	8016693991	\N	\N	\N	\N	84770	2018-03-08 22:17:51.937188
2	Andrew	Garvin	8015027423	\N	\N	\N	\N	84770	2018-03-08 22:21:12.896454
3	Benjamin	Pelo	8013619909	\N	\N	\N	\N	84770	2018-03-08 22:21:25.016401
\.


--
-- Data for Name: logins; Type: TABLE DATA; Schema: public; Owner: andrew
--

COPY public.logins (id, customer_id, phone, code, date_sent, expiration) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: andrew
--

COPY public.orders (id, customer_id, route_id, date_placed, total_price, product_id, product_qty, charge_status, status_id, status_update) FROM stdin;
\.


--
-- Data for Name: potential; Type: TABLE DATA; Schema: public; Owner: andrew
--

COPY public.potential (zip, city, state_name, date_entered) FROM stdin;
84604	Provo	UT	2018-03-08 22:11:57.585227
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: andrew
--

COPY public.products (id, product_name, price) FROM stdin;
\.


--
-- Data for Name: routes; Type: TABLE DATA; Schema: public; Owner: andrew
--

COPY public.routes (id, squire_id, date_created, status_id) FROM stdin;
\.


--
-- Data for Name: squires; Type: TABLE DATA; Schema: public; Owner: andrew
--

COPY public.squires (id, email, password, user_type) FROM stdin;
\.


--
-- Data for Name: templates; Type: TABLE DATA; Schema: public; Owner: andrew
--

COPY public.templates (id, message_head, message_body) FROM stdin;
\.


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andrew
--

SELECT pg_catalog.setval('public.customers_id_seq', 3, true);


--
-- Name: logins_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andrew
--

SELECT pg_catalog.setval('public.logins_id_seq', 1, false);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andrew
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andrew
--

SELECT pg_catalog.setval('public.products_id_seq', 2, true);


--
-- Name: routes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andrew
--

SELECT pg_catalog.setval('public.routes_id_seq', 1, true);


--
-- Name: squires_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andrew
--

SELECT pg_catalog.setval('public.squires_id_seq', 1, false);


--
-- Name: templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andrew
--

SELECT pg_catalog.setval('public.templates_id_seq', 1, false);


--
-- Name: customers customers_id_key; Type: CONSTRAINT; Schema: public; Owner: andrew
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_id_key UNIQUE (id);


--
-- Name: logins logins_id_key; Type: CONSTRAINT; Schema: public; Owner: andrew
--

ALTER TABLE ONLY public.logins
    ADD CONSTRAINT logins_id_key UNIQUE (id);


--
-- Name: orders orders_id_key; Type: CONSTRAINT; Schema: public; Owner: andrew
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_id_key UNIQUE (id);


--
-- Name: products products_id_key; Type: CONSTRAINT; Schema: public; Owner: andrew
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_id_key UNIQUE (id);


--
-- Name: routes routes_id_key; Type: CONSTRAINT; Schema: public; Owner: andrew
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_id_key UNIQUE (id);


--
-- Name: squires squires_id_key; Type: CONSTRAINT; Schema: public; Owner: andrew
--

ALTER TABLE ONLY public.squires
    ADD CONSTRAINT squires_id_key UNIQUE (id);


--
-- Name: templates templates_id_key; Type: CONSTRAINT; Schema: public; Owner: andrew
--

ALTER TABLE ONLY public.templates
    ADD CONSTRAINT templates_id_key UNIQUE (id);


--
-- Name: logins logins_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: andrew
--

ALTER TABLE ONLY public.logins
    ADD CONSTRAINT logins_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: andrew
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: orders orders_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: andrew
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: orders orders_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: andrew
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.routes(id);


--
-- Name: routes routes_squire_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: andrew
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_squire_id_fkey FOREIGN KEY (squire_id) REFERENCES public.squires(id);


--
-- PostgreSQL database dump complete
--

