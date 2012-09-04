--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

--
-- Name: polish_ispell; Type: TEXT SEARCH DICTIONARY; Schema: public; Owner: django
--

CREATE TEXT SEARCH DICTIONARY polish_ispell (
    TEMPLATE = pg_catalog.ispell,
    dictfile = 'polish', afffile = 'polish', stopwords = 'polish' );


ALTER TEXT SEARCH DICTIONARY public.polish_ispell OWNER TO django;

--
-- Name: polish_synonym; Type: TEXT SEARCH DICTIONARY; Schema: public; Owner: django
--

CREATE TEXT SEARCH DICTIONARY polish_synonym (
    TEMPLATE = pg_catalog.synonym,
    synonyms = 'polish' );


ALTER TEXT SEARCH DICTIONARY public.polish_synonym OWNER TO django;

--
-- Name: polish_thesaurus; Type: TEXT SEARCH DICTIONARY; Schema: public; Owner: django
--

CREATE TEXT SEARCH DICTIONARY polish_thesaurus (
    TEMPLATE = pg_catalog.thesaurus,
    dictfile = 'polish', dictionary = 'polish_ispell' );


ALTER TEXT SEARCH DICTIONARY public.polish_thesaurus OWNER TO django;

--
-- Name: polish; Type: TEXT SEARCH CONFIGURATION; Schema: public; Owner: django
--

CREATE TEXT SEARCH CONFIGURATION polish (
    PARSER = pg_catalog."default" );

ALTER TEXT SEARCH CONFIGURATION polish
    ADD MAPPING FOR asciiword WITH polish_thesaurus, polish_synonym, polish_ispell, simple;

ALTER TEXT SEARCH CONFIGURATION polish
    ADD MAPPING FOR word WITH polish_thesaurus, polish_synonym, polish_ispell, simple;

ALTER TEXT SEARCH CONFIGURATION polish
    ADD MAPPING FOR numword WITH simple;

ALTER TEXT SEARCH CONFIGURATION polish
    ADD MAPPING FOR email WITH simple;

ALTER TEXT SEARCH CONFIGURATION polish
    ADD MAPPING FOR url WITH simple;

ALTER TEXT SEARCH CONFIGURATION polish
    ADD MAPPING FOR host WITH simple;

ALTER TEXT SEARCH CONFIGURATION polish
    ADD MAPPING FOR sfloat WITH simple;

ALTER TEXT SEARCH CONFIGURATION polish
    ADD MAPPING FOR version WITH simple;

ALTER TEXT SEARCH CONFIGURATION polish
    ADD MAPPING FOR hword_numpart WITH simple;

ALTER TEXT SEARCH CONFIGURATION polish
    ADD MAPPING FOR hword_part WITH polish_thesaurus, polish_synonym, polish_ispell, simple;

ALTER TEXT SEARCH CONFIGURATION polish
    ADD MAPPING FOR hword_asciipart WITH polish_thesaurus, polish_synonym, polish_ispell, simple;

ALTER TEXT SEARCH CONFIGURATION polish
    ADD MAPPING FOR numhword WITH simple;

ALTER TEXT SEARCH CONFIGURATION polish
    ADD MAPPING FOR asciihword WITH polish_thesaurus, polish_synonym, polish_ispell, simple;

ALTER TEXT SEARCH CONFIGURATION polish
    ADD MAPPING FOR hword WITH polish_thesaurus, polish_synonym, polish_ispell, simple;

ALTER TEXT SEARCH CONFIGURATION polish
    ADD MAPPING FOR url_path WITH simple;

ALTER TEXT SEARCH CONFIGURATION polish
    ADD MAPPING FOR file WITH simple;

ALTER TEXT SEARCH CONFIGURATION polish
    ADD MAPPING FOR "float" WITH simple;

ALTER TEXT SEARCH CONFIGURATION polish
    ADD MAPPING FOR "int" WITH simple;

ALTER TEXT SEARCH CONFIGURATION polish
    ADD MAPPING FOR uint WITH simple;


ALTER TEXT SEARCH CONFIGURATION public.polish OWNER TO django;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: DFor_forum; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE "DFor_forum" (
    id integer NOT NULL,
    nazwa character varying(70) NOT NULL,
    opis character varying(150) NOT NULL
);


ALTER TABLE public."DFor_forum" OWNER TO django;

--
-- Name: DFor_forum_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE "DFor_forum_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."DFor_forum_id_seq" OWNER TO django;

--
-- Name: DFor_forum_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE "DFor_forum_id_seq" OWNED BY "DFor_forum".id;


--
-- Name: DFor_forum_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('"DFor_forum_id_seq"', 5, true);


--
-- Name: DFor_post; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE "DFor_post" (
    id integer NOT NULL,
    autor_id integer NOT NULL,
    temat_id integer NOT NULL,
    data_utworzenia timestamp with time zone NOT NULL,
    data_modyfikacji timestamp with time zone NOT NULL,
    tekst text NOT NULL,
    safe boolean NOT NULL,
    tekst_tsv tsvector
);


ALTER TABLE public."DFor_post" OWNER TO django;

--
-- Name: DFor_post_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE "DFor_post_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."DFor_post_id_seq" OWNER TO django;

--
-- Name: DFor_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE "DFor_post_id_seq" OWNED BY "DFor_post".id;


--
-- Name: DFor_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('"DFor_post_id_seq"', 76, true);


--
-- Name: DFor_temat; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE "DFor_temat" (
    id integer NOT NULL,
    tytul character varying(70) NOT NULL,
    data_utworzenia timestamp with time zone NOT NULL,
    forum_id integer NOT NULL,
    tytul_tsv tsvector
);


ALTER TABLE public."DFor_temat" OWNER TO django;

--
-- Name: DFor_temat_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE "DFor_temat_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."DFor_temat_id_seq" OWNER TO django;

--
-- Name: DFor_temat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE "DFor_temat_id_seq" OWNED BY "DFor_temat".id;


--
-- Name: DFor_temat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('"DFor_temat_id_seq"', 41, true);


--
-- Name: DFor_uzytkownik; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE "DFor_uzytkownik" (
    id integer NOT NULL,
    uzytkownik_id integer NOT NULL,
    data_urodzenia date,
    plec character varying(1) NOT NULL,
    miejscowosc character varying(100) NOT NULL,
    avatar character varying(100) NOT NULL,
    podpis text NOT NULL
);


ALTER TABLE public."DFor_uzytkownik" OWNER TO django;

--
-- Name: DFor_uzytkownik_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE "DFor_uzytkownik_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public."DFor_uzytkownik_id_seq" OWNER TO django;

--
-- Name: DFor_uzytkownik_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE "DFor_uzytkownik_id_seq" OWNED BY "DFor_uzytkownik".id;


--
-- Name: DFor_uzytkownik_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('"DFor_uzytkownik_id_seq"', 6, true);


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO django;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO django;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO django;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO django;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO django;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO django;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('auth_permission_id_seq', 33, true);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    username character varying(30) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(75) NOT NULL,
    password character varying(128) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    is_superuser boolean NOT NULL,
    last_login timestamp with time zone NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO django;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO django;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO django;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO django;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('auth_user_id_seq', 6, true);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO django;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO django;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    content_type_id integer,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO django;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO django;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 35, true);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO django;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO django;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('django_content_type_id_seq', 11, true);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO django;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: django; Tablespace: 
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO django;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: django
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO django;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: django
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: django
--

SELECT pg_catalog.setval('django_site_id_seq', 1, true);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY "DFor_forum" ALTER COLUMN id SET DEFAULT nextval('"DFor_forum_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY "DFor_post" ALTER COLUMN id SET DEFAULT nextval('"DFor_post_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY "DFor_temat" ALTER COLUMN id SET DEFAULT nextval('"DFor_temat_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY "DFor_uzytkownik" ALTER COLUMN id SET DEFAULT nextval('"DFor_uzytkownik_id_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: django
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Data for Name: DFor_forum; Type: TABLE DATA; Schema: public; Owner: django
--

COPY "DFor_forum" (id, nazwa, opis) FROM stdin;
5	BMW	Seria 1, 3, 5, 7, X1, X3, X5
4	Skutery	50 cc i większe
\.


--
-- Data for Name: DFor_post; Type: TABLE DATA; Schema: public; Owner: django
--

COPY "DFor_post" (id, autor_id, temat_id, data_utworzenia, data_modyfikacji, tekst, safe, tekst_tsv) FROM stdin;
12	6	9	2012-09-03 21:18:12.152513+02	2012-09-03 21:18:12.152567+02	<p><strong>BMW serii 1 [E81, E82, E87, E88]</strong> &ndash; samoch&oacute;d kompaktowy produkowany przez koncern BMW od 2004 roku. Zaprojektowany jako konkurent Audi A3. BMW E81/E87 jest obecnie jedynym kompaktem z napędem na tylną oś.</p>	t	'1':3 '2004':16 'a3':22 'audi':21 'bmw':1,14,23 'd':9 'e81':4 'e81/e87':24 'e82':5 'e87':6 'e88':7 'jaka':19 'jedyne':27 'jedyny':27 'kompakt':28 'kompaktowy':10 'koncern':13 'konkurent':20 'napęd':30 'obecny':26 'oda':15 'osi':33 'oś':33 'produkować':11 'rok':17 'samoch':8 'seria':2 'tylny':32 'zaprojektować':18 'ź':29
11	3	9	2012-09-03 21:17:00.996985+02	2012-09-03 21:17:00.997044+02	<p><strong>BMW serii 1</strong> &ndash; samoch&oacute;d kompaktowy, produkowany od 2004 roku przez niemiecką firmę BMW. Samoch&oacute;d występuje jako 3- i 5-drzwiowy hatchback oraz kabriolet i coup&eacute;. W połowie 2011 roku zaprezentowana została druga generacja serii 1.</p>	t	'1':3,37 '2004':9 '2011':30 '3':19 '5':21 'bmw':1,14 'coup':27 'd':5,16 'drugi':34 'drzwiowy':22 'firma':13 'generacja':35 'hatchback':23 'jaka':18 'kabriolet':25 'kompaktowy':6 'niemiecki':12 'oda':8 'połowa':29 'połów':29 'produkować':7 'rok':10,31 'samoch':4,15 'seria':2,36 'występować':17 'zaprezentować':32 'zostać':33
13	5	9	2012-09-03 21:19:17.24359+02	2012-09-03 21:19:17.243645+02	<p><strong>BMW F20</strong> &ndash; zadebiutowało w 2011 roku. Jest następcą BMW E87. Tak jak poprzednik, samoch&oacute;d należy do segmentu C.</p>	t	'2011':5 'bmw':1,9 'd':15 'e87':10 'f20':2 'jaka':12 'naleźć':16 'następca':8 'poprzednik':13 'rok':6 'samoch':14 'segment':18 'zadebiutować':3 'ć':19
14	5	10	2012-09-03 21:20:36.787334+02	2012-09-03 21:20:36.787392+02	<p><strong>BMW Serii 3</strong> &ndash; rodzina samochod&oacute;w średniej klasy BMW produkowana od 1975 roku.</p>	t	'1975':12 '3':3 'bmw':1,9 'klasa':8 'klasy':8 'oda':11 'produkować':10 'rodzina':4 'rok':13 'samochód':5 'seria':2 'średni':7
15	3	10	2012-09-03 21:21:18.593139+02	2012-09-03 21:21:18.593195+02	<p><strong>BMW F30</strong> to sz&oacute;sta generacja serii 3. Jej premiera odbyła się 14 października 2011 roku, a sam model jest dostępny w salonach od 11 lutego 2012.</p>	t	'11':25 '14':13 '2011':15 '2012':27 '3':8 'bmw':1 'dostępny':21 'f30':2 'generacja':6 'luty':26 'modła':19 'oda':24 'odbyć':11 'październik':14 'premier':10 'premiera':10 'rok':16 'salon':23 'seria':7 'sta':5 'sz':4 'ą':17 'śam':18
16	1	11	2012-09-03 21:22:08.767428+02	2012-09-03 21:22:08.767487+02	<p><strong>BMW serii 5</strong> &ndash; rodzina samochod&oacute;w klasy średniej-wyższej BMW, produkowana w kolejnych generacjach od 1972 roku. Poprzednikiem serii 5 było <span class="mw-redirect">BMW E115</span>.</p>	t	'1972':17 '5':3,21 'bmw':1,11,23 'e115':24 'generacja':15 'klasa':7 'klasy':7 'kolejny':14 'oda':16 'poprzednik':19 'produkować':12 'rodzina':4 'rok':18 'samochód':5 'seria':2,20 'wyższy':10 'średni':9 'średniej-wyższej':8
17	1	11	2012-09-03 21:22:33.995884+02	2012-09-03 21:22:33.995938+02	<p><strong>BMW E60</strong> &ndash; w 2003 roku na rynek wszedł nowy model serii 5 o kodzie fabrycznym E60, jako zastępca wersji E39. Jego zawieszenie składa się niemal wyłącznie z aluminiowych komponent&oacute;w. W zawieszeniu zastosowano stabilizatory r&oacute;żnej grubości, regulowane amortyzatory i aktywny układ kierowniczy. Opr&oacute;cz sedana BMW oferuje wersję <em>Touring</em> (kombi). Paleta silnikowa została gruntownie odświeżona, paletę modelową stanowią silniki benzynowe 520i, 523i, 525i, 530i, 540i, 550i oraz diesle 520d, 525d, 530d, i 535d.</p>	t	'2003':4 '5':12 '520d':70 '520i':62 '523i':63 '525d':71 '525i':64 '530d':72 '530i':65 '535d':74 '540i':66 '550i':67 'aktywny':41 'aluminiowy':28 'amortyzator':39 'benzynowy':61 'bmw':1,47 'cz':45 'diesel':69 'e39':20 'e60':2,16 'fabryczny':15 'grubość':37 'gruntowny':55 'jaka':17 'kierowniczy':43 'kod':14 'koda':14 'kombi':51 'komponent':29 'komponenta':29 'mala':25 'malo':25 'modelowy':58 'modła':10 'niemal':25 'nowy':9 'odświeżać':56 'oferować':48 'opr':44 'paleta':57 'pałętać':52 'r':35 'regulować':38 'rok':5 'rynek':7 'rynka':7 'sedan':46 'seria':11 'silnik':60 'silnikowy':53 'składać':23 'stabilizator':34 'stan':59 'touring':50 'układ':42 'wejście':8 'wejść':8 'wersja':19,49 'wyłączny':26 'zastosować':33 'zastępca':18 'zawiesić':22,32 'zostać':54 'ó':13 'ź':27 'żnej':36
18	4	11	2012-09-03 21:23:38.331921+02	2012-09-03 21:25:21.772622+02	<p><strong><strong>BMW 5</strong> (F10) &ndash; nowy model BMW serii 5</strong></p>\r\n<p><strong>BMW 5 F10</strong> produkowany jest z przeznaczeniem na rynek europejski oraz amerykański.</p>	t	'5':2,8,10 'amerykański':20 'bmw':1,6,9 'europejski':18 'f10':3,11 'modła':5 'nowy':4 'produkować':12 'przeznaczenie':15 'przeznaczyć':15 'rynek':17 'rynka':17 'seria':7 'ź':14
19	1	12	2012-09-03 21:26:20.239005+02	2012-09-03 21:26:20.239065+02	<p><strong>Yamaha Aerox 50</strong> &ndash; sportowy skuter, zadebiutował w roku 1997. Gł&oacute;wnie przeznaczony do ruchu miejskiego. Aeroxa napędza silnik dwusuwowy firmy Minarelli (należącej do koncernu Yamaha) o pojemności 49 cm&sup3; i mocy ok. 3,4 KW, chłodzony cieczą. Skuter posiada charakterystyczny, sportowy wygląd. Zawieszenie Paioli oraz 2 hamulce tarczowe firmy Brembo nadają wyścigowego charakteru. Osadzony został na 13-calowych kołach. Średnie spalanie wynosi ok. 3/100 km.</p>	t	'13':57 '1997':9 '2':46 '3':33 '3/100':64 '4':34 '49':28 '50':3 'aerox':2 'aeroxa':16 'brembo':50 'calowy':58 'charakter':53 'charakterystyczny':40 'chłodzić':36 'chłodzący':36 'ciecz':37 'cm':29 'dwusuwowy':19 'firma':20,49 'gł':10 'hamulce':47 'hamulec':47 'km':65 'koncern':24 'kołowy':59 'kw':35 'miejski':15 'minarelli':21 'moc':31 'nadawać':51 'należeć':22 'napędzać':17 'ok':32,63 'oko':32,63 'osadzić':54 'paioli':44 'pojemność':27 'posiadać':39 'przeznaczenie':12 'przeznaczyć':12 'rok':8 'ruch':14 'silnik':18 'skuter':5,38 'spalać':61 'sportowy':4,41 'tarczowe':48 'tarczowy':48 'wnie':11 'wygląd':42 'wynosić':62 'wyścig':52 'yamaha':1,25 'zadebiutować':6 'zawiesić':43 'zostać':55 'ó':26 'średni':60
20	1	13	2012-09-03 21:26:55.60776+02	2012-09-03 21:26:55.607819+02	<p>Peugeot JetForce to skuter o agresywnej, sportowej stylistyce.</p>	t	'agresywny':6 'jetforce':2 'peugeot':1 'skuter':4 'sportowy':7 'stylistyka':8 'ó':5
21	3	12	2012-09-03 21:27:49.281921+02	2012-09-03 21:27:49.281985+02	<p>Silnik dwusuwowy/ chłodzony cieczą.</p>	t	'chłodzić':3 'chłodzący':3 'ciecz':4 'dwusuwowy':2 'silnik':1
22	3	14	2012-09-03 21:28:27.117999+02	2012-09-03 21:28:27.118058+02	<p>Nowy sportowy Daelim S-Five rozwija tylko 3,2 KM, ale jego silnik z powodzeniem udaje znacznie mocniejszy. Inna jego zaleta to co najmniej dobre własności prowadzenia.</p>	t	'2':10 '3':9 'ala':12 'ca':24 'daelim':3 'dobre':26 'dobry':26 'five':6 'inny':20 'km':11 'mocniejszy':19 'najmniej':25 'nowy':1 'powodzić':16 'prowadzić':28 'rozwijać':7 's-five':4 'silnik':14 'sportowy':2 'tylek':8 'udawać':17 'własność':27 'zaleta':22 'znaczny':18 'ś':5 'ź':15
23	6	14	2012-09-03 21:28:52.532806+02	2012-09-03 21:28:52.532863+02	<p>Koreańczyk z charakterem</p>	t	'charakter':3 'koreańczyk':1 'ź':2
24	6	12	2012-09-03 21:29:24.070181+02	2012-09-03 21:29:24.070238+02	<p>Moc maksymalna&nbsp;: 3,4 kW przy 6500 obr./min, wersja otwarta 3,60 kW</p>	t	'./min':9 '3':3,12 '4':4 '60':13 '6500':7 'kw':5,14 'maksymalny':2 'móc':1 'obr':8 'otwarty':11 'wersja':10
25	5	13	2012-09-03 21:30:17.357862+02	2012-09-03 21:30:17.357917+02	<p>Jazda na tym skuterze jest bardzo komfortowa. Zawieszenie jest miękkie, bardzo dobrze tłumi nier&oacute;wności drogi. Konstrukcja osłon chroni kierowcę przed wiatrem. Pasażer siedzi bardzo wysoko, nogi stawia na rozkładanych podn&oacute;żkach. W przypadku silnika TSDI, ruszanie z miejsca odbywa się gwałtownie, przy wysokich prędkościach obrotowych silnika. Układ dolotowy oraz wydechowy wydają dość głośny hałas. Siedzenie pasażera jest odkręcane, pod nim znajduje się akumulator.</p>	t	'akumulator':64 'chronić':19 'dobra':12 'dobro':12 'dobry':12 'dolotowy':49 'droga':16 'drogi':16 'gwałtowny':42 'głośnia':54 'hałas':55 'jazda':1 'kierowca':20 'komfortowy':7 'konstrukcja':17 'miejsca':39 'miejsce':39 'miękki':10 'miękkie':10 'noga':27 'obrotowy':46 'odbywać':40 'odkręcać':59 'osłona':18 'pasażer':23,57 'podn':31 'przypadek':34 'prędkość':45 'rozkładać':30 'ruszać':37 'ryć':14 'siedzieć':24,56 'silnik':35,47 'skuter':4 'stawić':28 'tsdi':36 'tłumica':13 'układ':48 'wiatrem':22 'wności':15 'wydajać':52 'wydechowy':51 'wysoki':26,44 'wysoko':26 'zawiesić':8 'znajdować':62 'ź':38 'żkach':32
26	4	13	2012-09-03 21:30:44.310179+02	2012-09-03 21:30:44.310239+02	<p>Peugeot Jetforce występuje w wersjach C-TECH (wersja z gaźnikiem) oraz TSDI (wersja na wtrysku, obecnie nie produkowana). Obydwie wersje oferowane są r&oacute;wnież z pakietem stylistycznym R-Cup charakteryzującym się aluminiowymi podkładkami pod nogi, inną stylistyką przednich lamp oraz inną kolorystyką. Jetforce C-Tech posiada r&oacute;wnież wydaną w 2008 roku wersję DarkSide, kt&oacute;ra charakteryzuje się lakierem - ma on r&oacute;żne odcienie szarości, innym ogumieniem oraz nacinanymi tarczami hamulcowymi.</p>	t	'2008':54 'aluminiowy':34 'c-tech':6,46 'charakteryzować':32,60 'cup':31 'darkside':57 'gaźnik':11 'hamulcowy':74 'jetforce':2,45 'kolorystyka':44 'kt':58 'lakier':62 'lamp':41 'lampa':41 'lampić':41 'lampy':41 'mój':63 'nacinać':72 'noga':37 'obecny':17 'obydwie':20 'odcień':67 'oferować':22 'ogumić':70 'oń':64 'pakiet':27 'peugeot':1 'podkładka':35 'posiadać':49 'produkować':19 'przedni':40 'r':24,30,50,65 'r-cup':29 'ra':59 'rok':55 'stylistyczny':28 'stylistyka':39 'szarość':68 'tarcza':73 'tech':8,48 'tsdi':13 'wersja':5,9,14,21,56 'wnież':25,51 'wtrysk':16 'wydać':52 'występować':3 'ć':7,47 'ź':10,26 'żne':66
27	4	15	2012-09-03 21:37:50.578302+02	2012-09-03 21:37:50.578361+02	<p><strong>Jest to włoska niezawodna maszyna o&nbsp;sportowej sylwetce. Swoją wytrzymałość zawdzięcza w&nbsp;dużej mierze popularnej jednostce Minarelli chłodzonej cieczą, co dodatkowo zmniejsza usterkowość jednośladu.</strong></p>	t	'ca':20 'chłodzić':18 'chłodzący':18 'ciecz':19 'dodatkowy':21 'dużej':13 'duży':13 'jednostka':16 'jednoślad':24 'maszyna':5 'mierzić':14 'minarelli':17 'popularny':15 'sportowy':7 'swoją':9 'sylwetka':8 'usterkowość':23 'wytrzymałość':10 'włosek':3 'zawdzięczać':11 'zawodny':4 'zmniejszyć':22 'ó':6
28	4	16	2012-09-03 21:38:33.941747+02	2012-09-03 21:38:33.941807+02	<p><strong>BMW serii 7</strong> &ndash; seria luksusowych samochod&oacute;w klasy wyższej produkowanych przez niemiecki koncern BMW. Wprowadzona została w 1977 r. Dostępna tylko w wersji sedan.</p>	t	'1977':18 '7':3 'bmw':1,14 'dostępny':20 'klasa':8 'klasy':8 'koncern':13 'luksusowy':5 'niemiecki':12 'produkować':10 'r':19 'samochód':6 'sedan':24 'seria':2,4 'tylek':21 'wersja':23 'wprowadzić':15 'wyższy':9 'zostać':16
29	5	17	2012-09-03 21:39:47.946786+02	2012-09-03 21:39:47.946845+02	<p><strong>Aprilia Area jest skuterem, kt&oacute;ry może się spodobać lub nie. Jej stylistyka jest mocno kontrowersyjny, ale uważam to za jej ogromny atut.</strong></p>	t	'ala':17 'aprilia':1 'area':2 'atut':23 'kontrowersyjny':16 'kt':5 'mocno':15 'móc':7 'ogromny':22 'ry':6 'skuter':4 'spodobać':9 'stylistyk':13 'stylistyka':13 'uważać':18 'łub':10
30	6	18	2012-09-03 21:43:37.495491+02	2012-09-03 21:43:47.140133+02	<p>Piękna stylistyka.</p>	t	'piękno':1 'stylistyk':2 'stylistyka':2
31	6	19	2012-09-03 21:44:40.822291+02	2012-09-03 21:44:40.82235+02	<p><strong>BMW X1</strong> &ndash; samoch&oacute;d osobowy typu SUV produkowany od końca 2009 roku przez niemiecki koncern BMW. Jest to najmniejszy model tego segmentu firmy BMW.</p>	t	'2009':11 'bmw':1,16,24 'd':4 'firma':23 'koncern':15 'koniec':10 'modła':20 'najmniejszy':19 'niemiecki':14 'oda':9 'osobowy':5 'produkować':8 'rok':12 'samoch':3 'segment':22 'suv':7 'typ':6 'tęgi':21 'x1':2
32	1	20	2012-09-03 21:46:27.78903+02	2012-09-03 21:46:27.78909+02	<p><strong>BMW X3 E83</strong> - BMW X3 to pierwszy przedstawiciel klasy premium segmentu <span class="new">SAV</span> (Sports Activity Vehicle), kt&oacute;ry łączy cechy auta kompaktowego z właściwościami jezdnymi starszego i większego brata, modelu X5. W wielu przypadkach BMW X3 bazuje na tych samych lub podobnych rozwiązaniach, co większy model w gamie koncernu. Po raz pierwszy BMW X3 zaprezentowane zostało na targach IAA we Frankfurcie w 2003, a do sprzedaży trafiło w pierwszym kwartale 2004. We wrześniu 2006 pojawiła się nieco odmłodzona wersja BMW X3.</p>	t	'2003':62 '2004':70 '2006':73 'activity':14 'auto':20 'bazować':36 'bmw':1,4,34,52,79 'brata':28 'bratać':28 'ca':43,76 'cech':19 'cecha':19 'coa':76 'cy':76 'e83':3 'frankfurt':60 'gama':47 'iaa':58 'jezdny':24 'klasa':9 'klasy':9 'kompaktowy':21 'koncern':48 'kt':16 'kwartał':69 'model':29 'modła':45 'nieco':76 'odmłodzić':77 'pierwsza':68 'pierwsze':68 'pierwszy':7,51,68 'podobny':41 'pojawić':74 'premium':10 'przedstawiciel':8 'przypadek':33 'razić':50 'rozwiązać':42 'ry':17 'samych':39 'sav':12 'segment':11 'sports':13 'sprzedaż':65 'sprzedaży':65 'starszy':25 'targ':57 'trafić':66 'tychy':38 'vehicle':15 'wersja':78 'większy':27,44 'wrzesień':72 'właściwość':23 'x3':2,5,35,53,80 'x5':30 'zaprezentować':54 'zostać':55 'ą':63 'łub':40 'łączony':18 'łączyć':18 'ź':22
41	6	26	2012-09-03 22:00:05.949659+02	2012-09-03 22:00:05.949716+02	<p><strong>Silnik 300 cm</strong><strong>3</strong><strong>, najmocniejszy jaki kiedykolwiek zamontowano w&nbsp;Vespie, dodaje do elegancji designu charakter i&nbsp;moc. </strong></p>	t	'3':4 '300':2 'charakter':15 'cm':3 'design':14 'dodawać':11 'elegancja':13 'jaka':6 'kiedykolwiek':7 'móc':17 'najmocniejszy':5 'silnik':1 'vespie':10 'zamontować':8
42	6	26	2012-09-03 22:00:35.937473+02	2012-09-03 22:00:35.937531+02	<p><strong>Vespa GTS 300 ma być dystynktywnym wyborem wśr&oacute;d skuter&oacute;w GT.</strong></p>	t	'300':3 'd':9 'dystynktywny':6 'gt':12 'gts':2 'mój':4 'skuter':10 'vespa':1 'wybory':7 'wybór':7 'wśr':8
68	3	33	2012-09-03 22:27:07.933413+02	2012-09-03 22:27:07.9335+02	<p><strong>50cc sportowy</strong></p>	t	'50cc':1 'sportowy':2
33	1	21	2012-09-03 21:47:24.636825+02	2012-09-03 21:47:24.636944+02	<p>Podbij miasto albo ucieknij z&nbsp;niego. Cokolwiek zamierzasz zrobić, z&nbsp;pomocą maksiskutera <strong>C 650 GT</strong> uczynisz to w&nbsp;niezależny, samodzielny spos&oacute;b.</p>\r\n<p>Prężny, doskonale dobrany i&nbsp;oszczędny silnik o&nbsp;mocy 44 kW (60 KM) oferuje osiągi, kt&oacute;re możesz w&nbsp;pełni wykorzystać r&oacute;wnież na dłuższych trasach. Na każdym dystansie możesz natomiast doświadczyć niezwykłej łatwości prowadzenia oraz ponadprzeciętnego komfortu jazdy. Zwłaszcza w&nbsp;ruchu miejskim da Ci on poczucie wolności i&nbsp;niezależności, kt&oacute;rego teraz nie będzie Ci już brakować. Począwszy od ramy a&nbsp;skończywszy na wyrazistej stylistyce pod każdym względem ten maksiskuter pokazuje sw&oacute;j nadzwyczajny charakter. Co więcej, zapewnia największą pojemność schowka w&nbsp;swojej klasie oraz doskonałą ochronę przed wiatrem i&nbsp;innymi czynnikami atmosferycznymi.</p>	t	'44':31 '60':33 '650':14 'alba':3 'atmosferyczny':115 'b':22 'brakować':79 'ca':98 'charakter':97 'czynnik':114 'dać':65 'dobrać':25 'doskonalić':24,108 'doświadczyć':53 'dystans':50 'dłuższy':46 'ga':6 'gen':6 'goa':6 'gt':15 'j':95 'jazda':60 'klasa':106 'klasie':106 'km':34 'komfort':59 'kt':37,72 'kw':32 'maksiskuter':92 'maksiskutera':12 'miasto':2 'miejski':64 'moc':30 'móc':39,51 'nadzwyczajny':96 'największy':101 'niezależność':71 'ochrona':109 'oda':81 'oferować':35 'osiąg':36 'oszczędny':27 'oń':67 'pełnia':41 'poczuć':68 'począwszy':80 'podbicie':1 'podbić':1 'pojemność':102 'pokazywać':93 'pomoc':11 'pomocą':11 'ponadprzeciętny':58 'prowadzić':56 'prężnia':23 'r':43 'rama':82 'ramy':82 're':38 'rega':73 'ruch':63 'samodzielny':20 'schowek':103 'silnik':28 'skończywszy':84 'spos':21 'stylistyka':87 'sw':94 'swojej':105 'tras':47 'trasa':47 'uciec':4 'uczynić':16 'wiatrem':111 'wnież':44 'wolność':69 'wykorzystać':42 'wyrazisty':86 'wzgląd':90 'zależność':71 'zależny':19 'zamierzać':8 'zapewnić':100 'zrobić':9 'zwykły':54 'zwłaszcza':61 'ó':29 'ą':83 'ć':13 'łatwość':55 'ź':5,10
34	3	22	2012-09-03 21:50:17.490874+02	2012-09-03 21:50:17.490934+02	<p><strong>BMW X5</strong> &ndash; samoch&oacute;d sportowo-użytkowy produkowany przez firmę BMW od 1999 roku. Zadebiutował na rynku Stan&oacute;w Zjednoczonych w roku 1999, w Europie natomiast oferowany jest od 2000 roku. Dotychczas powstały dwie generacje tej serii: E53 produkowana w latach 1999&ndash;2006, oraz E70 produkowana od 2006 roku.</p>	t	'1999':13,23,42 '2000':30 '2006':43,48 'bmw':1,11 'd':4 'dotychczas':32 'e53':38 'e70':45 'europ':25 'europa':25 'europie':25 'firma':10 'generacja':35 'oda':12,29,47 'oferować':27 'powstać':33 'produkować':8,39,46 'rok':14,22,31,49 'rynek':17 'rynku':17 'samoch':3 'seria':37 'sportowo':6 'sportowo-użytkowy':5 'sportowy':6 'stan':18 'użytek':7 'x5':2 'zadebiutować':15 'zjednoczenie':20 'zjednoczyć':20 'łata':41
36	3	23	2012-09-03 21:53:02.189858+02	2012-09-03 21:53:29.197722+02	<p>W przypadku <strong>C 600 Sport</strong> masz do czynienia z&nbsp;prawdziwym BMW &ndash; zauważysz to najp&oacute;źniej wtedy, gdy na niego wsiądziesz. Ekscytujące wrażenia z&nbsp;jazdy idą tu w&nbsp;parze z&nbsp;uderzającym wdziękiem starannie przygotowanych detali: duży schowek ustawia imponująco wysoko poprzeczkę funkcjonalności i&nbsp;komfortu, a&nbsp;regulowana przednia szyba pozwala zrozumieć, dlaczego jazda maksiskuterem <strong>C 600 Sport</strong> jest r&oacute;wnie komfortowa co sportowa. C 600 Sport <span id="nsitsp_3" style="border-bottom: 1px solid #00a5be; margin: 0pt; padding: 0px 0px 1px; display: inline; color: #00a5be; font-weight: bold; text-decoration: underline; cursor: pointer; float: none;"></span> daje zupełnie nowe spojrzenie na świat, w&nbsp;kt&oacute;rym na co dzień się poruszamy.</p>	t	'600':4,54,63 'bmw':11 'ca':60,75 'czynić':8 'dawać':65 'detal':34 'duży':35 'dzień':76 'ekscytować':21 'funkcjonalność':41 'ga':19 'gen':19 'goa':19 'id':25 'ida':25 'idy':25 'imponować':38 'jazda':24,51 'komfort':43 'komfortowy':59 'kt':72 'maksiskuterem':52 'masz':6 'najp':14 'nowa':67 'nowe':67 'nowy':67 'par':28 'para':28 'parać':28 'poprzeczka':40 'poruszać':78 'pozwać':48 'prawdziwy':10 'przedni':46 'przygotować':33 'przypadek':2 'r':57 'regulować':45 'rym':73 'schowek':36 'spojrzeć':68 'sport':5,55,64 'sportowy':61 'staranny':32 'szyba':47 'uderzać':30 'ustawić':37 'wdzięk':31 'wnie':58 'wrazić':22 'wsiąść':20 'wysoki':39 'wysoko':39 'zauważać':12 'zrozumieć':49 'zupełny':66 'ą':44 'ć':3,53,62 'świat':70 'ź':9,23,29 'źniej':15
35	3	23	2012-09-03 21:52:23.192793+02	2012-09-03 21:53:54.656803+02	<p>Miasto czeka na Ciebie. I&nbsp;na pierwszy maksiskuter BMW Motorrad. Nowy <strong>C 600 Sport</strong> to wyb&oacute;r idealny dla wszystkich, kt&oacute;rzy chcą być inteligentnie mobilni, a&nbsp;przy tym chcą doznać niepowtarzalnych wrażeń z&nbsp;jazdy jednośladem<span id="nsitsp_1" style="border-bottom: 1px solid #00a5be; margin: 0pt; padding: 0px 0px 1px; display: inline; color: #00a5be; font-weight: bold; text-decoration: underline; cursor: pointer; float: none;"></span> BMW Motorrad. <strong>C 600 Sport</strong> oferuje doskonałe prowadzenie i&nbsp;najwyższej klasy układ napędowy. Oryginalny desing w&nbsp;charakterystycznym stylu BMW będzie z&nbsp;pewnością przyciągać uwagę w&nbsp;mieście. Tak się podchodzi do nowoczesnego transportu <span id="nsitsp_2" style="border-bottom: 1px solid #00a5be; margin: 0pt; padding: 0px 0px 1px; display: inline; color: #00a5be; font-weight: bold; text-decoration: underline; cursor: pointer; float: none;"></span>. Świat pełen możliwości, przyg&oacute;d i&nbsp;wyzwań.</p>	t	'600':13,40 'bmw':9,37,55 'charakterystyczny':53 'chcieć':23,30 'chcący':23,30 'czekać':2 'd':73 'desing':51 'doskonalić':43 'doznać':31 'idealny':18 'inteligentny':25 'jazda':35 'jednoślad':36 'klasa':47 'klasy':47 'kt':21 'maksiskuter':8 'miasto':1,62 'mobilny':26 'motorrad':10,38 'możliwości':71 'możliwość':71 'najwyższy':46 'napęd':49 'nowoczesny':67 'nowy':11 'oferować':42 'oryginalny':50 'pewnością':58 'pewność':58 'pełen':70 'pierwszy':7 'podchodzić':65 'podchodzący':65 'powtarzalny':32 'prowadzić':44 'przyciągać':59 'przyg':72 'r':17 'reż':22 'sport':14,41 'styl':54 'stylo':54 'transport':68 'układ':48 'uwaga':60 'wrazić':33 'wyb':16 'wyzwać':75 'ą':27 'ć':12,39 'świat':69 'ź':34,57
37	5	24	2012-09-03 21:55:58.960525+02	2012-09-03 21:55:58.960584+02	<p>Moc maksymalna:4,8 KM przy 7250 obr/min</p>	t	'4':3 '7250':7 '8':4 'km':5 'maksymalny':2 'móc':1 'obr/min':8
38	5	25	2012-09-03 21:56:49.856299+02	2012-09-03 21:56:49.856372+02	<p>Prędkość maks.:45 km/h ( zablokowany )</p>	t	'45':3 'km/h':4 'maks':2 'prędkość':1 'zablokować':5
39	5	23	2012-09-03 21:57:47.994623+02	2012-09-03 21:57:47.994677+02	<p><strong>Dzięki temu maksiskuterowi można pokonywać codzienne trasy nie tylko łatwiej, ale także z&nbsp;większą przyjemnością. Połączenie <span id="nsitsp_0" style="border-bottom: 1px solid #00a5be; margin: 0pt; padding: 0px 0px 1px; display: inline; color: #00a5be; text-decoration: underline; cursor: pointer; float: none;"></span> doskonałego prowadzenia i&nbsp;wyjątkowych osiąg&oacute;w to coś, czego po prostu trzeba doświadczyć z&nbsp;na własną rękę.</strong></p>\r\n<p><strong>Nowy C 600 Sport &ndash; o&nbsp;tym się m&oacute;wi na mieście.</strong></p>	t	'600':36 'ala':11 'codzienny':6 'czego':25 'doskonalić':17 'doświadczyć':29 'dzięki':1 'm':41 'maksiskuterowi':3 'miasto':44 'możny':4 'nowy':34 'osiąg':21 'pokonywać':5 'połączenie':16 'połączyć':16 'prostu':27 'prowadzić':18 'przyjemność':15 'ręka':33 'rękę':33 'sport':37 'temu':2 'tras':7 'trasa':7 'tylek':9 'wi':42 'większy':14 'wyjątek':20 'własny':32 'ó':38 'ć':35 'łatwiej':10 'ź':13,30
40	6	26	2012-09-03 21:59:47.382235+02	2012-09-03 21:59:47.382293+02	<p><strong>Vespa GTS, prototyp nowoczesnej sportowej Vespy, rośnie &ndash; zar&oacute;wno jeśli chodzi o&nbsp;pojemność cylindra <span id="nsitsp_3" style="border-bottom: 1px solid #00a5be; margin: 0pt; padding: 0px 0px 1px; display: inline; color: #00a5be; font-weight: bold; text-decoration: underline; cursor: pointer; float: none;"></span>jak osiągi.</strong></p>	t	'chodzenie':11 'chodzić':11 'cylinder':14 'gts':2 'jaka':15 'nowoczesny':4 'osiąg':16 'pojemność':13 'prototyp':3 'rościć':7 'sportowy':5 'vespa':1 'vespy':6 'wno':9 'ó':12 'żary':8
43	4	26	2012-09-03 22:01:15.741213+02	2012-09-03 22:01:15.741269+02	<p><strong>Jako jedyna może zaoferować całą klasę i&nbsp;ekskluzywny charakter Vespy, a&nbsp;ponadto zwinność i&nbsp;dynamizm połączone z&nbsp;osiągami i&nbsp;technologicznymi standardami klasy 300. </strong></p>	t	'300':23 'charakter':9 'dynamizm':15 'ekskluzywny':8 'jaka':1 'jedyny':2 'klasa':6,22 'klasy':22 'klasę':6 'móc':3 'osiąg':18 'ponadto':12 'połączenie':16 'połączyć':16 'standard':21 'technologiczny':20 'vespy':10 'zaoferować':4 'zwinność':13 'ą':11 'ź':17
44	4	26	2012-09-03 22:01:56.624044+02	2012-09-03 22:01:56.624101+02	<p>Kształt stalowego nadwozia <span id="nsitsp_2" style="border-bottom: 1px solid #00a5be; margin: 0pt; padding: 0px 0px 1px; display: inline; color: #00a5be; cursor: pointer; float: none;"></span> to linie udanej serii Vespa GTS, kt&oacute;ra zadebiutowawszy w2005 r., zdefiniowała od nowa techniczne i&nbsp;estetyczne kanony najbardziej sportowejVespy.</p>	t	'estetyczny':20 'gts':9 'kanon':21 'kształt':1 'kt':10 'linia':5 'nadwozie':3 'najbardziej':22 'nowy':17 'oda':16 'r':14 'ra':11 'seria':7 'sportowejvespy':23 'stalowy':2 'techniczny':18 'udać':6 'vespa':8 'w2005':13 'zadebiutowawszy':12 'zdefiniować':15
45	4	26	2012-09-03 22:02:14.009697+02	2012-09-03 22:02:14.009753+02	<p><strong>Tylna grupa optyczna</strong>, bogata tablica instrument&oacute;w, <strong>duża kanapa </strong>o dynamicznejlinii, stylowy <strong>tylny bagażnik </strong>- to tylko niekt&oacute;re z&nbsp;cech rozpoznawczych Vespy z&nbsp;silnymzdecydowanym charakterem.</p>	t	'bagażnik':14 'bogaty':4 'cech':20 'cecha':20 'charakter':25 'duża':8 'duży':8 'dynamicznejlinii':11 'grupa':2 'instrument':6 'kanapa':9 'optyczny':3 're':18 'rozpoznawczy':21 'silnymzdecydowanym':24 'stylowy':12 'tablica':5 'tylek':16 'tylny':1,13 'vespy':22 'ó':10 'ź':19,23
46	4	27	2012-09-03 22:03:39.440826+02	2012-09-03 22:03:39.440954+02	<p>Rajd&oacute;wka</p>	t	'rajd':1 'wka':2
47	1	28	2012-09-03 22:05:38.753536+02	2012-09-03 22:05:38.753597+02	<p>Wyciągając najczystszą esencję z&nbsp;rys&oacute;w legendarnej Vespie MP6, styliści <span id="nsitsp_1" style="border-bottom: 1px solid #00a5be; margin: 0pt; padding: 0px 0px 1px; display: inline; color: #00a5be; font-weight: bold; text-decoration: underline; cursor: pointer; float: none;"></span> z&nbsp;Pontedery projektują Vespę w&nbsp;perspektywie przyszłych możliwości, gdzie tradycja i&nbsp;nowatorstwo ciągle łączą się ze sobą. <strong>Kolejny raz Vespa potrafi wyprzedzać czas projektując siebie samą na kształt przyszłości pod znakiem kreatywności i&nbsp;unikalnego stylu.</strong></p>\r\n<p>Jednocylindrowy, czterosuwowy, trzy zaworowy, chłodzony cieczą z&nbsp;elektronicznym wtryskiem silnik <span id="nsitsp_2" style="border-bottom: 1px solid #00a5be; margin: 0pt; padding: 0px 0px 1px; display: inline; color: #00a5be; font-weight: bold; text-decoration: underline; cursor: pointer; float: none;"></span> 125 cm3 jest wyrazem najbardziej zaawansowanej technologii wykorzystywanej przez Grupę Piaggio w&nbsp;silnikach do skuter&oacute;w.<br /> Nowy silnik został w&nbsp;całości zaprojektowany, rozwinięty i&nbsp;skonstruowany w&nbsp;Pontederze, największych zakładach Grupy Piaggio, będących jednym z&nbsp;najważniejszych i&nbsp;najnowocześniejszych centr&oacute;w badań, rozwoju i&nbsp;produkcji w&nbsp;dziedzinie silnik&oacute;w na świecie.</p>\r\n<p>Silnik zastosowany w&nbsp;silniku skutera <strong>Vespa 946</strong> innowacyjny układ rozrządu<span id="nsitsp_0" style="border-bottom: 1px solid #00a5be; margin: 0pt; padding: 0px 0px 1px; display: inline; color: #00a5be; font-weight: bold; text-decoration: underline; cursor: pointer; float: none;"></span> z&nbsp;trzema zaworami pozwala zoptymalizować ruchy w&nbsp;cylindrze, jak r&oacute;wnież ustawić świecę zapłonową w&nbsp;optymalnej pozycji, wpływając na lepszy przebieg procesu spalania i&nbsp;jednocześnie gwarantując optymalne chłodzenie wewnętrznych części głowicy.</p>\r\n<p>W celu ograniczenia tarcia wewnętrznego do wszystkich ruchomych komponent&oacute;w zastosowano łożyska: dźwigienki zaworowe mają rolki, co wpływa na cichą i&nbsp;lepszą od strony mechanicznej pracę, wałek rozrządu<span id="nsitsp_3" style="border-bottom: 1px solid #00a5be; margin: 0pt; padding: 0px 0px 1px; display: inline; color: #00a5be; font-weight: bold; text-decoration: underline; cursor: pointer; float: none;"></span> jest łożyskowany, podobnie jak cały reduktor końcowy.</p>\r\n<p>Układ chłodzenia został poddany wnikliwej analizie, r&oacute;wnież poprzez symulacje termofluidodynamiczne, tak by zwiększyć jego efektywność, i&nbsp;w rezultacie otrzymano wyraźną redukcję hałasu oraz poboru mocy.</p>\r\n<p>Wysoce zaawansowana technologia systemu wtrysku z&nbsp;automatyczną kontrolą minimum i&nbsp;sondą lambda korzystnie wpływa na funkcjonalność i&nbsp;prowadzenie pojazdu. Tr&oacute;jwymiarowymi mapami wyprzedzenia i&nbsp;fazami wtrysku steruje najnowszej generacji kontrolka. Tr&oacute;jwartościowy katalizator gwarantuje spełnianie normy Euro3, z&nbsp;dużym zapasem &ndash; także w&nbsp;perspektywie przyszłych coraz bardziej restrykcyjnych norm w&nbsp;zakresie obniżania emisji spalin.</p>\r\n<p>Osiągi z&nbsp;maksymalną mocą <strong>8.7 kW (prawie 12 KM) przy 8.250 obrotach na minutę</strong> i&nbsp;maksymalnym momentem obrotowym <strong>10.3 Nm przy 7.000 obrotach na minutę</strong> (w wersji 125 cm3) oraz mocą <strong>9.7 kW (ponad 13 KM) przy 8.000 obrotach na minutę</strong> i&nbsp;maksymalnym momentem obrotowym <strong>12.6 Nm przy 6.500 obrotach na minutę</strong> (w wersji 150 cm3) sytuują nowy silnik na szczycie poszczeg&oacute;lnych kategorii.</p>	t	'10.3':278 '12':267 '12.6':305 '125':56,287 '13':294 '150':314 '6.500':308 '7.000':281 '8.000':297 '8.250':270 '8.7':264 '9.7':291 '946':111 'analiza':186 'automatyczny':213 'badać':95 'będących':87 'ca':162 'całości':76 'całość':76 'cel':147 'celu':147 'center':93 'chłodzić':50,142,182 'chłodzący':50 'cichy':165 'ciecz':51 'ciągły':23 'cm3':57,288,315 'coraz':251 'cylinder':122 'czas':33 'czterosuwowy':47 'częsty':144 'duży':245 'dużym':245 'dziedzina':100 'dźwigienka':158 'efektywność':196 'elektroniczny':53 'emisja':258 'esencja':3 'euro3':243 'faza':231 'funkcjonalność':222 'generacja':235 'grupa':65,85 'gwarantować':240 'gwarantując':140 'głowica':145 'hałas':203 'innowacyjny':112 'jaka':123,177 'jednocylindrowy':46 'jednoczesny':139 'jednym':88 'jwartościowy':238 'jwymiarowymi':227 'katalizator':239 'kategoria':323 'km':268,295 'kolejny':28 'komponent':154 'komponenta':154 'koniec':180 'kontrola':214 'kontrolka':236 'korzystno':219 'korzystny':219 'kreatywność':42 'kształt':38 'kw':265,292 'lambda':218 'legendarny':7 'lepsza':167 'lepszy':134,167 'lnych':322 'maić':160 'maj':160 'maja':160 'maksymalny':262,275,302 'mapa':228 'mechaniczny':170 'minimum':215 'minuta':273,284,300,311 'moc':206,263,290 'moment':276,303 'możliwości':18 'możliwość':18 'mp6':9 'najbardziej':60 'najczystszy':2 'najnowocześniejszy':92 'najnowszy':234 'najważniejszy':90 'największy':83 'nm':279,306 'norma':242,254 'nowatorstwo':22 'nowy':72,317 'obniżać':257 'obrotowy':277,304 'obrót':271,282,298,309 'oda':168 'ograniczony':148 'ograniczyć':148 'optymalny':130,141 'osiąg':260 'otrzymać':200 'perspektywa':16,249 'piaggio':66,86 'pobory':205 'pobór':205 'poddać':184 'podobny':176 'pojazd':225 'pontedery':12 'pontederze':82 'poprzez':189 'poszczeg':321 'potrafić':31 'pozwać':118 'pozycja':131 'praca':171 'prawić':266 'proces':136 'produkcja':98 'projektować':13 'projektując':34 'prowadzić':224 'przebieg':135 'przyjść':17,250 'przyszłość':39 'r':124,187 'razić':29 'redukcja':202 'reduktor':179 'restrykcyjny':253 'rezultacie':199 'rezultat':199 'rolek':161 'rolka':161 'rolki':161 'rozrząd':114,173 'rozwinąć':78 'rozwój':96 'ruch':120 'ruchomy':153 'rys':5 'rysa':5 'samą':36 'siebie':35 'silnik':55,68,73,101,105,108,318 'skonstruować':80 'skuter':70,109 'sonda':217 'sondą':217 'spalać':137 'spaliny':259 'spełniać':241 'sterować':233 'strona':169 'styl':45 'stylista':10 'stylo':45 'symulacja':190 'system':210 'sytuować':316 'szczać':320 'szczycie':320 'szczyt':320 'technologia':62,209 'termofluidodynamiczne':191 'tr':226,237 'tracić':149 'tradycja':20 'trzema':116 'trzy':48 'układ':113,181 'unikalny':44 'ustawić':126 'vespa':30,110 'vespie':8 'vespę':14 'walk':172 'walków':172 'wersja':286,313 'wewnętrzny':143,150 'wnież':125,188 'wnikliwy':185 'wpływając':132 'wpływać':163,220 'wtrysk':54,211,232 'wyciągając':1 'wykorzystywać':63 'wyprzedzać':32 'wyprząść':229 'wyraz':59 'wyraźny':201 'wysoce':207 'zaawansować':61,208 'zakres':256 'zakład':84 'zapas':246 'zaprojektować':77 'zapłon':128 'zastosować':106,156 'zawora':117 'zaworowy':49,159 'znak':41 'zoptymalizować':119 'zostać':74,183 'zwiększać':194 'łożysko':157 'łożyskować':175 'łączony':24 'łączyć':24 'świeca':127 'świecie':104 'ź':4,11,52,89,115,212,244,261 'że':26
48	1	26	2012-09-03 22:06:20.704532+02	2012-09-03 22:06:20.704588+02	<p><strong>Oryginalne umieszczenie światła pozycyjnego </strong>na masce obok głośnika klaksonu jest wyraźnym odwołaniem do Vespy z&nbsp;lat 50-tych dopełniającym elegancję tej wersji.</p>	t	'50':17 'dopełniać':19 'elegancja':20 'głośnik':8 'klakson':9 'maśka':6 'odwołać':12 'oryginalny':1 'pozycyjny':4 'tychy':18 'umieścić':2 'vespy':14 'wersja':22 'wyraźny':11 'łat':16 'światła':3 'światło':3 'światły':3 'ź':15
49	1	26	2012-09-03 22:06:33.112263+02	2012-09-03 22:06:33.112318+02	<p>Z przodu Vespa GTS 300 jest natychmiast rozpoznawana dzięki <strong>chromowanemu</strong> <strong>elementowi </strong>na błotniku.</p>	t	'300':5 'błotnik':13 'chromować':10 'dzięki':9 'element':11 'gts':4 'przód':2 'rozpoznać':8 'vespa':3 'ź':1
50	1	26	2012-09-03 22:06:57.280929+02	2012-09-03 22:06:57.280988+02	<p><strong>Nowoczesne i&nbsp;zdecydowane </strong>linie nadwozia, okrągła i&nbsp;pochylona ku dołowi <strong>przednia lampa</strong>, wysuwane podn&oacute;żki dla pasażera to <a id="a_nsitsp_1" style="margin: 0px; padding: 0px; float: none; text-decoration: none; text-indent: 0px; display: inline; z-index: 0;"></a><span id="nsitsp_1" style="border-bottom: 1px solid #00a5be; margin: 0pt; padding: 0px 0px 1px; display: inline; color: #00a5be; font-weight: bold; text-decoration: underline; cursor: pointer; float: none;">cechy</span>, kt&oacute;re czynią Vespę niepowtarzalną, i&nbsp;na kt&oacute;re położono nacisk przy projektowaniu wyglądu nowego modelu GTS 300 <em>i.e.</em></p>	t	'300':37 'cech':19 'cecha':19 'czynić':22 'doły':10 'dół':10 'gts':36 'i.e':38 'kt':20,27 'lampa':12 'linia':4 'model':35 'nacisk':30 'nadwozie':5 'niezdecydowany':3 'nowego':34 'nowoczesny':1 'nowy':34 'okrągły':6 'pasażer':17 'pochylenie':8 'pochylić':8 'podn':14 'powtarzalny':24 'położenie':29 'położyć':29 'projektować':32 'przedni':11 're':21,28 'vespę':23 'wygląd':33 'wysuwać':13 'zdecydowany':3 'zdecydować':3 'żki':15
51	1	26	2012-09-03 22:07:12.709903+02	2012-09-03 22:07:12.709981+02	<p>espa GTS zachowuje podstawowe cechy, dzięki kt&oacute;rym każda Vespa jest unikalnym pojazdem w&nbsp;światowej panoramie skuter&oacute;w: <strong>rama nośna w&nbsp;całości wykonana ze stali </strong>to filozofia konstrukcyjna zapewniająca <strong>legendarną wytrzymałość</strong>, <strong>niezawodność </strong>i <strong>sztywność </strong>wpływające na większą precyzję podczas jazdy.</p>	t	'całości':22 'całość':22 'cech':5 'cecha':5 'dzięki':6 'espa':1 'filozofia':27 'gts':2 'jazda':40 'konstrukcyjny':28 'kt':7 'legendarny':30 'niezawodność':32 'nośnia':20 'panorama':16 'podstawowy':4 'pojazd':13 'precyzja':38 'rama':19 'rym':8 'skuter':17 'stać':25 'sztywność':34 'unikalny':12 'vespa':10 'większy':37 'wpływać':35 'wykonać':23 'wytrzymałość':31 'zachowywać':3 'zapewniać':29 'światowy':15 'że':24
52	3	29	2012-09-03 22:11:19.036142+02	2012-09-03 22:11:19.036201+02	<p><span>Wygląd skutera nie budzi żadnych zastrzeżeń. Ładna linia, nowoczesna stylistyka i dokładnie przemyślane detale. Po prostu idealny środek transportu w miejskich korkach. Przyglądając się jednak dokładniej odnajdziemy w Red Bullet wiele element&oacute;w charakterystycznych dla skutera o sportowym charakterze. Już barwy i malowanie wskazują, że skuter ma sportowy charakter. Dopełnieniem całości są białe tarcze prędkościomierza oraz tylni plastikowy bagażnik, wyglądem przypominający spojler. <br />Skuter został wyposażony w 2-suwowy silnik o pojemności 49ccm, chłodzony cieczą, wyprodukowany przez Piaggio. Odpowiednie osiągi ma zapewnić fabrycznie montowany duży 17,5mm gaźnik. Wygodę przy miejskim stylu jazdy osiągnięto dzięki dobremu zawieszeniu (prz&oacute;d: hydrauliczny widelec ze skokiem 65mm, tył: pojedynczy wahacz ze skokiem 60mm) oraz 12 calowym kołom. Skuter wyposażono w mocny tarczowy hamulec przedni (190mm) oraz tylni hamulec bębnowy. </span></p>	t	'12':111 '17':85 '190mm':121 '2':67 '49ccm':72 '5mm':86 '60mm':109 '65mm':103 'bagażnik':59 'barwa':41 'barwy':41 'biała':53 'biały':53 'budzenie':4 'budzić':4 'bullet':30 'bęben':125 'calowy':112 'całości':51 'całość':51 'charakter':39,49 'charakterystyczny':34 'charakterze':39 'chłodzić':73 'chłodzący':73 'ciecz':74 'd':98 'detal':14 'dobremu':95 'dobry':95 'dokładniej':26 'dokładny':12 'dopełniać':50 'duży':84 'dzięki':94 'element':32 'fabryczny':82 'gaźnik':87 'hamulce':119,124 'hamulec':119,124 'hydrauliczny':99 'idealny':17 'jazda':92 'korek':22 'kołowy':113 'linia':8 'malować':43 'miejski':21,90 'mocny':117 'montować':83 'mój':47,80 'nowoczesny':9 'odnaleźć':27 'odpowiedni':78 'osiąg':79 'osiągnąć':93 'piaggio':77 'plastikowy':58 'pojedynczy':105 'pojemność':71 'prostu':16 'prz':97 'przemyślane':13 'przyglądając':23 'przypominać':61 'przędny':120 'prędkościomierz':55 'red':29 'reda':29 'silnik':69 'skok':102,108 'skuter':2,36,46,63,114 'spojler':62 'sportowy':38,48 'styl':91 'stylistyk':10 'stylistyka':10 'stylo':91 'suwowy':68 'tarcza':54 'tarczowy':118 'transport':19 'tylny':57,123 'tyć':104 'wahacz':106 'widelec':100 'wskazywać':44 'wygląd':1,60 'wygoda':88 'wyposażenie':65,115 'wyposażyć':65,115 'wyprodukować':75 'zapewnić':81 'zastrzec':6 'zawiesić':96 'zostać':64 'ó':37,70 'ładny':7 'środek':18 'że':101,107
53	3	26	2012-09-03 22:12:09.048273+02	2012-09-03 22:12:09.048328+02	<p>Od zawsze <strong>doskonała ergonomia </strong>i<strong> naturalna<span id="nsitsp_0" style="border-bottom: 1px solid #00a5be; margin: 0pt; padding: 0px 0px 1px; display: inline; color: #00a5be; font-weight: bold; text-decoration: underline; cursor: pointer; float: none;"></span> pozycja siedząca </strong>kierowcy przyczyniają się do <strong>łatwego prowadzenia </strong>Vespy.</p>	t	'doskonalić':3 'ergonomia':4 'kierowca':9 'naturalny':6 'oda':1 'pozycja':7 'prowadzić':14 'przyczyniać':10 'siedzieć':8 'vespy':15 'zawszyć':2 'łatwy':13
54	3	26	2012-09-03 22:12:40.609788+02	2012-09-03 22:12:40.609844+02	<p><strong>Kanapa </strong>nowej <strong>Vespy GTS </strong>oferuje <strong>wysoki komfort</strong> nawet na trasach średniego zasięgu, staranne wykończenie i&nbsp;podw&oacute;jne przeszycia świadczą o&nbsp;wyr&oacute;żniającej każdy model Vespy uwadze skierowanej na detale.</p>	t	'detal':29 'gts':4 'jne':17 'kanapa':1 'komfort':7 'modła':24 'nowa':2 'nowej':2 'nowy':2 'oferować':5 'podw':16 'przeszyć':18 'skierować':27 'staranny':13 'tras':10 'trasa':10 'uwaga':26 'vespy':3,25 'wykończenie':14 'wykończyć':14 'wyro':21 'wysoki':6 'zasiąg':12 'ó':20 'średni':11 'świadczenie':19 'świadczyć':19 'żniającej':22
55	3	26	2012-09-03 22:13:30.007029+02	2012-09-03 22:13:30.007084+02	<p><strong>Duży schowek pod kanapą </strong></p>	t	'duży':1 'kanapa':4 'kanapą':4 'schowek':2
56	3	26	2012-09-03 22:13:48.951406+02	2012-09-03 22:13:48.951462+02	<p>może pomieścić dwa kaski demi-jet i&nbsp;inne przedmioty, z&nbsp;kolei przestrzeń za przednią osłoną idealnie nadaje się do przechowywania mniejszych rzeczy takich jak okulary, dokumenty, telefon kom&oacute;rkowy i&nbsp;wszystkiego tego, co może być przydatne w&nbsp;zasięgu ręki. Dzięki umieszczeniu białych cyfr na czarnym tle <strong>analogiczna</strong> <strong>tablica instrument&oacute;w </strong>jest praktyczna i&nbsp;funkcjonalna.</p>	t	'analogiczny':48 'biała':43 'biały':43 'ca':34 'cyfra':44 'czarna':46 'czarny':46 'czarnym':46 'demi':6 'demi-jet':5 'dokument':27 'dzięki':41 'funkcjonalny':55 'idealny':17 'instrument':50 'jaka':25 'jęta':7 'ka':29 'kaśka':4 'kolei':12 'kolej':12 'koleje':12 'kom':29 'koma':29 'mniejszy':22 'móc':1,35 'nadawać':18 'okular':26 'osłona':16 'pomieścić':2 'praktyczny':53 'przechowywać':21 'przedmiot':10 'przedni':15 'przestrzeń':13 'przydatny':37 'rkowy':30 'rzecz':23 'rzeczy':23 'ręka':40 'ręki':40 'tablica':49 'telefon':28 'tlić':47 'tęgi':33 'umieścić':42 'wszystkiego':32 'zasiąg':39 'ź':11
57	5	26	2012-09-03 22:15:16.548919+02	2012-09-03 22:15:16.548973+02	<p><strong>Nadwozie</strong></p>	t	'nadwozie':1
58	5	26	2012-09-03 22:15:38.326578+02	2012-09-03 22:15:38.326633+02	<p>Karoseria Vespy, w&nbsp;całości wykonana ze stali, pełni także funkcję ramy nośnej.</p>	t	'całości':4 'całość':4 'funkcja':10 'karoseria':1 'nośnia':12 'pełnia':8 'rama':11 'ramy':11 'stać':7 'vespy':2 'wykonać':5 'że':6
59	5	26	2012-09-03 22:15:51.05677+02	2012-09-03 22:15:51.056826+02	<p>Od 1946 r. jest to cecha, kt&oacute;ra zawsze odr&oacute;żniała Vespę od każdego innego skutera.</p>	t	'1946':2 'cecha':6 'innego':15 'kt':7 'oda':1,13 'odra':10 'r':3 'ra':8 'skuter':16 'vespę':12 'zawszyć':9 'żniała':11
60	5	26	2012-09-03 22:16:08.21853+02	2012-09-03 22:16:08.218588+02	<p>Wewnątrz nadwozia Vespy GTS, pod kanapą, znajduje się zbiornik na paliwo, kt&oacute;ry pomimo swojej pojemności (9,2 l) <strong>zwiększającej autonomię </strong>pojazdu, nie wpływa na zmniejszenie schowka pod kanapą ani swobodę dostępu do silnika po zdjęciu (bez użycia narzędzi) schowka na kask. Legendarną sztywność nadwozia Vespa GTS 300 łączy z&nbsp;kołami <strong>12&rdquo; </strong>zaopatrzonymi w&nbsp;opony o&nbsp;wymiarach 120/70 (z przodu) i&nbsp;130/70 (z tyłu).</p>	t	'12':52 '120/70':58 '130/70':62 '2':18 '300':48 '9':17 'ania':30 'autonomia':21 'beż':37 'dostęp':32 'gts':4,47 'kanapa':6,29 'kanapą':6,29 'kask':42 'koło':51 'kt':12 'kół':51 'legendarny':43 'nadwozie':2,45 'narzędzie':39 'opona':55 'paliwo':11 'pojazd':22 'pojemność':16 'przód':60 'ry':13 'schowek':27,40 'silnik':34 'swoboda':31 'swojej':15 'sztywność':44 'tyć':64 'tył':64 'użycie':38 'użyć':38 'vespa':46 'vespy':3 'wewnątrz':1 'wpływać':24 'wymiar':57 'zaopatrzenie':53 'zaopatrzyć':53 'zbiornik':9 'zdjąć':36 'zmniejszyć':26 'znajdować':7 'zwiększać':20 'ó':56 'ł':19 'łączony':49 'łączyć':49 'ź':50,59,63
61	5	30	2012-09-03 22:16:53.875942+02	2012-09-03 22:16:53.876003+02	<p><span>Pod nazwą Runner kryje się cała rodzina skuter&oacute;w z silnikami od 50 ccm do 200 ccm. Pojazd ten wyr&oacute;żnia się charakterystycznym wysokim tunelem środkowym. Nadaje mu on niecodziennego, jak dla skuter&oacute;w wyglądu. 12-calowe koła i mocne tarczowe hamulce pozwalają na wygodne i bezpieczne przemieszczanie się. Do tego dochodzi ciekawostka w postaci ogrzewania n&oacute;g powietrzem nagrzanym przez chłodnice. Model bardzo udany i ciekawy pozwala z pewnością wyr&oacute;żnić się z tłumu. Jest też dosyć duży i przez to dwie osoby podr&oacute;żują nim w miare wygodnie, a wysokie osoby nie będą narzekały na brak miejsca. Bagażnik powyżej średniej zmieści nie tylko kask, ale także małe pudełko na narzędzia. Brakuje niestety małego schowka przy kierownicy i miejsca na wieszanie zakup&oacute;w. W wersji 180 i 200 ccm ma 21 KM i jest jednym z najszybszych skuter&oacute;w na świecie (osiąga 140 kmh). Ostatnio gilera odeszła od swojej idei dużego dwusuwowego skutera i runner 125, 180 oraz 200 jest dostępny także w wersji czterosuwowej. <br />Bardzo dobre rozłożenie masy sprawia, że zachowuje się w doskonały spos&oacute;b przy pokonywaniu zakręt&oacute;w. Co za tym idzie, niestety, 50-tkę trudno jest postawić "na gumę". <br />Runner jest wielkim zwycięzcą w większości plebiscyt&oacute;w na najlepszy skuter, jest też uznawany za jeden z najlepszych na świecie skuter&oacute;w sportowych.</span></p>	t	'12':36 '125':157 '140':144 '180':127,158 '200':16,129,160 '21':132 '50':13,188 'ala':107 'b':178 'bagażnik':100 'bezpieczny':47 'brak':98 'brakować':113 'ca':183 'calowy':37 'ccm':14,17,130 'charakterystyczny':23 'chłodnica':62 'ciekawostka':53 'ciekawy':67 'codzienny':30 'czterosuwowy':166 'dobre':168 'dobry':168 'dochodzenie':52 'dochodzić':52 'doskonalić':176 'dostępny':162 'dosyć':78 'dużego':152 'duży':79,152 'dwusuwowy':153 'g':58 'gilera':147 'guma':194 'hamulce':42 'hamulec':42 'id':186 'ida':186 'idea':151 'idy':186 'jaka':31 'jednym':136 'kask':106 'kierownica':118 'kierownik':118 'km':133 'kmh':145 'kołowy':38 'krycie':4 'kryć':4 'masa':170 'mała':109,115 'małe':109,115 'mały':109,115 'miara':89 'miejsca':99,120 'miejsce':99,120 'mocne':40 'mocny':40 'modła':63 'mój':131 'nadawać':27 'nagrzać':60 'najlepszy':204,212 'najszybszy':138 'narzekać':96 'narzędzie':112 'nazwać':2 'niestety':114,187 'oda':12,149 'odejście':148 'odejść':148 'ogrzewać':56 'osiągać':143 'osoba':84,93 'ostatnio':146 'oń':29 'pewnością':70 'pewność':70 'plebiscyt':201 'podr':85 'pojazd':18 'pokonywać':180 'postawić':192 'postać':55 'powietrze':59 'powyżej':101 'pozwalać':43 'pozwać':68 'przemieszczać':48 'pudełko':110 'rodzina':7 'rozłożony':169 'rozłożyć':169 'runner':3,156,195 'schowek':116 'silnik':11 'skuter':8,33,139,154,205,215 'sportowy':217 'spos':177 'sprawić':171 'stet':114,187 'swojej':150 'tarczowe':41 'tarczowy':41 'tkę':189 'trudno':190 'tunel':25 'tylek':105 'tęgi':51 'tłum':75 'tłumić':75 'udać':65 'uznać':208 'wersja':126,165 'wielki':197 'wielkim':197 'wieszać':122 'większości':200 'większość':200 'wygląd':35 'wygodny':45,90 'wyro':20,71 'wysoki':24,92 'wysokie':92 'zachowywać':173 'zakręt':181 'zakup':123 'zakupić':123 'zmieścić':103 'zwycięzca':198 'ą':91 'ń':57 'średni':102 'środkowa':26 'środkowy':26 'świecie':142,214 'ź':10,69,74,137,211 'żnia':21 'żnić':72 'żuć':86
62	4	26	2012-09-03 22:17:36.9621+02	2012-09-03 22:17:36.962157+02	<p><strong>Przednie zawieszenie </strong>wykorzystuje klasyczny podnośnik, typowy element w&nbsp;historii Vespy posiadający znakomite właściwości dynamiczno-funkcjonalne.</p>	t	'dynamiczno':15 'dynamiczno-funkcjonalne':14 'element':7 'funkcjonalny':16 'historia':9 'historie':9 'klasyczny':4 'podnośnik':5 'posiadać':11 'przedni':1 'typowy':6 'vespy':10 'wykorzystywać':3 'właściwość':13 'zawiesić':2 'znakomity':12
63	4	26	2012-09-03 22:17:49.541302+02	2012-09-03 22:17:49.541367+02	<p>Z&nbsp;tyłu znajdują się przymocowane do korpusu silnika <strong>dwa amortyzatory hydrauliczne </strong>z regulacją napięcia wstępnego sprężyny oraz mocowanie tłumika. Vespa GTS 300 może pochwalić się bardzo dobrym hamowaniem dzięki obecności dw&oacute;ch tarcz o&nbsp;średnicy 220 mm.</p>	t	'220':36 '300':22 'amortyzator':10 'ch':32 'dobre':27 'dobry':27 'dobrym':27 'dw':31 'dzięki':29 'gts':21 'hamować':28 'hydrauliczny':11 'korpus':7 'mm':37 'mocować':18 'móc':23 'napiąć':14 'obecność':30 'pochwalić':24 'przymocować':5 'regulacja':13 'silnik':8 'sprężyna':16 'tarcza':33 'tyć':2 'tył':2 'tłumik':19 'vespa':20 'wstępny':15 'znajdować':3 'ó':34 'średnica':35 'ź':1,12
64	4	26	2012-09-03 22:17:59.374862+02	2012-09-03 22:17:59.374917+02	<p><strong>Nowy silnik 300 w&nbsp;Vespie GTS</strong></p>	t	'300':3 'gts':6 'nowy':1 'silnik':2 'vespie':5
65	4	26	2012-09-03 22:18:12.395292+02	2012-09-03 22:18:12.395349+02	<p>Napęd <strong>300 </strong>- jednocylindrowy, czterosuwowy, czterozaworowy, chłodzony cieczą i&nbsp;z <strong>elektronicznym wtryskiem </strong>- dostarcza maksymalnej mocy <strong>22 KM przy 7.500 obrot&oacute;w </strong>i wyzwala maksymalny moment obrotowy <strong>22,3 Nm przy zaledwie 5.000 obrot&oacute;w</strong>: wartości te zapewniają Vespie GTS <strong>szybką reakcję na gaz </strong>oraz <strong>niezwykle błyskotliwe osiągi</strong>, sprawiając że staje się ona <strong>idealnym pojazdem zar&oacute;wno do jazdy po mieście jak do</strong> <strong>odbywania najdalszych podr&oacute;ży turystycznych, </strong>w pełnej wygodzie &ndash; także z&nbsp;pasażerem.</p>\r\n<p><strong>Nowy silnik Vespy GTS jest szybki</strong>, <strong>zwinny i&nbsp;drapieżny</strong>, <strong>płynny podczas jazdy dzięki</strong> <strong>elektronicznemu wtryskowi</strong>, ale także <strong>cichy i&nbsp;spełniający najsurowsze normy w</strong> <strong>zakresie emisji spalin (Euro3)</strong>. Przy rozruchu <strong>system wolnego koła w&nbsp;kąpieli olejowej</strong> zmniejsza hałaśliwość, natomiast w&nbsp;czasie jazdy mniejsza emisja hałasu to wynik zastosowania <strong>nowej obudowy korpusu silnika, kt&oacute;ra pozwala jednocześnie na lepsze</strong> <strong>chłodzenie </strong>przekładni.</p>	t	'22':15,26 '3':27 '300':2 '5.000':31 '7.500':18 'ala':88 'błyskotliwy':45 'chłodzić':6,130 'chłodzący':6 'cichy':90 'ciecz':7 'czas':112 'czterosuwowy':4 'czterozaworowy':5 'dostarczyć':12 'drapieżny':81 'dzięki':85 'elektroniczny':10,86 'emisja':97,115 'euro3':99 'gaz':42 'gaza':42 'gts':38,76 'hałas':116 'hałaśliwość':109 'idealny':52 'jaka':60 'jazda':57,84,113 'jednocylindrowy':3 'jednoczesny':127 'km':16 'korpus':122 'kołowy':104 'kt':124 'kąpiel':106 'lepsza':129 'lepsze':129 'lepszy':129 'maksymalny':13,23 'miasto':59 'mniejszy':114 'moc':14 'moment':24 'najdalszy':63 'najsurowszy':93 'napęd':1 'nm':28 'norma':94 'nowa':120 'nowej':120 'nowy':73,120 'obrotowy':25 'obrót':19,32 'obudowa':121 'odbywać':62 'olejowy':107 'on':51 'osiąg':46 'pasażer':72 'pełnia':68 'podr':64 'pojazd':53 'pozwać':126 'przekładnia':131 'płynny':82 'ra':125 'reakcja':40 'rozruch':101 'silnik':74,123 'spaliny':98 'spełniać':92 'sprawiając':47 'stajać':49 'system':102 'szybka':39,78 'szybki':39,78 'ten':35 'turystyczny':66 'vespie':37 'vespy':75 'wartość':34 'wno':55 'wolnego':103 'wolny':103 'wtrysk':11,87 'wtryskowy':87 'wygoda':69 'wynik':118 'wyzwać':22 'zakres':96 'zaledwie':30 'zapewniać':36 'zastosować':119 'zmniejszyć':108 'zwinny':79 'zwykły':44 'ź':9,71 'żary':54 'ży':65
66	4	31	2012-09-03 22:24:02.481557+02	2012-09-03 22:24:02.481617+02	<p><strong>50cc turystyczny</strong></p>	t	'50cc':1 'turystyczny':2
67	4	32	2012-09-03 22:25:57.671237+02	2012-09-03 22:25:57.671296+02	<p><strong>midi miejski</strong></p>	t	'midi':1 'miejski':2
69	5	34	2012-09-03 22:28:30.336491+02	2012-09-03 22:28:30.336569+02	<p><strong>50cc turystyczny</strong></p>	t	'50cc':1 'turystyczny':2
70	6	35	2012-09-03 22:29:51.581197+02	2012-09-03 22:29:51.581255+02	<p><strong>50cc ekonomiczny</strong></p>	t	'50cc':1 'ekonomiczny':2
71	1	36	2012-09-03 22:31:22.170552+02	2012-09-03 22:31:22.170613+02	<p><span>GP1 to sportowy skuter ze stajni tego znanego hiszpańskiego producenta. Model ten jest następcą Predatora, choć wydaje się że zmieniła się tylko nazwa. <br />13 calowe koła i stylistyka sprawiają że skuter troche przypomina Aeroxa. Niestety są to gł&oacute;wnie pozory. Choć GP1 to dobry skuter brakuje mu jednak chłodzenia cieczą (w jednej wersji) i obu hamulc&oacute;w tarczowych. Zachowanie na szczęście jest już typowo sportowe. Niezbyt komfortowe, ale pewne i gotowe do ostrej jazdy. <br />Skuter wygląda na szybki i agresywny i z pewnocią jest udanym stylistycznie dziełem. Będzie się podobał każdemu z żyłką sportowca. <br /> <br />W ostatnim czasie producent wprowadził na rynek pod tą nazwą nowy model, kt&oacute;ry jest niewątpliwie bardzo atrakcyjny. <br />Wygląd to prawdziwy majsetrsztyk. <br />Agresywnie wystylizowany prz&oacute;d zdradza adresta tego pojazdu, młodzi ludzie. <br />Wbrew sportowym akcentom mamy tutaj dużą kanapę, kt&oacute;ra zapewnia dostateczny komfort, i sporo miejsca dla kierowcy i pasazera. <br />Zestaw zegar&oacute;w to analogowy obrotmomierz na białym tle i elektroniczny wielofunkcyjny wyswietlacz LCD. <br />Silnik w wersji 50ccm to swietnie znany doskonały motor ze stajni Piaggio /Gilera , chłodzony ciecza o stosunkowo dużej mocy . <br />Skuter wystepuje tez w wersjach pojemności silnika 125 i 250ccm, r&oacute;wnież ze stajni Piaggio/Gilera. <br />We wszystkich wersjach producent montuje 2 , bardzo skuteczne tarcze hamulcowe. <br />Jest to skuter brdzo oryginalny i nie każdemu przypadnie do gustu. <br />W Polsce znany raczej za sprawą prywatnego importu.</span></p>	t	'/gilera':172 '125':186 '13':24 '2':199 '250ccm':188 '50ccm':163 'adresta':122 'aeroxa':34 'agresywny':80,117 'akcent':129 'ala':68 'analogowy':150 'atrakcyjny':112 'biała':153 'biały':153 'brakować':46 'brdzo':207 'calowy':25 'choć':16,41 'chłodzić':49,173 'chłodzący':173 'ciecz':50,174 'czas':97 'd':120 'dobry':44 'doskonalić':167 'dostateczny':137 'dużej':177 'duży':132,177 'dużą':132 'dzielić':87 'elektroniczny':156 'gotowić':71 'gp1':1,42 'gust':214 'gł':38 'hamulc':56 'hamulcowe':203 'hamulcowy':203 'hiszpański':9 'import':222 'jazda':74 'kanapa':133 'kanapę':133 'kierowca':143 'komfort':138 'komfortowy':67 'kołowy':26 'kt':107,134 'lcd':159 'majsetrsztyk':116 'mama':130 'mamy':130 'miejsca':141 'miejsce':141 'moc':178 'modła':11,106 'montować':198 'motor':168 'młodzie':125 'młódź':125 'następca':14 'nazwać':23,104 'nieczłowiek':126 'niestety':35 'nowy':105 'ob':55 'obrotmomierz':151 'obu':55 'oryginalny':208 'ostatni':96 'ostatnia':96 'ostrej':73 'ostry':73 'pasażer':145 'pewien':69 'pewnocią':83 'piaggio':171 'piaggio/gilera':193 'podobać':90 'pojazd':124 'pojemność':184 'polsce':216 'polska':216 'pozór':40 'prawdziwy':115 'predator':15 'producent':10,98,197 'prywatny':221 'prz':119 'przypadły':212 'przypaść':212 'przypominać':33 'r':189 'ra':135 'ry':108 'rynek':101 'rynka':101 'rączy':218 'silnik':160,185 'skuteczny':201 'skuter':4,31,45,75,179,206 'spora':140 'sportowiec':94 'sportowy':3,65,128 'spory':140 'sprawa':220 'sprawiać':29 'stajnia':6,170,192 'stet':35 'stosunkowy':176 'stylistyczny':86 'stylistyk':28 'stylistyka':28 'szczęścić':61 'szybka':78 'szybki':78 'tarcza':202 'tarczowy':58 'tenże':181 'tlić':154 'trocha':32 'tylek':22 'typowy':64 'tęgi':7,123 'udać':85 'wbrew':127 'wersja':53,162,183,196 'wielofunkcyjny':157 'wnie':39 'wnież':190 'wprowadzić':99 'wydajać':17 'wygląd':113 'wyglądać':76 'wystylizować':118 'występować':180 'wyświetlacz':158 'wątpliwy':110 'zachować':59 'zapewnić':136 'zbyt':66 'zdradzić':121 'zegar':147 'zestawić':146 'zmienić':20 'znać':8,166,217 'ó':175 'świetny':165 'ź':82,92 'że':5,169,191 'żyłka':93
72	4	37	2012-09-03 22:31:55.360789+02	2012-09-03 22:31:55.360848+02	<p><span>Kosmiczny ICE wstrząsnął rynkiem. Gilera jest kolejnym po Yamasze producentem kt&oacute;ry postawił na nietypowe skutery tworząc coś w rodzaju skuterowego BMX`a. Stylistyką wyszedł nawet dalej. Niepowtarzalna linia jest nie do pomylenia z niczym innym. Tym samym ICE odeszła znacząco od standard&oacute;w jakimi oceniamy skutery. Osłona, bagażnik, praktyczność i funkcjonalność stają się tu słowami niepotrzebnymi. Odlot i szaleństwo są natomiast bardzo wskazane. <br />Definitywnie brakuje jej znanej z większości skuter&oacute;w cech. Silnik, zawieszenie i hamulce są na bardzo wysokim poziomie. Widać że ten skuter jest stworzony do wariactw. Zadowoli tych kt&oacute;rzy cenią dobre parametry jezdne. <br />Jakość także bardzo dobra. Bardzo specyficzna budowa ramy z wspornikiem pomiędzy nogami i nietypowym podestem wzmacnia konstrukcje i nadaje kosmiczny wygląd. Całkowicie ciekłokrystaliczny zestaw wskaźnik&oacute;w pokazuje wszystkie niezbędne dane. <br />Dobrze że są grube opony, szkoda że tylko 10 calowe. Brakuje bardzo choćby małego schowka, ale w konkurencyjnym Sliderze jest podobnie. ICE to odlot nie tylko do transportu. Cena niezbyt niska, ale nie zniechęca i dzieki temu ICE szybko znajduje nabywc&oacute;w. Gdyby tylko był bardziej funkcjonalny to ocenilibyśmy ten skuter jako bardzo dobry. Tak jest na 4 z plusem.</span></p>	t	'10':137 '4':186 'ala':144,160 'bagażnik':49 'bmx':22 'brakować':66,139 'budowa':105 'calowy':138 'całkowity':120 'cech':73 'cecha':73 'cena':157 'cenić':95 'choćby':141 'ciekłokrystaliczny':121 'dalej':27 'dać':128 'definitywny':65 'dobra':102,129 'dobre':96 'dobro':102,129 'dobry':96,102,129,182 'dzięki':164 'funkcjonalność':52 'funkcjonalny':175 'gilera':5 'gruba':132 'hamulce':77 'hamulec':77 'ice':2,39,150,166 'jaka':180 'jakość':99 'jezdne':98 'jezdny':98 'kolejny':7 'konkurencyjny':146 'konstrukcja':115 'kosmiczny':1,118 'kt':11,93 'linia':29 'mała':142 'małe':142 'mały':142 'nabywc':169 'nadawać':117 'niczym':35 'nieoceniony':177 'niezbędny':127 'niski':159 'noga':110 'oceniać':46 'ocenić':177 'oda':42 'odejście':40 'odejść':40 'odlot':58,152 'opona':133 'osłona':48 'parametr':97 'plus':188 'podest':113 'podobny':149 'pokazywać':125 'pomiędzy':109 'pomylić':33 'postawić':13 'potrzebny':57 'powtarzalny':28 'poziom':82 'praktyczność':50 'producent':10 'rama':106 'ramy':106 'reż':94 'rodzaj':20 'ry':12 'rynek':4 'rynkiem':4 'samym':38 'schowek':143 'silnik':74 'skuter':16,47,71,86,179 'skuterowy':21 'sliderze':147 'specyficzny':104 'stajać':53 'standard':43 'stworzenie':88 'stworzyć':88 'stylistyka':24 'szaleństwo':60 'szkoda':134 'szybka':167 'szybki':167 'słowa':56 'słowami':56 'temu':165 'transport':156 'tworząc':17 'tychy':92 'tylek':136,154,172 'typowy':15,112 'wariactwo':90 'widać':83 'większości':70 'większość':70 'wskazać':64 'wskaźnik':123 'wspornik':108 'wstrząsnąć':3 'wygląd':119 'wyjście':25 'wyjść':25 'wysoki':81 'wzmacniać':114 'yamaha':9 'zadowolić':91 'zawiesić':75 'zbyt':158 'zbędny':127 'zestawić':122 'znaczący':41 'znajdować':168 'znać':68 'zniechęcać':162 'ą':23 'ź':34,69,107,187
73	3	38	2012-09-03 22:32:27.233812+02	2012-09-03 22:32:27.233871+02	<p><span>Sky to znany dość dobrze model skutera na dużych, 16-calowych kołach. Stylistycznie nawiązuje do modeli retro poprzez charakterystyczne reflektory. Ostatnio modele SKY`a wyposażono w katalizator dzięki czemu zmniejszyła się emisja szkodliwych spalin. <br />Dostępny jest w wersjach standardowej, Deluxe (z chromowanym wykończeniem) i Vetro (z p&oacute;łprzezroczystymi plastikami).</span></p>	t	'16':10 'calowy':11 'charakterystyczny':19 'chromować':42 'deluxe':40 'dobra':5 'dobro':5 'dobry':5 'dostępny':35 'duży':9 'dzięki':28 'emisja':32 'katalizator':27 'kołowy':12 'model':16,22 'modła':6 'nawiązywać':14 'ostatnio':21 'p':47 'plastik':49 'poprzez':18 'reflektor':20 'retro':17 'skuter':7 'sky':1,23 'spaliny':34 'standardowy':39 'stylistyczny':13 'szkodliwy':33 'vetro':45 'wersja':38 'wykończenie':43 'wykończyć':43 'wyposażenie':25 'wyposażyć':25 'zmniejszyć':30 'znać':3 'ą':24 'łprzezroczystymi':48 'ź':41,46
74	6	39	2012-09-03 22:33:06.884871+02	2012-09-03 22:33:06.884934+02	<p><span>Kolejny skuter z serii nowości 2007.Importer kusi atrakcyjnymi dodatkami takimi jak: kufer , ozdobna balcha na podłodze, <br />Silnik to dobrze znany czterosuw chłodzony powietrzem o mocy 1,70kw, typ silnika to 139qmb. Spalanie w granicach 2l/100km-wielka zaleta czterosuwowych skuter&oacute;w. Predkość maksymalna jest wystarczająca do bezpiecznego poruszania się po mieście.Zaletą tego silnika jest to , że spora większość mechanik&oacute;w skuterowych w Polsce zna ten silnik jak własną kieszeń. <br />Zegary to ciekawy element w Black Horse, w ich skład wchodzi prędkościomierz, obrotomierz(!) wskaźnik paliwa oraz kontrolki. Brakuje tutaj niestety tak przydatnego w codziennej eksploatacji zegarka. <br />Schowek pod kanapą niestety nie należy do najpojemniejszych co utrudnia przew&oacute;z zakup&oacute;w. Na szczęście w standardzie jest kufer. <br />Z przodu zamontowano hamulec tarczowy , a z tyłu bębnowy <br />Przy cenie 4100zł jest to bardzo atrakcyjna oferta. <br />Przednia częśc skutera jest łudząco podobna do Piaggio NRG Power, dla niekt&oacute;rych będzie to niewątpliwie zaletą. Kingway Motor Poland udziena na ten skuter 1 rok gwarancji. </span></p>	t	'1':26,156 '139qmb':31 '2007.importer':6 '2l/100km-wielka':35 '4100zł':126 '70kw':27 'atrakcyjny':8,130 'balcha':14 'bezpieczny':45 'black':74 'brakować':86 'bęben':123 'ca':103 'cenić':125 'chłodzić':22 'chłodzący':22 'ciekawy':71 'codzienny':92 'czterosuw':21 'czterosuwowy':37 'częśc':133 'dobra':19 'dobro':19 'dobry':19 'dodatek':9 'eksploatacja':93 'element':72 'granica':34 'gwarancja':158 'hamulce':118 'hamulec':118 'horse':75 'jaka':11,66 'kanapa':97 'kanapą':97 'kieszeń':68 'kingway':149 'kolejny':1 'kontrolka':85 'kufer':12,114 'kusić':7 'maksymalny':41 'mechanik':58 'mechanika':58 'miasto':49 'moc':25 'motor':150 'najpojemniejszy':102 'naleźć':100 'niestety':88,98 'nowość':5 'nrg':140 'obrotomierz':81 'oferta':131 'ozdobny':13 'paliwo':83 'piaggio':139 'podobny':137 'podłoga':16 'poland':151 'polsce':62 'polska':62 'poruszać':46 'power':141 'powietrze':23 'predkość':40 'przedni':132 'przew':105 'przydatny':90 'przód':116 'prędkościomierz':80 'rok':157 'rych':144 'schowek':95 'seria':4 'silnik':17,29,52,65 'skuter':2,38,134,155 'skuterowy':60 'skład':78 'spalać':32 'spory':56 'standard':112 'stet':88,98 'szczęścić':110 'tarczowy':119 'typ':28 'tyć':122 'tył':122 'tęgi':51 'udziena':152 'utrudnić':104 'wchodzić':79 'większość':57 'wskaźnik':82 'wystarczać':43 'wątpliwy':147 'własny':67 'zakup':107 'zakupić':107 'zaleta':36,50,148 'zamontować':117 'zegar':69 'zegarek':94 'znać':20,63 'ó':24 'ą':120 'łudząco':136 'ź':3,106,115,121
75	1	40	2012-09-03 22:33:32.868263+02	2012-09-03 22:33:32.868323+02	<p><span>Bardzo atrakcyjny stylistycznie model zwraca uwagę sportowymi detalami. <br />Tylna część skutera jest bardzo zgrabna i smukła. <br />Prz&oacute;d jest bardziej masywny , umieszczono w nim 2 niewielkie reflektory,przednie kierunkowskazy wbudowano w kierownicę. <br />Tłumik jest bardzo atrakcyjny stylistycznie , wyglada jakby żywcem przeniesiony z modeli o większych pojemnościach silnika , co jest niewątpliwą zaletą tego skutera. <br />Pasażer usiądzie wygodnie , ponieważ na kanapie konstruktorzy przeznaczyli dla niego sporo miejsca. <br />Zawieszenie opiera się z przodu na teleskopowym widelcu a z tyłu na podw&oacute;jnych amortyzatorach hydraulicznych. <br />Koła mają spory rozmiar - 14 cali, zapewniają komfortową jazdę po polskich drogach oraz zapewniają precyzyjne prowadzenie. <br />Silnik to czterosuw , chłodzony powietrzem , nie zapewnia kosmicznych osiąg&oacute;w, ale zapewnia za to bardzo małe spalanie-w okolicach 2l-3l/100km. <br />Aż prosi sie o dwusuwową , żwawszą jednostkę w tym modelu. <br />Hamulec z przodu to duża i efektowna tarcza "szarpana" oraz słaby bęben z tyłu, kt&oacute;ry może okazać się za słaby przy dosyć wysokiej masie skutera. <br />Tablica przyrzad&oacute;w to wskaźnik paliwa , kontrolki i co ważne zegarek cyforwy-bardzo przydatny w codziennej eksploatacji. <br />Za tę cenę S8 można uznać za bardzo atrakcyjną ofertę w tym przedziale cenowym. </span></p>	t	'/100km':121 '14':86 '2':25 '2l':119 '2l-3l':118 '3l':120 'ala':108 'amortyzator':80 'atrakcyjny':2,36,184 'bęben':143 'ca':48,166 'cal':87 'cena':178 'cenowy':189 'chłodzić':101 'chłodzący':101 'codzienny':174 'cyforwy':170 'cyforwy-bardzo':169 'czterosuw':100 'częsty':10 'd':18 'detal':8 'dosyć':154 'droga':93 'duża':136 'duży':136 'dwusuwowy':126 'efektowny':138 'eksploatacja':175 'ga':63 'gen':63 'goa':63 'hamulce':132 'hamulec':132 'hydrauliczny':81 'jazda':90 'jednostka':128 'jnych':79 'kanapa':59 'kanapie':59 'kierownica':32 'kierunkowskaz':29 'komfortowy':89 'konstruktor':60 'kontrolka':164 'kosmiczny':105 'kołowy':82 'kt':146 'maić':83 'maj':83 'maja':83 'masa':156 'masywny':21 'mała':113 'małe':113 'mały':113 'miejsca':65 'miejsce':65 'model':43,131 'modła':4 'możny':180 'móc':148 'oferta':185 'okazać':149 'okolica':117 'okolice':117 'opierać':67 'osiąg':106 'paliwo':163 'pasażer':54 'podw':78 'pojemność':46 'polski':92 'powietrze':102 'precyzyjny':96 'prosić':123 'prowadzić':97 'prz':17 'przedni':28 'przedział':188 'przeniesiony':41 'przeznaczenie':61 'przeznaczyć':61 'przydatny':172 'przyrząd':159 'przód':70,134 'reflektor':27 'rozmiar':85 'ry':147 's8':179 'siebie':124 'silnik':47,98 'skuter':11,53,157 'smukły':16 'spalanie-w':114 'spalać':115 'spora':64,84 'sportowy':7 'spory':64,84 'spór':84 'stylistyczny':3,37 'szarpać':140 'słaby':142,152 'tablica':158 'tarcza':139 'teleskopowy':72 'tylny':9 'tyć':76,145 'tył':76,145 'tę':177 'tęgi':52 'tłumik':33 'umieścić':22 'usiąść':55 'uwaga':6 'uznać':181 'ważnić':167 'wbudować':30 'widelec':73 'wielka':26 'wielki':26 'większy':45 'wskaźnik':162 'wyglądać':38 'wygodny':56 'wysoki':155 'wysokiej':155 'wątpliwy':50 'zaleta':51 'zapewniać':88,95 'zapewnić':104,109 'zawiesić':66 'zegarek':168 'zgrabny':14 'zwracać':5 'ó':44,125 'ą':74 'ź':42,69,75,133,144 'żwawszy':127 'żywcowy':40
76	1	41	2012-09-03 22:36:24.618495+02	2012-09-03 22:36:24.618555+02	<p><span>Na sezon 2008 Kingway przygotował bardzo nietypową niespodziankę. Tą nietypową niespodzianką jest Poster. Poster to przedstawiciel zapomnianego już segmentu zadaszonych skuter&oacute;w. Wśr&oacute;d bardzo popularnych Colibr&oacute;w czy Fonero jest istnym novum. Jednak jak każdy chiński skuter, także ten jest zadziwiająco podobny do kt&oacute;regoś z europejskich skuter&oacute;w. W tym przypadku Chińczycy zdecydowali się skopiować Benelli Adivę. Poster napędzany jest stosowaną praktycznie w każdym Kingwayu czterosuwową jednostką 139QMB. Jej zaletą jest na pewno niebywale niskie zużycie paliwa, jednak o ile ten 3-konny silniczek radzi sobie znakomicie z Colibrem, o tyle tutaj o dobrej dynamice można tylko pomarzyć. Dlaczego ? To proste - Poster waży aż 139 kg ! Pomimo dychawicznego silniczka, Poster jest propozycją wartą rozważenia - kosztuje tylko 5000 zł. Pytanie tylko, czy za tą dumpingową ceną nie kryje się dumpingowa jakość. </span></p>	t	'139':107 '139qmb':70 '2008':3 '3':84 '5000':119 'adivę':59 'benelli':58 'bywać':76 'cena':127 'chińczyk':54 'chiński':37 'colibr':27 'colibrem':91 'cza':29,123 'czterosuwowy':68 'd':24 'dobrej':96 'dobry':96 'dumpingowy':126,131 'dychawiczny':110 'dynamika':97 'europejski':48 'fonero':30 'istny':32 'iłowa':82 'iłowo':82 'jaka':35 'jakość':132 'jednostka':69 'kg':108 'kingway':4 'kingwayu':67 'konny':85 'kosztować':117 'krycie':129 'kryć':129 'kt':45 'możny':98 'napędzać':61 'niespodzianka':8,11 'niski':77 'novum':33 'paliwo':79 'pewno':75 'podobny':43 'pomarzyć':100 'popularny':26 'poster':13,14,60,104,112 'praktyczny':64 'propozycja':114 'prosta':103 'prosty':103 'przedstawiciel':16 'przygotować':5 'przypadek':53 'pytać':121 'radzi':87 'radzić':87 'regoś':46 'rozważać':116 'segment':19 'sezon':2 'silniczek':86,111 'skopiować':57 'skuter':21,38,49 'stosować':63 'tylek':99,118,122 'typować':7,10 'typowy':7,10 'tyć':93 'tył':93 'warta':115 'wartą':115 'ważenie':105 'ważyć':105 'wśr':23 'zadaszony':20 'zadaszyć':20 'zadziwiać':42 'zaleta':72 'zapomnieć':17 'zdecydować':55 'znakomity':89 'zużyć':78 'ó':81,92,95 'ź':47,90
\.


--
-- Data for Name: DFor_temat; Type: TABLE DATA; Schema: public; Owner: django
--

COPY "DFor_temat" (id, tytul, data_utworzenia, forum_id, tytul_tsv) FROM stdin;
9	BMW serii 1	2012-09-03 21:17:00.994606+02	5	'1':3 'bmw':1 'seria':2
10	BMW serii 3	2012-09-03 21:20:36.785024+02	5	'3':3 'bmw':1 'seria':2
11	BMW serii 5	2012-09-03 21:22:08.765108+02	5	'5':3 'bmw':1 'seria':2
12	Yamaha Aerox	2012-09-03 21:26:20.236722+02	4	'aerox':2 'yamaha':1
13	Peugeot Jetforce	2012-09-03 21:26:55.605478+02	4	'jetforce':2 'peugeot':1
14	Daelim S-Five	2012-09-03 21:28:27.115038+02	4	'daelim':1 'five':4 's-five':2 'ś':3
15	Malaguti F12	2012-09-03 21:37:50.576048+02	4	'f12':2 'malaguti':1
16	BMW serii 7	2012-09-03 21:38:33.93951+02	5	'7':3 'bmw':1 'seria':2
17	Aprilia Area 51	2012-09-03 21:39:47.944478+02	4	'51':3 'aprilia':1 'area':2
18	Aprilia SR 50	2012-09-03 21:43:37.493241+02	4	'50':3 'aprilia':1 'sr':2
19	BMW serii X1	2012-09-03 21:44:40.820068+02	5	'bmw':1 'seria':2 'x1':3
20	BMW serii X3	2012-09-03 21:46:27.786726+02	5	'bmw':1 'seria':2 'x3':3
21	BMW C 650 GT	2012-09-03 21:47:24.634632+02	4	'650':3 'bmw':1 'gt':4 'ć':2
22	BMW serii X5	2012-09-03 21:50:17.488562+02	5	'bmw':1 'seria':2 'x5':3
23	BMW C 600 Sport	2012-09-03 21:52:23.190551+02	4	'600':3 'bmw':1 'sport':4 'ć':2
24	Piaggio Zip SP 2	2012-09-03 21:55:58.958201+02	4	'2':4 'piaggio':1 'sp':3 'zip':2 'zipać':2
25	Piaggio NRG Power 50 DD	2012-09-03 21:56:49.853967+02	4	'50':4 'dd':5 'nrg':2 'piaggio':1 'power':3
26	Vespa GTS SUPER 300 i.e.	2012-09-03 21:59:47.37962+02	4	'300':4 'gts':2 'i.e':5 'super':3 'vespa':1
27	Yamaha TZR 50	2012-09-03 22:03:39.438384+02	4	'50':3 'tzr':2 'yamaha':1
28	Vespa 946	2012-09-03 22:05:38.751227+02	4	'946':2 'vespa':1
29	DERBI RED BULLET	2012-09-03 22:11:19.033748+02	4	'bullet':3 'derbi':1 'red':2 'reda':2
30	GILERA RUNNER	2012-09-03 22:16:53.873669+02	4	'gilera':1 'runner':2
31	Kymco Bet&win	2012-09-03 22:24:02.47928+02	4	'bet':2 'beta':2 'kymco':1 'winić':3
32	Malaguti F18 warrior	2012-09-03 22:25:57.668833+02	4	'f18':2 'malaguti':1 'warrior':3
33	Suzuki Katana	2012-09-03 22:27:07.930978+02	4	'katana':2 'suzuki':1
34	TGB f409 br1	2012-09-03 22:28:23.787967+02	4	'br1':3 'f409':2 'tgb':1
35	Zumico quick	2012-09-03 22:29:51.578981+02	4	'quick':2 'zumico':1
36	DERBI GP1	2012-09-03 22:31:22.168204+02	4	'derbi':1 'gp1':2
37	GILERA ICE	2012-09-03 22:31:55.358318+02	4	'gilera':1 'ice':2
38	HONDA SKY	2012-09-03 22:32:27.231536+02	4	'honda':1 'sky':2
39	KINGWAY BLACK HORSE	2012-09-03 22:33:06.882602+02	4	'black':2 'horse':3 'kingway':1
40	KYMCO SUPER 8	2012-09-03 22:33:32.866005+02	4	'8':3 'kymco':1 'super':2
41	KINGWAY POSTER	2012-09-03 22:36:24.616005+02	4	'kingway':1 'poster':2
\.


--
-- Data for Name: DFor_uzytkownik; Type: TABLE DATA; Schema: public; Owner: django
--

COPY "DFor_uzytkownik" (id, uzytkownik_id, data_urodzenia, plec, miejscowosc, avatar, podpis) FROM stdin;
1	1	\N				
3	3	\N				
5	5	\N				
6	6	\N				
4	4	1978-04-12	K	Częstochowa		Lubie auta
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: django
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: django
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: django
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add permission	1	add_permission
2	Can change permission	1	change_permission
3	Can delete permission	1	delete_permission
4	Can add group	2	add_group
5	Can change group	2	change_group
6	Can delete group	2	delete_group
7	Can add user	3	add_user
8	Can change user	3	change_user
9	Can delete user	3	delete_user
10	Can add content type	4	add_contenttype
11	Can change content type	4	change_contenttype
12	Can delete content type	4	delete_contenttype
13	Can add session	5	add_session
14	Can change session	5	change_session
15	Can delete session	5	delete_session
16	Can add site	6	add_site
17	Can change site	6	change_site
18	Can delete site	6	delete_site
19	Can add log entry	7	add_logentry
20	Can change log entry	7	change_logentry
21	Can delete log entry	7	delete_logentry
22	Can add uzytkownik	8	add_uzytkownik
23	Can change uzytkownik	8	change_uzytkownik
24	Can delete uzytkownik	8	delete_uzytkownik
25	Can add forum	9	add_forum
26	Can change forum	9	change_forum
27	Can delete forum	9	delete_forum
28	Can add temat	10	add_temat
29	Can change temat	10	change_temat
30	Can delete temat	10	delete_temat
31	Can add post	11	add_post
32	Can change post	11	change_post
33	Can delete post	11	delete_post
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: django
--

COPY auth_user (id, username, first_name, last_name, email, password, is_staff, is_active, is_superuser, last_login, date_joined) FROM stdin;
5	Franek			franek@o2.pl	pbkdf2_sha256$10000$eqlUHfmiKTJs$AmRjKBY7kUVio/gmL2kZY2C9+SejUuBa3k8u0Z8WZws=	f	t	f	2012-09-03 22:28:01.54075+02	2012-09-03 21:10:21.820759+02
3	ziomekH			ziomekH@o2.pl	pbkdf2_sha256$10000$RwmoMwwn8vYt$qNJMQ3sP+G7aOqBYVNNSMN4/BySptTxHbqJPyWW8dgw=	f	t	f	2012-09-03 22:32:06.046625+02	2012-09-03 21:08:24.238578+02
6	Asia			asia@o2.pl	pbkdf2_sha256$10000$WnY84a1RPxDr$Gqes7+Blhtotc6Q6EPOMdAIotVl88c7t4VO9m9yYJJM=	f	t	f	2012-09-03 22:32:50.051574+02	2012-09-03 21:10:56.158377+02
1	adi			neo_23@o2.pl	pbkdf2_sha256$10000$ZdiVUuckQXG6$Q0RaXiGQE0WEq0EhArdz9Ojrj96vKO8AIORa4G0ZtRI=	t	t	t	2012-09-04 17:45:22.650468+02	2012-08-27 20:59:21.507088+02
4	Kasia	Katarzyna		kasia@o2.pl	pbkdf2_sha256$10000$20F5W2EZXi8T$dqECLEBDpF/Y5LEjwyb3XGYZZplpLqyNDuxsAodJt9E=	f	t	f	2012-09-04 17:46:01.636247+02	2012-09-03 21:09:48.447215+02
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: django
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: django
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: django
--

COPY django_admin_log (id, action_time, user_id, content_type_id, object_id, object_repr, action_flag, change_message) FROM stdin;
1	2012-09-03 20:28:39.817071+02	1	3	2	ziomekH	1	
2	2012-09-03 20:29:10.950631+02	1	3	2	ziomekH	2	Zmieniono password
3	2012-09-03 20:31:16.042876+02	1	3	2	ziomekH	3	
4	2012-09-03 20:35:14.211226+02	1	9	1	Skutery	1	
5	2012-09-03 20:35:27.467786+02	1	9	1	Skutery	2	Żadne pole nie zmienione.
6	2012-09-03 20:35:31.346501+02	1	9	1	Skutery	2	Żadne pole nie zmienione.
7	2012-09-03 20:35:31.545176+02	1	9	1	Skutery	2	Żadne pole nie zmienione.
8	2012-09-03 20:35:39.499486+02	1	9	1	Skutery	3	
9	2012-09-03 20:35:48.163608+02	1	9	2	Skutery	1	
10	2012-09-03 20:37:16.544655+02	1	10	1	Yamaha Aerox	1	
11	2012-09-03 20:38:29.827516+02	1	10	2	Peugeot Jetforce	1	
12	2012-09-03 20:38:44.204901+02	1	10	3	Daelim S-Five	1	
13	2012-09-03 20:43:03.75955+02	1	11	1	adi 2012-09-03 18:43:03.725371+00:00	1	
14	2012-09-03 20:43:08.096115+02	1	11	1	adi 2012-09-03 18:43:08.087667+00:00	2	Żadne pole nie zmienione.
15	2012-09-03 20:43:56.139023+02	1	11	2	adi 2012-09-03 18:43:56.134810+00:00	1	
16	2012-09-03 20:44:22.684573+02	1	11	3	adi 2012-09-03 18:44:22.677123+00:00	1	
17	2012-09-03 20:44:47.06543+02	1	11	4	adi 2012-09-03 18:44:47.057660+00:00	1	
18	2012-09-03 20:45:59.804041+02	1	11	5	adi 2012-09-03 18:45:59.798880+00:00	1	
19	2012-09-03 20:46:16.502681+02	1	11	6	adi 2012-09-03 18:46:16.498811+00:00	1	
20	2012-09-03 20:47:38.522796+02	1	9	2	Skutery	2	Zmieniono opis
21	2012-09-03 20:47:42.317743+02	1	9	2	Skutery	2	Żadne pole nie zmienione.
22	2012-09-03 20:51:15.93879+02	1	9	3	BMW	1	
23	2012-09-03 20:52:20.896505+02	1	10	5	BMW serii 1	1	
24	2012-09-03 20:52:33.574818+02	1	10	6	BMW serii 3	1	
25	2012-09-03 20:55:03.240041+02	1	10	6	BMW serii 3	3	
26	2012-09-03 20:55:03.242374+02	1	10	5	BMW serii 1	3	
27	2012-09-03 20:57:32.787663+02	1	10	7	BMW serii 1	1	
28	2012-09-03 20:59:38.147483+02	1	11	8	adi 2012-09-03 18:59:38.141995+00:00	1	
29	2012-09-03 21:03:19.135743+02	1	9	3	BMW	3	
30	2012-09-03 21:04:43.473712+02	1	9	2	Skutery	3	
31	2012-09-03 21:05:07.341452+02	1	9	4	Skutery	1	
32	2012-09-03 21:05:16.653447+02	1	9	5	BMW	1	
33	2012-09-03 21:15:31.15979+02	1	10	8	BMW serii 1	3	
34	2012-09-03 21:45:30.195471+02	1	9	5	BMW	2	Zmieniono opis
35	2012-09-03 22:20:10.109305+02	1	9	4	Skutery	2	Zmieniono opis
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: django
--

COPY django_content_type (id, name, app_label, model) FROM stdin;
1	permission	auth	permission
2	group	auth	group
3	user	auth	user
4	content type	contenttypes	contenttype
5	session	sessions	session
6	site	sites	site
7	log entry	admin	logentry
8	uzytkownik	DFor	uzytkownik
9	forum	DFor	forum
10	temat	DFor	temat
11	post	DFor	post
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: django
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
dfe3aee1ae42b8e1d17baa163217d04e	YmU5ZGI0YTAwNTU5NWZhZTJmZTRkMzgxMWQ3MWQxYWRjNGVjNmNhYjqAAn1xAS4=\n	2012-09-17 22:41:26.879463+02
cb78e988d23672c60c49fdbcd9f68668	MjY0YjE0NjY0YjZiNDRlNjc1MjhjNGJkNGUwODhhZGE3MTdkNGE3NTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQRLBHUu\n	2012-09-18 17:46:01.641908+02
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: django
--

COPY django_site (id, domain, name) FROM stdin;
1	example.com	example.com
\.


--
-- Name: DFor_forum_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY "DFor_forum"
    ADD CONSTRAINT "DFor_forum_pkey" PRIMARY KEY (id);


--
-- Name: DFor_post_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY "DFor_post"
    ADD CONSTRAINT "DFor_post_pkey" PRIMARY KEY (id);


--
-- Name: DFor_temat_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY "DFor_temat"
    ADD CONSTRAINT "DFor_temat_pkey" PRIMARY KEY (id);


--
-- Name: DFor_temat_tytul_key; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY "DFor_temat"
    ADD CONSTRAINT "DFor_temat_tytul_key" UNIQUE (tytul);


--
-- Name: DFor_uzytkownik_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY "DFor_uzytkownik"
    ADD CONSTRAINT "DFor_uzytkownik_pkey" PRIMARY KEY (id);


--
-- Name: DFor_uzytkownik_uzytkownik_id_key; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY "DFor_uzytkownik"
    ADD CONSTRAINT "DFor_uzytkownik_uzytkownik_id_key" UNIQUE (uzytkownik_id);


--
-- Name: auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions_group_id_key; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_key UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission_content_type_id_key; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_key UNIQUE (content_type_id, codename);


--
-- Name: auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups_user_id_key; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_key UNIQUE (user_id, group_id);


--
-- Name: auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions_user_id_key; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_key UNIQUE (user_id, permission_id);


--
-- Name: auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type_app_label_key; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_key UNIQUE (app_label, model);


--
-- Name: django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: django; Tablespace: 
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: DFor_post_autor_id; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX "DFor_post_autor_id" ON "DFor_post" USING btree (autor_id);


--
-- Name: DFor_post_temat_id; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX "DFor_post_temat_id" ON "DFor_post" USING btree (temat_id);


--
-- Name: DFor_post_tsv; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX "DFor_post_tsv" ON "DFor_post" USING gin (tekst_tsv);


--
-- Name: DFor_temat_forum_id; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX "DFor_temat_forum_id" ON "DFor_temat" USING btree (forum_id);


--
-- Name: DFor_temat_tsv; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX "DFor_temat_tsv" ON "DFor_temat" USING gin (tytul_tsv);


--
-- Name: auth_group_permissions_group_id; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX auth_group_permissions_group_id ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX auth_group_permissions_permission_id ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX auth_permission_content_type_id ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX auth_user_groups_group_id ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX auth_user_groups_user_id ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_permission_id ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX auth_user_user_permissions_user_id ON auth_user_user_permissions USING btree (user_id);


--
-- Name: django_admin_log_content_type_id; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX django_admin_log_content_type_id ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX django_admin_log_user_id ON django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date; Type: INDEX; Schema: public; Owner: django; Tablespace: 
--

CREATE INDEX django_session_expire_date ON django_session USING btree (expire_date);


--
-- Name: tsvectorUpdatePost; Type: TRIGGER; Schema: public; Owner: django
--

CREATE TRIGGER "tsvectorUpdatePost"
    BEFORE INSERT OR UPDATE ON "DFor_post"
    FOR EACH ROW
    EXECUTE PROCEDURE tsvector_update_trigger('tekst_tsv', 'public.polish', 'tekst');


--
-- Name: tsvectorUpdateTemat; Type: TRIGGER; Schema: public; Owner: django
--

CREATE TRIGGER "tsvectorUpdateTemat"
    BEFORE INSERT OR UPDATE ON "DFor_temat"
    FOR EACH ROW
    EXECUTE PROCEDURE tsvector_update_trigger('tytul_tsv', 'public.polish', 'tytul');


--
-- Name: DFor_post_autor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY "DFor_post"
    ADD CONSTRAINT "DFor_post_autor_id_fkey" FOREIGN KEY (autor_id) REFERENCES "DFor_uzytkownik"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: DFor_post_temat_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY "DFor_post"
    ADD CONSTRAINT "DFor_post_temat_id_fkey" FOREIGN KEY (temat_id) REFERENCES "DFor_temat"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: DFor_temat_forum_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY "DFor_temat"
    ADD CONSTRAINT "DFor_temat_forum_id_fkey" FOREIGN KEY (forum_id) REFERENCES "DFor_forum"(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: DFor_uzytkownik_uzytkownik_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY "DFor_uzytkownik"
    ADD CONSTRAINT "DFor_uzytkownik_uzytkownik_id_fkey" FOREIGN KEY (uzytkownik_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions_permission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_type_id_refs_id_728de91f; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT content_type_id_refs_id_728de91f FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_content_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_fkey FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: group_id_refs_id_3cea63fe; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT group_id_refs_id_3cea63fe FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_831107f1; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT user_id_refs_id_831107f1 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: user_id_refs_id_f2045483; Type: FK CONSTRAINT; Schema: public; Owner: django
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT user_id_refs_id_f2045483 FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

