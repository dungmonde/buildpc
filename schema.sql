--
-- PostgreSQL database dump
--

\restrict QOqEbWduGGbLE9OPyrJYt0sHUGpwpQwcBdgndrhfHQdZ5tUm9gx5lYd83tdXHy3

-- Dumped from database version 18.2
-- Dumped by pg_dump version 18.2

-- Started on 2026-06-17 11:42:05

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 255 (class 1259 OID 25726)
-- Name: build_components; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.build_components (
    id bigint NOT NULL,
    build_id bigint NOT NULL,
    component_id bigint NOT NULL,
    quantity integer DEFAULT 1 NOT NULL
);


ALTER TABLE public.build_components OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 25725)
-- Name: build_components_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.build_components_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.build_components_id_seq OWNER TO postgres;

--
-- TOC entry 5306 (class 0 OID 0)
-- Dependencies: 254
-- Name: build_components_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.build_components_id_seq OWNED BY public.build_components.id;


--
-- TOC entry 227 (class 1259 OID 25441)
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration bigint NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 25452)
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration bigint NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 25610)
-- Name: cases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cases (
    component_id bigint NOT NULL,
    type character varying(255),
    color character varying(255),
    psu integer,
    side_panel character varying(255),
    external_volume double precision,
    internal_35_bays integer,
    form_factor_support character varying(255)
);


ALTER TABLE public.cases OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 26137)
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    post_id bigint NOT NULL,
    user_id bigint NOT NULL,
    content text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 26136)
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comments_id_seq OWNER TO postgres;

--
-- TOC entry 5307 (class 0 OID 0)
-- Dependencies: 260
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- TOC entry 249 (class 1259 OID 25648)
-- Name: component_prices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_prices (
    id bigint NOT NULL,
    component_id bigint NOT NULL,
    dealer_id bigint NOT NULL,
    price numeric(15,2) NOT NULL,
    product_url character varying(255),
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.component_prices OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 25647)
-- Name: component_prices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.component_prices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.component_prices_id_seq OWNER TO postgres;

--
-- TOC entry 5308 (class 0 OID 0)
-- Dependencies: 248
-- Name: component_prices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.component_prices_id_seq OWNED BY public.component_prices.id;


--
-- TOC entry 235 (class 1259 OID 25513)
-- Name: component_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_types (
    id bigint NOT NULL,
    type_name character varying(255) NOT NULL
);


ALTER TABLE public.component_types OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 25512)
-- Name: component_types_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.component_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.component_types_id_seq OWNER TO postgres;

--
-- TOC entry 5309 (class 0 OID 0)
-- Dependencies: 234
-- Name: component_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.component_types_id_seq OWNED BY public.component_types.id;


--
-- TOC entry 237 (class 1259 OID 25522)
-- Name: components; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.components (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    type_id bigint NOT NULL,
    base_price numeric(15,2)
);


ALTER TABLE public.components OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 25521)
-- Name: components_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.components_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.components_id_seq OWNER TO postgres;

--
-- TOC entry 5310 (class 0 OID 0)
-- Dependencies: 236
-- Name: components_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.components_id_seq OWNED BY public.components.id;


--
-- TOC entry 239 (class 1259 OID 25549)
-- Name: cpu_coolers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cpu_coolers (
    component_id bigint NOT NULL,
    rpm integer,
    noise_level double precision,
    color character varying(255),
    size integer
);


ALTER TABLE public.cpu_coolers OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 25536)
-- Name: cpus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cpus (
    component_id bigint NOT NULL,
    core_count integer,
    core_clock double precision,
    boost_clock double precision,
    microarchitecture character varying(255),
    tdp integer,
    graphics character varying(255),
    socket character varying(255)
);


ALTER TABLE public.cpus OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 25637)
-- Name: dealers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dealers (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    website character varying(255),
    logo_url character varying(255)
);


ALTER TABLE public.dealers OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 25636)
-- Name: dealers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dealers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dealers_id_seq OWNER TO postgres;

--
-- TOC entry 5311 (class 0 OID 0)
-- Dependencies: 246
-- Name: dealers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dealers_id_seq OWNED BY public.dealers.id;


--
-- TOC entry 233 (class 1259 OID 25494)
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 25493)
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.failed_jobs_id_seq OWNER TO postgres;

--
-- TOC entry 5312 (class 0 OID 0)
-- Dependencies: 232
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- TOC entry 243 (class 1259 OID 25597)
-- Name: internal_hard_drives; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.internal_hard_drives (
    component_id bigint NOT NULL,
    capacity integer,
    price_per_gb double precision,
    type character varying(255),
    cache integer,
    form_factor character varying(255),
    interface character varying(255)
);


ALTER TABLE public.internal_hard_drives OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 25479)
-- Name: job_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 25464)
-- Name: jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 25463)
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO postgres;

--
-- TOC entry 5313 (class 0 OID 0)
-- Dependencies: 229
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- TOC entry 241 (class 1259 OID 25573)
-- Name: memory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.memory (
    component_id bigint NOT NULL,
    speed integer,
    module_count integer,
    module_size integer,
    price_per_gb double precision,
    color character varying(255),
    first_word_latency double precision,
    cas_latency integer,
    capacity integer,
    ddr_gen integer
);


ALTER TABLE public.memory OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 25396)
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 25395)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- TOC entry 5314 (class 0 OID 0)
-- Dependencies: 221
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 240 (class 1259 OID 25560)
-- Name: motherboards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.motherboards (
    component_id bigint NOT NULL,
    socket character varying(255),
    form_factor character varying(255),
    max_memory integer,
    memory_slots integer,
    color character varying(255),
    ddr_gen integer
);


ALTER TABLE public.motherboards OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 25420)
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 25707)
-- Name: pc_builds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pc_builds (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    build_name character varying(255),
    total_price numeric(10,2),
    usage_profile_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.pc_builds OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 25706)
-- Name: pc_builds_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pc_builds_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pc_builds_id_seq OWNER TO postgres;

--
-- TOC entry 5315 (class 0 OID 0)
-- Dependencies: 252
-- Name: pc_builds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pc_builds_id_seq OWNED BY public.pc_builds.id;


--
-- TOC entry 257 (class 1259 OID 25748)
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posts (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    title character varying(255) NOT NULL,
    content text,
    post_type character varying(255) DEFAULT 'discussion'::character varying NOT NULL,
    build_id bigint,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.posts OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 25747)
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.posts_id_seq OWNER TO postgres;

--
-- TOC entry 5316 (class 0 OID 0)
-- Dependencies: 256
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- TOC entry 245 (class 1259 OID 25623)
-- Name: power_supplies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.power_supplies (
    component_id bigint NOT NULL,
    type character varying(255),
    efficiency character varying(255),
    wattage integer,
    modular boolean,
    color character varying(255)
);


ALTER TABLE public.power_supplies OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 25429)
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 25696)
-- Name: usage_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usage_profiles (
    id bigint NOT NULL,
    profile_name character varying(255) NOT NULL,
    description text,
    logic_rules json
);


ALTER TABLE public.usage_profiles OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 25695)
-- Name: usage_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usage_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usage_profiles_id_seq OWNER TO postgres;

--
-- TOC entry 5317 (class 0 OID 0)
-- Dependencies: 250
-- Name: usage_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usage_profiles_id_seq OWNED BY public.usage_profiles.id;


--
-- TOC entry 224 (class 1259 OID 25406)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    role character varying(255) DEFAULT 'user'::character varying NOT NULL,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY ((ARRAY['user'::character varying, 'admin'::character varying])::text[])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 25405)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5318 (class 0 OID 0)
-- Dependencies: 223
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 242 (class 1259 OID 25584)
-- Name: video_cards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.video_cards (
    component_id bigint NOT NULL,
    chipset character varying(255),
    memory integer,
    core_clock integer,
    boost_clock integer,
    color character varying(255),
    length integer,
    tdp integer
);


ALTER TABLE public.video_cards OWNER TO postgres;

--
-- TOC entry 5319 (class 0 OID 0)
-- Dependencies: 242
-- Name: COLUMN video_cards.tdp; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.video_cards.tdp IS 'Công suất tiêu thụ của VGA (Watt)';


--
-- TOC entry 259 (class 1259 OID 25772)
-- Name: votes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.votes (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    post_id bigint NOT NULL,
    vote_type character varying(255) DEFAULT 'up'::character varying NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.votes OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 25771)
-- Name: votes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.votes_id_seq OWNER TO postgres;

--
-- TOC entry 5320 (class 0 OID 0)
-- Dependencies: 258
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.votes_id_seq OWNED BY public.votes.id;


--
-- TOC entry 4987 (class 2604 OID 26112)
-- Name: build_components id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.build_components ALTER COLUMN id SET DEFAULT nextval('public.build_components_id_seq'::regclass);


--
-- TOC entry 4993 (class 2604 OID 26140)
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- TOC entry 4984 (class 2604 OID 26114)
-- Name: component_prices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_prices ALTER COLUMN id SET DEFAULT nextval('public.component_prices_id_seq'::regclass);


--
-- TOC entry 4981 (class 2604 OID 26115)
-- Name: component_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_types ALTER COLUMN id SET DEFAULT nextval('public.component_types_id_seq'::regclass);


--
-- TOC entry 4982 (class 2604 OID 26116)
-- Name: components id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components ALTER COLUMN id SET DEFAULT nextval('public.components_id_seq'::regclass);


--
-- TOC entry 4983 (class 2604 OID 26117)
-- Name: dealers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dealers ALTER COLUMN id SET DEFAULT nextval('public.dealers_id_seq'::regclass);


--
-- TOC entry 4979 (class 2604 OID 26118)
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- TOC entry 4978 (class 2604 OID 26119)
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- TOC entry 4975 (class 2604 OID 26120)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 4986 (class 2604 OID 26121)
-- Name: pc_builds id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pc_builds ALTER COLUMN id SET DEFAULT nextval('public.pc_builds_id_seq'::regclass);


--
-- TOC entry 4989 (class 2604 OID 26122)
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- TOC entry 4985 (class 2604 OID 26123)
-- Name: usage_profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usage_profiles ALTER COLUMN id SET DEFAULT nextval('public.usage_profiles_id_seq'::regclass);


--
-- TOC entry 4976 (class 2604 OID 26124)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4991 (class 2604 OID 26125)
-- Name: votes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes ALTER COLUMN id SET DEFAULT nextval('public.votes_id_seq'::regclass);


--
-- TOC entry 5294 (class 0 OID 25726)
-- Dependencies: 255
-- Data for Name: build_components; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.build_components (id, build_id, component_id, quantity) FROM stdin;
1	2	1	1
2	2	4339	1
4	4	1	1
5	5	1	1
7	7	1	1
8	1	1	1
\.


--
-- TOC entry 5266 (class 0 OID 25441)
-- Dependencies: 227
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
\.


--
-- TOC entry 5267 (class 0 OID 25452)
-- Dependencies: 228
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- TOC entry 5283 (class 0 OID 25610)
-- Dependencies: 244
-- Data for Name: cases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cases (component_id, type, color, psu, side_panel, external_volume, internal_35_bays, form_factor_support) FROM stdin;
4539	ATX Mid Tower	Black	\N	Tempered Glass	45	2	ATX ↓
4540	ATX Mid Tower	Black	\N	Tempered Glass	51.8	2	ATX ↓
4541	ATX Mid Tower	Black	\N	Tempered Glass	45	1	ATX ↓
4542	ATX Mid Tower	White	\N	Tempered Glass	55.9	2	ATX ↓
4543	MicroATX Mini Tower	Black	\N	Acrylic	33.6	1	ATX ↓
4544	ATX Mid Tower	Black	\N	Tinted Tempered Glass	48.6	2	ATX ↓
4545	ATX Mid Tower	Blue	\N	Tempered Glass	45.5	2	ATX ↓
4547	ATX Mid Tower	White	\N	Tempered Glass	57.4	2	ATX ↓
4549	MicroATX Mid Tower	Black	\N	Tempered Glass	36.1	2	ATX ↓
4550	ATX Mid Tower	Black	\N	Tempered Glass	54.2	2	ATX ↓
4551	MicroATX Mini Tower	Black	\N	Mesh	26.3	1	ATX ↓
4552	ATX Mid Tower	Black	\N	Tempered Glass	45.1	2	ATX ↓
4553	ATX Mid Tower	White	\N	Tempered Glass	70.7	2	ATX ↓
4554	ATX Full Tower	Black	\N	Tinted Tempered Glass	61.4	2	E-ATX ↓
4558	ATX Mid Tower	Black	\N	Tempered Glass	51.8	2	ATX ↓
4561	ATX Mid Tower	Black	\N	Tempered Glass	65.3	4	ATX ↓
4562	ATX Mid Tower	Black	\N	Tempered Glass	51.8	1	ATX ↓
4563	ATX Mid Tower	Black	\N	Tempered Glass	54.2	2	ATX ↓
4566	ATX Mid Tower	Black	\N	Tempered Glass	56.7	2	ATX ↓
4567	MicroATX Mid Tower	Black	\N	Tinted Tempered Glass	35	1	ATX ↓
4568	Mini ITX Desktop	Black / Brown	\N	Mesh	11.4	0	Mini ITX
4569	ATX Mid Tower	Black	\N	Tempered Glass	\N	1	ATX ↓
4570	ATX Full Tower	Black	\N	Tempered Glass	62.4	3	E-ATX ↓
4571	ATX Mid Tower	Black / Brown	\N	Tempered Glass	57.7	1	ATX ↓
4572	ATX Full Tower	Black	\N	Tempered Glass	84.4	4	E-ATX ↓
4573	ATX Mid Tower	Black	\N	Tempered Glass	63	5	ATX ↓
4574	ATX Mid Tower	Black	\N	Tinted Tempered Glass	40.6	2	ATX ↓
4576	ATX Mid Tower	Black	\N	Tempered Glass	55.6	2	ATX ↓
4577	ATX Mid Tower	White	\N	Tempered Glass	70.7	2	ATX ↓
4578	ATX Mid Tower	Black	\N	Tempered Glass	46.2	2	ATX ↓
4579	ATX Mid Tower	Black	\N	Tempered Glass	62.1	2	ATX ↓
4580	ATX Mid Tower	White	\N	Tempered Glass	40.9	2	ATX ↓
4581	ATX Mid Tower	Black	\N	Tempered Glass	49.5	2	ATX ↓
4582	ATX Mid Tower	Black	\N	Tempered Glass	67.8	2	ATX ↓
4586	ATX Mid Tower	Black	\N	Tempered Glass	\N	2	ATX ↓
4589	ATX Mid Tower	Black	\N	Tempered Glass	56.7	2	ATX ↓
4590	ATX Mid Tower	White	\N	Tempered Glass	51.8	1	ATX ↓
4591	MicroATX Mini Tower	Black	\N	Mesh	33	3	ATX ↓
4592	ATX Mid Tower	Black / Brown	\N	Tempered Glass	49.8	2	ATX ↓
4593	MicroATX Mini Tower	Black	\N	Tempered Glass	45.3	2	ATX ↓
4595	ATX Full Tower	Black	\N	Tempered Glass	66.9	2	E-ATX ↓
4596	MicroATX Mini Tower	Black	\N	Acrylic	30.4	2	ATX ↓
4597	ATX Full Tower	Black	\N	Tempered Glass	98.9	8	E-ATX ↓
4599	ATX Mid Tower	Black	\N	Tempered Glass	66.2	2	ATX ↓
4627	ATX Full Tower	Black	\N	Tempered Glass	\N	3	E-ATX ↓
4600	Mini ITX Tower	Black	\N	Mesh	16.3	0	Mini ITX
4601	ATX Mid Tower	Black	\N	Tempered Glass	55.9	2	ATX ↓
4603	MicroATX Mid Tower	Black	\N	Tempered Glass	30.9	1	ATX ↓
4604	ATX Full Tower	Black / Brown	\N	Tempered Glass	70.8	4	E-ATX ↓
4605	MicroATX Mid Tower	Black	\N	Tempered Glass	34.1	1	ATX ↓
4607	MicroATX Desktop	Black	\N	Tempered Glass	25.3	1	ATX ↓
4608	MicroATX Mid Tower	Black	\N	Tempered Glass	36.5	2	ATX ↓
4612	ATX Mid Tower	Black	\N	Tempered Glass	49.4	2	ATX ↓
4613	MicroATX Desktop	Black	\N	Tempered Glass	25.7	2	ATX ↓
4614	Mini ITX Desktop	Black	\N	Mesh	11.1	0	Mini ITX
4618	MicroATX Mini Tower	Black / Brown	\N	Tempered Glass	\N	2	ATX ↓
4619	ATX Mid Tower	Black	\N	Acrylic	42.2	2	ATX ↓
4620	MicroATX Mini Tower	Black	\N	Tempered Glass	35	1	ATX ↓
4621	ATX Mid Tower	Black	\N	Tempered Glass	45	1	ATX ↓
4623	ATX Mid Tower	Black	\N	Tinted Tempered Glass	76.7	2	ATX ↓
4628	ATX Mid Tower	Black	\N	Tempered Glass	55.6	2	ATX ↓
4629	ATX Mid Tower	Black	\N	Tempered Glass	47.6	2	ATX ↓
4630	ATX Mid Tower	Black / Brown	\N	Tempered Glass	58.1	2	ATX ↓
4632	Mini ITX Desktop	Black	\N	Mesh	20.1	1	Mini ITX
4636	ATX Mid Tower	Black	\N	Tempered Glass	56.7	2	ATX ↓
4734	ATX Mid Tower	Black	\N	\N	45.8	2	ATX ↓
4637	ATX Full Tower	Black	\N	Tempered Glass	83.5	2	E-ATX ↓
4638	ATX Mid Tower	Black	\N	Tempered Glass	46.2	2	ATX ↓
4639	ATX Mid Tower	Black	\N	Tinted Tempered Glass	76.7	2	ATX ↓
4640	ATX Mid Tower	Black	\N	Tempered Glass	63	2	ATX ↓
4643	MicroATX Mini Tower	Black	\N	Tempered Glass	34.1	1	ATX ↓
4644	ATX Full Tower	Black / Brown	\N	Tempered Glass	66.9	2	E-ATX ↓
4645	ATX Mid Tower	Black	\N	Tempered Glass	43	2	ATX ↓
4647	ATX Mid Tower	Black	\N	Tempered Glass	60	2	ATX ↓
4648	ATX Mid Tower	Black	\N	Tempered Glass	44.4	2	ATX ↓
4651	ATX Mid Tower	Black	\N	Acrylic	38.4	2	ATX ↓
4653	Mini ITX Desktop	Black	\N	Mesh	15.9	1	Mini ITX
4654	Mini ITX Desktop	Silver / Black	\N	Mesh	11.1	0	Mini ITX
4656	ATX Mid Tower	Black	\N	Tempered Glass	65.5	4	ATX ↓
4657	ATX Mid Tower	Black	\N	Tempered Glass	43.5	2	ATX ↓
4661	ATX Mid Tower	Black	\N	Tinted Tempered Glass	69.8	2	ATX ↓
4664	MicroATX Mini Tower	Black	\N	Tempered Glass	33	2	ATX ↓
4666	ATX Mid Tower	Black	\N	Tempered Glass	48.7	0	ATX ↓
4669	ATX Mid Tower	Black	\N	Tempered Glass	72.5	2	ATX ↓
4670	ATX Mid Tower	Black	\N	Tempered Glass	34.1	2	ATX ↓
4671	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	2	ATX ↓
4672	MicroATX Mid Tower	Black	\N	Acrylic	41.1	10	ATX ↓
4674	ATX Mid Tower	Black	\N	Tempered Glass	60.9	2	ATX ↓
4675	ATX Mid Tower	Black	\N	Tempered Glass	62.1	2	ATX ↓
4676	ATX Mid Tower	Black	\N	Tempered Glass	49.7	1	ATX ↓
4677	ATX Mid Tower	Black	\N	Tempered Glass	51.6	2	ATX ↓
4681	ATX Mid Tower	Black	\N	Tinted Tempered Glass	50.3	2	ATX ↓
4690	Mini ITX Desktop	Black	\N	Tempered Glass	16.4	1	Mini ITX
4691	MicroATX Mini Tower	Black	\N	Tempered Glass	54.8	2	ATX ↓
4698	ATX Full Tower	Black	\N	Tinted Tempered Glass	81.5	6	E-ATX ↓
4701	ATX Mid Tower	Black	\N	Tempered Glass	42.5	2	ATX ↓
4702	ATX Mid Tower	Black	\N	Tinted Tempered Glass	67.8	2	ATX ↓
4708	MicroATX Mini Tower	Black	\N	Tempered Glass	53	3	ATX ↓
4709	ATX Mid Tower	Black	\N	Tempered Glass	57.2	4	ATX ↓
4710	ATX Mid Tower	Black	\N	Tempered Glass	66.2	1	ATX ↓
4711	ATX Mid Tower	Black	\N	Tempered Glass	55.9	2	ATX ↓
4712	ATX Mid Tower	Black	\N	Tempered Glass	49.5	2	ATX ↓
4716	ATX Mid Tower	Black	\N	Tempered Glass	38.3	2	ATX ↓
4718	MicroATX Desktop	Black / Brown	\N	Mesh	19.6	6	ATX ↓
4719	ATX Mid Tower	Black	\N	Tempered Glass	59.7	1	ATX ↓
4720	MicroATX Mini Tower	Black	\N	Tinted Tempered Glass	36.6	1	ATX ↓
4721	ATX Mid Tower	Pink	\N	Tempered Glass	48.1	0	ATX ↓
4723	ATX Mid Tower	Black	\N	Tinted Tempered Glass	51.6	1	ATX ↓
4731	ATX Mid Tower	Black	\N	Tempered Glass	47.9	1	ATX ↓
4735	ATX Mid Tower	Black	\N	Tempered Glass	52.9	2	ATX ↓
4737	ATX Mid Tower	Black / Brown	\N	Tempered Glass	66.9	1	ATX ↓
4738	MicroATX Desktop	Black	\N	Tempered Glass	20.8	1	ATX ↓
\.


--
-- TOC entry 5300 (class 0 OID 26137)
-- Dependencies: 261
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (id, post_id, user_id, content, created_at, updated_at) FROM stdin;
1	1	1	Bình luận	2026-04-12 04:41:17	2026-04-12 04:41:17
2	1	1	hello	2026-04-12 06:49:29	2026-04-12 06:49:29
3	1	1	hello	2026-04-12 06:49:30	2026-04-12 06:49:30
4	3	6	25 triệu thì làm i5-14600K + 32GB RAM DDR5 là hợp lý.	2026-06-05 16:51:40	2026-06-05 16:51:40
5	3	7	Nếu Revit nhiều thì ưu tiên RAM 32GB, SSD 1TB và RTX 4060.	2026-06-05 16:51:40	2026-06-05 16:51:40
6	3	8	Mình đề xuất Ryzen 7 7700 + RTX 4060, hiệu năng/giá khá tốt.	2026-06-05 16:51:40	2026-06-05 16:51:40
7	3	5	Em cảm ơn các bác, em đang phân vân giữa Intel và AMD.	2026-06-05 16:51:40	2026-06-05 16:51:40
8	3	9	Tầm này AMD ngon hơn về nâng cấp sau này, vote Ryzen 7 7700.	2026-06-05 16:51:40	2026-06-05 16:51:40
9	1	1	test comment	2026-06-17 04:40:39	2026-06-17 04:40:39
\.


--
-- TOC entry 5288 (class 0 OID 25648)
-- Dependencies: 249
-- Data for Name: component_prices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_prices (id, component_id, dealer_id, price, product_url, updated_at) FROM stdin;
137	173	1	4000000.00	https://newegg.com	2026-06-16 16:57:01
957	1080	1	14731746.00	\N	2026-04-10 10:10:02
1374	4716	1	599000.00	\N	2026-06-16 17:14:03
1017	4745	1	8190000.00	\N	2026-04-10 10:28:50
1020	4748	1	8860000.00	\N	2026-04-10 10:29:36
1037	4772	1	7600000.00	\N	2026-04-10 10:34:27
1054	4803	1	3870000.00	\N	2026-04-10 10:39:14
1071	4839	1	970000.00	\N	2026-04-10 10:44:02
1088	4889	1	8790000.00	\N	2026-04-10 10:48:27
893	871	1	5500000.00	\N	2026-06-17 04:08:19
236	762	1	17779746.00	https://newegg.com	2026-04-10 00:08:56
888	862	1	38074600.00	\N	2026-04-10 09:47:57
261	903	1	38836600.00	https://newegg.com	2026-04-10 00:30:47
948	1037	1	38074600.00	\N	2026-04-10 10:06:38
969	1106	1	47929546.00	\N	2026-04-10 10:13:25
286	1092	1	5000000.00	https://newegg.com	2026-06-17 03:52:42
890	864	1	3000000.00	\N	2026-06-17 04:04:54
922	952	1	20000000.00	\N	2026-06-17 04:05:54
238	772	1	12000000.00	https://newegg.com	2026-06-17 04:13:09
889	863	1	5000000.00	\N	2026-06-17 04:14:58
1010	2331	1	63373000.00	\N	2026-04-10 10:26:29
988	1193	1	4900000.00	\N	2026-06-17 03:51:12
894	874	1	6095746.00	\N	2026-04-10 09:49:50
412	3805	1	8012000.00	https://newegg.com	2026-04-10 01:48:03
1105	3825	1	4168000.00	\N	2026-04-10 10:53:21
432	3842	1	15428000.00	https://newegg.com	2026-04-10 01:54:02
461	3936	1	21924000.00	https://newegg.com	2026-04-10 02:03:29
1122	3953	1	285000.00	\N	2026-04-10 10:58:20
488	4054	1	5791000.00	https://newegg.com	2026-04-10 02:11:33
1137	4171	1	8559000.00	\N	2026-04-10 11:02:36
1140	4181	1	924000.00	\N	2026-04-10 11:03:32
1165	2886	1	2600000.00	\N	2026-04-10 11:10:39
312	2894	1	2216000.00	https://newegg.com	2026-04-10 01:08:57
330	2934	1	3082000.00	https://newegg.com	2026-04-10 01:14:45
1182	2973	1	2143000.00	\N	2026-04-10 11:15:23
357	3045	1	6098000.00	https://newegg.com	2026-04-10 01:25:42
1199	3076	1	2467000.00	\N	2026-04-10 11:20:08
1216	3160	1	1909000.00	\N	2026-04-10 11:25:33
382	3181	1	3354000.00	https://newegg.com	2026-04-10 01:37:04
1233	3263	1	6748000.00	\N	2026-04-10 11:30:15
408	3275	1	2016000.00	https://newegg.com	2026-04-10 01:46:19
512	4340	1	3833000.00	https://newegg.com	2026-04-10 02:22:32
539	4366	1	4363000.00	https://newegg.com	2026-04-10 02:28:17
570	4397	1	3429000.00	https://newegg.com	2026-04-10 02:34:48
576	4403	1	2223000.00	https://newegg.com	2026-04-10 02:36:07
602	4430	1	6672000.00	https://newegg.com	2026-04-10 02:41:46
629	4463	1	2867000.00	https://newegg.com	2026-04-10 02:48:16
660	4500	1	7971000.00	https://newegg.com	2026-04-10 02:54:56
664	4505	1	6660000.00	https://newegg.com	2026-04-10 02:55:45
682	4527	1	2362000.00	https://newegg.com	2026-04-10 03:00:07
5	7	1	12000000.00	https://newegg.com	2026-06-16 17:03:37
3	4	1	7989000.00	https://newegg.com	2026-04-09 22:53:06
11	13	1	9000000.00	https://newegg.com	2026-06-05 12:00:28
17	19	1	15000000.00	https://newegg.com	2026-06-05 12:00:59
31	36	1	4500000.00	https://newegg.com	2026-06-16 16:57:16
8	10	1	8000000.00	https://newegg.com	2026-06-16 17:03:10
9	11	1	15000000.00	https://newegg.com	2026-06-16 17:04:14
18	20	1	4599000.00	https://newegg.com	2026-04-09 22:56:29
19	21	1	4529000.00	https://newegg.com	2026-04-09 22:56:42
21	26	1	6789000.00	https://newegg.com	2026-04-09 22:57:27
22	27	1	5069000.00	https://newegg.com	2026-04-09 22:57:41
23	28	1	1289000.00	https://newegg.com	2026-04-09 22:57:56
27	32	1	6379000.00	https://newegg.com	2026-04-09 22:58:53
32	37	1	12139000.00	https://newegg.com	2026-04-09 23:00:18
35	40	1	11939000.00	https://newegg.com	2026-04-09 23:01:06
38	43	1	2529000.00	https://newegg.com	2026-04-09 23:01:52
39	44	1	3189000.00	https://newegg.com	2026-04-09 23:02:06
41	49	1	10339000.00	https://newegg.com	2026-04-09 23:02:49
42	51	1	4059000.00	https://newegg.com	2026-04-09 23:03:16
44	53	1	6829000.00	https://newegg.com	2026-04-09 23:03:44
45	54	1	5359000.00	https://newegg.com	2026-04-09 23:03:58
49	58	1	8419000.00	https://newegg.com	2026-04-09 23:05:01
1	1	1	4429000.00	https://newegg.com	2026-04-09 22:52:16
60	67	1	7619000.00	https://newegg.com	2026-04-09 23:11:36
63	71	1	6969000.00	https://newegg.com	2026-04-09 23:12:16
65	73	1	8419000.00	https://newegg.com	2026-04-09 23:12:38
66	74	1	4339000.00	https://newegg.com	2026-04-09 23:12:51
70	78	1	5019000.00	https://newegg.com	2026-04-09 23:13:45
72	80	1	14209000.00	https://newegg.com	2026-04-09 23:14:14
75	86	1	8929000.00	https://newegg.com	2026-04-09 23:15:18
79	92	1	10969000.00	https://newegg.com	2026-04-09 23:16:28
80	93	1	3449000.00	https://newegg.com	2026-04-09 23:16:40
82	95	1	5079000.00	https://newegg.com	2026-04-09 23:17:04
84	98	1	2169000.00	https://newegg.com	2026-04-09 23:17:29
88	105	1	2299000.00	https://newegg.com	2026-04-09 23:18:38
94	112	1	5389000.00	https://newegg.com	2026-04-09 23:20:00
95	114	1	12299000.00	https://newegg.com	2026-04-09 23:20:27
98	118	1	11959000.00	https://newegg.com	2026-04-09 23:21:19
101	121	1	14209000.00	https://newegg.com	2026-04-09 23:21:58
104	127	1	5099000.00	https://newegg.com	2026-04-09 23:22:53
105	128	1	4799000.00	https://newegg.com	2026-04-09 23:23:06
106	129	1	4259000.00	https://newegg.com	2026-04-09 23:23:20
111	135	1	3989000.00	https://newegg.com	2026-04-09 23:24:25
113	138	1	17229000.00	https://newegg.com	2026-04-09 23:24:49
116	142	1	6439000.00	https://newegg.com	2026-04-09 23:25:27
118	144	1	4589000.00	https://newegg.com	2026-04-09 23:25:54
120	147	1	13309000.00	https://newegg.com	2026-04-09 23:26:20
124	152	1	1269000.00	https://newegg.com	2026-04-09 23:27:13
125	154	1	4339000.00	https://newegg.com	2026-04-09 23:27:28
129	161	1	3569000.00	https://newegg.com	2026-04-09 23:28:19
61	68	1	8500000.00	https://newegg.com	2026-06-05 12:00:06
91	108	1	12000000.00	https://newegg.com	2026-06-05 12:00:45
83	97	1	2500000.00	https://newegg.com	2026-06-16 16:51:31
134	168	1	5000000.00	https://newegg.com	2026-06-16 16:57:34
89	106	1	4500000.00	https://newegg.com	2026-06-16 16:57:50
126	157	1	5500000.00	https://newegg.com	2026-06-16 17:00:30
128	160	1	6000000.00	https://newegg.com	2026-06-16 17:00:43
99	119	1	9000000.00	https://newegg.com	2026-06-16 17:01:21
135	169	1	8000000.00	https://newegg.com	2026-06-16 17:03:00
96	115	1	10000000.00	https://newegg.com	2026-06-16 17:03:25
68	76	1	13000000.00	https://newegg.com	2026-06-16 17:03:52
112	136	1	15000000.00	https://newegg.com	2026-06-16 17:04:06
958	1081	1	1900000.00	\N	2026-06-17 03:54:29
136	172	1	10459000.00	https://newegg.com	2026-04-09 23:29:52
138	174	1	5099000.00	https://newegg.com	2026-04-09 23:30:18
139	350	1	6119000.00	https://newegg.com	2026-04-09 23:30:29
140	351	1	4619000.00	https://newegg.com	2026-04-09 23:30:39
141	352	1	2039000.00	https://newegg.com	2026-04-09 23:30:49
142	354	1	5599000.00	https://newegg.com	2026-04-09 23:31:19
143	355	1	3139000.00	https://newegg.com	2026-04-09 23:31:32
144	361	1	9429000.00	https://newegg.com	2026-04-09 23:32:10
145	363	1	6459000.00	https://newegg.com	2026-04-09 23:32:24
146	370	1	5079000.00	https://newegg.com	2026-04-09 23:33:02
147	371	1	2549000.00	https://newegg.com	2026-04-09 23:33:16
148	374	1	2549000.00	https://newegg.com	2026-04-09 23:33:46
149	375	1	3059000.00	https://newegg.com	2026-04-09 23:33:59
150	383	1	2549000.00	https://newegg.com	2026-04-09 23:35:21
151	384	1	2169000.00	https://newegg.com	2026-04-09 23:35:32
152	385	1	5459000.00	https://newegg.com	2026-04-09 23:35:46
153	388	1	2549000.00	https://newegg.com	2026-04-09 23:36:13
154	389	1	5099000.00	https://newegg.com	2026-04-09 23:36:25
155	390	1	3289000.00	https://newegg.com	2026-04-09 23:36:37
156	394	1	3799000.00	https://newegg.com	2026-04-09 23:37:07
157	396	1	2549000.00	https://newegg.com	2026-04-09 23:37:32
158	397	1	3289000.00	https://newegg.com	2026-04-09 23:37:47
159	399	1	5539000.00	https://newegg.com	2026-04-09 23:38:14
160	408	1	4309000.00	https://newegg.com	2026-04-09 23:38:27
161	411	1	3829000.00	https://newegg.com	2026-04-09 23:38:43
162	413	1	2019000.00	https://newegg.com	2026-04-09 23:38:58
163	416	1	2809000.00	https://newegg.com	2026-04-09 23:39:21
164	417	1	4899000.00	https://newegg.com	2026-04-09 23:39:35
165	418	1	2249000.00	https://newegg.com	2026-04-09 23:39:52
166	419	1	2219000.00	https://newegg.com	2026-04-09 23:40:04
167	420	1	3319000.00	https://newegg.com	2026-04-09 23:40:18
168	423	1	4339000.00	https://newegg.com	2026-04-09 23:40:45
169	427	1	5209000.00	https://newegg.com	2026-04-09 23:40:59
170	430	1	3799000.00	https://newegg.com	2026-04-09 23:41:42
171	432	1	6819000.00	https://newegg.com	2026-04-09 23:42:09
172	433	1	3319000.00	https://newegg.com	2026-04-09 23:42:22
173	436	1	1789000.00	https://newegg.com	2026-04-09 23:42:35
174	438	1	4339000.00	https://newegg.com	2026-04-09 23:42:49
175	440	1	1739000.00	https://newegg.com	2026-04-09 23:43:01
176	441	1	4079000.00	https://newegg.com	2026-04-09 23:43:15
177	444	1	4619000.00	https://newegg.com	2026-04-09 23:43:30
178	445	1	2809000.00	https://newegg.com	2026-04-09 23:43:42
179	449	1	3829000.00	https://newegg.com	2026-04-09 23:44:25
180	450	1	2299000.00	https://newegg.com	2026-04-09 23:44:40
181	454	1	6689000.00	https://newegg.com	2026-04-09 23:45:07
182	456	1	4899000.00	https://newegg.com	2026-04-09 23:45:33
183	457	1	2809000.00	https://newegg.com	2026-04-09 23:45:47
184	462	1	4849000.00	https://newegg.com	2026-04-09 23:46:16
185	463	1	1989000.00	https://newegg.com	2026-04-09 23:46:27
186	470	1	1409000.00	https://newegg.com	2026-04-09 23:46:54
187	471	1	2809000.00	https://newegg.com	2026-04-09 23:47:09
188	477	1	3569000.00	https://newegg.com	2026-04-09 23:47:38
189	479	1	4389000.00	https://newegg.com	2026-04-09 23:47:49
190	480	1	3059000.00	https://newegg.com	2026-04-09 23:48:02
191	486	1	3509000.00	https://newegg.com	2026-04-09 23:48:15
192	490	1	6889000.00	https://newegg.com	2026-04-09 23:48:40
193	515	1	4009000.00	https://newegg.com	2026-04-09 23:50:01
194	518	1	5869000.00	https://newegg.com	2026-04-09 23:50:28
195	523	1	3829000.00	https://newegg.com	2026-04-09 23:51:08
196	525	1	3879000.00	https://newegg.com	2026-04-09 23:51:20
197	529	1	3829000.00	https://newegg.com	2026-04-09 23:51:59
198	532	1	3479000.00	https://newegg.com	2026-04-09 23:52:23
199	540	1	1789000.00	https://newegg.com	2026-04-09 23:53:05
200	547	1	2549000.00	https://newegg.com	2026-04-09 23:53:30
201	555	1	4979000.00	https://newegg.com	2026-04-09 23:53:57
202	556	1	3569000.00	https://newegg.com	2026-04-09 23:54:07
203	559	1	3569000.00	https://newegg.com	2026-04-09 23:54:35
204	561	1	4819000.00	https://newegg.com	2026-04-09 23:55:02
205	562	1	9249000.00	https://newegg.com	2026-04-09 23:55:15
206	566	1	1019000.00	https://newegg.com	2026-04-09 23:55:32
207	568	1	2809000.00	https://newegg.com	2026-04-09 23:55:57
208	573	1	3089000.00	https://newegg.com	2026-04-09 23:56:24
209	583	1	4589000.00	https://newegg.com	2026-04-09 23:57:06
210	594	1	3059000.00	https://newegg.com	2026-04-09 23:58:00
211	595	1	5599000.00	https://newegg.com	2026-04-09 23:58:14
212	599	1	1789000.00	https://newegg.com	2026-04-09 23:58:25
213	604	1	1839000.00	https://newegg.com	2026-04-09 23:58:41
214	605	1	4469000.00	https://newegg.com	2026-04-09 23:58:52
215	609	1	11709000.00	https://newegg.com	2026-04-09 23:59:17
216	614	1	3879000.00	https://newegg.com	2026-04-09 23:59:41
217	638	1	4929000.00	https://newegg.com	2026-04-09 23:59:56
218	642	1	5619000.00	https://newegg.com	2026-04-10 00:00:22
219	655	1	7139000.00	https://newegg.com	2026-04-10 00:01:37
220	661	1	3829000.00	https://newegg.com	2026-04-10 00:02:01
221	662	1	4109000.00	https://newegg.com	2026-04-10 00:02:13
222	673	1	6349000.00	https://newegg.com	2026-04-10 00:03:09
223	681	1	4059000.00	https://newegg.com	2026-04-10 00:03:45
224	684	1	7399000.00	https://newegg.com	2026-04-10 00:03:56
225	687	1	2449000.00	https://newegg.com	2026-04-10 00:04:08
226	693	1	6349000.00	https://newegg.com	2026-04-10 00:04:20
227	706	1	2039000.00	https://newegg.com	2026-04-10 00:05:05
228	709	1	6379000.00	https://newegg.com	2026-04-10 00:05:34
229	713	1	6589000.00	https://newegg.com	2026-04-10 00:05:47
230	716	1	2039000.00	https://newegg.com	2026-04-10 00:06:11
231	719	1	6889000.00	https://newegg.com	2026-04-10 00:06:40
232	722	1	2299000.00	https://newegg.com	2026-04-10 00:06:53
233	726	1	6689000.00	https://newegg.com	2026-04-10 00:07:33
234	733	1	7469000.00	https://newegg.com	2026-04-10 00:08:01
235	742	1	5889000.00	https://newegg.com	2026-04-10 00:08:15
296	2849	1	1932000.00	https://newegg.com	2026-04-10 01:03:32
287	1125	1	4500000.00	https://newegg.com	2026-06-17 04:06:39
305	2875	1	4257000.00	https://newegg.com	2026-04-10 01:06:52
241	777	1	27939746.00	https://newegg.com	2026-04-10 00:11:52
289	1166	1	6500000.00	https://newegg.com	2026-06-17 04:10:53
243	781	1	18796000.00	https://newegg.com	2026-04-10 00:12:31
245	798	1	17779746.00	https://newegg.com	2026-04-10 00:15:28
270	970	1	2200000.00	https://newegg.com	2026-06-17 03:54:44
247	807	1	13918946.00	https://newegg.com	2026-04-10 00:16:39
248	813	1	16255746.00	https://newegg.com	2026-04-10 00:17:41
256	850	1	5000000.00	https://newegg.com	2026-06-17 04:15:42
250	821	1	18541746.00	https://newegg.com	2026-04-10 00:19:23
297	2851	1	1042000.00	https://newegg.com	2026-04-10 01:03:47
306	2877	1	2256000.00	https://newegg.com	2026-04-10 01:07:02
253	841	1	17525746.00	https://newegg.com	2026-04-10 00:22:43
298	2852	1	1876000.00	https://newegg.com	2026-04-10 01:03:59
255	843	1	20319746.00	https://newegg.com	2026-04-10 00:23:11
299	2853	1	2262000.00	https://newegg.com	2026-04-10 01:04:14
239	774	1	7000000.00	https://newegg.com	2026-06-17 04:06:21
257	868	1	47422308.00	https://newegg.com	2026-04-10 00:26:53
307	2878	1	1720000.00	https://newegg.com	2026-04-10 01:07:15
300	2855	1	1508000.00	https://newegg.com	2026-04-10 01:04:27
260	900	1	10032746.00	https://newegg.com	2026-04-10 00:30:07
262	904	1	23572724.00	https://newegg.com	2026-04-10 00:31:01
301	2857	1	3096000.00	https://newegg.com	2026-04-10 01:04:53
302	2860	1	3398000.00	https://newegg.com	2026-04-10 01:05:21
266	948	1	19049746.00	https://newegg.com	2026-04-10 00:35:40
267	958	1	21132800.00	https://newegg.com	2026-04-10 00:36:20
264	944	1	2200000.00	https://newegg.com	2026-06-17 03:52:57
303	2863	1	2631000.00	https://newegg.com	2026-04-10 01:05:51
887	861	1	4000000.00	\N	2026-06-17 04:03:41
242	778	1	14000000.00	https://newegg.com	2026-06-17 04:06:53
272	976	1	15239746.00	https://newegg.com	2026-04-10 00:38:48
273	982	1	10667746.00	https://newegg.com	2026-04-10 00:39:30
291	1179	1	3500000.00	https://newegg.com	2026-06-17 03:50:19
275	993	1	46456600.00	https://newegg.com	2026-04-10 00:40:27
276	1015	1	17145000.00	https://newegg.com	2026-04-10 00:42:20
277	1019	1	10667746.00	https://newegg.com	2026-04-10 00:43:01
278	1022	1	3175000.00	https://newegg.com	2026-04-10 00:43:27
308	2883	1	16791000.00	https://newegg.com	2026-04-10 01:07:41
280	1049	1	33019746.00	https://newegg.com	2026-04-10 00:45:39
304	2872	1	4460000.00	https://newegg.com	2026-04-10 01:06:41
309	2884	1	626000.00	https://newegg.com	2026-04-10 01:07:55
283	1067	1	27939746.00	https://newegg.com	2026-04-10 00:47:25
285	1079	1	21463000.00	https://newegg.com	2026-04-10 00:48:26
310	2885	1	1697000.00	https://newegg.com	2026-04-10 01:08:05
311	2887	1	2360000.00	https://newegg.com	2026-04-10 01:08:32
290	1174	1	39369746.00	https://newegg.com	2026-04-10 00:55:45
268	963	1	5000000.00	https://newegg.com	2026-06-17 03:50:55
292	1192	1	21564600.00	https://newegg.com	2026-04-10 00:57:20
293	1238	1	21589746.00	https://newegg.com	2026-04-10 01:01:32
246	806	1	9000000.00	https://newegg.com	2026-06-17 03:54:16
313	2895	1	3044000.00	https://newegg.com	2026-04-10 01:09:13
314	2897	1	3073000.00	https://newegg.com	2026-04-10 01:09:29
315	2899	1	4746000.00	https://newegg.com	2026-04-10 01:09:43
316	2901	1	1111000.00	https://newegg.com	2026-04-10 01:09:57
317	2905	1	1359000.00	https://newegg.com	2026-04-10 01:10:54
318	2906	1	1067000.00	https://newegg.com	2026-04-10 01:11:09
319	2913	1	741000.00	https://newegg.com	2026-04-10 01:11:37
320	2914	1	1639000.00	https://newegg.com	2026-04-10 01:11:51
321	2915	1	2133000.00	https://newegg.com	2026-04-10 01:12:03
322	2916	1	2485000.00	https://newegg.com	2026-04-10 01:12:17
323	2917	1	1457000.00	https://newegg.com	2026-04-10 01:12:32
324	2922	1	2891000.00	https://newegg.com	2026-04-10 01:12:44
325	2924	1	842000.00	https://newegg.com	2026-04-10 01:13:11
326	2928	1	488000.00	https://newegg.com	2026-04-10 01:13:52
327	2929	1	1428000.00	https://newegg.com	2026-04-10 01:14:04
328	2931	1	2102000.00	https://newegg.com	2026-04-10 01:14:18
329	2933	1	2654000.00	https://newegg.com	2026-04-10 01:14:32
331	2936	1	1667000.00	https://newegg.com	2026-04-10 01:15:00
332	2940	1	3135000.00	https://newegg.com	2026-04-10 01:15:29
333	2948	1	1151000.00	https://newegg.com	2026-04-10 01:15:58
334	2951	1	4943000.00	https://newegg.com	2026-04-10 01:16:26
335	2956	1	4839000.00	https://newegg.com	2026-04-10 01:17:08
336	2957	1	2398000.00	https://newegg.com	2026-04-10 01:17:20
337	2958	1	1682000.00	https://newegg.com	2026-04-10 01:17:31
338	2959	1	3666000.00	https://newegg.com	2026-04-10 01:17:43
339	2961	1	1672000.00	https://newegg.com	2026-04-10 01:17:55
340	2964	1	2104000.00	https://newegg.com	2026-04-10 01:18:19
341	2966	1	2369000.00	https://newegg.com	2026-04-10 01:18:34
342	2974	1	3100000.00	https://newegg.com	2026-04-10 01:19:28
343	2986	1	3399000.00	https://newegg.com	2026-04-10 01:20:34
344	2991	1	4849000.00	https://newegg.com	2026-04-10 01:21:04
345	2997	1	3511000.00	https://newegg.com	2026-04-10 01:21:44
346	3000	1	2064000.00	https://newegg.com	2026-04-10 01:22:09
347	3011	1	1894000.00	https://newegg.com	2026-04-10 01:22:34
348	3013	1	2015000.00	https://newegg.com	2026-04-10 01:22:47
349	3020	1	8034000.00	https://newegg.com	2026-04-10 01:23:00
350	3021	1	1609000.00	https://newegg.com	2026-04-10 01:23:15
351	3026	1	5305000.00	https://newegg.com	2026-04-10 01:23:43
352	3027	1	2213000.00	https://newegg.com	2026-04-10 01:23:56
353	3031	1	802000.00	https://newegg.com	2026-04-10 01:24:37
354	3033	1	3659000.00	https://newegg.com	2026-04-10 01:25:01
355	3037	1	760000.00	https://newegg.com	2026-04-10 01:25:15
356	3038	1	1966000.00	https://newegg.com	2026-04-10 01:25:30
358	3054	1	2448000.00	https://newegg.com	2026-04-10 01:25:56
359	3063	1	2145000.00	https://newegg.com	2026-04-10 01:26:22
360	3073	1	2223000.00	https://newegg.com	2026-04-10 01:26:47
361	3075	1	1275000.00	https://newegg.com	2026-04-10 01:27:11
362	3077	1	8026000.00	https://newegg.com	2026-04-10 01:27:37
363	3078	1	2049000.00	https://newegg.com	2026-04-10 01:27:48
364	3085	1	1054000.00	https://newegg.com	2026-04-10 01:28:02
365	3089	1	6337000.00	https://newegg.com	2026-04-10 01:28:29
366	3091	1	2445000.00	https://newegg.com	2026-04-10 01:28:43
367	3096	1	2150000.00	https://newegg.com	2026-04-10 01:29:09
368	3100	1	2264000.00	https://newegg.com	2026-04-10 01:29:38
369	3105	1	2244000.00	https://newegg.com	2026-04-10 01:30:19
370	3107	1	1269000.00	https://newegg.com	2026-04-10 01:30:31
371	3113	1	1297000.00	https://newegg.com	2026-04-10 01:30:43
372	3121	1	329000.00	https://newegg.com	2026-04-10 01:31:20
373	3124	1	2093000.00	https://newegg.com	2026-04-10 01:31:29
374	3125	1	2788000.00	https://newegg.com	2026-04-10 01:31:43
375	3129	1	4264000.00	https://newegg.com	2026-04-10 01:32:06
376	3139	1	3628000.00	https://newegg.com	2026-04-10 01:33:17
377	3148	1	2683000.00	https://newegg.com	2026-04-10 01:34:01
378	3149	1	1065000.00	https://newegg.com	2026-04-10 01:34:17
379	3166	1	791000.00	https://newegg.com	2026-04-10 01:35:40
380	3175	1	1438000.00	https://newegg.com	2026-04-10 01:36:35
381	3177	1	1523000.00	https://newegg.com	2026-04-10 01:36:50
383	3185	1	1120000.00	https://newegg.com	2026-04-10 01:37:17
384	3190	1	1757000.00	https://newegg.com	2026-04-10 01:37:54
385	3191	1	1988000.00	https://newegg.com	2026-04-10 01:38:06
386	3194	1	1036000.00	https://newegg.com	2026-04-10 01:38:17
387	3195	1	3106000.00	https://newegg.com	2026-04-10 01:38:29
388	3196	1	1576000.00	https://newegg.com	2026-04-10 01:38:43
389	3200	1	1862000.00	https://newegg.com	2026-04-10 01:38:56
390	3205	1	1680000.00	https://newegg.com	2026-04-10 01:39:23
391	3206	1	2617000.00	https://newegg.com	2026-04-10 01:39:35
392	3208	1	1899000.00	https://newegg.com	2026-04-10 01:39:48
393	3213	1	2365000.00	https://newegg.com	2026-04-10 01:40:12
394	3218	1	988000.00	https://newegg.com	2026-04-10 01:40:38
395	3220	1	2742000.00	https://newegg.com	2026-04-10 01:41:09
396	3226	1	811000.00	https://newegg.com	2026-04-10 01:41:20
397	3232	1	4209000.00	https://newegg.com	2026-04-10 01:41:33
398	3234	1	1586000.00	https://newegg.com	2026-04-10 01:41:43
399	3237	1	1821000.00	https://newegg.com	2026-04-10 01:41:59
413	3806	1	263000.00	https://newegg.com	2026-04-10 01:48:19
414	3807	1	7088000.00	https://newegg.com	2026-04-10 01:48:32
415	3809	1	4057000.00	https://newegg.com	2026-04-10 01:49:01
416	3810	1	16424000.00	https://newegg.com	2026-04-10 01:49:12
417	3814	1	887000.00	https://newegg.com	2026-04-10 01:49:53
418	3816	1	8611000.00	https://newegg.com	2026-04-10 01:50:18
419	3817	1	3646000.00	https://newegg.com	2026-04-10 01:50:29
420	3821	1	1941000.00	https://newegg.com	2026-04-10 01:50:52
421	3823	1	256000.00	https://newegg.com	2026-04-10 01:51:05
422	3824	1	3732000.00	https://newegg.com	2026-04-10 01:51:18
423	3826	1	979000.00	https://newegg.com	2026-04-10 01:51:46
424	3827	1	949000.00	https://newegg.com	2026-04-10 01:51:58
425	3832	1	9244000.00	https://newegg.com	2026-04-10 01:52:08
426	3833	1	5007000.00	https://newegg.com	2026-04-10 01:52:23
427	3834	1	276000.00	https://newegg.com	2026-04-10 01:52:38
428	3838	1	4841000.00	https://newegg.com	2026-04-10 01:53:07
429	3839	1	3713000.00	https://newegg.com	2026-04-10 01:53:19
430	3840	1	2790000.00	https://newegg.com	2026-04-10 01:53:34
431	3841	1	2961000.00	https://newegg.com	2026-04-10 01:53:49
433	3843	1	4227000.00	https://newegg.com	2026-04-10 01:54:17
434	3847	1	3772000.00	https://newegg.com	2026-04-10 01:54:31
435	3848	1	841000.00	https://newegg.com	2026-04-10 01:54:43
436	3850	1	21474000.00	https://newegg.com	2026-04-10 01:55:11
437	3851	1	721000.00	https://newegg.com	2026-04-10 01:55:24
438	3859	1	13314000.00	https://newegg.com	2026-04-10 01:55:50
439	3860	1	3716000.00	https://newegg.com	2026-04-10 01:56:06
440	3863	1	785000.00	https://newegg.com	2026-04-10 01:56:17
441	3865	1	15483000.00	https://newegg.com	2026-04-10 01:56:43
442	3868	1	2574000.00	https://newegg.com	2026-04-10 01:57:09
443	3870	1	18753000.00	https://newegg.com	2026-04-10 01:57:19
444	3871	1	2115000.00	https://newegg.com	2026-04-10 01:57:32
445	3872	1	5426000.00	https://newegg.com	2026-04-10 01:57:45
446	3874	1	4988000.00	https://newegg.com	2026-04-10 01:58:12
447	3875	1	11595000.00	https://newegg.com	2026-04-10 01:58:25
448	3879	1	500000.00	https://newegg.com	2026-04-10 01:58:40
449	3881	1	5226000.00	https://newegg.com	2026-04-10 01:59:08
450	3886	1	7311000.00	https://newegg.com	2026-04-10 01:59:24
451	3888	1	809000.00	https://newegg.com	2026-04-10 01:59:49
452	3892	1	1017000.00	https://newegg.com	2026-04-10 02:00:02
453	3895	1	4150000.00	https://newegg.com	2026-04-10 02:00:19
454	3897	1	713000.00	https://newegg.com	2026-04-10 02:00:31
455	3900	1	1630000.00	https://newegg.com	2026-04-10 02:00:47
456	3905	1	4452000.00	https://newegg.com	2026-04-10 02:01:31
457	3908	1	2636000.00	https://newegg.com	2026-04-10 02:01:46
458	3918	1	1568000.00	https://newegg.com	2026-04-10 02:02:12
459	3919	1	7764000.00	https://newegg.com	2026-04-10 02:02:25
460	3931	1	739000.00	https://newegg.com	2026-04-10 02:03:06
462	3937	1	4510000.00	https://newegg.com	2026-04-10 02:03:45
463	3942	1	15998000.00	https://newegg.com	2026-04-10 02:04:08
464	3949	1	9706000.00	https://newegg.com	2026-04-10 02:04:35
465	3954	1	5327000.00	https://newegg.com	2026-04-10 02:05:03
466	3956	1	963000.00	https://newegg.com	2026-04-10 02:05:16
467	3959	1	10140000.00	https://newegg.com	2026-04-10 02:05:29
468	3961	1	1317000.00	https://newegg.com	2026-04-10 02:05:43
469	3966	1	911000.00	https://newegg.com	2026-04-10 02:06:09
470	3969	1	831000.00	https://newegg.com	2026-04-10 02:06:25
471	3976	1	448000.00	https://newegg.com	2026-04-10 02:06:55
472	3980	1	899000.00	https://newegg.com	2026-04-10 02:07:08
473	3983	1	2044000.00	https://newegg.com	2026-04-10 02:07:24
474	3986	1	142000.00	https://newegg.com	2026-04-10 02:07:36
475	3988	1	15179000.00	https://newegg.com	2026-04-10 02:07:48
476	3990	1	16080000.00	https://newegg.com	2026-04-10 02:08:03
477	3994	1	3960000.00	https://newegg.com	2026-04-10 02:08:15
478	3997	1	8227000.00	https://newegg.com	2026-04-10 02:08:30
479	4015	1	1024000.00	https://newegg.com	2026-04-10 02:08:54
480	4016	1	8382000.00	https://newegg.com	2026-04-10 02:09:08
481	4018	1	18402000.00	https://newegg.com	2026-04-10 02:09:21
482	4023	1	8232000.00	https://newegg.com	2026-04-10 02:09:49
483	4026	1	16349000.00	https://newegg.com	2026-04-10 02:10:02
484	4031	1	3969000.00	https://newegg.com	2026-04-10 02:10:17
485	4033	1	3237000.00	https://newegg.com	2026-04-10 02:10:43
486	4041	1	1720000.00	https://newegg.com	2026-04-10 02:11:08
487	4046	1	903000.00	https://newegg.com	2026-04-10 02:11:22
400	3241	1	2289000.00	https://newegg.com	2026-04-10 01:42:12
401	3242	1	3150000.00	https://newegg.com	2026-04-10 01:42:26
402	3253	1	3207000.00	https://newegg.com	2026-04-10 01:43:20
403	3254	1	977000.00	https://newegg.com	2026-04-10 01:43:36
404	3267	1	1247000.00	https://newegg.com	2026-04-10 01:45:12
405	3268	1	2067000.00	https://newegg.com	2026-04-10 01:45:23
406	3270	1	1567000.00	https://newegg.com	2026-04-10 01:45:51
407	3272	1	2739000.00	https://newegg.com	2026-04-10 01:46:05
409	3279	1	660000.00	https://newegg.com	2026-04-10 01:46:32
410	3293	1	2367000.00	https://newegg.com	2026-04-10 01:46:56
411	3303	1	2000000.00	https://newegg.com	2026-04-10 01:47:50
489	4076	1	1006000.00	https://newegg.com	2026-04-10 02:11:47
490	4083	1	16348000.00	https://newegg.com	2026-04-10 02:13:21
491	4094	1	8480000.00	https://newegg.com	2026-04-10 02:13:49
492	4100	1	19019000.00	https://newegg.com	2026-04-10 02:14:04
493	4110	1	550000.00	https://newegg.com	2026-04-10 02:14:31
494	4147	1	433000.00	https://newegg.com	2026-04-10 02:15:26
495	4149	1	219000.00	https://newegg.com	2026-04-10 02:15:42
496	4150	1	3922000.00	https://newegg.com	2026-04-10 02:15:57
497	4153	1	242000.00	https://newegg.com	2026-04-10 02:16:11
498	4162	1	1791000.00	https://newegg.com	2026-04-10 02:16:37
499	4180	1	444000.00	https://newegg.com	2026-04-10 02:17:32
500	4182	1	251000.00	https://newegg.com	2026-04-10 02:18:00
501	4184	1	249000.00	https://newegg.com	2026-04-10 02:18:12
502	4189	1	3199000.00	https://newegg.com	2026-04-10 02:18:40
503	4191	1	578000.00	https://newegg.com	2026-04-10 02:18:55
504	4197	1	3940000.00	https://newegg.com	2026-04-10 02:19:24
505	4201	1	145000.00	https://newegg.com	2026-04-10 02:19:37
506	4248	1	5692000.00	https://newegg.com	2026-04-10 02:20:16
507	4275	1	452000.00	https://newegg.com	2026-04-10 02:20:56
508	4276	1	3899000.00	https://newegg.com	2026-04-10 02:21:09
509	4278	1	15228000.00	https://newegg.com	2026-04-10 02:21:24
510	4300	1	4729000.00	https://newegg.com	2026-04-10 02:22:07
511	4339	1	2868000.00	https://newegg.com	2026-04-10 02:22:20
513	4341	1	3288000.00	https://newegg.com	2026-04-10 02:22:44
514	4342	1	8704000.00	https://newegg.com	2026-04-10 02:22:56
515	4343	1	1999000.00	https://newegg.com	2026-04-10 02:23:08
516	4344	1	3881000.00	https://newegg.com	2026-04-10 02:23:22
517	4345	1	5070000.00	https://newegg.com	2026-04-10 02:23:35
518	4346	1	2976000.00	https://newegg.com	2026-04-10 02:23:47
519	4347	1	7239000.00	https://newegg.com	2026-04-10 02:24:01
520	4348	1	2316000.00	https://newegg.com	2026-04-10 02:24:15
521	4349	1	4126000.00	https://newegg.com	2026-04-10 02:24:28
522	4350	1	3739000.00	https://newegg.com	2026-04-10 02:24:42
523	4351	1	1737000.00	https://newegg.com	2026-04-10 02:24:54
524	4352	1	5427000.00	https://newegg.com	2026-04-10 02:25:06
525	4353	1	2659000.00	https://newegg.com	2026-04-10 02:25:19
526	4354	1	1832000.00	https://newegg.com	2026-04-10 02:25:28
527	4355	1	4378000.00	https://newegg.com	2026-04-10 02:25:43
528	4356	1	3828000.00	https://newegg.com	2026-04-10 02:25:53
529	4357	1	8009000.00	https://newegg.com	2026-04-10 02:26:05
530	4358	1	6347000.00	https://newegg.com	2026-04-10 02:26:17
531	4359	1	2471000.00	https://newegg.com	2026-04-10 02:26:30
532	4360	1	13543000.00	https://newegg.com	2026-04-10 02:26:41
533	4361	1	6237000.00	https://newegg.com	2026-04-10 02:26:55
534	4362	1	5683000.00	https://newegg.com	2026-04-10 02:27:07
535	4363	1	5145000.00	https://newegg.com	2026-04-10 02:27:21
536	4364	1	3260000.00	https://newegg.com	2026-04-10 02:27:35
537	4475	1	1903000.00	https://newegg.com	2026-04-10 02:27:50
538	4365	1	4226000.00	https://newegg.com	2026-04-10 02:28:05
540	4367	1	1989000.00	https://newegg.com	2026-04-10 02:28:28
541	4368	1	4768000.00	https://newegg.com	2026-04-10 02:28:41
542	4369	1	3204000.00	https://newegg.com	2026-04-10 02:28:52
543	4370	1	7454000.00	https://newegg.com	2026-04-10 02:29:05
544	4371	1	2450000.00	https://newegg.com	2026-04-10 02:29:18
545	4372	1	1767000.00	https://newegg.com	2026-04-10 02:29:31
546	4373	1	3455000.00	https://newegg.com	2026-04-10 02:29:44
547	4374	1	5417000.00	https://newegg.com	2026-04-10 02:29:55
548	4375	1	1675000.00	https://newegg.com	2026-04-10 02:30:05
549	4376	1	3650000.00	https://newegg.com	2026-04-10 02:30:17
550	4377	1	1585000.00	https://newegg.com	2026-04-10 02:30:32
551	4378	1	5927000.00	https://newegg.com	2026-04-10 02:30:45
552	4379	1	1318000.00	https://newegg.com	2026-04-10 02:31:00
553	4380	1	3998000.00	https://newegg.com	2026-04-10 02:31:15
554	4381	1	3134000.00	https://newegg.com	2026-04-10 02:31:29
555	4382	1	1747000.00	https://newegg.com	2026-04-10 02:31:40
556	4383	1	5849000.00	https://newegg.com	2026-04-10 02:31:53
557	4384	1	9779000.00	https://newegg.com	2026-04-10 02:32:05
558	4385	1	2018000.00	https://newegg.com	2026-04-10 02:32:15
559	4386	1	1894000.00	https://newegg.com	2026-04-10 02:32:26
560	4387	1	4970000.00	https://newegg.com	2026-04-10 02:32:37
561	4388	1	3213000.00	https://newegg.com	2026-04-10 02:32:53
562	4389	1	2156000.00	https://newegg.com	2026-04-10 02:33:06
563	4390	1	1872000.00	https://newegg.com	2026-04-10 02:33:21
564	4391	1	3061000.00	https://newegg.com	2026-04-10 02:33:33
565	4392	1	5498000.00	https://newegg.com	2026-04-10 02:33:45
566	4393	1	4593000.00	https://newegg.com	2026-04-10 02:33:57
567	4394	1	1990000.00	https://newegg.com	2026-04-10 02:34:10
568	4395	1	8382000.00	https://newegg.com	2026-04-10 02:34:21
569	4396	1	4433000.00	https://newegg.com	2026-04-10 02:34:34
571	4398	1	12357000.00	https://newegg.com	2026-04-10 02:35:00
572	4399	1	6296000.00	https://newegg.com	2026-04-10 02:35:15
573	4400	1	4803000.00	https://newegg.com	2026-04-10 02:35:28
574	4401	1	6346000.00	https://newegg.com	2026-04-10 02:35:39
575	4402	1	7087000.00	https://newegg.com	2026-04-10 02:35:52
577	4404	1	14421000.00	https://newegg.com	2026-04-10 02:36:18
578	4405	1	4235000.00	https://newegg.com	2026-04-10 02:36:31
579	4406	1	3507000.00	https://newegg.com	2026-04-10 02:36:44
580	4407	1	10922000.00	https://newegg.com	2026-04-10 02:36:56
581	4408	1	3344000.00	https://newegg.com	2026-04-10 02:37:11
582	4409	1	2250000.00	https://newegg.com	2026-04-10 02:37:21
583	4410	1	6174000.00	https://newegg.com	2026-04-10 02:37:35
584	4411	1	3955000.00	https://newegg.com	2026-04-10 02:37:48
585	4412	1	4720000.00	https://newegg.com	2026-04-10 02:38:02
586	4413	1	8373000.00	https://newegg.com	2026-04-10 02:38:17
587	4414	1	2472000.00	https://newegg.com	2026-04-10 02:38:29
588	4415	1	5420000.00	https://newegg.com	2026-04-10 02:38:41
589	4416	1	4041000.00	https://newegg.com	2026-04-10 02:38:54
590	4417	1	2414000.00	https://newegg.com	2026-04-10 02:39:06
591	4418	1	4504000.00	https://newegg.com	2026-04-10 02:39:17
592	4419	1	6345000.00	https://newegg.com	2026-04-10 02:39:29
593	4421	1	2531000.00	https://newegg.com	2026-04-10 02:39:54
594	4422	1	1323000.00	https://newegg.com	2026-04-10 02:40:06
595	4423	1	9485000.00	https://newegg.com	2026-04-10 02:40:17
596	4424	1	7392000.00	https://newegg.com	2026-04-10 02:40:30
597	4425	1	3850000.00	https://newegg.com	2026-04-10 02:40:42
598	4426	1	2543000.00	https://newegg.com	2026-04-10 02:40:53
599	4427	1	10364000.00	https://newegg.com	2026-04-10 02:41:06
600	4428	1	1712000.00	https://newegg.com	2026-04-10 02:41:20
601	4429	1	1964000.00	https://newegg.com	2026-04-10 02:41:34
603	4431	1	3213000.00	https://newegg.com	2026-04-10 02:41:58
604	4432	1	7601000.00	https://newegg.com	2026-04-10 02:42:11
605	4433	1	1927000.00	https://newegg.com	2026-04-10 02:42:24
606	4434	1	7329000.00	https://newegg.com	2026-04-10 02:42:38
607	4435	1	12387000.00	https://newegg.com	2026-04-10 02:42:49
608	4436	1	4109000.00	https://newegg.com	2026-04-10 02:43:04
609	4437	1	1689000.00	https://newegg.com	2026-04-10 02:43:15
610	4438	1	3796000.00	https://newegg.com	2026-04-10 02:43:26
611	4439	1	2037000.00	https://newegg.com	2026-04-10 02:43:37
612	4440	1	4505000.00	https://newegg.com	2026-04-10 02:43:52
613	4441	1	2858000.00	https://newegg.com	2026-04-10 02:44:04
614	4442	1	4341000.00	https://newegg.com	2026-04-10 02:44:15
615	4443	1	11570000.00	https://newegg.com	2026-04-10 02:44:27
616	4446	1	13278000.00	https://newegg.com	2026-04-10 02:44:53
617	4447	1	5381000.00	https://newegg.com	2026-04-10 02:45:08
618	4448	1	3374000.00	https://newegg.com	2026-04-10 02:45:21
619	4449	1	4728000.00	https://newegg.com	2026-04-10 02:45:36
620	4450	1	4593000.00	https://newegg.com	2026-04-10 02:45:49
621	4451	1	4243000.00	https://newegg.com	2026-04-10 02:46:04
622	4453	1	3486000.00	https://newegg.com	2026-04-10 02:46:31
623	4455	1	4441000.00	https://newegg.com	2026-04-10 02:46:44
624	4456	1	9620000.00	https://newegg.com	2026-04-10 02:46:56
625	4457	1	4491000.00	https://newegg.com	2026-04-10 02:47:09
626	4458	1	8124000.00	https://newegg.com	2026-04-10 02:47:21
627	4460	1	3529000.00	https://newegg.com	2026-04-10 02:47:48
628	4462	1	3778000.00	https://newegg.com	2026-04-10 02:48:01
630	4464	1	3025000.00	https://newegg.com	2026-04-10 02:48:31
631	4465	1	2157000.00	https://newegg.com	2026-04-10 02:48:43
632	4467	1	2427000.00	https://newegg.com	2026-04-10 02:48:55
633	4468	1	3275000.00	https://newegg.com	2026-04-10 02:49:06
634	4469	1	7474000.00	https://newegg.com	2026-04-10 02:49:19
635	4470	1	3243000.00	https://newegg.com	2026-04-10 02:49:33
636	4471	1	6481000.00	https://newegg.com	2026-04-10 02:49:47
637	4472	1	1870000.00	https://newegg.com	2026-04-10 02:50:00
638	4473	1	1812000.00	https://newegg.com	2026-04-10 02:50:12
639	4474	1	3908000.00	https://newegg.com	2026-04-10 02:50:23
640	4476	1	2466000.00	https://newegg.com	2026-04-10 02:50:35
641	4477	1	3685000.00	https://newegg.com	2026-04-10 02:50:48
642	4478	1	1826000.00	https://newegg.com	2026-04-10 02:51:01
643	4479	1	6172000.00	https://newegg.com	2026-04-10 02:51:14
644	4480	1	4110000.00	https://newegg.com	2026-04-10 02:51:28
645	4481	1	4700000.00	https://newegg.com	2026-04-10 02:51:42
646	4482	1	2488000.00	https://newegg.com	2026-04-10 02:51:53
647	4483	1	3602000.00	https://newegg.com	2026-04-10 02:52:08
648	4485	1	1594000.00	https://newegg.com	2026-04-10 02:52:22
649	4487	1	11770000.00	https://newegg.com	2026-04-10 02:52:32
650	4488	1	4281000.00	https://newegg.com	2026-04-10 02:52:45
651	4489	1	3785000.00	https://newegg.com	2026-04-10 02:52:58
652	4490	1	4295000.00	https://newegg.com	2026-04-10 02:53:11
653	4491	1	4892000.00	https://newegg.com	2026-04-10 02:53:24
654	4492	1	4054000.00	https://newegg.com	2026-04-10 02:53:35
655	4493	1	1979000.00	https://newegg.com	2026-04-10 02:53:49
656	4494	1	11057000.00	https://newegg.com	2026-04-10 02:54:03
657	4495	1	5431000.00	https://newegg.com	2026-04-10 02:54:14
658	4497	1	3812000.00	https://newegg.com	2026-04-10 02:54:31
659	4498	1	3016000.00	https://newegg.com	2026-04-10 02:54:44
661	4501	1	2107000.00	https://newegg.com	2026-04-10 02:55:09
662	4502	1	6992000.00	https://newegg.com	2026-04-10 02:55:21
663	4503	1	2774000.00	https://newegg.com	2026-04-10 02:55:34
691	4539	1	1789000.00	https://newegg.com	2026-04-10 03:02:18
692	4540	1	1529000.00	https://newegg.com	2026-04-10 03:02:29
693	4543	1	1019000.00	https://newegg.com	2026-04-10 03:03:11
694	4545	1	2119000.00	https://newegg.com	2026-04-10 03:03:38
695	4547	1	3189000.00	https://newegg.com	2026-04-10 03:03:50
696	4549	1	1789000.00	https://newegg.com	2026-04-10 03:04:05
697	4550	1	2039000.00	https://newegg.com	2026-04-10 03:04:19
698	4551	1	1869000.00	https://newegg.com	2026-04-10 03:04:32
699	4552	1	3169000.00	https://newegg.com	2026-04-10 03:04:44
700	4553	1	9819000.00	https://newegg.com	2026-04-10 03:04:55
701	4554	1	3979000.00	https://newegg.com	2026-04-10 03:05:09
702	4558	1	2039000.00	https://newegg.com	2026-04-10 03:05:23
703	4561	1	10309000.00	https://newegg.com	2026-04-10 03:05:36
704	4562	1	2549000.00	https://newegg.com	2026-04-10 03:05:48
705	4563	1	1659000.00	https://newegg.com	2026-04-10 03:05:58
706	4566	1	2299000.00	https://newegg.com	2026-04-10 03:06:12
707	4567	1	2039000.00	https://newegg.com	2026-04-10 03:06:25
708	4568	1	4079000.00	https://newegg.com	2026-04-10 03:06:35
709	4569	1	2809000.00	https://newegg.com	2026-04-10 03:06:48
710	4570	1	3059000.00	https://newegg.com	2026-04-10 03:07:03
711	4571	1	3059000.00	https://newegg.com	2026-04-10 03:07:13
712	4572	1	5999000.00	https://newegg.com	2026-04-10 03:07:23
713	4574	1	2549000.00	https://newegg.com	2026-04-10 03:07:50
714	4577	1	5049000.00	https://newegg.com	2026-04-10 03:08:18
715	4578	1	1739000.00	https://newegg.com	2026-04-10 03:08:30
716	4579	1	1789000.00	https://newegg.com	2026-04-10 03:08:46
717	4582	1	3189000.00	https://newegg.com	2026-04-10 03:09:26
718	4586	1	1789000.00	https://newegg.com	2026-04-10 03:09:40
719	4589	1	2169000.00	https://newegg.com	2026-04-10 03:09:53
720	4590	1	2809000.00	https://newegg.com	2026-04-10 03:10:10
721	4591	1	2169000.00	https://newegg.com	2026-04-10 03:10:21
722	4592	1	1789000.00	https://newegg.com	2026-04-10 03:10:35
723	4593	1	1509000.00	https://newegg.com	2026-04-10 03:10:49
724	4595	1	3059000.00	https://newegg.com	2026-04-10 03:11:02
725	4596	1	1409000.00	https://newegg.com	2026-04-10 03:11:15
726	4601	1	2039000.00	https://newegg.com	2026-04-10 03:12:10
727	4604	1	4589000.00	https://newegg.com	2026-04-10 03:12:40
728	4605	1	1919000.00	https://newegg.com	2026-04-10 03:12:53
729	4608	1	2039000.00	https://newegg.com	2026-04-10 03:13:24
730	4612	1	1789000.00	https://newegg.com	2026-04-10 03:13:38
731	4613	1	1839000.00	https://newegg.com	2026-04-10 03:13:50
732	4619	1	1789000.00	https://newegg.com	2026-04-10 03:14:36
733	4623	1	8319000.00	https://newegg.com	2026-04-10 03:15:15
734	4627	1	7039000.00	https://newegg.com	2026-04-10 03:15:26
735	4628	1	2629000.00	https://newegg.com	2026-04-10 03:15:39
736	4629	1	1789000.00	https://newegg.com	2026-04-10 03:15:50
737	4630	1	1789000.00	https://newegg.com	2026-04-10 03:16:05
738	4636	1	2169000.00	https://newegg.com	2026-04-10 03:16:32
739	4637	1	6739000.00	https://newegg.com	2026-04-10 03:16:44
740	4638	1	2039000.00	https://newegg.com	2026-04-10 03:16:58
741	4639	1	3059000.00	https://newegg.com	2026-04-10 03:17:10
742	4640	1	2429000.00	https://newegg.com	2026-04-10 03:17:24
743	4643	1	3939000.00	https://newegg.com	2026-04-10 03:17:39
744	4644	1	3059000.00	https://newegg.com	2026-04-10 03:17:52
745	4645	1	15279000.00	https://newegg.com	2026-04-10 03:18:07
746	4647	1	4589000.00	https://newegg.com	2026-04-10 03:18:18
747	4651	1	1149000.00	https://newegg.com	2026-04-10 03:18:40
748	4653	1	1589000.00	https://newegg.com	2026-04-10 03:18:54
749	4656	1	26089000.00	https://newegg.com	2026-04-10 03:19:22
750	4657	1	1919000.00	https://newegg.com	2026-04-10 03:19:33
751	4661	1	4719000.00	https://newegg.com	2026-04-10 03:19:48
665	4506	1	3576000.00	https://newegg.com	2026-04-10 02:55:59
666	4507	1	2416000.00	https://newegg.com	2026-04-10 02:56:12
667	4508	1	2972000.00	https://newegg.com	2026-04-10 02:56:25
668	4509	1	2777000.00	https://newegg.com	2026-04-10 02:56:35
669	4511	1	3727000.00	https://newegg.com	2026-04-10 02:56:59
670	4512	1	2071000.00	https://newegg.com	2026-04-10 02:57:11
671	4513	1	2908000.00	https://newegg.com	2026-04-10 02:57:21
672	4514	1	3683000.00	https://newegg.com	2026-04-10 02:57:32
673	4515	1	8705000.00	https://newegg.com	2026-04-10 02:57:48
674	4516	1	6778000.00	https://newegg.com	2026-04-10 02:58:03
675	4517	1	5996000.00	https://newegg.com	2026-04-10 02:58:15
676	4519	1	3655000.00	https://newegg.com	2026-04-10 02:58:40
677	4520	1	2133000.00	https://newegg.com	2026-04-10 02:58:53
678	4521	1	9771000.00	https://newegg.com	2026-04-10 02:59:06
679	4523	1	8358000.00	https://newegg.com	2026-04-10 02:59:31
680	4524	1	1439000.00	https://newegg.com	2026-04-10 02:59:42
681	4525	1	4751000.00	https://newegg.com	2026-04-10 02:59:53
683	4528	1	1498000.00	https://newegg.com	2026-04-10 03:00:22
684	4532	1	1095000.00	https://newegg.com	2026-04-10 03:00:46
685	4533	1	2387000.00	https://newegg.com	2026-04-10 03:01:02
686	4534	1	1732000.00	https://newegg.com	2026-04-10 03:01:15
687	4535	1	9788000.00	https://newegg.com	2026-04-10 03:01:25
688	4536	1	3758000.00	https://newegg.com	2026-04-10 03:01:39
689	4537	1	4172000.00	https://newegg.com	2026-04-10 03:01:52
690	4538	1	2273000.00	https://newegg.com	2026-04-10 03:02:06
752	4666	1	1279000.00	https://newegg.com	2026-04-10 03:20:13
753	4669	1	2809000.00	https://newegg.com	2026-04-10 03:20:29
754	4670	1	1769000.00	https://newegg.com	2026-04-10 03:20:44
755	4671	1	1019000.00	https://newegg.com	2026-04-10 03:20:56
756	4672	1	3449000.00	https://newegg.com	2026-04-10 03:21:08
757	4674	1	3059000.00	https://newegg.com	2026-04-10 03:21:22
758	4675	1	2039000.00	https://newegg.com	2026-04-10 03:21:36
759	4676	1	3319000.00	https://newegg.com	2026-04-10 03:21:47
760	4677	1	1509000.00	https://newegg.com	2026-04-10 03:22:02
761	4681	1	3569000.00	https://newegg.com	2026-04-10 03:22:17
762	4690	1	3399000.00	https://newegg.com	2026-04-10 03:22:30
763	4691	1	6709000.00	https://newegg.com	2026-04-10 03:22:40
764	4698	1	5609000.00	https://newegg.com	2026-04-10 03:22:53
765	4702	1	17109000.00	https://newegg.com	2026-04-10 03:23:19
766	4709	1	4139000.00	https://newegg.com	2026-04-10 03:23:45
767	4710	1	4589000.00	https://newegg.com	2026-04-10 03:24:01
768	4712	1	2939000.00	https://newegg.com	2026-04-10 03:24:30
769	4718	1	3399000.00	https://newegg.com	2026-04-10 03:24:54
770	4720	1	1359000.00	https://newegg.com	2026-04-10 03:25:20
771	4721	1	2169000.00	https://newegg.com	2026-04-10 03:25:35
772	4731	1	1659000.00	https://newegg.com	2026-04-10 03:26:04
773	4734	1	1529000.00	https://newegg.com	2026-04-10 03:26:15
774	4735	1	1609000.00	https://newegg.com	2026-04-10 03:26:29
775	4737	1	3829000.00	https://newegg.com	2026-04-10 03:26:41
776	4738	1	2119000.00	https://newegg.com	2026-04-10 03:26:56
777	5001	1	1149000.00	https://newegg.com	2026-04-10 03:47:11
778	5004	1	1939000.00	https://newegg.com	2026-04-10 03:47:50
779	5010	1	1299000.00	https://newegg.com	2026-04-10 03:49:07
780	5012	1	2299000.00	https://newegg.com	2026-04-10 03:49:29
781	5015	1	799000.00	https://newegg.com	2026-04-10 03:50:05
782	5020	1	3449000.00	https://newegg.com	2026-04-10 03:51:10
783	5021	1	1529000.00	https://newegg.com	2026-04-10 03:51:25
784	5022	1	5649000.00	https://newegg.com	2026-04-10 03:51:36
785	5026	1	1279000.00	https://newegg.com	2026-04-10 03:52:25
786	5037	1	2509000.00	https://newegg.com	2026-04-10 03:54:50
787	5038	1	1529000.00	https://newegg.com	2026-04-10 03:55:03
788	5039	1	1529000.00	https://newegg.com	2026-04-10 03:55:16
789	5042	1	2069000.00	https://newegg.com	2026-04-10 03:56:00
790	5043	1	1709000.00	https://newegg.com	2026-04-10 03:56:13
791	5045	1	2349000.00	https://newegg.com	2026-04-10 03:56:41
863	124	1	7649000.00	\N	2026-04-10 09:40:25
855	825	1	5589000.00	\N	2026-04-10 09:22:54
867	768	1	8500000.00	\N	2026-06-17 04:09:34
848	814	1	6800000.00	\N	2026-06-17 03:51:44
854	824	1	5000000.00	\N	2026-06-17 03:53:14
871	773	1	11429746.00	\N	2026-04-10 09:42:41
868	769	1	7100000.00	\N	2026-06-17 03:51:35
830	783	1	17754600.00	\N	2026-04-10 09:17:11
832	785	1	7000000.00	\N	2026-06-17 03:55:58
885	859	1	6800000.00	\N	2026-06-17 04:07:21
865	765	1	3000000.00	\N	2026-06-17 04:08:10
838	794	1	4800000.00	\N	2026-06-17 04:10:07
840	796	1	22580600.00	\N	2026-04-10 09:19:32
870	771	1	9000000.00	\N	2026-06-17 03:52:28
864	764	1	6000000.00	\N	2026-06-17 04:12:03
844	808	1	17145000.00	\N	2026-04-10 09:20:27
845	809	1	97790000.00	\N	2026-04-10 09:20:41
879	849	1	7000000.00	\N	2026-06-17 04:17:09
842	802	1	6500000.00	\N	2026-06-17 03:51:59
849	815	1	60934600.00	\N	2026-04-10 09:21:39
856	827	1	9000000.00	\N	2026-06-17 04:17:36
853	820	1	6500000.00	\N	2026-06-17 04:18:08
852	819	1	15493746.00	\N	2026-04-10 09:22:17
851	817	1	6800000.00	\N	2026-06-17 03:53:29
858	831	1	3809746.00	\N	2026-04-10 09:23:30
860	834	1	53339746.00	\N	2026-04-10 09:23:54
873	837	1	19062700.00	\N	2026-04-10 09:43:18
874	838	1	130556762.00	\N	2026-04-10 09:43:33
876	840	1	53314600.00	\N	2026-04-10 09:44:12
878	847	1	2539746.00	\N	2026-04-10 09:44:52
880	852	1	2997200.00	\N	2026-04-10 09:45:30
881	854	1	12674600.00	\N	2026-04-10 09:45:49
829	780	1	3500000.00	\N	2026-06-17 03:50:30
916	929	1	15809000.00	\N	2026-04-10 09:56:29
924	960	1	40779000.00	\N	2026-04-10 09:58:46
928	971	1	16219000.00	\N	2026-04-10 10:00:00
964	1096	1	38519000.00	\N	2026-04-10 10:11:56
981	1154	1	104039000.00	\N	2026-04-10 10:17:42
991	1199	1	22699000.00	\N	2026-04-10 10:20:46
1003	1231	1	17849000.00	\N	2026-04-10 10:24:34
1004	1233	1	22699000.00	\N	2026-04-10 10:24:50
1011	4739	1	8610000.00	\N	2026-04-10 10:26:56
1012	4740	1	8440000.00	\N	2026-04-10 10:27:15
1013	4741	1	2160000.00	\N	2026-04-10 10:27:32
1014	4742	1	8480000.00	\N	2026-04-10 10:27:52
1015	4743	1	8990000.00	\N	2026-04-10 10:28:11
1016	4744	1	3870000.00	\N	2026-04-10 10:28:32
896	880	1	33019746.00	\N	2026-04-10 09:50:24
897	883	1	18999200.00	\N	2026-04-10 09:50:41
956	1077	1	6500000.00	\N	2026-06-17 04:06:11
900	895	1	11937746.00	\N	2026-04-10 09:51:37
993	1205	1	3000000.00	\N	2026-06-17 03:53:56
905	906	1	101574600.00	\N	2026-04-10 09:53:04
906	911	1	25145746.00	\N	2026-04-10 09:53:29
909	915	1	2500000.00	\N	2026-06-17 03:55:39
955	1070	1	12000000.00	\N	2026-06-17 03:56:07
910	917	1	43136566.00	\N	2026-04-10 09:54:44
917	931	1	9108186.00	\N	2026-04-10 09:56:43
898	888	1	6500000.00	\N	2026-06-17 04:05:12
931	980	1	12000000.00	\N	2026-06-17 04:05:24
1002	1229	1	6500000.00	\N	2026-06-17 04:12:12
979	1149	1	6900000.00	\N	2026-06-17 03:50:43
962	1093	1	990000.00	\N	2026-06-17 04:07:34
942	1021	1	12000000.00	\N	2026-06-17 04:05:40
977	1146	1	1750000.00	\N	2026-06-17 04:07:45
912	919	1	9000000.00	\N	2026-06-17 04:12:53
966	1100	1	7500000.00	\N	2026-06-17 04:09:24
936	1003	1	19557746.00	\N	2026-04-10 10:02:36
937	1006	1	83439000.00	\N	2026-04-10 10:03:21
903	901	1	2000000.00	\N	2026-06-17 04:14:32
915	925	1	3500000.00	\N	2026-06-17 04:15:07
1006	1252	1	27000000.00	\N	2026-06-17 04:09:50
947	1030	1	1574546.00	\N	2026-04-10 10:06:24
925	962	1	7800000.00	\N	2026-06-17 04:16:19
950	1050	1	93853000.00	\N	2026-04-10 10:07:48
1008	1256	1	9900000.00	\N	2026-06-17 04:10:19
953	1064	1	16509746.00	\N	2026-04-10 10:08:49
954	1065	1	7619746.00	\N	2026-04-10 10:09:10
972	1113	1	4000000.00	\N	2026-06-17 04:11:12
904	902	1	45000000.00	\N	2026-06-17 04:17:55
967	1101	1	7873746.00	\N	2026-04-10 10:12:57
968	1103	1	29210000.00	\N	2026-04-10 10:13:11
990	1197	1	7100000.00	\N	2026-06-17 04:11:35
980	1150	1	91313000.00	\N	2026-04-10 10:17:15
985	1180	1	14477746.00	\N	2026-04-10 10:18:49
987	1187	1	32004762.00	\N	2026-04-10 10:19:24
995	1214	1	31749746.00	\N	2026-04-10 10:21:58
997	1219	1	5969000.00	\N	2026-04-10 10:22:36
999	1222	1	17779746.00	\N	2026-04-10 10:23:14
1000	1223	1	52044600.00	\N	2026-04-10 10:23:32
1005	1246	1	16509746.00	\N	2026-04-10 10:25:06
1009	1261	1	24891746.00	\N	2026-04-10 10:26:15
1018	4746	1	17510000.00	\N	2026-04-10 10:29:08
1019	4747	1	17690000.00	\N	2026-04-10 10:29:22
1021	4749	1	8080000.00	\N	2026-04-10 10:29:49
1022	4750	1	8630000.00	\N	2026-04-10 10:30:06
1023	4751	1	3970000.00	\N	2026-04-10 10:30:23
1024	4754	1	2070000.00	\N	2026-04-10 10:30:38
1025	4755	1	2190000.00	\N	2026-04-10 10:30:56
1026	4757	1	8240000.00	\N	2026-04-10 10:31:15
1027	4758	1	17740000.00	\N	2026-04-10 10:31:32
1028	4759	1	3910000.00	\N	2026-04-10 10:31:46
1029	4762	1	4470000.00	\N	2026-04-10 10:32:02
1030	4763	1	1900000.00	\N	2026-04-10 10:32:22
1031	4764	1	8410000.00	\N	2026-04-10 10:32:41
1032	4765	1	17250000.00	\N	2026-04-10 10:32:59
1033	4766	1	16070000.00	\N	2026-04-10 10:33:18
1034	4767	1	8250000.00	\N	2026-04-10 10:33:38
1035	4768	1	3800000.00	\N	2026-04-10 10:33:54
1036	4771	1	17800000.00	\N	2026-04-10 10:34:10
1038	4776	1	3970000.00	\N	2026-04-10 10:34:41
1039	4778	1	2060000.00	\N	2026-04-10 10:34:57
1040	4779	1	4380000.00	\N	2026-04-10 10:35:17
1041	4782	1	8610000.00	\N	2026-04-10 10:35:34
1042	4783	1	7910000.00	\N	2026-04-10 10:35:48
1043	4784	1	8750000.00	\N	2026-04-10 10:36:06
1044	4785	1	8400000.00	\N	2026-04-10 10:36:23
1045	4788	1	17840000.00	\N	2026-04-10 10:36:41
1046	4789	1	16270000.00	\N	2026-04-10 10:36:56
1047	4794	1	2060000.00	\N	2026-04-10 10:37:10
1048	4796	1	16230000.00	\N	2026-04-10 10:37:30
1049	4797	1	16820000.00	\N	2026-04-10 10:37:47
1050	4798	1	17090000.00	\N	2026-04-10 10:38:05
1051	4799	1	8240000.00	\N	2026-04-10 10:38:23
1052	4801	1	2120000.00	\N	2026-04-10 10:38:41
1053	4802	1	8110000.00	\N	2026-04-10 10:38:57
1055	4805	1	4120000.00	\N	2026-04-10 10:39:28
1056	4806	1	16030000.00	\N	2026-04-10 10:39:46
1057	4807	1	16970000.00	\N	2026-04-10 10:40:03
1058	4812	1	17690000.00	\N	2026-04-10 10:40:18
1059	4813	1	3990000.00	\N	2026-04-10 10:40:35
1060	4817	1	8620000.00	\N	2026-04-10 10:40:56
1061	4819	1	8440000.00	\N	2026-04-10 10:41:13
1062	4820	1	17700000.00	\N	2026-04-10 10:41:28
1063	4822	1	8860000.00	\N	2026-04-10 10:41:44
1064	4825	1	3930000.00	\N	2026-04-10 10:42:03
1065	4828	1	2160000.00	\N	2026-04-10 10:42:22
1066	4830	1	17610000.00	\N	2026-04-10 10:42:42
1067	4831	1	4340000.00	\N	2026-04-10 10:43:00
1068	4832	1	4200000.00	\N	2026-04-10 10:43:13
1069	4833	1	16740000.00	\N	2026-04-10 10:43:30
1070	4837	1	8770000.00	\N	2026-04-10 10:43:47
1072	4846	1	4100000.00	\N	2026-04-10 10:44:17
1073	4847	1	16070000.00	\N	2026-04-10 10:44:34
1074	4853	1	8980000.00	\N	2026-04-10 10:44:50
1075	4854	1	8910000.00	\N	2026-04-10 10:45:04
1076	4857	1	16820000.00	\N	2026-04-10 10:45:19
1077	4861	1	910000.00	\N	2026-04-10 10:45:35
1078	4864	1	1970000.00	\N	2026-04-10 10:45:48
1079	4866	1	940000.00	\N	2026-04-10 10:46:04
1080	4867	1	3840000.00	\N	2026-04-10 10:46:17
1081	4868	1	17270000.00	\N	2026-04-10 10:46:30
1082	4873	1	8040000.00	\N	2026-04-10 10:46:48
1083	4874	1	2100000.00	\N	2026-04-10 10:47:06
1084	4875	1	3980000.00	\N	2026-04-10 10:47:27
1085	4876	1	2100000.00	\N	2026-04-10 10:47:42
1086	4884	1	2140000.00	\N	2026-04-10 10:47:56
1087	4886	1	4440000.00	\N	2026-04-10 10:48:11
1089	4891	1	4100000.00	\N	2026-04-10 10:48:49
1090	4896	1	8410000.00	\N	2026-04-10 10:49:02
1091	4899	1	3860000.00	\N	2026-04-10 10:49:21
1092	4901	1	8970000.00	\N	2026-04-10 10:49:35
1093	4902	1	16870000.00	\N	2026-04-10 10:49:49
1094	4903	1	16480000.00	\N	2026-04-10 10:50:07
1095	4910	1	1960000.00	\N	2026-04-10 10:50:25
1096	4916	1	3860000.00	\N	2026-04-10 10:50:42
1097	4922	1	16770000.00	\N	2026-04-10 10:50:59
1098	4934	1	500000.00	\N	2026-04-10 10:51:18
1099	4935	1	17010000.00	\N	2026-04-10 10:51:39
1100	3808	1	4752000.00	\N	2026-04-10 10:51:56
1101	3812	1	840000.00	\N	2026-04-10 10:52:11
1102	3813	1	1796000.00	\N	2026-04-10 10:52:30
1103	3815	1	7534000.00	\N	2026-04-10 10:52:46
1104	3818	1	484000.00	\N	2026-04-10 10:53:04
1106	3837	1	315000.00	\N	2026-04-10 10:53:37
1107	3849	1	11466000.00	\N	2026-04-10 10:53:55
1108	3857	1	2634000.00	\N	2026-04-10 10:54:14
1109	3864	1	3474000.00	\N	2026-04-10 10:54:29
1110	3867	1	5903000.00	\N	2026-04-10 10:54:43
1111	3873	1	5768000.00	\N	2026-04-10 10:55:00
1112	3880	1	3547000.00	\N	2026-04-10 10:55:21
1113	3887	1	1697000.00	\N	2026-04-10 10:55:41
1114	3902	1	5398000.00	\N	2026-04-10 10:55:59
1115	3904	1	505000.00	\N	2026-04-10 10:56:19
1116	3910	1	306000.00	\N	2026-04-10 10:56:36
1117	3921	1	3849000.00	\N	2026-04-10 10:56:52
1118	3923	1	809000.00	\N	2026-04-10 10:57:08
1119	3935	1	1634000.00	\N	2026-04-10 10:57:28
1120	3938	1	7736000.00	\N	2026-04-10 10:57:46
1121	3946	1	3658000.00	\N	2026-04-10 10:58:04
1123	3962	1	6763000.00	\N	2026-04-10 10:58:37
1124	3972	1	7856000.00	\N	2026-04-10 10:58:56
1125	4006	1	8114000.00	\N	2026-04-10 10:59:13
1126	4021	1	3240000.00	\N	2026-04-10 10:59:32
1127	4032	1	5599000.00	\N	2026-04-10 10:59:49
1128	4038	1	395000.00	\N	2026-04-10 11:00:08
1129	4079	1	921000.00	\N	2026-04-10 11:00:23
1130	4081	1	2760000.00	\N	2026-04-10 11:00:41
1131	4091	1	1715000.00	\N	2026-04-10 11:00:56
1132	4104	1	903000.00	\N	2026-04-10 11:01:09
1133	4116	1	2043000.00	\N	2026-04-10 11:01:24
1134	4134	1	443000.00	\N	2026-04-10 11:01:42
1135	4145	1	1725000.00	\N	2026-04-10 11:02:01
1136	4161	1	7709000.00	\N	2026-04-10 11:02:16
1241	353	1	2299000.00	\N	2026-04-10 11:32:25
1242	356	1	1559000.00	\N	2026-04-10 11:32:46
1243	360	1	679000.00	\N	2026-04-10 11:33:05
1244	364	1	1409000.00	\N	2026-04-10 11:33:22
1245	367	1	1639000.00	\N	2026-04-10 11:33:43
1246	373	1	1149000.00	\N	2026-04-10 11:34:02
1247	376	1	2299000.00	\N	2026-04-10 11:34:18
1248	378	1	1309000.00	\N	2026-04-10 11:34:33
1249	379	1	1919000.00	\N	2026-04-10 11:34:52
1250	380	1	1789000.00	\N	2026-04-10 11:35:11
1251	382	1	679000.00	\N	2026-04-10 11:35:30
1252	387	1	2299000.00	\N	2026-04-10 11:35:45
1253	391	1	1279000.00	\N	2026-04-10 11:36:02
1254	395	1	409000.00	\N	2026-04-10 11:36:18
1255	398	1	409000.00	\N	2026-04-10 11:36:35
1256	415	1	1279000.00	\N	2026-04-10 11:36:50
1138	4172	1	9011000.00	\N	2026-04-10 11:02:56
1139	4177	1	11908000.00	\N	2026-04-10 11:03:14
1141	4185	1	16074000.00	\N	2026-04-10 11:03:52
1142	4193	1	10357000.00	\N	2026-04-10 11:04:08
1143	4231	1	4103000.00	\N	2026-04-10 11:04:28
1144	4247	1	495000.00	\N	2026-04-10 11:04:43
1145	4256	1	2001000.00	\N	2026-04-10 11:05:03
1146	4272	1	7442000.00	\N	2026-04-10 11:05:22
1147	4286	1	10383000.00	\N	2026-04-10 11:05:39
1148	4295	1	3492000.00	\N	2026-04-10 11:05:59
1157	2856	1	2963000.00	\N	2026-04-10 11:08:25
1158	2859	1	4811000.00	\N	2026-04-10 11:08:43
1159	2861	1	8052000.00	\N	2026-04-10 11:09:03
1160	2862	1	3155000.00	\N	2026-04-10 11:09:20
1161	2864	1	1769000.00	\N	2026-04-10 11:09:32
1162	2866	1	2444000.00	\N	2026-04-10 11:09:53
1163	2868	1	2760000.00	\N	2026-04-10 11:10:08
1164	2879	1	1001000.00	\N	2026-04-10 11:10:22
1166	2889	1	711000.00	\N	2026-04-10 11:10:59
1167	2902	1	2783000.00	\N	2026-04-10 11:11:14
1168	2903	1	4123000.00	\N	2026-04-10 11:11:29
1169	2904	1	2644000.00	\N	2026-04-10 11:11:43
1170	2907	1	829000.00	\N	2026-04-10 11:11:58
1171	2923	1	2154000.00	\N	2026-04-10 11:12:16
1172	2925	1	2376000.00	\N	2026-04-10 11:12:35
1173	2926	1	1654000.00	\N	2026-04-10 11:12:53
1174	2939	1	3399000.00	\N	2026-04-10 11:13:11
1175	2941	1	1193000.00	\N	2026-04-10 11:13:26
1176	2949	1	2251000.00	\N	2026-04-10 11:13:41
1177	2953	1	1108000.00	\N	2026-04-10 11:14:01
1178	2954	1	1675000.00	\N	2026-04-10 11:14:17
1179	2963	1	2712000.00	\N	2026-04-10 11:14:33
1180	2967	1	4997000.00	\N	2026-04-10 11:14:49
1181	2970	1	2091000.00	\N	2026-04-10 11:15:07
1183	2975	1	2429000.00	\N	2026-04-10 11:15:37
1184	2977	1	1031000.00	\N	2026-04-10 11:15:53
1185	2980	1	3937000.00	\N	2026-04-10 11:16:08
1186	2985	1	3197000.00	\N	2026-04-10 11:16:24
1187	2987	1	1786000.00	\N	2026-04-10 11:16:39
1188	2993	1	2361000.00	\N	2026-04-10 11:16:54
1189	2996	1	3105000.00	\N	2026-04-10 11:17:13
1190	2999	1	2271000.00	\N	2026-04-10 11:17:30
1191	3001	1	2916000.00	\N	2026-04-10 11:17:51
1192	3024	1	1477000.00	\N	2026-04-10 11:18:06
1193	3028	1	4971000.00	\N	2026-04-10 11:18:25
1194	3030	1	2931000.00	\N	2026-04-10 11:18:38
1195	3032	1	4403000.00	\N	2026-04-10 11:18:57
1196	3057	1	1955000.00	\N	2026-04-10 11:19:15
1197	3069	1	1882000.00	\N	2026-04-10 11:19:33
1198	3074	1	1857000.00	\N	2026-04-10 11:19:48
1200	3088	1	8164000.00	\N	2026-04-10 11:20:26
1201	3092	1	2352000.00	\N	2026-04-10 11:20:39
1202	3097	1	1857000.00	\N	2026-04-10 11:20:56
1203	3103	1	3195000.00	\N	2026-04-10 11:21:13
1204	3104	1	847000.00	\N	2026-04-10 11:21:27
1205	3117	1	2686000.00	\N	2026-04-10 11:21:42
1206	3119	1	1618000.00	\N	2026-04-10 11:22:02
1207	3126	1	1871000.00	\N	2026-04-10 11:22:18
1208	3131	1	1359000.00	\N	2026-04-10 11:22:36
1209	3132	1	1861000.00	\N	2026-04-10 11:22:57
1210	3137	1	2208000.00	\N	2026-04-10 11:23:16
1211	3138	1	2077000.00	\N	2026-04-10 11:23:33
1212	3146	1	912000.00	\N	2026-04-10 11:24:20
1213	3150	1	4723000.00	\N	2026-04-10 11:24:37
1214	3156	1	2301000.00	\N	2026-04-10 11:24:54
1215	3158	1	1877000.00	\N	2026-04-10 11:25:14
1217	3162	1	3682000.00	\N	2026-04-10 11:25:50
1218	3168	1	437000.00	\N	2026-04-10 11:26:03
1219	3173	1	3096000.00	\N	2026-04-10 11:26:23
1220	3174	1	551000.00	\N	2026-04-10 11:26:40
1221	3186	1	3207000.00	\N	2026-04-10 11:26:55
1222	3189	1	2118000.00	\N	2026-04-10 11:27:12
1223	3204	1	1899000.00	\N	2026-04-10 11:27:27
1224	3211	1	2268000.00	\N	2026-04-10 11:27:46
1225	3214	1	1849000.00	\N	2026-04-10 11:28:03
1226	3219	1	1756000.00	\N	2026-04-10 11:28:21
1227	3243	1	1982000.00	\N	2026-04-10 11:28:40
1228	3244	1	1123000.00	\N	2026-04-10 11:28:54
1229	3246	1	1970000.00	\N	2026-04-10 11:29:12
1230	3257	1	1982000.00	\N	2026-04-10 11:29:26
1231	3260	1	3220000.00	\N	2026-04-10 11:29:46
1232	3262	1	8719000.00	\N	2026-04-10 11:30:02
1234	3264	1	2181000.00	\N	2026-04-10 11:30:30
1235	3266	1	911000.00	\N	2026-04-10 11:30:45
1236	3269	1	3717000.00	\N	2026-04-10 11:31:04
1237	3287	1	1821000.00	\N	2026-04-10 11:31:22
1238	3294	1	2051000.00	\N	2026-04-10 11:31:36
1239	3297	1	3320000.00	\N	2026-04-10 11:31:52
1240	3300	1	2859000.00	\N	2026-04-10 11:32:07
1149	4420	1	12401000.00	\N	2026-04-10 11:06:15
1150	4444	1	8766000.00	\N	2026-04-10 11:06:31
1151	4452	1	2113000.00	\N	2026-04-10 11:06:45
1152	4459	1	6743000.00	\N	2026-04-10 11:07:03
1153	4510	1	1492000.00	\N	2026-04-10 11:07:19
1154	4518	1	1497000.00	\N	2026-04-10 11:07:35
1155	4522	1	1768000.00	\N	2026-04-10 11:07:53
1156	4530	1	2094000.00	\N	2026-04-10 11:08:11
1257	421	1	369000.00	\N	2026-04-10 11:37:06
1258	428	1	369000.00	\N	2026-04-10 11:37:25
1259	429	1	1479000.00	\N	2026-04-10 11:37:45
1260	431	1	1329000.00	\N	2026-04-10 11:38:02
1261	446	1	1279000.00	\N	2026-04-10 11:38:19
1262	448	1	299000.00	\N	2026-04-10 11:38:34
1263	452	1	1659000.00	\N	2026-04-10 11:38:53
1264	455	1	1399000.00	\N	2026-04-10 11:39:08
1265	458	1	1529000.00	\N	2026-04-10 11:39:23
1266	468	1	1279000.00	\N	2026-04-10 11:39:38
1267	476	1	1659000.00	\N	2026-04-10 11:39:54
1268	488	1	1529000.00	\N	2026-04-10 11:40:11
1269	501	1	1789000.00	\N	2026-04-10 11:40:28
1270	505	1	1309000.00	\N	2026-04-10 11:40:42
1271	509	1	10149000.00	\N	2026-04-10 11:40:58
1272	512	1	1529000.00	\N	2026-04-10 11:41:12
1273	514	1	2299000.00	\N	2026-04-10 11:41:32
1274	516	1	2299000.00	\N	2026-04-10 11:41:52
1275	521	1	1279000.00	\N	2026-04-10 11:42:07
1276	522	1	409000.00	\N	2026-04-10 11:42:26
1277	526	1	2549000.00	\N	2026-04-10 11:42:44
1278	527	1	1409000.00	\N	2026-04-10 11:43:00
1279	531	1	2809000.00	\N	2026-04-10 11:43:16
1280	533	1	1789000.00	\N	2026-04-10 11:43:30
1281	539	1	679000.00	\N	2026-04-10 11:43:45
1282	546	1	1789000.00	\N	2026-04-10 11:43:59
1283	550	1	2809000.00	\N	2026-04-10 11:44:12
1284	557	1	299000.00	\N	2026-04-10 11:44:26
1285	560	1	1309000.00	\N	2026-04-10 11:44:40
1286	567	1	3059000.00	\N	2026-04-10 11:44:59
1287	571	1	1229000.00	\N	2026-04-10 11:45:15
1288	577	1	309000.00	\N	2026-04-10 11:45:32
1289	578	1	1659000.00	\N	2026-04-10 11:45:50
1290	584	1	1409000.00	\N	2026-04-10 11:46:06
1291	587	1	1229000.00	\N	2026-04-10 11:46:26
1292	591	1	5869000.00	\N	2026-04-10 11:46:47
1293	606	1	409000.00	\N	2026-04-10 11:47:01
1294	610	1	1529000.00	\N	2026-04-10 11:47:21
1295	640	1	2169000.00	\N	2026-04-10 11:47:38
1296	646	1	2039000.00	\N	2026-04-10 11:47:55
1297	651	1	1229000.00	\N	2026-04-10 11:48:12
1298	652	1	1529000.00	\N	2026-04-10 11:48:32
1299	654	1	2549000.00	\N	2026-04-10 11:48:52
1300	658	1	1789000.00	\N	2026-04-10 11:49:06
1301	663	1	1229000.00	\N	2026-04-10 11:49:26
1302	667	1	2809000.00	\N	2026-04-10 11:49:42
1303	672	1	2169000.00	\N	2026-04-10 11:50:02
1304	674	1	2169000.00	\N	2026-04-10 11:50:17
1305	677	1	1309000.00	\N	2026-04-10 11:50:32
1306	700	1	1659000.00	\N	2026-04-10 11:50:52
1307	704	1	1509000.00	\N	2026-04-10 11:51:08
1308	708	1	1229000.00	\N	2026-04-10 11:51:25
1309	714	1	2299000.00	\N	2026-04-10 11:51:46
1310	718	1	2169000.00	\N	2026-04-10 11:52:00
1311	723	1	4359000.00	\N	2026-04-10 11:52:18
1312	724	1	2219000.00	\N	2026-04-10 11:52:31
1313	729	1	1279000.00	\N	2026-04-10 11:52:48
1314	743	1	1789000.00	\N	2026-04-10 11:53:04
1315	749	1	1529000.00	\N	2026-04-10 11:53:24
1316	5000	1	769000.00	\N	2026-04-10 11:53:41
1317	5002	1	3799000.00	\N	2026-04-10 11:54:01
1318	5003	1	509000.00	\N	2026-04-10 11:54:15
1319	5005	1	609000.00	\N	2026-04-10 11:54:30
1320	5006	1	1129000.00	\N	2026-04-10 11:54:45
1321	5007	1	409000.00	\N	2026-04-10 11:55:01
1322	5008	1	1019000.00	\N	2026-04-10 11:55:16
1323	5009	1	2909000.00	\N	2026-04-10 11:55:38
1324	5011	1	2249000.00	\N	2026-04-10 11:55:53
1325	5013	1	819000.00	\N	2026-04-10 11:56:10
1326	5014	1	489000.00	\N	2026-04-10 11:56:25
1327	5016	1	3489000.00	\N	2026-04-10 11:56:43
1328	5017	1	389000.00	\N	2026-04-10 11:57:04
1329	5018	1	769000.00	\N	2026-04-10 11:57:18
1330	5019	1	269000.00	\N	2026-04-10 11:57:34
1331	5023	1	619000.00	\N	2026-04-10 11:57:54
1332	5024	1	509000.00	\N	2026-04-10 11:58:13
1333	5025	1	1229000.00	\N	2026-04-10 11:58:26
1334	5027	1	769000.00	\N	2026-04-10 11:58:42
1335	5028	1	609000.00	\N	2026-04-10 11:59:00
1336	5029	1	609000.00	\N	2026-04-10 11:59:14
1337	5030	1	1179000.00	\N	2026-04-10 11:59:31
1338	5031	1	949000.00	\N	2026-04-10 11:59:47
1339	5032	1	479000.00	\N	2026-04-10 12:00:05
1340	5033	1	279000.00	\N	2026-04-10 12:00:21
1341	5034	1	3799000.00	\N	2026-04-10 12:00:42
1342	5035	1	499000.00	\N	2026-04-10 12:00:58
1343	5036	1	509000.00	\N	2026-04-10 12:01:11
1344	5040	1	1889000.00	\N	2026-04-10 12:01:26
1345	5041	1	10149000.00	\N	2026-04-10 12:01:45
1346	5044	1	279000.00	\N	2026-04-10 12:01:59
1347	5046	1	409000.00	\N	2026-04-10 12:02:14
1348	5047	1	509000.00	\N	2026-04-10 12:02:34
1349	5048	1	1309000.00	\N	2026-04-10 12:02:53
1350	5049	1	769000.00	\N	2026-04-10 12:03:08
1351	4541	1	1529000.00	\N	2026-04-10 12:03:23
1352	4542	1	1659000.00	\N	2026-04-10 12:03:43
1353	4544	1	2039000.00	\N	2026-04-10 12:03:58
1354	4573	1	3569000.00	\N	2026-04-10 12:04:14
1355	4576	1	1279000.00	\N	2026-04-10 12:04:33
1356	4580	1	899000.00	\N	2026-04-10 12:04:49
1357	4581	1	1659000.00	\N	2026-04-10 12:05:05
1358	4597	1	1609000.00	\N	2026-04-10 12:05:21
1359	4599	1	2039000.00	\N	2026-04-10 12:05:39
1360	4600	1	1019000.00	\N	2026-04-10 12:05:56
1361	4603	1	1019000.00	\N	2026-04-10 12:06:14
1362	4607	1	969000.00	\N	2026-04-10 12:06:27
1363	4614	1	1279000.00	\N	2026-04-10 12:06:45
1364	4618	1	2139000.00	\N	2026-04-10 12:07:02
1365	4620	1	1409000.00	\N	2026-04-10 12:07:18
1366	4621	1	1529000.00	\N	2026-04-10 12:07:35
1367	4632	1	1019000.00	\N	2026-04-10 12:07:53
1368	4648	1	2019000.00	\N	2026-04-10 12:08:12
1369	4654	1	1279000.00	\N	2026-04-10 12:08:28
1370	4664	1	1409000.00	\N	2026-04-10 12:08:44
1371	4701	1	2549000.00	\N	2026-04-10 12:08:58
1372	4708	1	1249000.00	\N	2026-04-10 12:09:18
1373	4711	1	2039000.00	\N	2026-04-10 12:09:34
1375	4719	1	1279000.00	\N	2026-04-10 12:10:07
1376	4723	1	1919000.00	\N	2026-04-10 12:10:23
1380	1032	1	25120600.00	\N	2026-04-10 14:49:52
1379	1002	1	5700000.00	\N	2026-06-17 04:16:04
1377	3142	1	793000.00	\N	2026-04-10 14:10:57
\.


--
-- TOC entry 5274 (class 0 OID 25513)
-- Dependencies: 235
-- Data for Name: component_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_types (id, type_name) FROM stdin;
1	CPU
2	GPU
3	RAM
4	STORAGE
5	MOTHERBOARD
6	PSU
7	COOLER
8	CASE
\.


--
-- TOC entry 5276 (class 0 OID 25522)
-- Dependencies: 237
-- Data for Name: components; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.components (id, name, type_id, base_price) FROM stdin;
1	AMD Ryzen 7 7700	1	\N
4352	ASRock B850I Lightning WiFi	5	5653000.00
4	AMD Ryzen 7 7800X3D	1	\N
4358	Gigabyte X870 AORUS ELITE WIFI7 ICE	5	6162000.00
4475	Gigabyte A520M DS3H V2	5	1903000.00
4365	Asus ROG STRIX B650-A GAMING WIFI	5	4402000.00
4372	Asus TUF GAMING B550-PLUS WIFI II	5	1785000.00
4380	Gigabyte B850 AORUS ELITE WIFI7 ICE	5	4122000.00
4388	ASRock B650M PG Lightning Wifi	5	3119000.00
4395	MSI MAG X670E TOMAHAWK WIFI	5	7983000.00
4402	Gigabyte Z790 AORUS ELITE AX	5	6948000.00
4409	Gigabyte A620I AX	5	2296000.00
20	AMD Ryzen 7 5700G	1	\N
21	AMD Ryzen 5 7600X	1	\N
4415	Asus TUF GAMING B650E-PLUS WIFI	5	5366000.00
4423	MSI MEG X870E GODLIKE	5	9581000.00
26	Intel Core Ultra 5 235	1	\N
27	Intel Core Ultra 5 245K	1	\N
28	AMD Ryzen 5 2400G	1	\N
4429	ASRock B550 Phantom Gaming 4/ac	5	2004000.00
4435	Asus ProArt X870E-CREATOR WIFI	5	12144000.00
4442	ASRock B650I Lightning Wifi	5	4385000.00
32	Intel Core Ultra 7 265K	1	\N
4450	MSI B840 GAMING PLUS WIFI	5	4735000.00
4458	Asus ROG STRIX X870-I GAMING WIFI	5	8462000.00
4469	MSI X870 GAMING PLUS WIFI	5	7474000.00
37	Intel Xeon E-2174G	1	\N
4474	Gigabyte B850I AORUS PRO	5	4114000.00
4477	MSI MAG B850M MORTAR WIFI	5	3685000.00
40	AMD Ryzen 9 9950X	1	\N
4483	Asus ROG STRIX B860-I GAMING WIFI	5	3675000.00
4494	Gigabyte X870E AORUS MASTER	5	11283000.00
43	Intel Core i3-14100	1	\N
44	AMD Ryzen 5 5500GT	1	\N
4503	Gigabyte B650M AORUS ELITE AX	5	2860000.00
4509	Gigabyte B650M AORUS ELITE AX ICE	5	2863000.00
49	Intel Xeon E-2176G	1	\N
4517	Gigabyte Z790 AORUS ELITE X WIFI7	5	5996000.00
51	AMD Ryzen 5 8500G	1	\N
4525	Asus PRIME B840-PLUS WIFI	5	4613000.00
53	AMD Ryzen 7 9700X	1	\N
54	Intel Core i5-14600K	1	\N
4536	MSI PRO B650-A WIFI	5	3579000.00
58	Intel Core Ultra 7 265	1	\N
67	AMD Ryzen 5 7600X3D	1	\N
71	AMD Ryzen 7 8700G	1	\N
73	Intel Core i7-14700	1	\N
74	Intel Core i5-12600K	1	\N
78	AMD Ryzen 5 8600G	1	\N
80	Intel Core Ultra 9 285K	1	\N
86	Intel Core i7-13700K	1	\N
92	AMD Ryzen 9 9900X	1	\N
93	AMD Ryzen 5 5600G	1	\N
95	AMD Ryzen 7 7700X	1	\N
98	AMD Ryzen 5 3400G	1	\N
105	Intel Core i3-12100	1	\N
112	Intel Core i9-11900	1	\N
114	AMD Ryzen 9 9900X3D	1	\N
118	AMD Ryzen 7 9800X3D	1	\N
121	Intel Core Ultra 9 285	1	\N
124	Intel Xeon E3-1245 V6	1	\N
127	AMD Ryzen 5 9600	1	\N
128	Intel Core i5-13400	1	\N
129	Intel Core i5-14500	1	\N
135	AMD Ryzen 5 5600GT	1	\N
68	AMD Ryzen 9 7900	1	8500000.00
13	AMD Ryzen 9 7900X	1	9000000.00
108	AMD Ryzen 9 7950X	1	12000000.00
19	AMD Ryzen 9 7950X3D	1	15000000.00
97	Intel Core i3-13100	1	2500000.00
36	Intel Core i5-14400	1	4500000.00
106	Intel Core i5-13500	1	4500000.00
119	Intel Core i7-14700K	1	9000000.00
10	Intel Core i9-12900	1	8000000.00
115	Intel Core i9-13900	1	10000000.00
7	Intel Core i9-13900K	1	12000000.00
76	Intel Core i9-14900	1	13000000.00
136	Intel Core i9-14900K	1	15000000.00
11	Intel Core i9-14900KS	1	15000000.00
138	AMD Ryzen 9 9950X3D	1	\N
142	Intel Core i7-13700	1	\N
144	Intel Core Ultra 5 225	1	\N
147	Intel Core i9-13900KS	1	\N
152	AMD Ryzen 3 3200G	1	\N
154	Intel Core i5-12600	1	\N
161	AMD Ryzen 5 7600	1	\N
172	Intel Core i9-12900KS	1	\N
174	AMD Ryzen 5 9600X	1	\N
350	NZXT Kraken Elite 240	7	\N
351	Lian Li Galahad II Trinity SL-INF	7	\N
352	be quiet! Light Loop	7	\N
353	NZXT Kraken Z63 RGB	7	\N
354	Asus ROG RYUO III 360 ARGB	7	\N
355	Ocypus Iota L24	7	\N
356	Asus ROG STRIX LC III ARGB LCD	7	\N
360	Thermaltake TOUGHLIQUID ARGB	7	\N
361	Asus Prime LC 360 ARGB LCD	7	\N
363	Asus ROG STRIX LC II 280 ARGB	7	\N
364	Cooler Master MasterLiquid 360 Core II	7	\N
367	Thermalright Frozen Notte ARGB	7	\N
370	Cooler Master MasterLiquid ML360L ARGB V2	7	\N
371	Corsair NAUTILUS 240 RS ARGB	7	\N
373	Thermalright Frozen Prism ARGB	7	\N
374	MSI MAG CORELIQUID A15	7	\N
375	Cooler Master Masterliquid 360 Atmos	7	\N
376	NZXT Kraken 240 RGB	7	\N
378	Asus ROG RYUO III 240 ARGB	7	\N
379	SAMA SM360 LCD	7	\N
380	Gigabyte AORUS WATERFORCE II 360 ICE	7	\N
382	Thermaltake TOUGHLIQUID Ultra RGB	7	\N
383	NZXT Kraken Plus	7	\N
384	Montech HyperFlow ARGB 240	7	\N
385	GAMDIAS AURA GL360	7	\N
387	NZXT Kraken 360 RGB	7	\N
388	Corsair NAUTILUS 360 RS	7	\N
389	Lian Li Galahad II LCD	7	\N
390	ID-COOLING FX360 INF	7	\N
391	Asus TUF Gaming LC II ARGB	7	\N
394	Montech HyperFlow Silent 360	7	\N
395	Thermalright Core Vision ARGB	7	\N
396	Corsair NAUTILUS 360 RS ARGB	7	\N
397	Ocypus Iota L36	7	\N
398	Thermaltake TH120 V2 ARGB Sync	7	\N
399	Cooler Master MasterLiquid 360L Core ARGB	7	\N
408	Asus ROG STRIX LC II	7	\N
411	Thermaltake TH360 V2 Ultra ARGB Sync	7	\N
413	Thermalright Frozen Prism	7	\N
415	Asus ROG STRIX LC II ARGB	7	\N
416	Valkyrie SYN	7	\N
417	Asus ROG RYUJIN II	7	\N
418	ID-COOLING FROSTFLOW X	7	\N
419	Phanteks Glacier One 360M25 G2	7	\N
420	Cooler Master Masterliquid 240 Atmos	7	\N
421	Alphacool Eisbaer 240	7	\N
423	Phanteks GLACIER ONE 420D30	7	\N
427	Cougar Poseidon Elite ARGB 360	7	\N
428	Alphacool Eisbaer 360	7	\N
429	be quiet! Silent Loop 2 120	7	\N
430	NZXT Kraken M22	7	\N
431	YEYIAN VATN ARGB 360	7	\N
432	In Win SR24	7	\N
433	Cooler Master MasterLiquid 240 Atmos	7	\N
436	Asus ROG RYUO 120 RGB	7	\N
438	NZXT Kraken 120	7	\N
440	Montech HyperFlow ARGB 360	7	\N
441	NZXT Kraken 280	7	\N
444	Lian Li Galahad II Trinity	7	\N
445	be quiet! Silent Loop 3	7	\N
446	Asus ROG STRIX LC III ARGB	7	\N
448	Alphacool Eisbaer Extreme	7	\N
449	Thermalright Mjolnir Vision 360 ARGB	7	\N
450	Enermax LIQMAXFLO 240	7	\N
452	Thermaltake TH360 V2 ARGB Sync	7	\N
454	NZXT Kraken Elite 280 RGB	7	\N
455	EK EK-Nucleus AIO CR240 Lux D-RGB	7	\N
456	Asus ROG Ryujin III	7	\N
457	NZXT Kraken Plus RGB	7	\N
458	Thermalright Frozen Infinity 360 ARGB	7	\N
462	Vetroo V360	7	\N
463	Thermalright Frozen Edge	7	\N
468	Asus ROG Ryujin III ARGB	7	\N
470	Vetroo V240	7	\N
471	ID-COOLING FX240 INF	7	\N
476	Thermaltake TH280 V2 ARGB Sync	7	\N
477	NZXT Kraken 240	7	\N
479	ID-COOLING SL360	7	\N
480	Fractal Design Lumen S28 V2	7	\N
486	MSI MAG CORELIQUID 240R V2	7	\N
488	PC Cooler DS360	7	\N
490	NZXT Kraken X73 RGB	7	\N
501	Cooler Master MasterLiquid 240L Core ARGB	7	\N
505	Asus ROG RYUO III 240 ARGB WHITE EDITION	7	\N
509	Asus ROG Ryujin III 360 ARGB Extreme	7	\N
512	Phanteks Glacier One D30 X2	7	\N
514	NZXT Kraken Elite 240 RGB	7	\N
173	Intel Core i5-12400	1	4000000.00
157	Intel Core i7-12700K	1	5500000.00
160	Intel Core i7-12700	1	6000000.00
169	Intel Core i9-12900K	1	8000000.00
515	Thermaltake TH240 V2 Ultra ARGB Sync	7	\N
516	NZXT Kraken Elite 280 RGB (2024)	7	\N
518	Asus ProArt LC 420	7	\N
521	Asus ROG STRIX LC 360 RGB White Edition	7	\N
522	In Win SR36 PRO	7	\N
523	Enermax LIQMAXFLO 420	7	\N
525	NZXT Kraken X53	7	\N
526	Corsair H115i RGB PLATINUM	7	\N
527	Silverstone NovaPeak 360	7	\N
529	Thermaltake TOUGHLIQUID Ultra	7	\N
531	Fractal Design Lumen S28 RGB V2	7	\N
532	Alphacool Eisbaer LT240	7	\N
533	Gigabyte AORUS WATERFORCE X II 360	7	\N
539	Thermalright AQUA ELITE ARGB V4	7	\N
540	Montech HyperFlow Silent 240	7	\N
546	Gigabyte AORUS WATERFORCE II 360	7	\N
547	GAMDIAS CHIONE M4-360	7	\N
550	Fractal Design Lumen S24 RGB V2	7	\N
555	Corsair iCUE LINK TITAN 360 RX LCD	7	\N
556	Thermaltake TH420 ARGB Sync	7	\N
557	Alphacool Eisbaer LT360	7	\N
559	Corsair iCUE LINK TITAN 240 RX LCD	7	\N
560	Silverstone NovaPeak 360 ARGB	7	\N
561	Asus ROG RYUO 240 RGB	7	\N
562	NZXT Kraken Elite 360	7	\N
566	Cooler Master Elite	7	\N
567	NZXT Kraken 280 RGB	7	\N
568	ARCTIC Liquid Freezer II 280 A-RGB	7	\N
571	Cougar Poseidon Elite ARGB 240	7	\N
573	Fractal Design Lumen S36 V2	7	\N
577	Asus ROG STRIX LC 120 RGB	7	\N
578	Thermaltake TH240 V2 ARGB Sync	7	\N
583	ID-COOLING SL240	7	\N
584	Silverstone IceMyst 360	7	\N
587	Cooler Master MasterLiquid 240 Core II	7	\N
591	NZXT Kraken Elite 360 RGB	7	\N
594	Cooler Master MasterLiquid 360 Atmos	7	\N
595	Asus ROG RYUO III 360 ARGB WHITE EDITION	7	\N
599	Cooler Master MasterLiquid 240L Core	7	\N
604	Enermax LIQMAXFLO 360	7	\N
605	Thermaltake TH280 V2 Ultra ARGB Sync	7	\N
606	In Win SR36	7	\N
609	NZXT Kraken Z73	7	\N
610	Thermalright Aqua Elite V3	7	\N
614	NZXT Kraken X53 RGB	7	\N
638	In Win BR36	7	\N
640	Lian Li Galahad II Lite Performance	7	\N
642	NZXT Kraken 360	7	\N
646	Thermaltake TH420 V2 ARGB Sync	7	\N
651	Gigabyte AORUS WATERFORCE 240	7	\N
652	Gigabyte AORUS WATERFORCE II 240	7	\N
654	Corsair iCUE H100i RGB ELITE	7	\N
655	TRYX PANORAMA	7	\N
658	ARCTIC Liquid Freezer II 280 RGB	7	\N
661	NZXT Kraken Z63	7	\N
662	MSI MAG CORELIQUID M360	7	\N
663	Cooler Master MasterLiquid 240 ATMOS Stealth	7	\N
667	Fractal Design Lumen S36 RGB V2	7	\N
672	ARCTIC Liquid Freezer II 420 RGB	7	\N
673	Cooler Master MasterLiquid ML360 Mirror	7	\N
674	Lian Li Galahad II Lite RGB	7	\N
677	Asus ROG Ryujin III ARGB Extreme	7	\N
681	Cooler Master MasterLiquid ML240L V2 RGB	7	\N
684	Asus ROG STRIX LC 240 RGB White Edition	7	\N
687	ID-COOLING FX240 PRO	7	\N
693	NZXT Kraken X63	7	\N
700	EK EK-Nucleus AIO CR360 Lux D-RGB	7	\N
704	Cooler Master MasterLiquid ML360R RGB	7	\N
706	Gigabyte GAMING 360	7	\N
708	Enermax LIQMAX III 240 ARGB	7	\N
709	NZXT Kraken Z53	7	\N
713	Phanteks Glacier One 360MPH	7	\N
714	NZXT Kraken X63 RGB	7	\N
716	Asus ROG STRIX LC 240 RGB	7	\N
718	ARCTIC Liquid Freezer II 420 A-RGB	7	\N
719	NZXT Kraken X73	7	\N
722	Corsair NAUTILUS 240 RS	7	\N
723	Asus ROG Strix LC 360	7	\N
724	Silverstone IceMyst 420	7	\N
726	NZXT Kraken Elite 280	7	\N
729	Cooler Master MASTERLIQUID ML240L RGB V2	7	\N
733	Lian Li Galahad II Trinity Performance	7	\N
742	Asus ROG STRIX LC III	7	\N
743	Gigabyte AORUS WATERFORCE X II 360 ICE	7	\N
749	Gigabyte AORUS WATERFORCE 280	7	\N
764	MSI VENTUS 2X OC	2	6000000.00
772	PNY Dual Fan	2	12000000.00
768	MSI GAMING TRIO OC	2	8500000.00
771	Asus ProArt OC	2	9000000.00
785	EVGA FTW3 ULTRA GAMING	2	7000000.00
773	Gigabyte AORUS XTREME WATERFORCE	2	11429746.00
765	Gigabyte OC	2	3000000.00
777	Zotac Solid Core OC	2	27939746.00
769	Asus KO Gaming OC	2	7100000.00
781	Gigabyte WINDFORCE OC	2	18796000.00
783	PowerColor Hellhound OC	2	17754600.00
774	Gigabyte AORUS MASTER	2	7000000.00
780	ASRock Phantom Gaming D OC	2	3500000.00
825	Inno3D Twin X2	2	\N
929	Acer Predator BiFrost OC	2	\N
960	PNY XLR8 Gaming VERTO EPIC-X RGB OC	2	\N
971	Inno3D X3 OC	2	\N
796	Asus PRIME OC	2	22580600.00
798	PowerColor Reaper	2	17779746.00
901	PNY VCQK1200DVI-PB	2	2000000.00
944	Asus ROG STRIX	2	2200000.00
915	EVGA FTW GAMING	2	2500000.00
807	Asus PRIME	2	13918946.00
808	XFX THICC II	2	17145000.00
809	PNY VCNRTX4500ADA-PB	2	97790000.00
952	Gigabyte AERO OC	2	20000000.00
802	Asus DUAL OC	2	6500000.00
815	EVGA FTW3 GAMING	2	60934600.00
863	PNY VCQM5000-PB	2	5000000.00
806	Asus TUF GAMING OC	2	9000000.00
819	MSI SHADOW 3X OC	2	15493746.00
821	XFX Quicksilver	2	18541746.00
817	Asus ROG STRIX GAMING OC V2	2	6800000.00
831	Zotac GAMING SOLO	2	3809746.00
925	PNY VCQP2000-PB	2	3500000.00
837	MSI VENTUS 3X E1 OC	2	19062700.00
838	Zotac GAMING SOLID OC	2	130556762.00
840	Gigabyte GAMING OC	2	53314600.00
841	XFX Swift	2	17525746.00
843	Sapphire NITRO+	2	20319746.00
847	XFX RX-570P8DFD6	2	2539746.00
852	PNY VCQP400-PB	2	2997200.00
861	EVGA SC GAMING	2	4000000.00
864	EVGA SC ULTRA GAMING	2	3000000.00
850	PowerColor Fighter	2	5000000.00
888	EVGA XC GAMING	2	6500000.00
859	Gigabyte GAMING OC Rev 2.0	2	6800000.00
871	Gigabyte OC Low Profile	2	5500000.00
1002	PowerColor Red Devil OC	2	5700000.00
962	Sparkle TITAN OC	2	7800000.00
874	MSI VENTUS 2X XS OC	2	6095746.00
880	PNY VERTO OC	2	33019746.00
883	Asus DUAL EVO OC	2	18999200.00
849	XFX Speedster SWFT 210 Core	2	7000000.00
794	MSI GAMING X	2	4800000.00
895	MSI VENTUS 2X	2	11937746.00
900	Gigabyte WINDFORCE	2	10032746.00
903	Yeston Sakura	2	38836600.00
904	Asus TUF GAMING	2	23572724.00
906	Asus TUF Gaming OG OC	2	101574600.00
827	Zotac GAMING AMP	2	9000000.00
902	Zotac GAMING SOLID CORE OC	2	45000000.00
917	MSI VENTUS 3X	2	43136566.00
931	PNY VCG50608DFXPB1	2	9108186.00
948	ASRock Steel Legend	2	19049746.00
814	Asus KO GAMING OC V2	2	6800000.00
963	Asus DUAL	2	5000000.00
976	PowerColor Hellhound	2	15239746.00
982	Zotac Twin Edge OC	2	10667746.00
824	Asus ROG STRIX GAMING OC	2	5000000.00
993	MSI EXPERT	2	46456600.00
1003	XFX Mercury OC RGB	2	19557746.00
1006	PNY VCQRTX8000-PB	2	83439000.00
1096	EVGA K|NGP|N HYBRID GAMING	2	\N
1154	PNY EPIC-X RGB OC	2	\N
1199	ASRock Phantom Gaming OC	2	\N
1231	PowerColor Red Devil Limited Edition OC	2	\N
1233	ASRock Taichi OC	2	\N
2853	Asus ROG LOKI	6	2285000.00
1015	PowerColor Red Dragon	2	17145000.00
1252	MSI GAMING TRIO OC PLUS	2	27000000.00
1019	Zotac Twin Edge	2	10667746.00
1022	PNY VCQM2000-PB	2	3175000.00
1021	Gainward Ghost	2	12000000.00
1030	PNY VCQP620-PB	2	1574546.00
1032	Sapphire NITRO+ SE	2	25120600.00
2855	Apevia Prestige	6	1478000.00
1037	MSI RTX 3090 SUPRIM X 24G	2	38074600.00
2856	Thermaltake Toughpower GF A3 - TT Premium Edition	6	2877000.00
1049	PNY VERTO	2	33019746.00
1070	EVGA FTW3 ULTRA GAMING LHR	2	12000000.00
1256	MSI GAMING X SLIM	2	9900000.00
2857	Montech TITAN PLA	6	3159000.00
1064	XFX RX-79TMBABF9	2	16509746.00
1065	MSI SHADOW 2X OC	2	7619746.00
2859	Corsair HX1500i (2023)	6	5064000.00
1077	Gigabyte AORUS ELITE Rev 2.0	2	6500000.00
1093	Gigabyte GV-N1030D4-2GL	2	990000.00
1079	PNY VCQRTX5000-PB	2	21463000.00
1080	MSI VENTUS 2X PLUS OC	2	14731746.00
2860	Lian Li EDGE	6	3577000.00
1205	Asus TUF Gaming EVO OC	2	3000000.00
1113	MSI LP OC	2	4000000.00
1197	MSI RTX 3070 GAMING X TRIO	2	7100000.00
2861	ASRock Taichi TC-1650T	6	7669000.00
1229	MSI VENTUS 2X OCV1	2	6500000.00
1101	ONIX LUMI OC	2	7873746.00
1103	XFX RX-79GMERCB9	2	29210000.00
1125	Gigabyte EAGLE	2	4500000.00
1146	Gigabyte GV-N105TD5-4GD	2	1750000.00
1100	MSI GAMING OC	2	7500000.00
2862	Silverstone SX1000R-PL	6	3124000.00
1092	Asus Phoenix	2	5000000.00
2863	Super Flower Zillion FG	6	2658000.00
2849	Silverstone Essential	6	1840000.00
2851	SeaSonic S12III	6	1063000.00
2864	Asus Prime AP-750G	6	1685000.00
2852	ASRock Steel Legend SL-750G	6	1787000.00
1193	Asus DUAL V2	2	4900000.00
1150	Asus ROG STRIX GAMING	2	91313000.00
2866	Silverstone DA1000R	6	2444000.00
1174	PNY VCG508016TFXPB1	2	39369746.00
2868	Asus ROG Strix Aura Edition	6	2788000.00
2872	MSI MEG Ai1300P PCIE5	6	4598000.00
1149	ASRock Steel Legend OC	2	6900000.00
1180	MSI VENTUS 2X PLUS	2	14477746.00
1081	Asus TUF GAMING OC P	2	1900000.00
1192	PowerColor Red Devil	2	21564600.00
2875	Cooler Master V1300 Platinum	6	4389000.00
2877	Thermaltake Toughpower GF A3 Snow	6	2375000.00
2878	ASRock Phantom Gaming PG-750G	6	1703000.00
2879	Thermaltake Smart BX1 650	6	1032000.00
2883	Super Flower Leadex Titanium	6	15991000.00
2884	Montech APX	6	602000.00
1219	Yeston LP	2	5969000.00
2885	ASRock Steel Legend SL-650G	6	1786000.00
1222	PNY VCG507012TFXPB1	2	17779746.00
2886	Antec NE1000G M ATX3.0	6	2500000.00
1238	PowerColor Hellhound Spectral	2	21589746.00
1246	ASRock Creator	2	16509746.00
1261	PNY OC	2	24891746.00
2331	Asus STRIX LC GAMING OC	2	63373000.00
1179	ASRock Phantom Gaming	2	3500000.00
2889	SeaSonic SSP-300SUG	6	741000.00
2894	Corsair RM850	6	2308000.00
2897	Thermaltake Toughpower SFX	6	3073000.00
2899	be quiet! Straight Power 12	6	4893000.00
2901	ASRock Challenger CL-750B	6	1157000.00
2902	Corsair SF850 (2024)	6	2899000.00
2904	PC Cooler YS1000	6	2671000.00
2905	MSI MAG A750BN PCIE5	6	1294000.00
2906	EVGA 610 BP	6	1078000.00
2907	be quiet! System Power 10	6	873000.00
2913	EVGA 500 BA	6	756000.00
2914	Lian Li SP	6	1707000.00
2916	Lian Li SP850	6	2367000.00
2917	SeaSonic FOCUS GX	6	1534000.00
2922	SeaSonic VERTEX GX-1200	6	2834000.00
2923	Apevia ATX-PR850W PCIE5.0	6	2154000.00
2924	NZXT C550	6	877000.00
2925	Lian Li EDGE GOLD	6	2475000.00
2928	Silverstone SST-TX300	6	483000.00
2929	EVGA 850 B5	6	1386000.00
2931	Thermaltake Toughpower iRGB PLUS 750	6	2081000.00
2933	MSI MPG A1000GS PCIE5	6	2765000.00
2934	SeaSonic VERTEX PX-1000	6	3177000.00
2936	be quiet! Pure Power 12	6	1736000.00
2940	Corsair RM1200x SHIFT	6	3044000.00
2941	Silverstone FX500-G	6	1158000.00
2948	EVGA 710 BP	6	1117000.00
2949	Corsair SF750 (2024)	6	2369000.00
2951	be quiet! Dark Power 13	6	4799000.00
2953	Azza ARGB	6	1119000.00
2956	Corsair HX1500i (2025)	6	5094000.00
2957	Apevia Galaxy	6	2398000.00
2958	be quiet! Pure Power 12 M	6	1770000.00
2959	SeaSonic VERTEX PX-1200	6	3859000.00
2961	Montech CENTURY G5	6	1706000.00
2963	Rosewill CMG1000G5	6	2712000.00
2966	Cooler Master V850 SFX GOLD	6	2278000.00
2967	GameMax RGB	6	4805000.00
2970	Gigabyte P850GM	6	2011000.00
2973	Corsair RM1000x SHIFT	6	2209000.00
2974	Montech CENTURY II	6	3263000.00
2975	MSI A1000G PCIE5	6	2381000.00
2977	Azza PSAZ-650W	6	1063000.00
2980	In Win P105II	6	3786000.00
2986	MSI MAG A1250GL PCIE5	6	3268000.00
2987	Silverstone ST75F-GS-V3	6	1701000.00
2991	EVGA SuperNOVA 1300 P+	6	4618000.00
2993	Antec NE1000G M White ATX 3.0	6	2361000.00
2996	Asus TUF Gaming 1200G	6	2957000.00
2997	Cougar POLAR	6	3511000.00
3000	Cooler Master V750 SFX GOLD	6	2024000.00
3001	Super Flower LEADEX VII Platinum PRO	6	3038000.00
3011	be quiet! Pure Power 13 M	6	1913000.00
3013	ASRock Challenger CL-750G	6	1919000.00
3021	be quiet! SFX L Power	6	1676000.00
3024	Corsair RM650	6	1448000.00
3026	NZXT C1500	6	5526000.00
3027	MSI MPG A850G PCIE5	6	2213000.00
3028	Cooler Master V Platinum V2	6	5178000.00
3030	FSP Group Hydro PTM X PRO,Gen5	6	2846000.00
3031	ASRock Challenger CL-550B	6	835000.00
3032	Razer Katana Chroma	6	4447000.00
3037	Silverstone Extreme 500 Bronze	6	800000.00
3038	Cooler Master MWE Gold 850 V3	6	1966000.00
3045	EVGA SuperNOVA 1600 P+	6	5808000.00
3054	ASRock Phantom Gaming PG-1000G	6	2424000.00
3057	Corsair RM750	6	1862000.00
3063	NZXT E850	6	2083000.00
3073	MSI MAG A850GL PCIE5	6	2117000.00
3074	MSI MAG A750GL PCIE5 II	6	1895000.00
3075	Azza PSAZ-750W	6	1314000.00
3076	Asus TUF Gaming 1000G	6	2597000.00
3078	MSI MAG A750GL PCIE5	6	2091000.00
3085	NZXT C650	6	1076000.00
3088	Asus ROG THOR 1600T Gaming	6	8594000.00
3089	be quiet! Dark Power Pro 13	6	6035000.00
3091	MSI MAG A1000GL PCIE5	6	2470000.00
3092	MSI MAG A850GL PCIE5 II	6	2376000.00
3097	Lian Li SP750	6	1821000.00
3100	ASRock Steel Legend SL-1000G	6	2383000.00
3103	Rosewill CMG1200G5	6	3102000.00
3104	Silverstone FX350-G	6	830000.00
3107	Thermaltake Smart BM2	6	1244000.00
3113	SHARKOON SilentStorm	6	1323000.00
3117	Thermaltake Toughpower GF3 Snow	6	2659000.00
3119	NZXT C650 (2022)	6	1618000.00
3121	In Win IP-S300FF1-0	6	316000.00
3124	ASRock Challenger CL-850G	6	2114000.00
3126	MSI MPG A850GF	6	1969000.00
3129	Corsair HX1200i	6	4180000.00
3131	Silverstone SX500-G	6	1307000.00
3132	Corsair RM750x SHIFT	6	1843000.00
3137	Cooler Master MWE Gold 850 - V2	6	2186000.00
3138	Corsair RM850x SHIFT	6	2077000.00
3139	Silverstone HELA 1200R	6	3702000.00
3146	ENDORFY Vero L5	6	885000.00
3148	Cougar GEX	6	2555000.00
3149	SeaSonic SS-600ES	6	1024000.00
3150	Asus ROG STRIX 1200P Gaming	6	4541000.00
3156	FSP Group Hydro PTM PRO	6	2348000.00
3806	Seagate Momentus Thin	4	274000.00
3807	Seagate EXOS Enterprise	4	7088000.00
3809	Toshiba X300	4	3864000.00
3810	Western Digital Purple Pro	4	15642000.00
3812	Toshiba MQ04ABF100	4	808000.00
3813	Seagate ST2000NX0253	4	1852000.00
3814	Western Digital Caviar Blue	4	896000.00
3815	Seagate IronWolf NAS	4	7848000.00
3817	Seagate BarraCuda	4	3540000.00
3818	Seagate Momentus 7200.4	4	479000.00
3821	Seagate SkyHawk Surveillance	4	1922000.00
3823	Toshiba MK3276GSX	4	267000.00
3824	Samsung 870 Evo	4	3928000.00
3825	Gigabyte AORUS Gen4 7300	4	4086000.00
3827	Western Digital WD Blue	4	959000.00
3832	Seagate IronWolf Pro	4	9730000.00
3833	Toshiba S300	4	5058000.00
3834	Seagate Enterprise Performance	4	271000.00
3837	Western Digital Scorpio Blue	4	300000.00
3838	Western Digital Blue	4	4890000.00
3840	Western Digital Caviar Green	4	2847000.00
3841	Seagate Constellation ES.2	4	2820000.00
3842	Seagate Exos X18	4	15584000.00
3843	Gigabyte AORUS Gen4	4	4064000.00
3847	Samsung 860 Evo	4	3970000.00
3849	Toshiba MG09 512e	4	10920000.00
3850	Seagate Exos X24	4	21912000.00
3851	Toshiba MK7559GSXP	4	707000.00
3857	Western Digital Red	4	2688000.00
3859	Western Digital Purple	4	13314000.00
3860	Western Digital WD_BLACK	4	3792000.00
3863	Western Digital AV-GP	4	818000.00
3865	Samsung 860 Pro	4	16128000.00
3867	Toshiba MG08ADA600E	4	5622000.00
3868	Seagate Exos 7E8	4	2451000.00
3870	Toshiba N300 NAS	4	19740000.00
3871	Acer Predator GM7000	4	2094000.00
3872	Western Digital Gold	4	5268000.00
3874	Western Digital Green	4	4890000.00
3875	Toshiba N300 Pro	4	11712000.00
3879	Toshiba P300	4	495000.00
3880	Seagate IronWolf Pro NAS	4	3444000.00
3881	Toshiba MD04ACA600	4	5226000.00
3886	Toshiba N300	4	7616000.00
3888	Hitachi Travelstar	4	801000.00
3892	Seagate Barracuda ES	4	969000.00
3895	Crucial MX500	4	3990000.00
3897	Seagate Barracuda ES.2	4	686000.00
3902	Hitachi Ultrastar He8	4	5190000.00
3158	Silverstone DA750 Gold	6	1840000.00
3160	SeaSonic FOCUS SGX (2021)	6	1989000.00
3162	Corsair SF1000 (2024)	6	3682000.00
3166	SeaSonic SSP-300SFG	6	815000.00
3168	Silverstone TX300	6	455000.00
3173	Corsair RM1200e	6	3192000.00
3175	Thermaltake Smart BM3	6	1482000.00
3177	Thermaltake Toughpower GX2	6	1450000.00
3181	SeaSonic PRIME Fanless	6	3494000.00
3185	ASRock Challenger CL-650B	6	1067000.00
3186	Corsair HX1000i (2023)	6	3272000.00
3189	Asus ROG-STRIX-850G	6	2037000.00
3191	Thermaltake Toughpower GX3	6	2029000.00
3194	MSI MAG A650BN	6	1091000.00
3195	NZXT C1200	6	3106000.00
3196	EVGA 700 GD	6	1576000.00
3200	Silverstone DA850R-GMA	6	1940000.00
3204	GAMDIAS HELIOS P2-850G	6	1958000.00
3206	Silverstone SFX	6	2541000.00
3208	ASRock Steel Legend SL-850G	6	1958000.00
3211	Vetroo GV1000	6	2338000.00
3213	SeaSonic VERTEX GX-850	6	2296000.00
3214	Silverstone TX700-G	6	1849000.00
3219	Apevia Premier	6	1722000.00
3220	Silverstone Strider	6	2856000.00
3226	MSI MAG A550BN	6	828000.00
3232	ASRock Phantom Gaming PG-1600G	6	4086000.00
3234	MSI MAG A650GL	6	1635000.00
3241	SeaSonic VERTEX GX-1000	6	2409000.00
3242	Silverstone HELA 850R	6	3119000.00
3243	Asus TUF Gaming 850G	6	2022000.00
3244	Silverstone TX500-G	6	1146000.00
3246	SeaSonic CORE GX ATX 3 (2024)	6	2031000.00
3253	ASRock Phantom Gaming PG-1300G	6	3114000.00
3254	Athena Power AP-MFATX50P8	6	958000.00
3257	PC Cooler YS850	6	2043000.00
3260	Gigabyte UD1300GM PG5	6	3286000.00
3263	ASRock Taichi TC-1300T	6	7029000.00
3264	Rosewill CMG850	6	2077000.00
3266	Asus TUF Gaming B	6	949000.00
3267	MSI MAG A750BE	6	1313000.00
3268	In Win P85	6	2026000.00
3269	Silverstone SX1000-LPT	6	3540000.00
3272	MSI MPG A1000G	6	2659000.00
3275	SeaSonic VERTEX GX-750	6	2100000.00
3279	Athena Power AP-MFATX40P8	6	660000.00
3287	Silverstone SX-G	6	1839000.00
3293	MSI MPG A850GS PCIE5	6	2298000.00
3294	Asus Prime AP-850G	6	2031000.00
3300	MSI MPG A1250GS PCIE5	6	2978000.00
3303	Cooler Master V750 Gold V2	6	1961000.00
4339	Asus PRIME B650-PLUS WIFI	5	2957000.00
4340	MSI B650 GAMING PLUS WIFI	5	3993000.00
4341	MSI MAG B650 TOMAHAWK WIFI	5	3224000.00
4342	Gigabyte X870E AORUS ELITE WIFI7	5	9067000.00
4343	Asus PRIME B550M-A WIFI II	5	1979000.00
4344	Gigabyte B650 EAGLE AX	5	4043000.00
4345	Asus TUF GAMING B850-PLUS WIFI	5	4875000.00
4346	ASRock B650M Pro RS WiFi	5	3068000.00
4347	MSI MAG X870 TOMAHAWK WIFI	5	7387000.00
4348	Gigabyte A520M K V2	5	2413000.00
4349	Asus B650E MAX GAMING WIFI W	5	4126000.00
4350	MSI PRO B650-S WIFI	5	3702000.00
4351	Gigabyte B550M K	5	1654000.00
4353	MSI B760 GAMING PLUS WIFI	5	2741000.00
4354	MSI PRO B550M-VC WIFI	5	1814000.00
3905	Western Digital RE	4	4365000.00
3908	Hitachi Deskstar 5K3000	4	2535000.00
3918	Western Digital Caviar Black	4	1650000.00
3919	MSI SPATIUM M480 PRO	4	8004000.00
3921	Seagate Barracuda Compute	4	3968000.00
3923	Western Digital SE	4	825000.00
3931	Seagate Momentus XT	4	746000.00
3936	Western Digital Ultrastar DC HC560	4	21494000.00
3937	Seagate Archive HDD v2	4	4295000.00
3938	Samsung 980 Pro w/Heatsink	4	7814000.00
3942	Samsung 9100 PRO	4	16160000.00
3946	Seagate Exos 7E10 512e/4Kn	4	3484000.00
3949	Seagate Exos X14	4	9804000.00
3953	Seagate Momentus 5400.6	4	285000.00
3956	Samsung 960 Evo	4	993000.00
3959	Seagate Exos X10	4	9750000.00
3961	Seagate Barracuda Green	4	1386000.00
3962	Toshiba MG06ACA800E	4	6696000.00
3966	Toshiba L200	4	920000.00
3972	Mushkin Source	4	8016000.00
3976	Western Digital VelociRaptor	4	448000.00
3980	Seagate ST1000NX0313	4	899000.00
3983	Crucial P5 Plus	4	1984000.00
3986	Seagate Barracuda 7200.9	4	135000.00
3988	Samsung 990 Pro	4	15648000.00
3994	Samsung 980 Pro	4	3960000.00
3997	Toshiba S300 Pro	4	8570000.00
4006	Mushkin Vortex Redline	4	7878000.00
4015	Western Digital Black	4	994000.00
4016	Seagate BarraCuda Pro	4	8060000.00
4018	Seagate Exos X20	4	17694000.00
4023	Toshiba X300 Pro	4	8150000.00
4026	Samsung 990 Pro w/Heatsink	4	16028000.00
4031	Samsung 970 Evo	4	4092000.00
4032	Western Digital Purple NV	4	5436000.00
4033	Seagate ST4000LM016	4	3372000.00
4041	Seagate SkyHawk	4	1654000.00
4046	Seagate ST1000LM035	4	877000.00
4054	Seagate ST6000NM0024	4	5622000.00
4076	Seagate Barracuda LP	4	958000.00
4079	Hitachi 7K1000.C	4	969000.00
4081	Seagate Constellation CS	4	2733000.00
4083	Seagate Exos X16	4	15872000.00
4094	Samsung 960 Pro	4	8076000.00
4100	Seagate Exos X22	4	20020000.00
4104	Western Digital WDBMYH0010BNC-NRSN	4	877000.00
4110	Seagate Momentus	4	579000.00
4116	Seagate ST2000NM0024	4	1964000.00
4134	Hitachi A7K2000	4	461000.00
4147	Western Digital RE3	4	433000.00
4149	Samsung Spinpoint MP4	4	231000.00
4150	Samsung 970 Evo Plus	4	4085000.00
4153	Western Digital AV-25	4	230000.00
4162	Seagate Surveillance HDD	4	1706000.00
4171	Western Digital Ultrastar DC HC330	4	8310000.00
4172	Hitachi Ultrastar He10	4	9290000.00
4177	Western Digital DC HC530	4	12404000.00
4180	Seagate SV35.5	4	423000.00
4182	Western Digital Scorpio Black	4	259000.00
4184	Hitachi Travelstar Z7K320	4	239000.00
4185	Toshiba MG09 4Kn	4	16074000.00
4189	Toshiba MG04ACA400N	4	3332000.00
4191	Toshiba AL13SEB600	4	572000.00
4193	Hitachi Ultrastar He12	4	9864000.00
4197	Samsung 970 Pro	4	4062000.00
4231	Western Digital WD_BLACK SN8100	4	4023000.00
4247	Hitachi Travelstar Z7K500	4	500000.00
4248	Hitachi Ultrastar	4	5580000.00
4256	HP EX920	4	2084000.00
4272	Seagate Exos 7E8 512e	4	7296000.00
4276	Gigabyte AORUS Gen5 14000	4	4061000.00
4278	Toshiba MG08	4	14784000.00
4286	Toshiba MG07ACA12TE	4	9984000.00
4300	Seagate Enterprise NAS	4	4926000.00
4355	MSI PRO Z790-A MAX WIFI	5	4335000.00
4356	Asus TUF GAMING B650-PLUS WIFI	5	3828000.00
4357	Gigabyte X870 EAGLE WIFI7	5	8172000.00
4359	MSI B550M PRO-VDH WIFI	5	2399000.00
4360	Asus ROG STRIX X870E-E GAMING WIFI	5	13277000.00
4361	ASRock B850M-X WiFi R2.0	5	5997000.00
4362	Gigabyte B850 EAGLE WIFI6E	5	5859000.00
4363	MSI MAG B850 TOMAHAWK MAX WIFI	5	4995000.00
4364	Gigabyte B760M GAMING PLUS WIFI DDR4	5	3196000.00
4366	Gigabyte B650M GAMING PLUS WIFI	5	4498000.00
3805	Seagate SkyHawk AI	4	8260000.00
3808	Western Digital WD Red Pro	4	4950000.00
3816	Seagate Enterprise Capacity	4	8970000.00
2887	Asus ROG Strix	6	2360000.00
4367	MSI MAG B550 TOMAHAWK MAX WIFI	5	2009000.00
4368	Gigabyte B850 AORUS ELITE WIFI7	5	4865000.00
4369	Gigabyte B650 GAMING X AX V2	5	3303000.00
4370	Asus ROG STRIX X870-A GAMING WIFI	5	7765000.00
4371	ASRock A620I LIGHTNING WIFI	5	2379000.00
4373	Asus TUF GAMING B650-E WIFI	5	3490000.00
4374	Gigabyte Z790 EAGLE AX	5	5363000.00
4375	MSI B450M-A PRO MAX II	5	1727000.00
4376	MSI PRO B650M-P	5	3510000.00
4377	ASRock B450M/ac R2.0	5	1569000.00
4378	Asus TUF GAMING B850M-PLUS WIFI	5	5927000.00
4379	ASRock B450M-HDV R4.0	5	1387000.00
4381	MSI PRO B760M-P DDR4	5	2985000.00
4382	Asus ROG STRIX B550-F GAMING WIFI II	5	1783000.00
4383	Gigabyte B850M GAMING X WIFI6E	5	5849000.00
4384	Asus ROG CROSSHAIR X870E HERO	5	9587000.00
4385	Gigabyte A520I AC	5	1959000.00
4386	Gigabyte B550M AORUS ELITE AX	5	1857000.00
4387	ASRock B850M Pro-A WiFi	5	4733000.00
4389	MSI MPG B550 GAMING PLUS	5	2073000.00
4390	MSI A520M-A PRO	5	1910000.00
4391	MSI PRO B650M-A WIFI	5	2915000.00
4392	Asus ROG STRIX B650E-F GAMING WIFI	5	5444000.00
4393	Asus ROG STRIX B850-A GAMING WIFI	5	4687000.00
4394	ASRock B550M Pro4	5	2031000.00
4396	Asus ROG STRIX B850-I GAMING WIFI	5	4523000.00
4397	Asus ROG STRIX B650E-I GAMING WIFI	5	3572000.00
4398	MSI MPG X870E CARBON WIFI	5	12357000.00
4399	Gigabyte B850 GAMING WIFI6	5	5996000.00
4400	MSI B850 GAMING PLUS WIFI	5	4618000.00
4401	Asus TUF GAMING X870-PLUS WIFI	5	6680000.00
4403	MSI B550-A PRO	5	2117000.00
4404	Asus ROG CROSSHAIR X870E EXTREME	5	13734000.00
4405	ASRock B850M Pro RS WiFi	5	4152000.00
4406	Asus TUF GAMING Z790-PLUS WIFI	5	3653000.00
4407	Gigabyte X870E AORUS PRO ICE	5	10922000.00
4408	Gigabyte B650 AORUS ELITE AX	5	3278000.00
4410	Gigabyte X870I AORUS PRO ICE	5	6236000.00
4411	MSI B650M GAMING PLUS WIFI	5	3877000.00
4412	Asus ROG STRIX B850-F GAMING WIFI	5	4495000.00
4413	ASRock X870 Pro RS	5	8458000.00
4414	MSI PRO A620M-E	5	2575000.00
4416	Gigabyte B850 GAMING X WIFI6E	5	4041000.00
4417	Gigabyte B550 GAMING X V2	5	2321000.00
4418	ASRock B650M-HDV/M.2	5	4416000.00
4419	Asus Z790 GAMING WIFI7	5	6101000.00
4420	MSI MAG X870E TOMAHAWK WIFI	5	12526000.00
4421	Gigabyte B550 EAGLE WIFI6	5	2434000.00
4422	MSI PRO H610M-G DDR4	5	1378000.00
4424	ASRock X870 Pro RS WiFi	5	7319000.00
4425	Gigabyte B850M AORUS ELITE WIFI6E ICE	5	3738000.00
4426	ASRock B760M-HDV/M.2	5	2622000.00
4427	Gigabyte TRX40 DESIGNARE	5	10685000.00
4428	ASRock A520M-HDV	5	1678000.00
4430	Gigabyte X870 AORUS ELITE WIFI7	5	6354000.00
4431	Asus ROG STRIX B760-I GAMING WIFI	5	3060000.00
4432	Gigabyte X870 GAMING WIFI6	5	7836000.00
4433	ASRock A620M-HDV/M.2	5	2028000.00
4434	MSI MAG Z890 TOMAHAWK WIFI	5	7116000.00
4436	ASRock B650 PG LIGHTNING	5	4193000.00
4437	MSI MAG B550 TOMAHAWK	5	1656000.00
4438	MSI MAG B760 TOMAHAWK WIFI	5	3758000.00
4439	Gigabyte B550 UD AC	5	2017000.00
4440	Gigabyte B650M D3HP AX	5	4374000.00
4441	Asus PRIME B650M-A AX II	5	3008000.00
4443	ASRock X870E Taichi	5	12179000.00
4444	MSI MPG X870E EDGE TI WIFI	5	9227000.00
4446	MSI PRO X870E-P WIFI	5	13689000.00
4447	MSI PRO B850-P WIFI	5	5224000.00
4448	Gigabyte B760M DS3H AX	5	3552000.00
4449	ASRock B850 Riptide WiFi	5	4635000.00
4451	ASRock B650M Pro RS	5	4243000.00
4452	Asus TUF GAMING A520M-PLUS WIFI	5	2134000.00
4453	ASRock B760M PG Riptide Wifi	5	3418000.00
4455	Gigabyte B650 AORUS ELITE AX ICE	5	4312000.00
4456	MSI X670E GAMING PLUS WIFI	5	9816000.00
4457	Gigabyte B650 AORUS ELITE AX V2	5	4403000.00
4459	Asus ROG STRIX Z790-A GAMING WIFI II	5	6484000.00
4460	MSI PRO Z790-P WIFI	5	3601000.00
4462	ASRock B850M Steel Legend WiFi	5	3741000.00
4463	Asus TUF GAMING B650M-PLUS WIFI	5	2896000.00
4464	MSI B760M GAMING PLUS WIFI	5	3025000.00
4465	Gigabyte B550M DS3H AC	5	2136000.00
4467	MSI PRO B760-P WIFI DDR4	5	2528000.00
4468	Gigabyte B650 EAGLE	5	3119000.00
4470	Asus TUF GAMING B760-PLUS WIFI	5	3309000.00
4471	ASRock Z790 PRO RS WIFI	5	6354000.00
4472	Gigabyte A520M S2H	5	1870000.00
4473	Asus Prime B450M-A II	5	1776000.00
168	Intel Core i5-13600K	1	5000000.00
3826	Samsung Spinpoint M8	4	960000.00
3839	Seagate Constellation ES.3	4	3640000.00
3848	Seagate Constellation ES	4	849000.00
3864	Hitachi Ultrastar 7K6000	4	3340000.00
3873	Toshiba MG04ACA600E	4	5946000.00
3887	Western Digital Red Plus	4	1714000.00
3900	Hitachi Ultrastar 7K3000	4	1680000.00
4539	Montech XR	8	\N
4540	Phanteks XT PRO	8	\N
4541	NZXT H5 Flow (2024)	8	\N
4542	Corsair 3500X ARGB	8	\N
4543	Cooler Master MasterBox Q300L	8	\N
4544	Corsair 4000D Airflow	8	\N
4545	Lian Li Lancool 207	8	\N
3904	Hitachi 0Y30055	4	500000.00
4547	Lian Li O11 VISION COMPACT	8	\N
4549	Montech AIR 100 ARGB	8	\N
4550	Montech AIR 903 MAX	8	\N
4551	Lian Li A3-mATX	8	\N
4552	Fractal Design North	8	\N
4553	HYTE Y70 Touch Infinite	8	\N
4554	Fractal Design North XL	8	\N
4558	Phanteks XT PRO ULTRA	8	\N
4561	Lian Li O11D EVO RGB	8	\N
4562	NZXT H6 Flow	8	\N
4563	Montech AIR 903 BASE	8	\N
4566	Corsair FRAME 4000D RS ARGB	8	\N
4567	NZXT H3 Flow	8	\N
4568	Fractal Design Terra	8	\N
4569	Antec C5 ARGB	8	\N
4570	Fractal Design Pop XL Air	8	\N
4571	Lian Li LANCOOL 217	8	\N
4572	Lian Li O11 Dynamic EVO XL	8	\N
4573	Montech KING 95 PRO	8	\N
4574	Fractal Design Meshify C	8	\N
3910	Seagate Momentus 5400.3	4	300000.00
4576	Lian Li LANCOOL 216 RGB	8	\N
4577	HYTE Y70	8	\N
4578	Fractal Design Pop Air	8	\N
4579	NZXT H7 Flow (2024)	8	\N
4580	MUSETEX Y6	8	\N
4581	Corsair 3000D AIRFLOW	8	\N
4582	Lian Li O11 Vision	8	\N
4586	Montech X3 Mesh	8	\N
3935	Seagate SkyHawk Surveillance +Rescue	4	1650000.00
4589	Corsair FRAME 4000D	8	\N
4590	NZXT H6 Flow RGB	8	\N
4591	Asus Prime AP201	8	\N
4592	Montech XR Wood	8	\N
4593	Montech X5M	8	\N
4595	Antec C8	8	\N
4596	Thermaltake Versa H18	8	\N
4597	Silverstone ALTA F2	8	\N
4599	Corsair 5000D AIRFLOW	8	\N
4600	Fractal Design Ridge PCIe 4.0	8	\N
4601	Corsair 3500X	8	\N
4476	MSI B550 GAMING GEN3	5	2466000.00
4603	Zalman T3 PLUS	8	\N
4478	Gigabyte B550 AORUS ELITE AX V2	5	1756000.00
4479	ASRock B850 Steel Legend WiFi	5	5878000.00
4480	MSI MPG B650I EDGE WIFI	5	4194000.00
4481	MSI MAG Z790 TOMAHAWK WIFI	5	4519000.00
4482	Gigabyte B550I AORUS PRO AX	5	2416000.00
4485	Asus ROG STRIX B550-A GAMING	5	1610000.00
4487	Gigabyte X870E AORUS PRO	5	12010000.00
4488	MSI Z790 GAMING PLUS WIFI	5	4239000.00
4489	MSI MPG B850I EDGE TI WIFI	5	3785000.00
4490	ASRock B650 PRO RS	5	4338000.00
4491	Gigabyte B650E AORUS ELITE X AX ICE	5	4941000.00
4492	MSI PRO B840-P WIFI	5	4267000.00
4493	ASRock B550M-ITX/ac	5	2019000.00
4495	ASRock B850 Pro-A	5	5542000.00
4497	Asus ROG STRIX B850-E GAMING WIFI	5	3930000.00
4498	MSI MAG B650M MORTAR WIFI	5	2872000.00
4500	MSI PRO X870-P WIFI	5	7815000.00
4501	Asus PRIME B550-PLUS AC-HES	5	2218000.00
4502	Asus PRIME X870-P WIFI	5	6788000.00
4505	Asus Z790-AYW WIFI W II	5	6594000.00
4506	ASRock B850M Riptide WiFi	5	3541000.00
4507	Gigabyte B760M DS3H DDR4	5	2517000.00
4508	Asus TUF GAMING B760M-PLUS WIFI II	5	2830000.00
4510	Asus PRIME H610I-PLUS D4-CSM	5	1421000.00
4511	Asus PRIME B760M-A AX	5	3923000.00
4512	Gigabyte B550M DS3H	5	2071000.00
4513	MSI PRO B650-P WIFI	5	3029000.00
4514	ASRock B650M-H/M.2+	5	3541000.00
4515	ASRock X870 Steel Legend WiFi	5	8619000.00
4516	Asus ROG MAXIMUS Z790 DARK HERO	5	6846000.00
4518	ASRock H610M/ac	5	1512000.00
4519	Gigabyte B650I AORUS ULTRA	5	3481000.00
4520	Gigabyte A620M S2H	5	2199000.00
4521	Gigabyte Z890 EAGLE WIFI7	5	9870000.00
4522	Asus ROG STRIX B450-F GAMING II	5	1750000.00
4523	Asus ROG STRIX X870-F GAMING WIFI	5	8194000.00
4524	Gigabyte B450M DS3H	5	1454000.00
4527	Asus TUF GAMING B550M-PLUS WIFI II	5	2410000.00
4528	ASRock B450M PRO4 R2.0	5	1577000.00
4530	ASRock A620M Pro RS WiFi	5	2137000.00
4532	ASRock H510M-HDV/M.2 SE	5	1141000.00
4533	Asus ROG STRIX B550-F GAMING	5	2273000.00
4534	ASRock B550M-HDV	5	1732000.00
4535	MSI PRO Z890-P WIFI	5	9596000.00
4537	ASRock B850M-X WiFi	5	4301000.00
4538	Gigabyte B550M AORUS ELITE	5	2368000.00
4604	Antec FLUX PRO	8	\N
4605	Cooler Master Elite 301	8	\N
4607	Jonsbo Jonsplus Z20	8	\N
4608	Fractal Design Pop Mini Air	8	\N
4716	BGears b-Vortex-RGB	8	599000.00
4612	MSI MAG FORGE 321R AIRFLOW	8	\N
4613	Jonsbo D32 PRO	8	\N
4614	Lian Li A4-H20 X4	8	\N
4618	Okinos Cypress 3	8	\N
4619	Fractal Design Focus G	8	\N
4620	Thermaltake View 170 ARGB	8	\N
4621	NZXT H5 Flow RGB (2024)	8	\N
4623	NZXT H9 Flow RGB+ (2025)	8	\N
4739	Corsair Vengeance RGB 32 GB	3	8610000.00
4627	Lian Li ODYSSEY X	8	\N
4628	Lian Li LANCOOL 216	8	\N
4629	Thermaltake View 270 Plus TG ARGB	8	\N
4630	Antec FLUX	8	\N
4632	Cooler Master MasterBox NR200P V2	8	\N
4740	G.Skill Flare X5 32 GB	3	8440000.00
4741	Corsair Vengeance LPX 16 GB	3	2160000.00
4636	Corsair FRAME 4000D RS	8	\N
4637	Asus ROG Strix Helios	8	\N
4638	Fractal Design Pop Air RGB	8	\N
4639	NZXT H9 Flow (2025)	8	\N
4640	Montech KING 65 PRO	8	\N
4643	Cooler Master Q300L V2	8	\N
4644	Antec C8 Wood	8	\N
4645	Lian Li O11 Dynamic Mini	8	\N
4647	HYTE Y60	8	\N
4648	MUSETEX K2	8	\N
4651	Zalman S2	8	\N
4653	Jonsbo C6-ITX	8	\N
4654	Lian Li A4-H20 A4	8	\N
4742	Corsair Vengeance 32 GB	3	8480000.00
4656	Lian Li LANCOOL III RGB	8	\N
4657	SAMA SV01	8	\N
4743	TEAMGROUP T-Create Expert 32 GB	3	8990000.00
4661	Fractal Design Torrent	8	\N
4744	Corsair Vengeance LPX 32 GB	3	3870000.00
4664	Thermaltake Versa H16 ARGB	8	\N
4745	Crucial Pro Overclocking 32 GB	3	8190000.00
4666	Phanteks Eclipse G370A	8	\N
4669	MSI MAG PANO 100R PZ	8	\N
4670	GAMDIAS TALOS E3 MESH	8	\N
4671	Antec NX200M	8	\N
4672	Fractal Design Node 804	8	\N
4746	G.Skill Trident Z5 RGB 64 GB	3	17510000.00
4674	Phanteks EVOLV X2	8	\N
4675	NZXT H7 Flow RGB (2024)	8	\N
4676	HYTE Y40	8	\N
4677	Montech X5	8	\N
4747	Corsair Vengeance RGB 64 GB	3	17690000.00
4748	TEAMGROUP T-Force Delta RGB 32 GB	3	8860000.00
4681	Fractal Design Meshify 3	8	\N
4749	G.Skill Trident Z5 Neo RGB 32 GB	3	8080000.00
4750	Patriot Viper Venom 32 GB	3	8630000.00
4751	Corsair Vengeance RGB Pro 32 GB	3	3970000.00
4754	Silicon Power GAMING 16 GB	3	2070000.00
4690	Jonsbo TK-0	8	\N
4691	Corsair 2500X	8	\N
4755	TEAMGROUP T-Force Vulcan Z 16 GB	3	2190000.00
4757	Kingston FURY Beast 32 GB	3	8240000.00
4698	Fractal Design Meshify 2 XL	8	\N
4701	MSI MAG FORGE 112R	8	\N
4702	Lian Li O11 Vision Chrome	8	\N
4758	G.Skill Trident Z5 Neo RGB 64 GB	3	17740000.00
4759	G.Skill Ripjaws V 32 GB	3	3910000.00
4708	Thermaltake The Tower 300	8	\N
4709	Asus TUF Gaming GT502	8	\N
4710	Thermaltake The Tower 600	8	\N
4711	Corsair iCUE LINK 3500X RGB	8	\N
4712	Corsair 3000D RGB AIRFLOW	8	\N
4762	Kingston FURY Beast 16 GB	3	4470000.00
4718	Jonsbo N4	8	\N
4719	be quiet! Light Base 600 LX	8	\N
4720	BGears b-Pellucid	8	\N
4721	Vetroo AL900	8	\N
4723	Thermaltake View 380 ARGB	8	\N
4763	Corsair Vengeance RGB Pro 16 GB	3	1900000.00
4764	Silicon Power Value Gaming 32 GB	3	8410000.00
4731	Antec C3 ARGB	8	\N
4765	Corsair Vengeance 64 GB	3	17250000.00
4734	Fractal Design Focus 2	8	\N
4735	Asus A31	8	\N
4766	G.Skill Flare X5 64 GB	3	16070000.00
4737	Antec C8 Curve Wood	8	\N
4738	Jonsbo C6 MAX	8	\N
4767	TEAMGROUP T-Force Vulcan 32 GB	3	8250000.00
4768	Silicon Power GAMING 32 GB	3	3800000.00
4771	Corsair Dominator Titanium 64 GB	3	17800000.00
4772	G.Skill Ripjaws V 64 GB	3	7600000.00
762	ASRock Challenger	2	17779746.00
813	PowerColor RX 7900 XT 20G	2	16255746.00
834	Zotac GAMING AMP Extreme AIRO	2	53339746.00
854	MSI VENTUS 2X BLACK OC	2	12674600.00
862	Zotac GAMING Trinity	2	38074600.00
868	MSI GeForce RTX 3090 TI GAMING X TRIO 24G	2	47422308.00
911	MSI SHADOW 3X	2	25145746.00
778	Gigabyte EAGLE OC	2	14000000.00
919	PNY ARGB EPIC-X RGB OC	2	9000000.00
820	Zotac GAMING Twin Edge	2	6500000.00
4776	G.Skill Trident Z RGB 32 GB	3	3970000.00
4778	G.Skill Ripjaws V 16 GB	3	2060000.00
4779	Crucial Classic 16 GB	3	4380000.00
4782	G.Skill Ripjaws S5 32 GB	3	8610000.00
4783	Corsair Vengeance LPX 64 GB	3	7910000.00
4784	Crucial Pro 32 GB	3	8750000.00
4785	Kingston FURY Beast RGB 32 GB	3	8400000.00
4788	Patriot Venom 64 GB	3	17840000.00
4789	Crucial Pro 64 GB	3	16270000.00
4794	TEAMGROUP T-Force Delta RGB 16 GB	3	2060000.00
4796	Kingston FURY Beast 64 GB	3	16230000.00
4797	G.Skill Trident Z5 RGB 48 GB	3	16820000.00
4798	Patriot Viper Venom 64 GB	3	17090000.00
4799	G.Skill Trident Z5 RGB 32 GB	3	8240000.00
4801	Timetec PINNACLE Konduit 16 GB	3	2120000.00
4802	Corsair Dominator Titanium 32 GB	3	8110000.00
4803	Patriot Viper Steel 32 GB	3	3870000.00
4805	Corsair Vengeance 16 GB	3	4120000.00
4806	G.Skill Ripjaws S5 64 GB	3	16030000.00
4807	Crucial CP2K64G56C46U5 128 GB	3	16970000.00
4812	Corsair Vengeance RGB 128 GB	3	17690000.00
4813	Corsair Vengeance RGB Pro SL 32 GB	3	3990000.00
5000	Thermalright Assassin X 120 Refined SE	7	\N
5001	Thermalright Peerless Assassin 120 SE	7	\N
5002	Deepcool AK400 Performance CPU Cooler	7	\N
5003	ID-COOLING SE-214-XT ARGB	7	\N
5004	Cooler Master Hyper 212 Halo Black	7	\N
5005	Be Quiet! Pure Rock 2 Black	7	\N
5006	Arctic Freezer 36 Black	7	\N
5007	Vetroo V5 CPU Air Cooler Black	7	\N
5008	Thermalright Burst Assassin 120 ARGB	7	\N
5009	Deepcool AG400 BK ARGB	7	\N
5010	ID-COOLING SE-224-XTS Black	7	\N
5011	Thermalright Silver Soul 135	7	\N
5012	Arctic Freezer i35 A-RGB	7	\N
5013	Cooler Master Hyper 620S ARGB	7	\N
5014	Jonsbo CR1000 EVO ARGB	7	\N
5015	Scythe Kotetsu Mark 3	7	\N
5016	Deepcool AK500 Zero Dark	7	\N
5017	ID-COOLING SE-914-XT Basic	7	\N
5018	Thermalright Assassin Spirit 120 V2	7	\N
5019	Zalman CNPS10X Performa Black	7	\N
5020	Noctua NH-D15 chromax.black	7	\N
5021	Noctua NH-U12S Redux	7	\N
4817	TEAMGROUP T-Create Classic 32 GB	3	8620000.00
4819	Patriot Viper Elite 5 RGB 32 GB	3	8440000.00
4820	TEAMGROUP T-Force Delta RGB 64 GB	3	17700000.00
4822	G.Skill Trident Z5 Royal 32 GB	3	8860000.00
4825	TEAMGROUP T-Force Vulcan Z 32 GB	3	3930000.00
4828	G.Skill Trident Z RGB 16 GB	3	2160000.00
4830	Corsair Vengeance 128 GB	3	17610000.00
4831	Corsair Vengeance RGB 16 GB	3	4340000.00
4832	Crucial CT2K8G48C40U5 16 GB	3	4200000.00
4833	G.Skill Trident Z5 Neo 64 GB	3	16740000.00
4837	PNY XLR8 Gaming RGB 32 GB	3	8770000.00
4839	Kingston FURY Beast 8 GB	3	970000.00
4846	Patriot Viper Venom 16 GB	3	4100000.00
4847	G.Skill Trident Z5 Royal 64 GB	3	16070000.00
4853	Patriot Signature Line 32 GB	3	8980000.00
4854	Crucial CT2K16G48C40U5 32 GB	3	8910000.00
4857	Crucial Pro Overclocking 64 GB	3	16820000.00
4861	Corsair Vengeance LPX 8 GB	3	910000.00
4864	Crucial CT2K8G4DFRA32A 16 GB	3	1970000.00
4866	Crucial CT8G4DFS824A 8 GB	3	940000.00
4867	Timetec PINNACLE Konduit 32 GB	3	3840000.00
4868	Kingston FURY Beast RGB 64 GB	3	17270000.00
4873	G.Skill Trident Z5 Neo 32 GB	3	8040000.00
4874	G.Skill Aegis 16 GB	3	2100000.00
4875	PNY XLR8 32 GB	3	3980000.00
4876	TEAMGROUP Elite 16 GB	3	2100000.00
4884	Silicon Power XPOWER Turbine 16 GB	3	2140000.00
4886	Crucial CT16G48C40U5 16 GB	3	4440000.00
4889	Klevv FIT V 32 GB	3	8790000.00
4891	Kingston FURY Beast RGB 16 GB	3	4100000.00
4896	Patriot Viper Xtreme 5 32 GB	3	8410000.00
4899	G.Skill Trident Z Neo 32 GB	3	3860000.00
4901	Patriot Viper Venom RGB 32 GB	3	8970000.00
4902	Kingston FURY Beast 128 GB	3	16870000.00
4903	Corsair Vengeance 48 GB	3	16480000.00
4910	Silicon Power SP016GBLFU320B22 16 GB	3	1960000.00
4916	G.Skill Aegis 32 GB	3	3860000.00
4922	TEAMGROUP T-Create Expert 64 GB	3	16770000.00
4934	Kingston KCP424NS6/4 4 GB	3	500000.00
4935	G.Skill Trident Z5 Royal 48 GB	3	17010000.00
958	Sapphire PURE	2	21132800.00
1050	MSI RTX 4090 GAMING SLIM 24G	2	93853000.00
1067	Zotac SOLID SFF OC	2	27939746.00
1106	PNY VCNRTX4000ADA-PB	2	47929546.00
970	Asus Turbo	2	2200000.00
980	EVGA XC3 ULTRA GAMING	2	12000000.00
1166	MSI GeForce RTX 3060 Ventus 2X 12G OC	2	6500000.00
3954	Seagate Enterprise	4	5172000.00
3969	Seagate Constellation.2	4	815000.00
3990	Western Digital Ultrastar DC HC550	4	15462000.00
4021	Seagate ST4000NM0034	4	3208000.00
4038	Western Digital Blue Mobile	4	416000.00
4091	Seagate ST2000NX0273	4	1750000.00
5022	Cooler Master MasterAir MA612 Stealth	7	\N
5023	Deepcool AS500 Plus	7	\N
5024	Scythe Fuma 3	7	\N
5025	Scythe Mugen 5 Rev.C	7	\N
5026	Thermalright Phantom Spirit 120 SE	7	\N
5027	ID-COOLING SE-226-XT Black	7	\N
5028	Be Quiet! Dark Rock Pro 4	7	\N
5029	Be Quiet! Shadow Rock 3	7	\N
5030	Arctic Freezer 34 eSports DUO	7	\N
5031	Deepcool AK620 Digital	7	\N
5032	Thermalright Le Grand Macho RT	7	\N
5033	Phanteks Polar T6-120	7	\N
5034	Deepcool AK400 Zero Dark Plus	7	\N
5035	ID-COOLING SE-207-XT Black	7	\N
5036	Thermalright Silver Arrow ITX-R	7	\N
5037	Cooler Master Hyper 212 Black Edition	7	\N
5038	Thermaltake ToughAir 510	7	\N
5039	Noctua NH-L9i chromax.black	7	\N
5040	Noctua NH-P1 Passive Cooler	7	\N
5041	Deepcool Gammaxx 400 V2 Blue	7	\N
5042	ID-COOLING SE-225-XT Black	7	\N
5043	Thermalright AXP120-X67 Black	7	\N
5044	Arctic Alpine 17	7	\N
5045	SilverStone Hydrogon D120 ARGB	7	\N
5046	Jonsbo CR1400 ARGB Black	7	\N
5047	Cooler Master MasterAir MA610P RGB	7	\N
5048	Deepcool Assassin IV	7	\N
5049	Thermalright True Spirit 120 Direct	7	\N
1187	PowerColor Red Devil E/OC	2	32004762.00
1214	Zotac GAMING SOLID CORE	2	31749746.00
1223	Sapphire Toxic Extreme Edition	2	52044600.00
4145	Hitachi Deskstar 7K2000	4	1708000.00
4161	MSI SPATIUM M570 FROZR	4	8030000.00
4181	Seagate BarraCuda Pro Compute	4	897000.00
4201	Seagate Constellation	4	144000.00
4275	Seagate ST500LM021	4	430000.00
4295	Seagate Constellation Product Series:ES.3	4	3600000.00
2895	be quiet! Power Zone 2	6	3171000.00
2903	Antec Signature Platinum	6	4251000.00
2915	ASRock Phantom Gaming PG-850G	6	2245000.00
2926	SeaSonic Prime Fanless PX-500	6	1741000.00
2939	SeaSonic PRIME 1300 Gold	6	3332000.00
2954	SHARKOON SilentStorm Cool Zero 650	6	1745000.00
2964	ASRock Steel Legend SL-850GW	6	2004000.00
2985	Cooler Master MWE Gold V2 ATX3.0	6	3229000.00
2999	Asus ROG STRIX 1000G	6	2205000.00
3020	SeaSonic PRIME TX-1600 Noctua Edition	6	7954000.00
3033	Corsair HX1200i (2025)	6	3623000.00
3069	Asus TUF Gaming 750G	6	1845000.00
3077	SeaSonic PRIME TX	6	7792000.00
3096	Silverstone SX700-PT	6	2129000.00
3105	Super Flower LEADEX VII XG	6	2267000.00
3125	Cooler Master XG850 Plus	6	2707000.00
3142	Thermaltake Smart BX1 550	6	826000.00
3174	SeaSonic SS-300TFX Bronze	6	530000.00
3190	Cooler Master MWE Gold 750 V3	6	1757000.00
3205	EVGA SuperNOVA 650 GA	6	1600000.00
3218	FSP Group FSP400-60FGGBA	6	1008000.00
3237	Cooler Master MWE GOLD 750 V2 FULL MODULAR	6	1751000.00
3262	SeaSonic PRIME TX-1600 ATX 3.1	6	8304000.00
3270	Thermaltake Toughpower GF2 ARGB	6	1583000.00
3297	Antec NE1300G M ATX3.0	6	3192000.00
\.


--
-- TOC entry 5278 (class 0 OID 25549)
-- Dependencies: 239
-- Data for Name: cpu_coolers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cpu_coolers (component_id, rpm, noise_level, color, size) FROM stdin;
350	1800	17.9	Black	240
351	2100	29	Black	360
352	2900	17.2	Black	360
353	1500	22	Black	280
354	2200	36.45	Black	360
355	2000	29	White	240
356	2200	36	Black	360
360	2000	22.3	Teal	240
361	2500	36.5	Black	360
363	2100	35.7	Black	280
364	1750	30	White	360
367	2000	27.7	Black	360
370	1800	8	Black	360
371	2100	34	Black	240
373	1850	27	Black	360
374	2050	28.7	Black	240
375	2500	27.2	White	360
376	1800	17.9	White	240
378	2200	36.45	Black	240
379	1800	35.5	Black	360
380	2300	12.8	White	360
382	2000	30.7	Black	420
383	1700	30	Black	280
384	2200	29.1	Black	240
385	2000	11	Black	360
387	1800	17.9	White	360
388	2100	34	Black	360
389	2450	30	Black	360
390	2900	25	Pink	360
391	2000	29	Black	240
394	2200	24.8	Black	360
395	2000	27.7	Black	360
396	2100	34	Black	360
397	2000	29	White	360
398	2000	25.8	Black	120
399	1750	27.2	White	360
408	2500	37.6	Black	360
411	1800	25.8	Blue / White	360
413	1850	27	Black	360
415	2500	37.6	Black	360
416	2150	29	White / Blue	360
417	2000	29.7	Black	240
418	1600	16.8	Black / Silver	280
419	2000	35.13	White	360
420	2500	27.2	White	240
421	1700	29	Black	240
423	1800	29.5	White	420
427	2200	33.5	White	360
428	1700	29	Black	360
429	2200	16.6	Black	120
430	2000	21	Black	120
431	2000	25	Black	360
432	2500	23	Black	240
433	2500	27.2	Black	240
436	2500	37	Black	120
438	2000	21	Black	120
440	2200	29.1	Black	360
441	1500	19.4	Black	280
444	2450	35.4	White	240
445	2500	19.8	Black	360
446	2200	36	White	360
448	1000	18.8	Black	280
449	2150	27	Black	360
450	1800	23.46	Black	240
452	2000	25.8	White	360
454	1500	34.48	Black	280
455	2300	36	Black	240
456	2200	36.45	White	240
457	2400	31.9	White	240
458	2000	28.2	White	360
462	1800	30.8	Pink	360
463	2150	28.1	Black	360
468	2200	36.45	Black	360
470	1800	30.8	Black	240
471	2000	27.2	Black	240
476	1800	25.8	Green	280
477	1800	17.9	Black	240
479	2000	29.9	White	360
480	1700	10	Black	280
486	2000	14.3	Black	240
488	2200	32	Black	360
490	1500	22	White / Black	360
501	1750	27.2	White	240
505	2200	36.45	White	240
509	2800	36	Black	360
512	2000	35.13	White	360
514	1800	17.9	White	240
515	1800	25.8	Black	240
516	2000	34.5	White	280
518	2000	31.5	Black	420
521	2500	37.6	White	360
522	2500	23	Black	360
523	1700	25.47	Black	420
525	2000	21	Black	240
526	2000	37	Black / Silver	280
527	2200	35.1	Black	360
529	2500	28.1	Black	240
531	1700	10	Black	280
532	1700	29	Black	240
533	2400	12	Black	360
539	1550	25.6	White	360
540	2200	24.8	Black	240
546	2300	12.8	Black	360
547	2000	11	Black	360
550	2000	10	Black	240
555	2100	10	White	360
556	1800	34.7	Black	420
557	1700	29	Black	360
559	2100	10	White	240
560	2200	12.1	Black	360
561	2500	37	Black	240
562	1800	17.9	Black	360
566	2100	39.5	White	360
567	1500	34.48	White	280
568	1900	22.5	Black	280
571	2200	33.5	White	240
573	2000	10	Black	360
577	2500	37.6	Black	120
578	2000	25.8	Black	240
583	2000	29.9	White	240
584	2200	12.1	Silver / Black	360
587	1750	30	Black	240
591	1800	17.9	Black	360
594	2500	27.2	Black	360
595	2200	36.45	White	360
599	1750	27.2	Black	240
604	1800	23.46	Black	360
605	2000	34.7	Black	280
606	2500	23	Black	360
609	1800	21	Black	360
610	1500	25.6	Black	120
614	1500	22	Black	240
638	1800	35.5	Black / White	360
640	2500	29.8	Black	360
642	1800	17.9	Black	360
646	1800	34.7	Black	420
651	2150	16.9	Black	240
652	2300	12.8	Black	240
654	1850	5	White	240
655	2250	30.97	White	240
658	1900	22.5	Black	280
661	1800	21	Black	280
662	2000	14.3	Black	360
663	2400	30	Black	240
667	2000	10	Black	360
672	1900	22.5	Black	420
673	1800	8	Black	360
674	2500	34.8	Black	360
677	2800	36	White	360
681	1800	8	White / Black	240
684	2500	37.6	White	240
687	1800	35.2	Black	240
693	2000	21	Black	280
700	2300	36	White	360
704	2000	6	Black	360
706	2200	13.8	White	360
708	1600	14	White / Black	240
709	2000	21	Black	240
713	2200	18	White	360
714	1500	22	Black	280
716	2500	37.6	Black	240
718	1900	22.5	Black	420
719	2000	21	Black	360
722	2100	34	Black	240
723	2500	37.6	Black	360
724	1750	13.3	Silver / Black	420
726	1500	19.4	Black	280
729	1800	6	Black	240
733	3000	32.1	White	360
742	2200	36	Black	360
743	2400	12	White	360
749	2150	17.1	Black	280
5000	1550	25.6	Black	120
5001	1550	25.6	Gray	120
5002	1850	29	Black	120
5003	1500	26.6	Black	120
5004	2000	27	Black	120
5005	1500	26.8	Black	120
5006	1800	22.5	Black	120
5007	1700	30.8	Black	120
5008	1550	25.6	Black	120
5009	2000	31.6	Black	120
5010	2000	28.9	Black	120
5011	1500	25.6	Silver	135
5012	1700	23	Black	120
5013	1750	27	Black	120
5014	1500	28	Black	120
5015	1500	28.6	Silver	120
5016	1850	31.5	Black	120
5017	2500	30	Black	92
5018	1500	25.6	Black	120
5019	1500	27	Black	120
5020	1500	24.6	Black	140
5021	1700	22.6	Gray	120
5022	1800	27	Black	120
5023	1200	26	Black	140
5024	1500	28	Black	120
5025	1200	24.9	Silver	120
5026	1500	25.6	Black	120
5027	2000	29.8	Black	120
5028	1500	24.3	Black	140
5029	1600	24.4	Black	120
5030	2100	28	Black	120
5031	1850	28	Black	120
5032	1300	19	Silver	140
5033	2000	27	Black	120
5034	1850	28	Black	120
5035	1600	35	Black	120
5036	1300	25	Silver	120
5037	2000	30	Black	120
5038	2000	23.6	Black	120
5039	2500	23.6	Black	92
5040	0	0	Silver	0
5041	1500	27.8	Black	120
5042	1800	30	Black	120
5043	1800	26.1	Black	120
5044	2000	22.5	Silver	92
5045	1850	30.5	Black	120
5046	2300	30.5	Black	92
5047	1800	31	Black	120
5048	1700	22.6	Black	140
5049	1500	25	Silver	120
\.


--
-- TOC entry 5277 (class 0 OID 25536)
-- Dependencies: 238
-- Data for Name: cpus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cpus (component_id, core_count, core_clock, boost_clock, microarchitecture, tdp, graphics, socket) FROM stdin;
40	16	4.3	5.7	Zen 5	170	Radeon	AM5
53	8	3.8	5.5	Zen 5	65	Radeon	AM5
92	12	4.4	5.6	Zen 5	120	Radeon	AM5
114	12	4.4	5.5	Zen 5	120	Radeon	AM5
118	8	4.7	5.2	Zen 5	120	Radeon	AM5
127	6	3.8	5.2	Zen 5	65	Radeon	AM5
138	16	4.3	5.7	Zen 5	170	Radeon	AM5
174	6	3.9	5.4	Zen 5	65	Radeon	AM5
1	8	3.6	5.3	Zen 4	65	Radeon	AM5
4	8	4.2	5	Zen 4	120	Radeon	AM5
13	12	4.7	5.6	Zen 4	170	Radeon	AM5
19	16	4.2	5.7	Zen 4	120	Radeon	AM5
21	6	4.7	5.3	Zen 4	105	Radeon	AM5
51	6	4.1	5	Zen 4	65	Radeon 740M	AM5
67	6	4.1	4.7	Zen 4	65	Radeon	AM5
68	12	3.7	5.4	Zen 4	65	Radeon	AM5
71	8	4.2	5.1	Zen 4	65	Radeon 780M	AM5
78	6	4.3	5	Zen 4	65	Radeon 760M	AM5
95	8	4.5	5.4	Zen 4	105	Radeon	AM5
108	16	4.5	5.7	Zen 4	170	Radeon	AM5
161	6	3.8	5.1	Zen 4	65	Radeon	AM5
20	8	3.8	4.6	Zen 3	65	Radeon Vega 8	AM4
44	6	3.6	4.4	Zen 3	65	Radeon Vega 7	AM4
93	6	3.9	4.4	Zen 3	65	Radeon Vega 7	AM4
135	6	3.6	4.6	Zen 3	65	Radeon Vega 7	AM4
98	4	3.7	4.2	Zen+	65	Radeon Vega 11	AM4
152	4	3.6	4	Zen+	65	Radeon Vega 8	AM4
28	4	3.6	3.9	Zen	65	Radeon Vega 11	AM4
26	14	3.4	5	Arrow Lake	65	Intel Xe	LGA1851
27	14	4.2	5.2	Arrow Lake	125	Intel Xe	LGA1851
32	20	3.9	5.5	Arrow Lake	125	Intel Xe	LGA1851
58	20	2.4	5.3	Arrow Lake	65	Intel Xe	LGA1851
80	24	3.7	5.7	Arrow Lake	125	Intel Xe	LGA1851
121	24	2.5	5.6	Arrow Lake	65	Intel Xe	LGA1851
144	10	3.3	4.9	Arrow Lake	65	Intel Xe	LGA1851
11	24	3.2	6.2	Raptor Lake Refresh	150	Intel UHD Graphics 770	LGA1700
36	10	2.5	4.7	Raptor Lake Refresh	65	Intel UHD Graphics 730	LGA1700
43	4	3.5	4.7	Raptor Lake Refresh	60	Intel UHD Graphics 730	LGA1700
54	14	3.5	5.3	Raptor Lake Refresh	125	Intel UHD Graphics 770	LGA1700
73	20	2.1	5.4	Raptor Lake Refresh	65	Intel UHD Graphics 770	LGA1700
76	24	2	5.8	Raptor Lake Refresh	65	Intel UHD Graphics 770	LGA1700
119	20	3.4	5.6	Raptor Lake Refresh	125	Intel UHD Graphics 770	LGA1700
129	14	2.6	5	Raptor Lake Refresh	65	Intel UHD Graphics 770	LGA1700
136	24	3.2	6	Raptor Lake Refresh	125	Intel UHD Graphics 770	LGA1700
7	24	3	5.8	Raptor Lake	125	Intel UHD Graphics 770	LGA1700
86	16	3.4	5.4	Raptor Lake	125	Intel UHD Graphics 770	LGA1700
97	4	3.4	4.5	Raptor Lake	60	Intel UHD Graphics 730	LGA1700
106	14	2.5	4.8	Raptor Lake	65	Intel UHD Graphics 770	LGA1700
115	24	2	5.6	Raptor Lake	65	Intel UHD Graphics 770	LGA1700
128	10	2.5	4.6	Raptor Lake	65	Intel UHD Graphics 730	LGA1700
142	16	2.1	5.2	Raptor Lake	65	Intel UHD Graphics 770	LGA1700
147	24	3	6	Raptor Lake	150	Intel UHD Graphics 770	LGA1700
168	14	3.5	5.1	Raptor Lake	125	Intel UHD Graphics 770	LGA1700
10	16	2.4	5.1	Alder Lake	65	Intel UHD Graphics 770	LGA1700
74	10	3.7	4.9	Alder Lake	125	Intel UHD Graphics 770	LGA1700
105	4	3.3	4.3	Alder Lake	60	Intel UHD Graphics 730	LGA1700
154	6	3.3	4.8	Alder Lake	65	Intel UHD Graphics 770	LGA1700
157	12	3.6	5	Alder Lake	125	Intel UHD Graphics 770	LGA1700
160	12	2.1	4.9	Alder Lake	65	Intel UHD Graphics 770	LGA1700
169	16	3.2	5.2	Alder Lake	125	Intel UHD Graphics 770	LGA1700
172	16	3.4	5.5	Alder Lake	150	Intel UHD Graphics 770	LGA1700
173	6	2.5	4.4	Alder Lake	65	Intel UHD Graphics 730	LGA1700
112	8	2.5	5.2	Rocket Lake	65	Intel UHD Graphics 750	LGA1200
37	4	3.8	4.7	Coffee Lake	71	Intel HD Graphics P630	LGA1151
49	6	3.7	4.7	Coffee Lake	80	Intel HD Graphics P630	LGA1151
124	4	3.7	4.1	Kaby Lake	73	Intel HD Graphics P630	LGA1151
\.


--
-- TOC entry 5286 (class 0 OID 25637)
-- Dependencies: 247
-- Data for Name: dealers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dealers (id, name, website, logo_url) FROM stdin;
1	PCPartPicker (US)	\N	\N
2	Newegg	https://www.newegg.com	\N
\.


--
-- TOC entry 5272 (class 0 OID 25494)
-- Dependencies: 233
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- TOC entry 5282 (class 0 OID 25597)
-- Dependencies: 243
-- Data for Name: internal_hard_drives; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.internal_hard_drives (component_id, capacity, price_per_gb, type, cache, form_factor, interface) FROM stdin;
3805	10000	0.024	7200	256	3.5	SATA 6.0 Gb/s
3806	320	0.091	7200	16	2.5	SATA 3.0 Gb/s
3807	8000	0.027	7200	256	3.5	SATA 6.0 Gb/s
3808	6000	0.04	7200	256	3.5	SATA 6.0 Gb/s
3809	4000	0.037	7200	128	3.5	SATA 6.0 Gb/s
3810	18000	0.021	7200	512	3.5	SATA 6.0 Gb/s
3812	1000	0.049	5400	128	2.5	SATA 6.0 Gb/s
3813	2000	0.073	7200	128	2.5	SATA 6.0 Gb/s
3814	1000	0.099	7200	32	3.5	SATA 6.0 Gb/s
3815	8000	0.031	7200	256	3.5	SATA 6.0 Gb/s
3816	10000	0.027	7200	256	3.5	SATA 6.0 Gb/s
3817	4000	0.036	5900	64	3.5	SATA 6.0 Gb/s
3818	500	0.09	7200	16	2.5	SATA 3.0 Gb/s
3821	2000	0.093	7200	256	3.5	SATA 6.0 Gb/s
3823	320	0.044	5400	8	2.5	SATA 3.0 Gb/s
3824	1000	0.093	SSD	1024	2.5	SATA 6.0 Gb/s
3825	1000	0.092	SSD	1024	M.2-2280	M.2 PCIe 4.0 X4
3826	1000	0.029	5400	8	2.5	SATA 3.0 Gb/s
3827	1000	0.045	5400	64	3.5	SATA 6.0 Gb/s
3832	10000	0.023	7200	256	3.5	SATA 6.0 Gb/s
3833	6000	0.028	5400	256	3.5	SATA 6.0 Gb/s
3834	300	0.284	10000	128	2.5	SAS 12.0 Gb/s
3837	80	1.113	5400	8	2.5	SATA 1.5 Gb/s
3838	6000	0.026	5400	64	3.5	SATA 6.0 Gb/s
3839	4000	0.045	7200	128	3.5	SAS 6.0 Gb/s
3840	3000	0.05	5400	64	3.5	SATA 3.0 Gb/s
3841	3000	0.016	7200	64	3.5	SAS 6.0 Gb/s
3842	16000	0.019	7200	256	3.5	SATA 6.0 Gb/s
3843	1000	0.15	SSD	2048	M.2-2280	M.2 PCIe 4.0 X4
3847	1000	0.216	SSD	1024	M.2-2280	M.2 SATA
3848	1000	0.058	7200	32	3.5	SATA 3.0 Gb/s
3849	12000	0.024	7200	512	3.5	SATA 6.0 Gb/s
3850	24000	0.02	7200	512	3.5	SATA 6.0 Gb/s
3851	750	0.083	5400	8	2.5	SATA 3.0 Gb/s
3857	3000	0.035	5400	64	3.5	SATA 6.0 Gb/s
3859	14000	0.024	7200	512	3.5	SATA 6.0 Gb/s
3860	4000	0.032	7200	256	3.5	SATA 6.0 Gb/s
3863	1000	0.035	5400	64	3.5	SATA 6.0 Gb/s
3864	4000	0.019	7200	128	3.5	SATA 6.0 Gb/s
3865	4000	0.231	SSD	4096	2.5	SATA 6.0 Gb/s
3867	6000	0.033	7200	256	3.5	SATA 6.0 Gb/s
3868	3000	0.03	7200	256	3.5	SATA 6.0 Gb/s
3870	20000	0.017	7200	512	3.5	SATA 6.0 Gb/s
3871	512	0.103	SSD	512	M.2-2280	M.2 PCIe 4.0 X4
3872	6000	0.046	7200	128	3.5	SATA 6.0 Gb/s
3873	6000	0.025	7200	128	3.5	SATA 6.0 Gb/s
3874	6000	0.04	5400	64	3.5	SATA 6.0 Gb/s
3875	12000	0.022	7200	512	3.5	SATA 6.0 Gb/s
3879	500	0.137	7200	64	3.5	SATA 6.0 Gb/s
3880	4000	0.032	7200	256	3.5	SATA 6.0 Gb/s
3881	6000	0.076	7200	128	3.5	SATA 6.0 Gb/s
3886	8000	0.036	7200	256	3.5	SATA 6.0 Gb/s
3887	2000	0.053	5400	128	3.5	SATA 6.0 Gb/s
3888	1000	0.085	7200	32	2.5	SATA 6.0 Gb/s
3892	1000	0.128	7200	32	3.5	SATA 3.0 Gb/s
3895	1000	0.15	SSD	1024	2.5	SATA 6.0 Gb/s
3897	750	0.149	7200	32	3.5	SATA 3.0 Gb/s
3900	2000	0.076	7200	64	3.5	SATA 6.0 Gb/s
3902	6000	0.159	7200	128	3.5	SAS 12.0 Gb/s
3904	500	0.14	5400	8	2.5	SATA 3.0 Gb/s
3905	5000	0.029	7200	128	3.5	SATA 6.0 Gb/s
3908	3000	0.041	5400	32	3.5	SATA 6.0 Gb/s
3910	80	0.738	5400	8	2.5	PATA 44-Pin 100
3918	2000	0.076	7200	64	3.5	SATA 6.0 Gb/s
3919	2000	0.06	SSD	2048	M.2-2280	M.2 PCIe 4.0 X4
3921	4000	0.019	5400	256	3.5	SATA 6.0 Gb/s
3923	1000	0.103	7200	128	3.5	SATA 6.0 Gb/s
3931	750	0.124	7200	32	2.5	SATA 6.0 Gb/s
3935	2000	0.035	5400	256	3.5	SATA 6.0 Gb/s
3936	22000	0.022	7200	512	3.5	SATA 6.0 Gb/s
3937	5000	0.028	5900	128	3.5	SATA 6.0 Gb/s
3938	2000	0.117	SSD	2048	M.2-2280	M.2 PCIe 4.0 X4
3942	4000	0.107	SSD	4096	M.2-2280	M.2 PCIe 5.0 X4
3946	4000	0.044	7200	256	3.5	SATA 6.0 Gb/s
3949	12000	0.026	7200	256	3.5	SATA 6.0 Gb/s
3953	320	0.103	5400	8	2.5	SATA 3.0 Gb/s
3954	6000	0.027	7200	128	3.5	SAS 12.0 Gb/s
3956	250	0.352	SSD	512	M.2-2280	M.2 PCIe 3.0 X4
3959	10000	0.101	7200	256	3.5	SAS 12.0 Gb/s
3961	1500	0.163	5900	64	3.5	SATA 6.0 Gb/s
3962	8000	0.035	7200	256	3.5	SATA 6.0 Gb/s
3966	1000	0.064	5400	128	2.5	SATA 6.0 Gb/s
3969	1000	0.05	7200	64	2.5	SAS 6.0 Gb/s
3972	2000	0.15	SSD	2048	2.5	SATA 6.0 Gb/s
3976	500	0.157	10000	64	3.5	SATA 6.0 Gb/s
3980	1000	0.058	7200	128	2.5	SATA 6.0 Gb/s
3983	500	0.208	SSD	1024	M.2-2280	M.2 PCIe 4.0 X4
3986	160	0.438	7200	8	3.5	SATA 6.0 Gb/s
3988	4000	0.075	SSD	4096	M.2-2280	M.2 PCIe 4.0 X4
3990	18000	0.026	7200	512	3.5	SATA 6.0 Gb/s
3994	1000	0.14	SSD	1024	M.2-2280	M.2 PCIe 4.0 X4
3997	10000	0.028	7200	256	3.5	SATA 6.0 Gb/s
4006	2000	0.085	SSD	1024	M.2-2280	M.2 PCIe 4.0 X4
4015	1000	0.05	7200	64	2.5	SATA 6.0 Gb/s
4016	10000	0.024	7200	256	3.5	SATA 6.0 Gb/s
4018	18000	0.021	7200	256	3.5	SATA 6.0 Gb/s
4021	4000	0.029	7200	128	3.5	SAS 12.0 Gb/s
4023	10000	0.036	7200	512	3.5	SATA 6.0 Gb/s
4026	4000	0.079	SSD	4096	M.2-2280	M.2 PCIe 4.0 X4
4031	1000	0.146	SSD	1024	M.2-2280	M.2 PCIe 3.0 X4
4032	6000	0.026	5400	64	3.5	SATA 6.0 Gb/s
4033	4000	0.039	5400	128	2.5	SATA 6.0 Gb/s
4038	500	0.094	5400	128	2.5	SATA 6.0 Gb/s
4041	2000	0.038	5900	64	3.5	SATA 6.0 Gb/s
4046	1000	0.044	5400	128	2.5	SATA 6.0 Gb/s
4054	6000	0.025	7200	128	3.5	SATA 6.0 Gb/s
4076	1000	0.135	5900	32	3.5	SATA 3.0 Gb/s
4079	1000	0.088	7200	32	3.5	SATA 3.0 Gb/s
4081	3000	0.049	7200	64	3.5	SATA 6.0 Gb/s
4083	16000	0.024	7200	256	3.5	SATA 6.0 Gb/s
4091	2000	0.068	7200	128	2.5	SAS 12.0 Gb/s
4094	2000	0.345	SSD	2048	M.2-2280	M.2 PCIe 3.0 X4
4100	22000	0.02	7200	512	3.5	SATA 6.0 Gb/s
4104	1000	0.049	5400	8	2.5	SATA 3.0 Gb/s
4110	640	0.422	5400	8	2.5	SATA 3.0 Gb/s
4116	2000	0.118	7200	128	3.5	SATA 6.0 Gb/s
4134	500	0.058	7200	32	3.5	SATA 3.0 Gb/s
4145	2000	0.036	7200	32	3.5	SATA 3.0 Gb/s
4147	500	0.101	7200	16	3.5	SATA 3.0 Gb/s
4149	250	0.126	7200	16	2.5	SATA 3.0 Gb/s
4150	1000	0.134	SSD	1024	M.2-2280	M.2 PCIe 3.0 X4
4153	250	0.38	5400	16	2.5	SATA 3.0 Gb/s
4161	2000	0.12	SSD	4096	M.2-2280	M.2 PCIe 5.0 X4
4162	2000	0.05	5400	64	3.5	SATA 6.0 Gb/s
4171	10000	0.027	7200	256	3.5	SATA 6.0 Gb/s
4172	10000	0.02	7200	256	3.5	SAS 12.0 Gb/s
4177	14000	0.016	7200	512	3.5	SATA 6.0 Gb/s
4180	500	0.18	5900	16	3.5	SATA 3.0 Gb/s
4181	1000	0.065	7200	128	2.5	SATA 6.0 Gb/s
4182	320	0.127	7200	16	2.5	SATA 3.0 Gb/s
4184	250	0.224	7200	16	2.5	SATA 3.0 Gb/s
4185	18000	0.022	7200	512	3.5	SATA 6.0 Gb/s
4189	4000	0.028	7200	128	3.5	SATA 6.0 Gb/s
4191	600	0.068	10500	64	2.5	SAS 6.0 Gb/s
4193	12000	0.021	7200	256	3.5	SATA 6.0 Gb/s
4197	1000	0.4	SSD	1024	M.2-2280	M.2 PCIe 3.0 X4
4201	160	0.947	7200	32	2.5	SATA 3.0 Gb/s
4231	1000	0.17	SSD	1024	M.2-2280	M.2 PCIe 5.0 X4
4247	500	0.3	7200	32	2.5	SATA 6.0 Gb/s
4248	6000	0.037	7200	128	3.5	SAS 12.0 Gb/s
4256	512	0.133	SSD	512	M.2-2280	M.2 PCIe 3.0 X4
4272	8000	0.033	7200	256	3.5	SATA 6.0 Gb/s
4275	500	0.04	7200	32	2.5	SATA 6.0 Gb/s
4276	1000	0.166	SSD	2048	M.2-2280	M.2 PCIe 5.0 X4
4278	16000	0.019	7200	512	3.5	SATA 6.0 Gb/s
4286	12000	0.025	7200	256	3.5	SATA 6.0 Gb/s
4295	4000	0.05	7200	128	3.5	SAS 6.0 Gb/s
4300	6000	0.063	7200	128	3.5	SATA 6.0 Gb/s
\.


--
-- TOC entry 5270 (class 0 OID 25479)
-- Dependencies: 231
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- TOC entry 5269 (class 0 OID 25464)
-- Dependencies: 230
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- TOC entry 5280 (class 0 OID 25573)
-- Dependencies: 241
-- Data for Name: memory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.memory (component_id, speed, module_count, module_size, price_per_gb, color, first_word_latency, cas_latency, capacity, ddr_gen) FROM stdin;
4739	6000	2	16	2.968	Black	12	36	32	5
4740	6000	2	16	2.812	Black	12	36	32	5
4741	3200	2	8	2.874	Black / Yellow	10	16	16	4
4742	6000	2	16	4.062	Black / Gray	10	30	32	5
4743	6000	2	16	3.093	Black	10	30	32	5
4744	3600	2	16	2.437	Black / Yellow	10	18	32	4
4745	6000	2	16	2.656	Black	12	36	32	5
4746	6400	2	32	3.672	Black / Silver	10	32	64	5
4747	6000	2	32	3.594	Black	10	30	64	5
4748	6000	2	16	3.312	White	10	30	32	5
4749	6000	2	16	3.75	Black	10	30	32	5
4750	6000	2	16	2.687	Black / White	10	30	32	5
4751	3600	2	16	3.594	Black	10	18	32	4
4754	3200	2	8	2.061	Black / Gray	10	16	16	4
4755	3200	2	8	2.437	Black	10	16	16	4
4757	6000	2	16	3.843	Black	10	30	32	5
4758	6000	2	32	3.25	Black / Silver	10	30	64	5
4759	3200	2	16	2.249	Black	10	16	32	4
4762	5200	2	8	3.933	Black	15.385	40	16	5
4763	3200	2	8	3.437	Black	10	16	16	4
4764	6000	2	16	2.843	Black	10	30	32	5
4765	5200	2	32	2.442	Black	15.385	40	64	5
4766	6000	2	32	3.031	Black	10	30	64	5
4767	6000	2	16	3.031	Black	10	30	32	5
4768	3200	2	16	1.906	Black	10	16	32	4
4771	6600	2	32	4.476	White	9.697	32	64	5
4772	3200	4	16	21.123	Black	8.75	14	64	4
4776	3600	2	16	2.593	Black	10	18	32	4
4778	3200	2	8	2.874	Black	10	16	16	4
4779	5600	2	8	2.749	Black	16.429	46	16	5
4782	6000	2	16	3.437	Black	10	30	32	5
4783	3200	2	32	2.422	Black / Yellow	10	16	64	4
4784	5600	2	16	2.593	Black	16.429	46	32	5
4785	6000	2	16	4.218	Black	10	30	32	5
4788	6000	2	32	2.469	Black	10	30	64	5
4789	5600	2	32	2.187	Black	16.429	46	64	5
4794	3600	2	8	3.187	White	10	18	16	4
4796	6000	2	32	3.656	Black	10	30	64	5
4797	8400	2	24	5.416	Black	9.524	40	48	5
4798	6400	2	32	2.969	Black / White	10	32	64	5
4799	6400	2	16	3.656	Black	10	32	32	5
4801	3200	2	8	1.999	Black	10	16	16	4
4802	6000	2	16	5.656	White	10	30	32	5
4803	3200	2	16	1.875	Silver / Black	10	16	32	4
4805	5200	2	8	4.061	Black	15.385	40	16	5
4806	6000	2	32	2.422	Black	12	36	64	5
4807	5600	2	64	2.344	Black	16.429	46	128	5
4812	5600	4	32	4.312	Black	14.286	40	128	5
4813	3600	2	16	3.437	White / Black	10	18	32	4
4817	5600	2	16	2.343	Black	16.429	46	32	5
4819	6000	2	16	3.218	White	10	30	32	5
4820	6000	2	32	2.89	White	12.667	38	64	5
4822	6400	2	16	4.843	White	9.375	30	32	5
4825	3200	2	16	2.063	Gray	10	16	32	4
4828	3600	2	8	3.437	Black	10	18	16	4
4830	6400	2	64	2.914	Black	13.125	42	128	5
4831	5200	2	8	4.249	Black / Gray	15.385	40	16	5
4832	4800	2	8	2.624	Black	16.667	40	16	5
4833	6000	2	32	3.203	Black / Silver	10	30	64	5
4837	6000	2	16	2.968	Black	12	36	32	5
4839	3200	1	8	3.736	Black	10	16	8	4
4846	5200	2	8	3.312	Black / White	13.846	36	16	5
4847	6400	2	32	4.062	Silver	10	32	64	5
4853	4800	2	16	2.249	Black	16.667	40	32	5
4854	4800	2	16	2.312	Black	16.667	40	32	5
4857	6400	2	32	3.125	Black	12.5	40	64	5
4861	2400	1	8	4.624	Black / Yellow	13.333	16	8	4
4864	3200	2	8	3.534	Green	13.75	22	16	4
4866	2400	1	8	2.498	Green	14.167	17	8	4
4867	3200	2	16	1.875	White	10	16	32	4
4868	6000	2	32	3.828	Black	10	30	64	5
4873	6000	2	16	3.656	Black	10	30	32	5
4874	3200	2	8	2.812	Red / Black	10	16	16	4
4875	3600	2	16	1.875	Black	10	18	32	4
4876	2666	2	8	1.812	Black	14.254	19	16	4
4884	3200	2	8	2.123	Blue	10	16	16	4
4886	4800	1	16	2.429	Black	16.667	40	16	5
4889	6000	2	16	2.656	White	10.667	32	32	5
4891	6000	2	8	4.749	Black	12	36	16	5
4896	8200	2	16	4.218	Black	9.268	38	32	5
4899	3600	2	16	3.125	Black / Silver	8.889	16	32	4
4901	6000	2	16	2.843	Black / Silver	10	30	32	5
4902	5600	4	32	3.148	White	14.286	40	128	5
4903	6000	2	24	3.75	Black / Gray	10	30	48	5
4910	3200	2	8	2.498	\N	13.75	22	16	4
4916	3200	2	16	2.187	Red / Black	10	16	32	4
4922	6000	2	32	2.765	Black	11.333	34	64	5
4934	2400	1	4	2.498	Green / Black	14.167	17	4	4
4935	8400	2	24	5.833	Silver	9.524	40	48	5
\.


--
-- TOC entry 5261 (class 0 OID 25396)
-- Dependencies: 222
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2024_01_01_000001_create_component_types_table	1
5	2024_01_01_000002_create_components_table	1
6	2024_01_01_000003_create_cpus_table	1
7	2024_01_01_000004_create_cpu_coolers_table	1
8	2024_01_01_000005_create_motherboards_table	1
9	2024_01_01_000006_create_memory_table	1
10	2024_01_01_000007_create_video_cards_table	1
11	2024_01_01_000008_create_internal_hard_drives_table	1
12	2024_01_01_000009_create_cases_table	1
13	2024_01_01_000010_create_power_supplies_table	1
14	2024_01_01_000011_create_dealers_table	1
15	2024_01_01_000012_create_component_prices_table	1
16	2024_01_01_000013_create_compatibility_rules_table	1
17	2024_01_01_000014_create_usage_profiles_table	1
18	2024_01_01_000015_create_pc_builds_table	1
19	2024_01_01_000016_create_build_components_table	1
20	2024_01_01_000017_create_posts_table	1
21	2024_01_01_000018_create_votes_table	1
22	2026_04_11_043027_add_role_to_users_table	2
23	2026_04_12_043652_create_comments_table	3
24	2026_06_15_093513_add_tdp_to_video_cards	4
\.


--
-- TOC entry 5279 (class 0 OID 25560)
-- Dependencies: 240
-- Data for Name: motherboards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.motherboards (component_id, socket, form_factor, max_memory, memory_slots, color, ddr_gen) FROM stdin;
4427	sTRX4	XL ATX	256	8	Black / Silver	\N
4339	AM5	ATX	192	4	Black / Silver	5
4340	AM5	ATX	192	4	Black	5
4341	AM5	ATX	256	4	Black	5
4342	AM5	ATX	256	4	Black	5
4344	AM5	ATX	192	4	Gray / Black	5
4345	AM5	ATX	192	4	Black / Silver	5
4346	AM5	Micro ATX	256	4	Black / Silver	5
4347	AM5	ATX	256	4	Black	5
4349	AM5	ATX	256	4	White	5
4350	AM5	ATX	192	4	Black	5
4352	AM5	Mini ITX	128	2	Black	5
4356	AM5	ATX	128	4	Black	5
4357	AM5	ATX	256	4	Black	5
4358	AM5	ATX	256	4	White	5
4360	AM5	ATX	192	4	Black	5
4361	AM5	Micro ATX	128	2	Black / White	5
4362	AM5	ATX	256	4	Gray / Black	5
4363	AM5	ATX	256	4	Black / Green	5
4365	AM5	ATX	192	4	Black / Silver	5
4366	AM5	Micro ATX	192	4	Silver / Black	5
4368	AM5	ATX	256	4	Black	5
4369	AM5	ATX	192	4	Gray / Black	5
4370	AM5	ATX	192	4	White	5
4371	AM5	Mini ITX	96	2	Black	5
4373	AM5	ATX	192	4	Black / Orange	5
4376	AM5	Micro ATX	192	4	Black / Silver	5
4378	AM5	Micro ATX	192	4	Black	5
4380	AM5	ATX	256	4	White / Silver	5
4383	AM5	Micro ATX	256	4	Black	5
4384	AM5	ATX	192	4	Black	5
4387	AM5	Micro ATX	256	4	Black	5
4388	AM5	Micro ATX	256	4	Silver / Black	5
4391	AM5	Micro ATX	192	4	Black	5
4392	AM5	ATX	192	4	Black	5
4393	AM5	ATX	192	4	White	5
4395	AM5	ATX	192	4	Black	5
4396	AM5	Mini ITX	96	2	Black	5
4397	AM5	Mini ITX	96	2	Black	5
4398	AM5	ATX	256	4	Black	5
4399	AM5	ATX	256	4	Black / Gray	5
4400	AM5	ATX	256	4	Silver / Black	5
4401	AM5	ATX	192	4	Black	5
4404	AM5	EATX	256	4	Black / Silver	5
4405	AM5	Micro ATX	256	4	Silver / Black	5
4407	AM5	ATX	256	4	White	5
4408	AM5	ATX	192	4	Black / Silver	5
4409	AM5	Mini ITX	96	2	Black / Gray	5
4410	AM5	Mini ITX	128	2	White	5
4411	AM5	Micro ATX	192	4	Silver / Black	5
4412	AM5	ATX	192	4	Black	5
4413	AM5	ATX	256	4	White	5
4414	AM5	Micro ATX	96	2	Black	5
4415	AM5	ATX	256	4	Black / Silver	5
4416	AM5	ATX	256	4	Gray / Black	5
4418	AM5	Micro ATX	96	2	Silver / Black	5
4420	AM5	ATX	256	4	Black / Green	5
4423	AM5	EATX	256	4	Black	5
4424	AM5	ATX	256	4	White	5
4425	AM5	Micro ATX	256	4	White / Silver	5
4430	AM5	ATX	256	4	Black	5
4432	AM5	ATX	256	4	Black / Gray	5
4433	AM5	Micro ATX	96	2	Gray / Black	5
4434	LGA1851	ATX	256	4	Black / Yellow	5
4435	AM5	ATX	256	4	Black / Gold	5
4436	AM5	ATX	256	4	Black	5
4440	AM5	Micro ATX	192	4	Black / Gray	5
4441	AM5	Micro ATX	192	4	Black / Silver	5
4442	AM5	Mini ITX	96	2	Black	5
4443	AM5	EATX	256	4	Black	5
4444	AM5	ATX	256	4	Silver / White	5
4446	AM5	ATX	256	4	Black / Silver	5
4447	AM5	ATX	256	4	Silver / Black	5
4449	AM5	ATX	256	4	Black	5
4450	AM5	ATX	256	4	Silver / Black	5
4451	AM5	Micro ATX	256	4	Black / Silver	5
4455	AM5	ATX	192	4	Silver	5
4456	AM5	ATX	192	4	Silver / Black	5
4457	AM5	ATX	192	4	Black / Silver	5
4458	AM5	Mini ITX	128	2	Black	5
4462	AM5	Micro ATX	256	4	Silver / Black	5
4463	AM5	Micro ATX	192	4	Black	5
4468	AM5	ATX	192	4	Black / Gray	5
4469	AM5	ATX	256	4	Black / White	5
4474	AM5	Mini ITX	128	2	\N	5
4477	AM5	Micro ATX	256	4	Black / Green	5
4479	AM5	ATX	256	4	White / Black	5
4480	AM5	Mini ITX	128	2	Black / Silver	5
4483	LGA1851	Mini ITX	128	2	Black / Silver	5
4487	AM5	ATX	256	4	Black	5
4489	AM5	Mini ITX	128	2	Silver	5
4490	AM5	ATX	256	4	Black / Silver	5
4491	AM5	ATX	192	4	Silver / White	5
4492	AM5	ATX	256	4	Silver	5
4494	AM5	ATX	256	4	Black	5
4495	AM5	ATX	256	4	Black / Silver	5
4497	AM5	ATX	256	4	Black	5
4498	AM5	Micro ATX	192	4	Black	5
4500	AM5	ATX	256	4	Black / Silver	5
4502	AM5	ATX	192	4	Black / Silver	5
4503	AM5	Micro ATX	192	4	Black	5
4506	AM5	Micro ATX	256	4	Black	5
4509	AM5	Micro ATX	192	4	Silver	5
4513	AM5	ATX	192	4	Black	5
4514	AM5	Micro ATX	96	2	Silver / Black	5
4515	AM5	ATX	256	4	White	5
4519	AM5	Mini ITX	96	2	Black / Silver	5
4520	AM5	Micro ATX	96	2	Gray / Black	5
4521	LGA1851	ATX	256	4	Silver / Black	5
4523	AM5	ATX	192	4	Black	5
4525	AM5	ATX	192	4	Silver / Black	5
4530	AM5	Micro ATX	256	4	Silver / Black	5
4535	LGA1851	ATX	256	4	Black / Silver	5
4536	AM5	ATX	256	4	Black / Silver	5
4537	AM5	Micro ATX	128	2	Black / White	5
4343	AM4	Micro ATX	128	4	Blue / Silver	4
4348	AM4	Micro ATX	64	2	Brown / Black	4
4351	AM4	Micro ATX	128	4	Brown / Silver	4
4353	LGA1700	ATX	192	4	Black / Silver	4
4354	AM4	Micro ATX	128	4	Black	4
4355	LGA1700	ATX	192	4	Silver / Black	4
4359	AM4	Micro ATX	128	4	Black	4
4364	LGA1700	Micro ATX	128	4	Black / Silver	4
4367	AM4	ATX	128	4	Silver / Black	4
4372	AM4	ATX	128	4	Black / Gray	4
4374	LGA1700	ATX	192	4	Gray / Black	4
4375	AM4	Micro ATX	64	2	Black	4
4377	AM4	Micro ATX	128	4	Black / Silver	4
4379	AM4	Micro ATX	64	2	Black / White	4
4381	LGA1700	Micro ATX	128	4	Black	4
4382	AM4	ATX	128	4	Black / Red	4
4385	AM4	Mini ITX	64	2	Black	4
4386	AM4	Micro ATX	128	4	Black / Silver	4
4389	AM4	ATX	128	4	Black	4
4390	AM4	Micro ATX	64	2	Black	4
4394	AM4	Micro ATX	128	4	Silver / Black	4
4402	LGA1700	ATX	192	4	Black	4
4403	AM4	ATX	128	4	Black / Silver	4
4406	LGA1700	ATX	192	4	Black / Gray	4
4417	AM4	ATX	128	4	Black	4
4419	LGA1700	ATX	192	4	Silver / Black	4
4421	AM4	ATX	128	4	Black	4
4422	LGA1700	Micro ATX	64	2	Black / Silver	4
4426	LGA1700	Micro ATX	96	2	White / Black	4
4428	AM4	Micro ATX	64	2	Black / Silver	4
4429	AM4	ATX	128	4	Silver / Black	4
4431	LGA1700	Mini ITX	96	2	Black	4
4437	AM4	ATX	128	4	Black / Silver	4
4438	LGA1700	ATX	192	4	Black	4
4439	AM4	ATX	128	4	Brown / Black	4
4448	LGA1700	Micro ATX	192	4	Black	4
4452	AM4	Micro ATX	128	4	Black / Orange	4
4453	LGA1700	Micro ATX	192	4	Black	4
4459	LGA1700	ATX	192	4	Black / Silver	4
4460	LGA1700	ATX	192	4	Black / Silver	4
4464	LGA1700	Micro ATX	192	4	Black / Silver	4
4465	AM4	Micro ATX	128	4	Black	4
4467	LGA1700	ATX	128	4	Black	4
4470	LGA1700	ATX	192	4	Black	4
4471	LGA1700	ATX	192	4	Silver / Black	4
4472	AM4	Micro ATX	64	2	Black	4
4473	AM4	Micro ATX	128	4	\N	4
4475	AM4	Micro ATX	128	4	Gray / Brown	4
4476	AM4	ATX	128	4	Black	4
4478	AM4	ATX	128	4	Black / Silver	4
4481	LGA1700	ATX	192	4	Black	4
4482	AM4	Mini ITX	64	2	Black / Silver	4
4485	AM4	ATX	128	4	Black / White	4
4488	LGA1700	ATX	192	4	Black	4
4493	AM4	Mini ITX	64	2	Silver / Black	4
4501	AM4	ATX	128	4	Silver / Black	4
4505	LGA1700	ATX	192	4	White	4
4507	LGA1700	Micro ATX	128	4	Black	4
4508	LGA1700	Micro ATX	192	4	Black / Orange	4
4510	LGA1700	Mini ITX	64	2	Silver / Black	4
4511	LGA1700	Micro ATX	128	4	Silver / Black	4
4512	AM4	Micro ATX	128	4	Black / Gold	4
4516	LGA1700	ATX	192	4	Black	4
4517	LGA1700	ATX	192	4	Black	4
4518	LGA1700	Micro ATX	64	2	Silver / Black	4
4522	AM4	ATX	128	4	Black	4
4524	AM4	Micro ATX	128	4	Black / Silver	4
4527	AM4	Micro ATX	128	4	Black / Gray	4
4528	AM4	Micro ATX	128	4	Gray / Black	4
4532	LGA1200	Micro ATX	64	2	Black / Silver	4
4533	AM4	ATX	128	4	Black	4
4534	AM4	Micro ATX	64	2	Black	4
4538	AM4	Micro ATX	128	4	Black / Orange	4
\.


--
-- TOC entry 5264 (class 0 OID 25420)
-- Dependencies: 225
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- TOC entry 5292 (class 0 OID 25707)
-- Dependencies: 253
-- Data for Name: pc_builds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pc_builds (id, user_id, build_name, total_price, usage_profile_id, created_at, updated_at) FROM stdin;
2	1	Cấu hình #1	10968000.00	\N	2026-06-05 09:54:40	2026-06-05 09:56:56
3	1	Cấu hình #2	1789000.00	\N	2026-06-05 09:57:57	2026-06-05 09:57:57
4	1	Cấu hình #1	4429000.00	\N	2026-06-05 10:21:46	2026-06-05 10:21:46
5	1	Cấu hình #1	4429000.00	\N	2026-06-05 10:40:25	2026-06-05 10:40:25
7	1	Cấu hình #1	4429000.00	\N	2026-06-05 10:46:49	2026-06-05 10:46:49
1	1	Cấu hình #1	4429000.00	\N	2026-06-05 09:54:07	2026-06-05 11:02:52
\.


--
-- TOC entry 5296 (class 0 OID 25748)
-- Dependencies: 257
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (id, user_id, title, content, post_type, build_id, created_at, updated_at) FROM stdin;
1	1	Xin chào	Đây là bài viết đầu tiên	discussion	\N	2026-04-12 04:17:54	2026-04-12 04:17:54
3	5	[HN] Xin tư vấn cấu hình 25 triệu phục vụ CAD 2D/3D và Revit	Em có ngân sách khoảng 25 triệu, chưa gồm màn hình. Nhu cầu CAD 2D, CAD 3D, Revit và làm việc lâu dài. Mong các bác tư vấn giúp.	discussion	\N	2026-06-05 16:51:40	2026-06-05 16:51:40
\.


--
-- TOC entry 5284 (class 0 OID 25623)
-- Dependencies: 245
-- Data for Name: power_supplies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.power_supplies (component_id, type, efficiency, wattage, modular, color) FROM stdin;
2849	ATX	gold	750	t	Black / Blue
2851	ATX	bronze	650	f	Black
2852	ATX	gold	750	t	Black
2853	SFX	platinum	750	t	Black / Silver
2855	ATX	gold	600	f	Black
2856	ATX	gold	1050	t	Black
2857	ATX	platinum	850	t	White
2859	ATX	platinum	1500	t	Black
2860	ATX	platinum	1000	t	Black
2861	ATX	titanium	1650	t	Black / Silver
2862	SFX	platinum	1000	t	Black / White
2863	ATX	gold	1050	t	Black
2864	ATX	gold	750	t	White / Black
2866	ATX	gold	1000	t	Black
2868	ATX	gold	1000	t	Black
2872	ATX	platinum	1300	t	Black / Copper
2875	ATX	platinum	1300	t	Black
2877	ATX	gold	1050	t	White
2878	ATX	gold	750	t	Black
2879	ATX	bronze	650	f	Black
2883	ATX	titanium	2800	t	Black
2884	ATX	plus	550	f	Black
2885	ATX	gold	650	t	Black
2886	ATX	gold	1000	t	Black
2887	ATX	gold	850	t	White
2889	Flex ATX	gold	300	f	Silver
2894	ATX	gold	850	t	White / Black
2895	ATX	platinum	850	t	Black
2897	SFX	platinum	1000	t	Black
2899	ATX	platinum	1500	t	Black
2901	ATX	bronze	750	f	Black
2902	SFX	platinum	850	t	Black
2903	ATX	platinum	1300	t	Black
2904	ATX	gold	1000	t	Black
2905	ATX	bronze	750	f	Black
2906	ATX	bronze	610	f	Black
2907	ATX	bronze	550	f	Black
2913	ATX	bronze	500	f	Black
2914	SFX	gold	750	t	Black
2915	ATX	gold	850	t	Black
2916	SFX	gold	850	t	Black
2917	ATX	gold	650	t	Black
2922	ATX	gold	1200	t	Black / Silver
2923	ATX	gold	850	f	Black
2924	ATX	bronze	550	t	Black
2925	ATX	gold	1000	t	Black
2926	ATX	platinum	500	t	Black
2928	TFX	bronze	300	f	Black
2929	ATX	bronze	850	t	Black
2931	ATX	gold	750	t	Black
2933	ATX	gold	1000	t	Black
2934	ATX	platinum	1000	t	Black / Silver
2936	ATX	gold	750	f	Black
2939	ATX	gold	1300	t	Black
2940	ATX	gold	1200	t	Black
2941	Flex ATX	gold	500	f	Black
2948	ATX	bronze	710	f	Black
2949	SFX	platinum	750	t	Black
2951	ATX	titanium	1000	t	Black
2953	ATX	bronze	650	f	Black
2954	ATX	gold	650	t	Black
2956	ATX	platinum	1500	t	Black
2957	ATX	gold	1000	t	Black
2958	ATX	gold	650	t	Black
2959	ATX	platinum	1200	t	Black / Silver
2961	ATX	gold	750	t	Black
2963	ATX	gold	1000	t	Black
2964	ATX	gold	850	t	White
2966	SFX	gold	850	t	White
2967	ATX	platinum	1300	t	Black
2970	ATX	gold	850	t	Black
2973	ATX	gold	1000	t	White
2974	ATX	gold	1200	t	Black
2975	ATX	gold	1000	t	Black
2977	ATX	bronze	650	f	Black
2980	ATX	platinum	1050	t	Black
2985	ATX	gold	1250	t	Black
2986	ATX	gold	1250	t	Black
2987	ATX	gold	750	t	Black
2991	ATX	platinum	1300	t	Black
2993	ATX	gold	1000	t	White
2996	ATX	gold	1200	t	Black
2997	ATX	platinum	1050	t	White
2999	ATX	gold	1000	t	Black
3000	SFX	gold	750	t	White
3001	ATX	platinum	850	t	Black
3011	ATX	gold	750	t	Black
3013	ATX	gold	750	f	Black
3020	ATX	titanium	1600	t	Brown / Black
3021	SFX	gold	600	t	Black
3024	ATX	gold	650	t	Black
3026	ATX	platinum	1500	t	Black
3027	ATX	gold	850	t	Black
3028	ATX	platinum	1600	t	Black / Purple
3030	ATX	platinum	850	t	Black
3031	ATX	bronze	550	f	Black
3032	ATX	platinum	1200	t	Black
3033	ATX	platinum	1200	t	Black
3037	SFX	bronze	500	f	Black / White
3038	ATX	gold	850	t	Black
3045	ATX	platinum	1600	t	Black
3054	ATX	gold	1000	t	Black
3057	ATX	gold	750	t	White / Black
3063	ATX	gold	850	t	Black
3069	ATX	gold	750	t	Black
3073	ATX	gold	850	t	White
3074	ATX	gold	750	t	Black
3075	ATX	bronze	750	f	Black
3076	ATX	gold	1000	t	White
3077	ATX	titanium	1600	t	Black / Silver
3078	ATX	gold	750	t	Black
3085	ATX	bronze	650	t	Black
3088	ATX	titanium	1600	t	Silver / Black
3089	ATX	titanium	1300	t	Black
3091	ATX	gold	1000	t	Black
3092	ATX	gold	850	t	Black
3096	SFX	platinum	700	t	Black
3097	SFX	gold	750	t	White
3100	ATX	gold	1000	t	Black
3103	ATX	gold	1200	t	Black
3104	Flex ATX	gold	350	f	Black
3105	ATX	gold	1000	t	White
3107	ATX	bronze	750	t	Black
3113	SFX	gold	500	t	Black
3117	ATX	gold	1200	t	White
3119	ATX	gold	650	t	Black
3121	TFX	plus	300	f	Silver
3124	ATX	gold	850	f	Black
3125	ATX	platinum	850	t	Black
3126	ATX	gold	850	t	Black
3129	ATX	platinum	1200	t	Black
3131	SFX	gold	500	t	Black
3132	ATX	gold	750	t	Black
3137	ATX	gold	850	t	Black
3138	ATX	gold	850	t	White
3139	ATX	platinum	1200	t	Black
3142	ATX	bronze	550	f	Black
3146	ATX	bronze	500	f	Black
3148	ATX	gold	1050	t	Black
3149	ATX	bronze	600	f	Gray
3150	ATX	platinum	1200	t	Black / Silver
3156	ATX	platinum	750	t	Black
3158	ATX	gold	750	t	Black / White
3160	SFX	gold	750	t	Black
3162	SFX	platinum	1000	t	Black
3166	SFX	gold	300	f	Silver
3168	TFX	bronze	300	f	Black
3173	ATX	gold	1200	t	Black
3174	TFX	bronze	300	f	Silver
3175	ATX	bronze	850	t	Black
3177	ATX	gold	600	f	Black
3181	ATX	titanium	700	t	Black
3185	ATX	bronze	650	f	Black
3186	ATX	platinum	1000	t	Black
3189	ATX	gold	850	t	Black
3190	ATX	gold	750	t	Black
3191	ATX	gold	850	f	Black
3194	ATX	bronze	650	f	Black
3195	ATX	gold	1200	t	Black
3196	ATX	gold	700	f	Black
3200	ATX	gold	850	t	Black
3204	ATX	gold	850	f	Black
3205	ATX	gold	650	t	Black
3206	SFX	platinum	700	t	Black
3208	ATX	gold	850	t	Black
3211	ATX	gold	1000	t	Black
3213	ATX	gold	850	t	Black / Silver
3214	TFX	gold	700	f	Black
3218	Flex ATX	gold	400	f	Silver
3219	ATX	gold	650	t	Black
3220	ATX	silver	1500	t	Black
3226	ATX	bronze	550	f	Black
3232	ATX	gold	1600	t	Black
3234	ATX	gold	650	t	Black
3237	ATX	gold	750	t	Black
3241	ATX	gold	1000	t	Black / Silver
3242	ATX	platinum	850	t	Black / Silver
3243	ATX	gold	850	t	Black
3244	TFX	gold	500	f	Black
3246	ATX	gold	850	t	Black
3253	ATX	gold	1300	t	Black
3254	Flex ATX	silver	500	f	Silver
3257	ATX	gold	850	t	Black
3260	ATX	gold	1300	t	Black
3262	ATX	titanium	1600	t	Black / Silver
3263	ATX	titanium	1300	t	Black / Silver
3264	ATX	gold	850	t	Black
3266	ATX	bronze	550	f	Black
3267	ATX	bronze	750	t	Black
3268	ATX	gold	850	t	Black
3269	SFX	platinum	1000	t	Black
3270	ATX	gold	650	t	Black
3272	ATX	gold	1000	t	Black
3275	ATX	gold	750	t	Black / Silver
3279	Flex ATX	bronze	400	f	Silver
3287	SFX	gold	700	t	Black
3293	ATX	gold	850	t	Black
3294	ATX	gold	850	t	White / Black
3297	ATX	gold	1300	t	Black
3300	ATX	gold	1250	t	Black
3303	ATX	gold	750	t	Black
\.


--
-- TOC entry 5265 (class 0 OID 25429)
-- Dependencies: 226
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
tOQsOYIeMA89Lma92I8wM0ML3FwQhkdLW4uzMm9h	1	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36	eyJfdG9rZW4iOiJKWWNIZFkwU05ObFlKVTQzQkxCWHZ5VURFZzY5QzZRazE4QVFlckFyIiwibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiOjEsIl9wcmV2aW91cyI6eyJ1cmwiOiJodHRwOlwvXC8xMjcuMC4wLjE6ODAwMCIsInJvdXRlIjoiaG9tZSJ9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX0sImJ1aWxkX3BjX3Nsb3RzIjp7IjEiOnsiY3B1Ijp7ImlkIjoxLCJuYW1lIjoiQU1EIFJ5emVuIDcgNzcwMCIsInByaWNlIjoiNDQyOTAwMC4wMCIsImltYWdlIjpudWxsfX0sIjIiOnsiY3B1Ijp7ImlkIjoxLCJuYW1lIjoiQU1EIFJ5emVuIDcgNzcwMCIsInByaWNlIjoiNDQyOTAwMC4wMCIsImltYWdlIjpudWxsfSwibWFpbmJvYXJkIjp7ImlkIjo0MzM5LCJuYW1lIjoiQXN1cyBQUklNRSBCNjUwLVBMVVMgV0lGSSIsInByaWNlIjoiMjk1NzAwMC4wMCIsImltYWdlIjpudWxsfX0sIjMiOltdLCI0Ijp7ImNwdSI6eyJpZCI6MSwibmFtZSI6IkFNRCBSeXplbiA3IDc3MDAiLCJwcmljZSI6IjQ0MjkwMDAuMDAiLCJpbWFnZSI6bnVsbH19LCI1Ijp7ImNwdSI6eyJpZCI6MSwibmFtZSI6IkFNRCBSeXplbiA3IDc3MDAiLCJwcmljZSI6IjQ0MjkwMDAuMDAiLCJpbWFnZSI6bnVsbH19LCI2Ijp7ImNwdSI6eyJpZCI6MSwibmFtZSI6IkFNRCBSeXplbiA3IDc3MDAiLCJwcmljZSI6IjQ0MjkwMDAuMDAiLCJpbWFnZSI6bnVsbH19fSwiYnVpbGRfc2xvdF9pZHMiOnsiMSI6MSwiMiI6MiwiMyI6MywiNCI6NCwiNSI6NSwiNiI6N30sImJ1aWxkX3BjX3Nsb3RzX2xvYWRlZCI6dHJ1ZSwiYnVpbGRfcGMiOnsiY3B1Ijp7ImlkIjoxLCJuYW1lIjoiQU1EIFJ5emVuIDcgNzcwMCIsInByaWNlIjoiNDQyOTAwMC4wMCIsImltYWdlIjpudWxsfSwibWFpbmJvYXJkIjp7ImlkIjo0NDA5LCJuYW1lIjoiR2lnYWJ5dGUgQTYyMEkgQVgiLCJwcmljZSI6IjIyOTYwMDAuMDAiLCJpbWFnZSI6bnVsbH0sInJhbSI6eyJpZCI6NDc2MiwibmFtZSI6IktpbmdzdG9uIEZVUlkgQmVhc3QgMTYgR0IiLCJwcmljZSI6IjQ0NzAwMDAuMDAiLCJpbWFnZSI6bnVsbH0sInZnYSI6eyJpZCI6NzY0LCJuYW1lIjoiIEdlRm9yY2UgUlRYIDMwNjAgOEdCIiwicHJpY2UiOiI2MDAwMDAwLjAwIiwiaW1hZ2UiOm51bGx9LCJzdG9yYWdlIjp7ImlkIjozODQ3LCJuYW1lIjoiU2Ftc3VuZyA4NjAgRXZvIiwicHJpY2UiOiIzOTcwMDAwLjAwIiwiaW1hZ2UiOm51bGx9LCJwc3UiOnsiaWQiOjI4NTEsIm5hbWUiOiJTZWFTb25pYyBTMTJJSUkiLCJwcmljZSI6IjEwNjMwMDAuMDAiLCJpbWFnZSI6bnVsbH19fQ==	1781671256
\.


--
-- TOC entry 5290 (class 0 OID 25696)
-- Dependencies: 251
-- Data for Name: usage_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usage_profiles (id, profile_name, description, logic_rules) FROM stdin;
\.


--
-- TOC entry 5263 (class 0 OID 25406)
-- Dependencies: 224
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at, role) FROM stdin;
2	Helo	hihi@gmail.com	\N	$2y$12$pzNUuCS370/JuvLayUyrM.BRdBrDeNaxlMKcV6D9Bq1CwwMiPJ8K6	\N	2026-04-11 15:18:25	2026-04-11 15:18:25	user
3	hilo	abc@gmail.com	\N	$2y$12$pzNUuCS370/JuvLayUyrM.BRdBrDeNaxlMKcV6D9Bq1CwwMiPJ8K6	\N	2026-04-11 15:28:16	2026-04-11 15:28:16	user
4	Pham Xuan Thang	user@gmail.com	\N	$2y$12$pzNUuCS370/JuvLayUyrM.BRdBrDeNaxlMKcV6D9Bq1CwwMiPJ8K6	\N	2026-06-01 02:54:03	2026-06-01 02:54:03	user
5	coderngheo	a@gmail.com	\N	$2y$12$pzNUuCS370/JuvLayUyrM.BRdBrDeNaxlMKcV6D9Bq1CwwMiPJ8K6	\N	2026-06-05 16:51:40	2026-06-05 16:51:40	user
6	techguru	b@gmail.com	\N	$2y$12$pzNUuCS370/JuvLayUyrM.BRdBrDeNaxlMKcV6D9Bq1CwwMiPJ8K6	\N	2026-06-05 16:51:40	2026-06-05 16:51:40	user
7	revitmaster	c@gmail.com	\N	$2y$12$pzNUuCS370/JuvLayUyrM.BRdBrDeNaxlMKcV6D9Bq1CwwMiPJ8K6	\N	2026-06-05 16:51:40	2026-06-05 16:51:40	user
8	buildpcvn	d@gmail.com	\N	$2y$12$pzNUuCS370/JuvLayUyrM.BRdBrDeNaxlMKcV6D9Bq1CwwMiPJ8K6	\N	2026-06-05 16:51:40	2026-06-05 16:51:40	user
9	fen123	e@gmail.com	\N	$2y$12$pzNUuCS370/JuvLayUyrM.BRdBrDeNaxlMKcV6D9Bq1CwwMiPJ8K6	\N	2026-06-05 16:51:40	2026-06-05 16:51:40	user
1	Pham Xuan Thang	xthang260205@gmail.com	\N	$2y$12$pzNUuCS370/JuvLayUyrM.BRdBrDeNaxlMKcV6D9Bq1CwwMiPJ8K6	v0YHaPCHQpHBtkqetoHRBXrZHQMPbqrzzz9nUKRrWSb5Vt0iKUbL80tNqpws	2026-04-11 04:37:19	2026-04-11 04:37:40	admin
\.


--
-- TOC entry 5281 (class 0 OID 25584)
-- Dependencies: 242
-- Data for Name: video_cards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.video_cards (component_id, chipset, memory, core_clock, boost_clock, color, length, tdp) FROM stdin;
777	GeForce RTX 5070 Ti	16	2300	2482	White / Gold	304	300
819	GeForce RTX 5070	12	2160	2557	Black	303	250
772	GeForce RTX 5060 Ti	16	2407	2572	Black	245	180
768	GeForce RTX 5060	8	2280	2640	Black	300	150
806	GeForce RTX 5060	8	2280	2677	Black	302	150
827	GeForce RTX 5060	8	2280	2550	Black	220	150
834	GeForce RTX 4090	24	2235	2580	Black / Silver	356	450
862	GeForce RTX 4080 SUPER	16	2210	2550	Black	307	320
880	GeForce RTX 4080 SUPER	16	2210	2565	Black	340	320
781	GeForce RTX 4070 SUPER	12	1980	2505	Black	261	220
883	GeForce RTX 4070 SUPER	12	1980	2550	Black	227	220
837	GeForce RTX 4070	12	1920	2520	Silver / Black	308	200
854	GeForce RTX 4060 Ti	16	2310	2625	Black	199	165
771	GeForce RTX 4060	8	1830	2580	Black / Gold	300	115
815	GeForce RTX 3090 Ti	24	1560	1890	Black	300	450
868	GeForce RTX 3090 Ti	24	1560	1920	Black	325	450
840	GeForce RTX 3090	24	1395	1755	Black / Gray	320	350
773	GeForce RTX 3080 10GB	10	1440	1845	Black / Silver	252	320
769	GeForce RTX 3070	8	1500	1845	Black / Silver	275	220
774	GeForce RTX 3070	8	1500	1845	Black	290	220
785	GeForce RTX 3070	8	1500	1815	Black / Silver	300	220
817	GeForce RTX 3060 Ti LHR	8	1410	1890	Black / Silver	318	200
888	GeForce RTX 3060 Ti	8	1410	1710	Black	202	200
764	GeForce RTX 3060 8GB	8	1320	1807	Black	235	170
802	GeForce RTX 3060 8GB	8	1320	1867	Black	200	170
820	GeForce RTX 3060 12GB	12	1320	1777	Black	224	170
859	GeForce RTX 3060 12GB	12	1320	1837	Black / Gray	282	170
824	GeForce RTX 3050 8GB	8	1550	1890	Black / Silver	300	130
825	GeForce RTX 3050 6GB	6	1040	1470	Gray / Black	222	130
831	GeForce RTX 3050 6GB	6	1040	1470	Black	151	130
871	GeForce RTX 3050 6GB	6	1040	1477	Black	181	130
794	GeForce RTX 2060 SUPER	8	1470	1695	Black / Silver	248	175
861	GeForce RTX 2060	6	1365	1710	Black	190	160
765	GeForce GTX 1660 Ti	6	1500	1800	Black / Gray	226	120
864	GeForce GTX 1660 SUPER	6	1530	1830	Black	202	125
821	Radeon RX 9070 XT	16	1660	2970	White	360	304
841	Radeon RX 9070 XT	16	1660	2970	White	325	304
843	Radeon RX 9070 XT	16	2520	3060	Black	331	304
762	Radeon RX 9070	16	2070	2520	Black / Silver	290	220
796	Radeon RX 9070	16	2120	2610	Black	312	220
798	Radeon RX 9070	16	2070	2520	Black	289	220
813	Radeon RX 7900 XT	20	2000	2400	Black	276	315
783	Radeon RX 7800 XT	16	1295	2520	Black	322	263
849	Radeon RX 7600	8	1875	2655	Black	241	165
850	Radeon RX 6600	8	1626	2491	Black	200	132
780	Radeon RX 6500 XT	4	2365	2820	Black	240	107
808	Radeon RX 5700 XT	8	1605	1905	Black	293	225
863	Quadro M5000	8	861	1038	Black / Green	267	150
852	Quadro P400	2	1070	1170	Black	145	30
847	Radeon RX 570	8	1168	1286	Black / Red	243	150
809	RTX 4500 Ada Generation	24	2070	2580	Black / Gold	245	210
911	GeForce RTX 5070 Ti	16	2300	2467	Black	303	300
971	GeForce RTX 5070	12	2325	2542	Black / Silver	300	250
900	GeForce RTX 5060 Ti	16	2410	2572	Black	208	180
982	GeForce RTX 5060 Ti	8	2410	2602	Black	220	180
919	GeForce RTX 5060	8	2280	2580	Black	280	150
931	GeForce RTX 5060	8	2280	2497	Black	200	150
906	GeForce RTX 4090	24	2235	2595	Black	326	450
1050	GeForce RTX 4090	24	2235	2535	Black	322	450
960	GeForce RTX 4080 SUPER	16	2210	2595	Black	332	320
993	GeForce RTX 4080 SUPER	16	2210	2625	Copper / Black	312	320
917	GeForce RTX 4080	16	2205	2520	Black	322	320
1049	GeForce RTX 4080	16	2205	2505	Black	332	320
952	GeForce RTX 4070 Ti SUPER	16	2340	2655	White / Silver	300	285
904	GeForce RTX 4070 Ti	12	2310	2640	Black	305	285
903	GeForce RTX 4070 SUPER	12	1980	2640	White / Blue	330	220
1037	GeForce RTX 3090	24	1395	1875	Silver	336	350
1096	GeForce RTX 3090	24	1395	1920	Black	289	350
980	GeForce RTX 3080 12GB LHR	12	1260	1755	Black	285	320
1070	GeForce RTX 3080 10GB LHR	10	1440	1800	Black	300	320
1077	GeForce RTX 3060 Ti LHR	8	1410	1785	Black	296	200
1092	GeForce RTX 3050 8GB	8	1550	1807	Black	177	130
1081	GeForce GTX 1650 G6	4	1410	1785	Black	206	75
915	GeForce GTX 1060 6GB	6	1620	1847	Black	267	120
970	GeForce GTX 1060 6GB	6	1506	1708	Black	267	120
948	Radeon RX 9070 XT	16	2400	2970	White / Gray	298	304
1003	Radeon RX 9070 XT	16	1870	3100	White	360	304
929	Radeon RX 9070	16	2070	2700	Black / Silver	297	220
958	Radeon RX 9070	16	2210	2700	White	320	220
976	Radeon RX 7900 XT	20	2000	2500	Black	320	315
1064	Radeon RX 7900 XT	20	2000	2400	Black	276	315
1032	Radeon RX 6900 XT	16	1825	2365	Black / White	310	300
1002	Radeon RX 6650 XT	8	2055	2694	Black	251	180
963	Radeon RX 6600	8	1626	2491	Black / Silver	243	132
1015	Radeon RX 5700 XT	8	1650	1905	Black	240	225
962	Arc B580	12	2670	2740	Blue / White	317	190
1022	Quadro M2000	4	872	1180	Black	168	75
925	Quadro P2000	5	1370	1470	Black	201	75
944	Radeon RX 580	8	1257	1380	Black	298	185
1006	Quadro RTX 8000	48	1395	1770	Black / White	267	295
1079	Quadro RTX 5000	16	1620	1815	Silver / Black	267	230
901	Quadro K1200	4	1058	1124	Black / Green	160	45
1030	Quadro P620	2	1266	1354	Black	145	40
1093	GeForce GT 1030 DDR4	2	1151	1417	Black	150	30
1065	GeForce RTX 5050	8	2317	2617	Black	197	90
838	GeForce RTX 5090	32	2010	2422	White / Copper	330	575
1154	GeForce RTX 5090	32	2010	2625	Black	329	575
902	GeForce RTX 5080	16	2300	2640	Black / Copper	304	360
1174	GeForce RTX 5080	16	2300	2620	Black	329	360
1214	GeForce RTX 5080	16	2300	2617	Black / Copper	304	360
1067	GeForce RTX 5070 Ti	16	2300	2482	Black / Gold	304	300
1252	GeForce RTX 5070 Ti	16	2300	2580	Black	338	300
1261	GeForce RTX 5070 Ti	16	2295	2572	Black	300	300
1222	GeForce RTX 5070	12	2325	2512	Black	300	250
778	GeForce RTX 5060 Ti	8	2410	2617	Black	215	180
807	GeForce RTX 5060 Ti	8	2410	2602	Black	304	180
1019	GeForce RTX 5060 Ti	8	2410	2572	Black	220	180
1021	GeForce RTX 5060 Ti	8	2410	2572	Black	262	180
1080	GeForce RTX 5060 Ti	16	2410	2617	Black / Gray	227	180
1180	GeForce RTX 5060 Ti	8	2410	2587	Black / Gray	227	180
895	GeForce RTX 5060	8	2280	2512	White	197	150
1150	GeForce RTX 4090	24	2235	2550	Black	358	450
1256	GeForce RTX 4060 Ti	16	2310	2685	White	307	165
2331	GeForce RTX 3090 Ti	24	1560	1980	Silver / Black	293	450
814	GeForce RTX 3070 LHR	8	1500	1845	Black / Silver	275	220
1197	GeForce RTX 3070	8	1500	1830	Black / Silver	323	220
1229	GeForce RTX 3060 Ti LHR	8	1410	1695	Black / Gray	235	200
1166	GeForce RTX 3060 12GB	12	1320	1807	Black	235	170
874	GeForce RTX 3050 8GB	8	1550	1807	Black / Gray	205	130
1113	GeForce RTX 3050 6GB	6	1040	1492	Black	174	130
1219	GeForce RTX 3050 6GB	6	1040	1470	Pink	160	130
1205	GeForce GTX 1660 Ti	6	1500	1845	Black / Gray	206	120
1146	GeForce GTX 1050 Ti	4	1290	1430	Black / Orange	172	75
1187	Radeon RX 9070 XT	16	2460	3060	White	340	304
1231	Radeon RX 9070 XT	16	2460	3060	Black	340	304
1238	Radeon RX 9070 XT	16	2400	3010	White	327	304
1199	Radeon RX 7900 XTX	24	2300	2615	Black	330	355
1233	Radeon RX 7900 XTX	24	2300	2680	White	345	355
1246	Radeon RX 7900 XT	20	2000	2395	Black / Silver	312	315
1103	Radeon RX 7900 GRE	16	1270	2395	Black	335	260
1149	Radeon RX 7600	8	1720	2725	White	303	165
1223	Radeon RX 6900 XT	16	1825	2525	Black	270	300
1192	Radeon RX 6700 XT	12	2321	2622	Black	320	230
1125	Radeon RX 6600 XT	8	1968	2589	Black / Silver	282	160
1193	Radeon RX 6600	8	1626	2491	Black	243	132
1179	Radeon RX 6500 XT	8	2420	2825	Black	240	107
1101	Arc B580	12	2670	2740	White / Silver	260	190
1106	RTX 4000 Ada Generation	20	1500	2175	Black	241	130
1100	GeForce RTX 5050	8	2317	2647	Black	202	90
\.


--
-- TOC entry 5298 (class 0 OID 25772)
-- Dependencies: 259
-- Data for Name: votes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.votes (id, user_id, post_id, vote_type, created_at) FROM stdin;
\.


--
-- TOC entry 5321 (class 0 OID 0)
-- Dependencies: 254
-- Name: build_components_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.build_components_id_seq', 8, true);


--
-- TOC entry 5322 (class 0 OID 0)
-- Dependencies: 260
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 9, true);


--
-- TOC entry 5323 (class 0 OID 0)
-- Dependencies: 248
-- Name: component_prices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.component_prices_id_seq', 1381, true);


--
-- TOC entry 5324 (class 0 OID 0)
-- Dependencies: 234
-- Name: component_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.component_types_id_seq', 8, true);


--
-- TOC entry 5325 (class 0 OID 0)
-- Dependencies: 236
-- Name: components_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.components_id_seq', 5049, true);


--
-- TOC entry 5326 (class 0 OID 0)
-- Dependencies: 246
-- Name: dealers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dealers_id_seq', 1, true);


--
-- TOC entry 5327 (class 0 OID 0)
-- Dependencies: 232
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- TOC entry 5328 (class 0 OID 0)
-- Dependencies: 229
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- TOC entry 5329 (class 0 OID 0)
-- Dependencies: 221
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 24, true);


--
-- TOC entry 5330 (class 0 OID 0)
-- Dependencies: 252
-- Name: pc_builds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pc_builds_id_seq', 7, true);


--
-- TOC entry 5331 (class 0 OID 0)
-- Dependencies: 256
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posts_id_seq', 3, true);


--
-- TOC entry 5332 (class 0 OID 0)
-- Dependencies: 250
-- Name: usage_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usage_profiles_id_seq', 1, false);


--
-- TOC entry 5333 (class 0 OID 0)
-- Dependencies: 223
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 9, true);


--
-- TOC entry 5334 (class 0 OID 0)
-- Dependencies: 258
-- Name: votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.votes_id_seq', 1, false);


--
-- TOC entry 5059 (class 2606 OID 25736)
-- Name: build_components build_components_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.build_components
    ADD CONSTRAINT build_components_pkey PRIMARY KEY (id);


--
-- TOC entry 5014 (class 2606 OID 25461)
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- TOC entry 5011 (class 2606 OID 25450)
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- TOC entry 5043 (class 2606 OID 25622)
-- Name: cases cases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (component_id);


--
-- TOC entry 5072 (class 2606 OID 26148)
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- TOC entry 5049 (class 2606 OID 25657)
-- Name: component_prices component_prices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_prices
    ADD CONSTRAINT component_prices_pkey PRIMARY KEY (id);


--
-- TOC entry 5025 (class 2606 OID 25520)
-- Name: component_types component_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_types
    ADD CONSTRAINT component_types_pkey PRIMARY KEY (id);


--
-- TOC entry 5027 (class 2606 OID 25807)
-- Name: component_types component_types_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_types
    ADD CONSTRAINT component_types_type_name_key UNIQUE (type_name);


--
-- TOC entry 5029 (class 2606 OID 25530)
-- Name: components components_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT components_pkey PRIMARY KEY (id);


--
-- TOC entry 5033 (class 2606 OID 25559)
-- Name: cpu_coolers cpu_coolers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cpu_coolers
    ADD CONSTRAINT cpu_coolers_pkey PRIMARY KEY (component_id);


--
-- TOC entry 5031 (class 2606 OID 25548)
-- Name: cpus cpus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cpus
    ADD CONSTRAINT cpus_pkey PRIMARY KEY (component_id);


--
-- TOC entry 5047 (class 2606 OID 25646)
-- Name: dealers dealers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dealers
    ADD CONSTRAINT dealers_pkey PRIMARY KEY (id);


--
-- TOC entry 5021 (class 2606 OID 25509)
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 5023 (class 2606 OID 25511)
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- TOC entry 5041 (class 2606 OID 25609)
-- Name: internal_hard_drives internal_hard_drives_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_hard_drives
    ADD CONSTRAINT internal_hard_drives_pkey PRIMARY KEY (component_id);


--
-- TOC entry 5019 (class 2606 OID 25492)
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- TOC entry 5016 (class 2606 OID 25477)
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 5037 (class 2606 OID 25583)
-- Name: memory memory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memory
    ADD CONSTRAINT memory_pkey PRIMARY KEY (component_id);


--
-- TOC entry 4996 (class 2606 OID 25404)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 5035 (class 2606 OID 25572)
-- Name: motherboards motherboards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motherboards
    ADD CONSTRAINT motherboards_pkey PRIMARY KEY (component_id);


--
-- TOC entry 5004 (class 2606 OID 25428)
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- TOC entry 5057 (class 2606 OID 25714)
-- Name: pc_builds pc_builds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pc_builds
    ADD CONSTRAINT pc_builds_pkey PRIMARY KEY (id);


--
-- TOC entry 5063 (class 2606 OID 25760)
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 5045 (class 2606 OID 25635)
-- Name: power_supplies power_supplies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.power_supplies
    ADD CONSTRAINT power_supplies_pkey PRIMARY KEY (component_id);


--
-- TOC entry 5007 (class 2606 OID 25438)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 5053 (class 2606 OID 25914)
-- Name: component_prices uq_component_dealer; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_prices
    ADD CONSTRAINT uq_component_dealer UNIQUE (component_id, dealer_id);


--
-- TOC entry 5055 (class 2606 OID 25705)
-- Name: usage_profiles usage_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usage_profiles
    ADD CONSTRAINT usage_profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 4998 (class 2606 OID 25809)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 5000 (class 2606 OID 25419)
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- TOC entry 5002 (class 2606 OID 25417)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5039 (class 2606 OID 25596)
-- Name: video_cards video_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video_cards
    ADD CONSTRAINT video_cards_pkey PRIMARY KEY (component_id);


--
-- TOC entry 5066 (class 2606 OID 25782)
-- Name: votes votes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- TOC entry 5068 (class 2606 OID 25811)
-- Name: votes votes_user_id_post_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_user_id_post_id_key UNIQUE (user_id, post_id);


--
-- TOC entry 5070 (class 2606 OID 25794)
-- Name: votes votes_user_id_post_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_user_id_post_id_unique UNIQUE (user_id, post_id);


--
-- TOC entry 5009 (class 1259 OID 25451)
-- Name: cache_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_expiration_index ON public.cache USING btree (expiration);


--
-- TOC entry 5012 (class 1259 OID 25462)
-- Name: cache_locks_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_locks_expiration_index ON public.cache_locks USING btree (expiration);


--
-- TOC entry 5060 (class 1259 OID 25812)
-- Name: idx_build_components_build; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_build_components_build ON public.build_components USING btree (build_id);


--
-- TOC entry 5061 (class 1259 OID 25813)
-- Name: idx_posts_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_posts_user ON public.posts USING btree (user_id);


--
-- TOC entry 5050 (class 1259 OID 25814)
-- Name: idx_prices_component; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_prices_component ON public.component_prices USING btree (component_id);


--
-- TOC entry 5051 (class 1259 OID 25815)
-- Name: idx_prices_dealer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_prices_dealer ON public.component_prices USING btree (dealer_id);


--
-- TOC entry 5064 (class 1259 OID 25816)
-- Name: idx_votes_post; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_votes_post ON public.votes USING btree (post_id);


--
-- TOC entry 5017 (class 1259 OID 25478)
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- TOC entry 5005 (class 1259 OID 25440)
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- TOC entry 5008 (class 1259 OID 25439)
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- TOC entry 5099 (class 2606 OID 25817)
-- Name: build_components build_components_build_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.build_components
    ADD CONSTRAINT build_components_build_id_fkey FOREIGN KEY (build_id) REFERENCES public.pc_builds(id) ON DELETE CASCADE;


--
-- TOC entry 5100 (class 2606 OID 25737)
-- Name: build_components build_components_build_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.build_components
    ADD CONSTRAINT build_components_build_id_foreign FOREIGN KEY (build_id) REFERENCES public.pc_builds(id) ON DELETE CASCADE;


--
-- TOC entry 5101 (class 2606 OID 25822)
-- Name: build_components build_components_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.build_components
    ADD CONSTRAINT build_components_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id);


--
-- TOC entry 5102 (class 2606 OID 25742)
-- Name: build_components build_components_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.build_components
    ADD CONSTRAINT build_components_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5087 (class 2606 OID 25827)
-- Name: cases cases_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5088 (class 2606 OID 25616)
-- Name: cases cases_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5111 (class 2606 OID 26149)
-- Name: comments comments_post_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_post_id_foreign FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- TOC entry 5112 (class 2606 OID 26154)
-- Name: comments comments_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5091 (class 2606 OID 25832)
-- Name: component_prices component_prices_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_prices
    ADD CONSTRAINT component_prices_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5092 (class 2606 OID 25658)
-- Name: component_prices component_prices_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_prices
    ADD CONSTRAINT component_prices_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5093 (class 2606 OID 25837)
-- Name: component_prices component_prices_dealer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_prices
    ADD CONSTRAINT component_prices_dealer_id_fkey FOREIGN KEY (dealer_id) REFERENCES public.dealers(id) ON DELETE CASCADE;


--
-- TOC entry 5094 (class 2606 OID 25663)
-- Name: component_prices component_prices_dealer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_prices
    ADD CONSTRAINT component_prices_dealer_id_foreign FOREIGN KEY (dealer_id) REFERENCES public.dealers(id) ON DELETE CASCADE;


--
-- TOC entry 5073 (class 2606 OID 25531)
-- Name: components components_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT components_type_id_foreign FOREIGN KEY (type_id) REFERENCES public.component_types(id);


--
-- TOC entry 5077 (class 2606 OID 25842)
-- Name: cpu_coolers cpu_coolers_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cpu_coolers
    ADD CONSTRAINT cpu_coolers_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5078 (class 2606 OID 25553)
-- Name: cpu_coolers cpu_coolers_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cpu_coolers
    ADD CONSTRAINT cpu_coolers_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5075 (class 2606 OID 25847)
-- Name: cpus cpus_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cpus
    ADD CONSTRAINT cpus_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5076 (class 2606 OID 25542)
-- Name: cpus cpus_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cpus
    ADD CONSTRAINT cpus_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5074 (class 2606 OID 25852)
-- Name: components fk_component_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT fk_component_type FOREIGN KEY (type_id) REFERENCES public.component_types(id);


--
-- TOC entry 5085 (class 2606 OID 25857)
-- Name: internal_hard_drives internal_hard_drives_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_hard_drives
    ADD CONSTRAINT internal_hard_drives_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5086 (class 2606 OID 25603)
-- Name: internal_hard_drives internal_hard_drives_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_hard_drives
    ADD CONSTRAINT internal_hard_drives_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5081 (class 2606 OID 25862)
-- Name: memory memory_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memory
    ADD CONSTRAINT memory_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5082 (class 2606 OID 25577)
-- Name: memory memory_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memory
    ADD CONSTRAINT memory_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5079 (class 2606 OID 25867)
-- Name: motherboards motherboards_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motherboards
    ADD CONSTRAINT motherboards_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5080 (class 2606 OID 25566)
-- Name: motherboards motherboards_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motherboards
    ADD CONSTRAINT motherboards_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5095 (class 2606 OID 25872)
-- Name: pc_builds pc_builds_usage_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pc_builds
    ADD CONSTRAINT pc_builds_usage_profile_id_fkey FOREIGN KEY (usage_profile_id) REFERENCES public.usage_profiles(id);


--
-- TOC entry 5096 (class 2606 OID 25720)
-- Name: pc_builds pc_builds_usage_profile_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pc_builds
    ADD CONSTRAINT pc_builds_usage_profile_id_foreign FOREIGN KEY (usage_profile_id) REFERENCES public.usage_profiles(id) ON DELETE SET NULL;


--
-- TOC entry 5097 (class 2606 OID 25877)
-- Name: pc_builds pc_builds_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pc_builds
    ADD CONSTRAINT pc_builds_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5098 (class 2606 OID 25715)
-- Name: pc_builds pc_builds_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pc_builds
    ADD CONSTRAINT pc_builds_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5103 (class 2606 OID 25882)
-- Name: posts posts_build_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_build_id_fkey FOREIGN KEY (build_id) REFERENCES public.pc_builds(id);


--
-- TOC entry 5104 (class 2606 OID 25766)
-- Name: posts posts_build_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_build_id_foreign FOREIGN KEY (build_id) REFERENCES public.pc_builds(id) ON DELETE SET NULL;


--
-- TOC entry 5105 (class 2606 OID 25887)
-- Name: posts posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5106 (class 2606 OID 25761)
-- Name: posts posts_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5089 (class 2606 OID 25892)
-- Name: power_supplies power_supplies_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.power_supplies
    ADD CONSTRAINT power_supplies_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5090 (class 2606 OID 25629)
-- Name: power_supplies power_supplies_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.power_supplies
    ADD CONSTRAINT power_supplies_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5083 (class 2606 OID 25897)
-- Name: video_cards video_cards_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video_cards
    ADD CONSTRAINT video_cards_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5084 (class 2606 OID 25590)
-- Name: video_cards video_cards_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video_cards
    ADD CONSTRAINT video_cards_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5107 (class 2606 OID 25902)
-- Name: votes votes_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- TOC entry 5108 (class 2606 OID 25788)
-- Name: votes votes_post_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_post_id_foreign FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- TOC entry 5109 (class 2606 OID 25907)
-- Name: votes votes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5110 (class 2606 OID 25783)
-- Name: votes votes_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2026-06-17 11:42:06

--
-- PostgreSQL database dump complete
--

\unrestrict QOqEbWduGGbLE9OPyrJYt0sHUGpwpQwcBdgndrhfHQdZ5tUm9gx5lYd83tdXHy3

