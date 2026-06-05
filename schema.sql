--
-- PostgreSQL database dump
--

\restrict 05J1UtGsFBVjaohYHylTYa6NWFdghILH3yfCBBjiGalhMVi6EEraKkx3nLvdaZd

-- Dumped from database version 18.2
-- Dumped by pg_dump version 18.2

-- Started on 2026-06-05 16:26:55

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
-- TOC entry 257 (class 1259 OID 25726)
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
-- TOC entry 256 (class 1259 OID 25725)
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
-- TOC entry 5324 (class 0 OID 0)
-- Dependencies: 256
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
-- TOC entry 264 (class 1259 OID 26137)
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
-- TOC entry 263 (class 1259 OID 26136)
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
-- TOC entry 5325 (class 0 OID 0)
-- Dependencies: 263
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- TOC entry 251 (class 1259 OID 25669)
-- Name: compatibility_rules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.compatibility_rules (
    id bigint NOT NULL,
    rule_name character varying(255) NOT NULL,
    component_type_a bigint NOT NULL,
    component_type_b bigint NOT NULL,
    field_a character varying(255) NOT NULL,
    field_b character varying(255) NOT NULL,
    operator character varying(255) DEFAULT 'equals'::character varying NOT NULL
);


ALTER TABLE public.compatibility_rules OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 25668)
-- Name: compatibility_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.compatibility_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.compatibility_rules_id_seq OWNER TO postgres;

--
-- TOC entry 5326 (class 0 OID 0)
-- Dependencies: 250
-- Name: compatibility_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.compatibility_rules_id_seq OWNED BY public.compatibility_rules.id;


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
-- TOC entry 5327 (class 0 OID 0)
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
-- TOC entry 5328 (class 0 OID 0)
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
-- TOC entry 5329 (class 0 OID 0)
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
-- TOC entry 5330 (class 0 OID 0)
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
-- TOC entry 5331 (class 0 OID 0)
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
-- TOC entry 5332 (class 0 OID 0)
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
-- TOC entry 5333 (class 0 OID 0)
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
-- TOC entry 255 (class 1259 OID 25707)
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
-- TOC entry 254 (class 1259 OID 25706)
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
-- TOC entry 5334 (class 0 OID 0)
-- Dependencies: 254
-- Name: pc_builds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pc_builds_id_seq OWNED BY public.pc_builds.id;


--
-- TOC entry 259 (class 1259 OID 25748)
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
-- TOC entry 258 (class 1259 OID 25747)
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
-- TOC entry 5335 (class 0 OID 0)
-- Dependencies: 258
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
-- TOC entry 262 (class 1259 OID 26127)
-- Name: temp_cases; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.temp_cases (
    name text,
    price numeric,
    type text,
    color text,
    psu text,
    side_panel text,
    external_volume numeric,
    internal_35_bays integer
);


ALTER TABLE public.temp_cases OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 25696)
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
-- TOC entry 252 (class 1259 OID 25695)
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
-- TOC entry 5336 (class 0 OID 0)
-- Dependencies: 252
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
-- TOC entry 5337 (class 0 OID 0)
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
    length integer
);


ALTER TABLE public.video_cards OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 25772)
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
-- TOC entry 260 (class 1259 OID 25771)
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
-- TOC entry 5338 (class 0 OID 0)
-- Dependencies: 260
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.votes_id_seq OWNED BY public.votes.id;


--
-- TOC entry 4998 (class 2604 OID 26112)
-- Name: build_components id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.build_components ALTER COLUMN id SET DEFAULT nextval('public.build_components_id_seq'::regclass);


--
-- TOC entry 5004 (class 2604 OID 26140)
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- TOC entry 4994 (class 2604 OID 26113)
-- Name: compatibility_rules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compatibility_rules ALTER COLUMN id SET DEFAULT nextval('public.compatibility_rules_id_seq'::regclass);


--
-- TOC entry 4993 (class 2604 OID 26114)
-- Name: component_prices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_prices ALTER COLUMN id SET DEFAULT nextval('public.component_prices_id_seq'::regclass);


--
-- TOC entry 4990 (class 2604 OID 26115)
-- Name: component_types id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_types ALTER COLUMN id SET DEFAULT nextval('public.component_types_id_seq'::regclass);


--
-- TOC entry 4991 (class 2604 OID 26116)
-- Name: components id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components ALTER COLUMN id SET DEFAULT nextval('public.components_id_seq'::regclass);


--
-- TOC entry 4992 (class 2604 OID 26117)
-- Name: dealers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dealers ALTER COLUMN id SET DEFAULT nextval('public.dealers_id_seq'::regclass);


--
-- TOC entry 4988 (class 2604 OID 26118)
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- TOC entry 4987 (class 2604 OID 26119)
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- TOC entry 4984 (class 2604 OID 26120)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 4997 (class 2604 OID 26121)
-- Name: pc_builds id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pc_builds ALTER COLUMN id SET DEFAULT nextval('public.pc_builds_id_seq'::regclass);


--
-- TOC entry 5000 (class 2604 OID 26122)
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- TOC entry 4996 (class 2604 OID 26123)
-- Name: usage_profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usage_profiles ALTER COLUMN id SET DEFAULT nextval('public.usage_profiles_id_seq'::regclass);


--
-- TOC entry 4985 (class 2604 OID 26124)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5002 (class 2604 OID 26125)
-- Name: votes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes ALTER COLUMN id SET DEFAULT nextval('public.votes_id_seq'::regclass);


--
-- TOC entry 5311 (class 0 OID 25726)
-- Dependencies: 257
-- Data for Name: build_components; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.build_components (id, build_id, component_id, quantity) FROM stdin;
\.


--
-- TOC entry 5281 (class 0 OID 25441)
-- Dependencies: 227
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (key, value, expiration) FROM stdin;
\.


--
-- TOC entry 5282 (class 0 OID 25452)
-- Dependencies: 228
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- TOC entry 5298 (class 0 OID 25610)
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
-- TOC entry 5318 (class 0 OID 26137)
-- Dependencies: 264
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (id, post_id, user_id, content, created_at, updated_at) FROM stdin;
1	1	1	Bình luận	2026-04-12 04:41:17	2026-04-12 04:41:17
2	1	1	hello	2026-04-12 06:49:29	2026-04-12 06:49:29
3	1	1	hello	2026-04-12 06:49:30	2026-04-12 06:49:30
\.


--
-- TOC entry 5305 (class 0 OID 25669)
-- Dependencies: 251
-- Data for Name: compatibility_rules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.compatibility_rules (id, rule_name, component_type_a, component_type_b, field_a, field_b, operator) FROM stdin;
\.


--
-- TOC entry 5303 (class 0 OID 25648)
-- Dependencies: 249
-- Data for Name: component_prices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_prices (id, component_id, dealer_id, price, product_url, updated_at) FROM stdin;
957	1080	1	9179000.00	\N	2026-04-10 10:10:02
893	871	1	6379000.00	\N	2026-04-10 09:49:35
894	874	1	5609000.00	\N	2026-04-10 09:49:50
3	4	1	7989000.00	https://newegg.com	2026-04-09 22:53:06
4	6	1	5129000.00	https://newegg.com	2026-04-09 22:53:20
5	7	1	7139000.00	https://newegg.com	2026-04-09 22:53:32
6	8	1	1579000.00	https://newegg.com	2026-04-09 22:53:48
7	9	1	1879000.00	https://newegg.com	2026-04-09 22:54:02
8	10	1	8929000.00	https://newegg.com	2026-04-09 22:54:17
9	11	1	10459000.00	https://newegg.com	2026-04-09 22:54:31
10	12	1	3829000.00	https://newegg.com	2026-04-09 22:54:44
11	13	1	6409000.00	https://newegg.com	2026-04-09 22:54:58
12	14	1	5999000.00	https://newegg.com	2026-04-09 22:55:11
13	15	1	1699000.00	https://newegg.com	2026-04-09 22:55:26
14	16	1	1409000.00	https://newegg.com	2026-04-09 22:55:37
15	17	1	1939000.00	https://newegg.com	2026-04-09 22:55:49
16	18	1	3939000.00	https://newegg.com	2026-04-09 22:56:03
17	19	1	8899000.00	https://newegg.com	2026-04-09 22:56:15
18	20	1	4599000.00	https://newegg.com	2026-04-09 22:56:29
19	21	1	4529000.00	https://newegg.com	2026-04-09 22:56:42
20	25	1	2219000.00	https://newegg.com	2026-04-09 22:57:11
21	26	1	6789000.00	https://newegg.com	2026-04-09 22:57:27
22	27	1	5069000.00	https://newegg.com	2026-04-09 22:57:41
23	28	1	1289000.00	https://newegg.com	2026-04-09 22:57:56
24	29	1	15719000.00	https://newegg.com	2026-04-09 22:58:14
25	30	1	1789000.00	https://newegg.com	2026-04-09 22:58:27
26	31	1	3929000.00	https://newegg.com	2026-04-09 22:58:40
27	32	1	6379000.00	https://newegg.com	2026-04-09 22:58:53
28	33	1	1659000.00	https://newegg.com	2026-04-09 22:59:08
29	34	1	5609000.00	https://newegg.com	2026-04-09 22:59:24
30	35	1	10609000.00	https://newegg.com	2026-04-09 22:59:42
31	36	1	6019000.00	https://newegg.com	2026-04-09 22:59:59
32	37	1	12139000.00	https://newegg.com	2026-04-09 23:00:18
33	38	1	1879000.00	https://newegg.com	2026-04-09 23:00:33
34	39	1	3439000.00	https://newegg.com	2026-04-09 23:00:51
35	40	1	11939000.00	https://newegg.com	2026-04-09 23:01:06
36	41	1	8009000.00	https://newegg.com	2026-04-09 23:01:23
37	42	1	4559000.00	https://newegg.com	2026-04-09 23:01:36
38	43	1	2529000.00	https://newegg.com	2026-04-09 23:01:52
39	44	1	3189000.00	https://newegg.com	2026-04-09 23:02:06
40	48	1	4079000.00	https://newegg.com	2026-04-09 23:02:34
41	49	1	10339000.00	https://newegg.com	2026-04-09 23:02:49
42	51	1	4059000.00	https://newegg.com	2026-04-09 23:03:16
43	52	1	4599000.00	https://newegg.com	2026-04-09 23:03:33
44	53	1	6829000.00	https://newegg.com	2026-04-09 23:03:44
45	54	1	5359000.00	https://newegg.com	2026-04-09 23:03:58
46	55	1	1409000.00	https://newegg.com	2026-04-09 23:04:16
47	56	1	3019000.00	https://newegg.com	2026-04-09 23:04:31
48	57	1	1339000.00	https://newegg.com	2026-04-09 23:04:47
49	58	1	8419000.00	https://newegg.com	2026-04-09 23:05:01
50	59	1	2569000.00	https://newegg.com	2026-04-09 23:05:15
51	60	1	7169000.00	https://newegg.com	2026-04-09 23:05:30
52	61	1	869000.00	https://newegg.com	2026-04-09 23:05:42
53	62	1	1439000.00	https://newegg.com	2026-04-09 23:05:55
54	63	1	769000.00	https://newegg.com	2026-04-09 23:06:09
55	64	1	2299000.00	https://newegg.com	2026-04-09 23:06:23
56	65	1	5609000.00	https://newegg.com	2026-04-09 23:06:37
1	1	1	4429000.00	https://newegg.com	2026-04-09 22:52:16
2	3	1	1789000.00	https://newegg.com	2026-04-09 22:52:48
59	66	1	4849000.00	https://newegg.com	2026-04-09 23:10:37
60	67	1	7619000.00	https://newegg.com	2026-04-09 23:11:36
61	68	1	6409000.00	https://newegg.com	2026-04-09 23:11:49
62	70	1	10609000.00	https://newegg.com	2026-04-09 23:12:01
63	71	1	6969000.00	https://newegg.com	2026-04-09 23:12:16
64	72	1	1279000.00	https://newegg.com	2026-04-09 23:12:27
65	73	1	8419000.00	https://newegg.com	2026-04-09 23:12:38
66	74	1	4339000.00	https://newegg.com	2026-04-09 23:12:51
67	75	1	1659000.00	https://newegg.com	2026-04-09 23:13:04
68	76	1	11219000.00	https://newegg.com	2026-04-09 23:13:17
69	77	1	7419000.00	https://newegg.com	2026-04-09 23:13:32
70	78	1	5019000.00	https://newegg.com	2026-04-09 23:13:45
71	79	1	2529000.00	https://newegg.com	2026-04-09 23:14:01
72	80	1	14209000.00	https://newegg.com	2026-04-09 23:14:14
73	82	1	1939000.00	https://newegg.com	2026-04-09 23:14:40
74	85	1	1069000.00	https://newegg.com	2026-04-09 23:15:04
75	86	1	8929000.00	https://newegg.com	2026-04-09 23:15:18
76	88	1	3269000.00	https://newegg.com	2026-04-09 23:15:31
77	89	1	3339000.00	https://newegg.com	2026-04-09 23:15:47
78	90	1	2039000.00	https://newegg.com	2026-04-09 23:16:00
79	92	1	10969000.00	https://newegg.com	2026-04-09 23:16:28
80	93	1	3449000.00	https://newegg.com	2026-04-09 23:16:40
81	94	1	4519000.00	https://newegg.com	2026-04-09 23:16:52
82	95	1	5079000.00	https://newegg.com	2026-04-09 23:17:04
83	97	1	6119000.00	https://newegg.com	2026-04-09 23:17:15
84	98	1	2169000.00	https://newegg.com	2026-04-09 23:17:29
85	99	1	2429000.00	https://newegg.com	2026-04-09 23:17:44
86	100	1	43329000.00	https://newegg.com	2026-04-09 23:17:57
87	101	1	2309000.00	https://newegg.com	2026-04-09 23:18:12
88	105	1	2299000.00	https://newegg.com	2026-04-09 23:18:38
89	106	1	7629000.00	https://newegg.com	2026-04-09 23:18:50
90	107	1	2729000.00	https://newegg.com	2026-04-09 23:19:03
958	1081	1	6609000.00	\N	2026-04-10 10:10:16
91	108	1	8649000.00	https://newegg.com	2026-04-09 23:19:17
92	109	1	1759000.00	https://newegg.com	2026-04-09 23:19:32
93	110	1	3349000.00	https://newegg.com	2026-04-09 23:19:46
94	112	1	5389000.00	https://newegg.com	2026-04-09 23:20:00
95	114	1	12299000.00	https://newegg.com	2026-04-09 23:20:27
96	115	1	7139000.00	https://newegg.com	2026-04-09 23:20:40
97	117	1	6409000.00	https://newegg.com	2026-04-09 23:21:06
98	118	1	11959000.00	https://newegg.com	2026-04-09 23:21:19
99	119	1	6629000.00	https://newegg.com	2026-04-09 23:21:34
100	120	1	3189000.00	https://newegg.com	2026-04-09 23:21:45
101	121	1	14209000.00	https://newegg.com	2026-04-09 23:21:58
102	123	1	6099000.00	https://newegg.com	2026-04-09 23:22:13
103	126	1	3909000.00	https://newegg.com	2026-04-09 23:22:39
104	127	1	5099000.00	https://newegg.com	2026-04-09 23:22:53
105	128	1	4799000.00	https://newegg.com	2026-04-09 23:23:06
106	129	1	4259000.00	https://newegg.com	2026-04-09 23:23:20
107	130	1	8439000.00	https://newegg.com	2026-04-09 23:23:32
108	131	1	1659000.00	https://newegg.com	2026-04-09 23:23:42
109	133	1	1879000.00	https://newegg.com	2026-04-09 23:23:56
110	134	1	1409000.00	https://newegg.com	2026-04-09 23:24:10
111	135	1	3989000.00	https://newegg.com	2026-04-09 23:24:25
112	136	1	8519000.00	https://newegg.com	2026-04-09 23:24:37
113	138	1	17229000.00	https://newegg.com	2026-04-09 23:24:49
114	139	1	3689000.00	https://newegg.com	2026-04-09 23:25:03
115	141	1	3909000.00	https://newegg.com	2026-04-09 23:25:15
116	142	1	6439000.00	https://newegg.com	2026-04-09 23:25:27
117	143	1	9669000.00	https://newegg.com	2026-04-09 23:25:39
118	144	1	4589000.00	https://newegg.com	2026-04-09 23:25:54
119	145	1	1939000.00	https://newegg.com	2026-04-09 23:26:10
120	147	1	13309000.00	https://newegg.com	2026-04-09 23:26:20
121	148	1	4699000.00	https://newegg.com	2026-04-09 23:26:32
122	149	1	2449000.00	https://newegg.com	2026-04-09 23:26:47
123	151	1	1379000.00	https://newegg.com	2026-04-09 23:26:59
124	152	1	1269000.00	https://newegg.com	2026-04-09 23:27:13
125	154	1	4339000.00	https://newegg.com	2026-04-09 23:27:28
126	157	1	3319000.00	https://newegg.com	2026-04-09 23:27:40
127	158	1	899000.00	https://newegg.com	2026-04-09 23:27:54
128	160	1	6859000.00	https://newegg.com	2026-04-09 23:28:07
129	161	1	3569000.00	https://newegg.com	2026-04-09 23:28:19
130	162	1	1279000.00	https://newegg.com	2026-04-09 23:28:34
131	164	1	6099000.00	https://newegg.com	2026-04-09 23:28:46
132	165	1	869000.00	https://newegg.com	2026-04-09 23:28:59
133	166	1	4369000.00	https://newegg.com	2026-04-09 23:29:13
134	168	1	4209000.00	https://newegg.com	2026-04-09 23:29:27
135	169	1	4849000.00	https://newegg.com	2026-04-09 23:29:39
136	172	1	10459000.00	https://newegg.com	2026-04-09 23:29:52
137	173	1	2269000.00	https://newegg.com	2026-04-09 23:30:06
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
886	860	1	8899000.00	\N	2026-04-10 09:47:20
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
236	762	1	3569000.00	https://newegg.com	2026-04-10 00:08:56
237	763	1	6029000.00	https://newegg.com	2026-04-10 00:09:09
238	772	1	9389000.00	https://newegg.com	2026-04-10 00:10:58
239	774	1	89229000.00	https://newegg.com	2026-04-10 00:11:26
240	775	1	7269000.00	https://newegg.com	2026-04-10 00:11:38
241	777	1	28049000.00	https://newegg.com	2026-04-10 00:11:52
242	778	1	16019000.00	https://newegg.com	2026-04-10 00:12:06
243	781	1	12729000.00	https://newegg.com	2026-04-10 00:12:31
244	793	1	8189000.00	https://newegg.com	2026-04-10 00:14:31
245	798	1	9439000.00	https://newegg.com	2026-04-10 00:15:28
246	806	1	8929000.00	https://newegg.com	2026-04-10 00:16:25
247	807	1	2529000.00	https://newegg.com	2026-04-10 00:16:39
248	813	1	16579000.00	https://newegg.com	2026-04-10 00:17:41
249	818	1	39779000.00	https://newegg.com	2026-04-10 00:18:45
250	821	1	19379000.00	https://newegg.com	2026-04-10 00:19:23
251	833	1	10179000.00	https://newegg.com	2026-04-10 00:20:53
252	836	1	30579000.00	https://newegg.com	2026-04-10 00:21:33
253	841	1	9689000.00	https://newegg.com	2026-04-10 00:22:43
254	842	1	11479000.00	https://newegg.com	2026-04-10 00:22:56
255	843	1	11989000.00	https://newegg.com	2026-04-10 00:23:11
256	850	1	9919000.00	https://newegg.com	2026-04-10 00:24:02
257	868	1	47609000.00	https://newegg.com	2026-04-10 00:26:53
258	881	1	10079000.00	https://newegg.com	2026-04-10 00:28:18
259	884	1	2709000.00	https://newegg.com	2026-04-10 00:28:43
260	900	1	7629000.00	https://newegg.com	2026-04-10 00:30:07
261	903	1	13489000.00	https://newegg.com	2026-04-10 00:30:47
262	904	1	3059000.00	https://newegg.com	2026-04-10 00:31:01
263	926	1	5609000.00	https://newegg.com	2026-04-10 00:33:44
264	944	1	3569000.00	https://newegg.com	2026-04-10 00:35:16
265	947	1	8799000.00	https://newegg.com	2026-04-10 00:35:30
266	948	1	2039000.00	https://newegg.com	2026-04-10 00:35:40
267	958	1	11729000.00	https://newegg.com	2026-04-10 00:36:20
268	963	1	9439000.00	https://newegg.com	2026-04-10 00:36:59
269	966	1	12629000.00	https://newegg.com	2026-04-10 00:37:11
270	970	1	8899000.00	https://newegg.com	2026-04-10 00:37:50
271	973	1	7529000.00	https://newegg.com	2026-04-10 00:38:19
272	976	1	10079000.00	https://newegg.com	2026-04-10 00:38:48
273	982	1	7909000.00	https://newegg.com	2026-04-10 00:39:30
274	988	1	12469000.00	https://newegg.com	2026-04-10 00:40:12
275	993	1	30609000.00	https://newegg.com	2026-04-10 00:40:27
276	1015	1	3569000.00	https://newegg.com	2026-04-10 00:42:20
277	1019	1	7909000.00	https://newegg.com	2026-04-10 00:43:01
278	1022	1	3499000.00	https://newegg.com	2026-04-10 00:43:27
279	1033	1	9949000.00	https://newegg.com	2026-04-10 00:44:59
280	1049	1	12729000.00	https://newegg.com	2026-04-10 00:45:39
281	1056	1	11729000.00	https://newegg.com	2026-04-10 00:46:19
282	1066	1	33099000.00	https://newegg.com	2026-04-10 00:47:12
283	1067	1	23969000.00	https://newegg.com	2026-04-10 00:47:25
284	1073	1	16809000.00	https://newegg.com	2026-04-10 00:47:53
285	1079	1	26829000.00	https://newegg.com	2026-04-10 00:48:26
286	1092	1	5609000.00	https://newegg.com	2026-04-10 00:49:56
287	1125	1	27029000.00	https://newegg.com	2026-04-10 00:53:18
288	1138	1	5099000.00	https://newegg.com	2026-04-10 00:53:48
289	1166	1	12219000.00	https://newegg.com	2026-04-10 00:55:22
290	1174	1	43099000.00	https://newegg.com	2026-04-10 00:55:45
291	1179	1	1869000.00	https://newegg.com	2026-04-10 00:56:22
292	1192	1	12499000.00	https://newegg.com	2026-04-10 00:57:20
293	1238	1	22929000.00	https://newegg.com	2026-04-10 01:01:32
294	1243	1	9539000.00	https://newegg.com	2026-04-10 01:01:47
295	1259	1	8879000.00	https://newegg.com	2026-04-10 01:02:52
296	2849	1	1919000.00	https://newegg.com	2026-04-10 01:03:32
297	2851	1	3799000.00	https://newegg.com	2026-04-10 01:03:47
298	2852	1	1869000.00	https://newegg.com	2026-04-10 01:03:59
299	2853	1	3699000.00	https://newegg.com	2026-04-10 01:04:14
300	2855	1	1829000.00	https://newegg.com	2026-04-10 01:04:27
301	2857	1	3289000.00	https://newegg.com	2026-04-10 01:04:53
302	2860	1	2169000.00	https://newegg.com	2026-04-10 01:05:21
303	2863	1	2299000.00	https://newegg.com	2026-04-10 01:05:51
304	2872	1	9329000.00	https://newegg.com	2026-04-10 01:06:41
305	2875	1	11959000.00	https://newegg.com	2026-04-10 01:06:52
306	2877	1	4339000.00	https://newegg.com	2026-04-10 01:07:02
307	2878	1	2039000.00	https://newegg.com	2026-04-10 01:07:15
308	2883	1	14029000.00	https://newegg.com	2026-04-10 01:07:41
309	2884	1	1179000.00	https://newegg.com	2026-04-10 01:07:55
310	2885	1	1919000.00	https://newegg.com	2026-04-10 01:08:05
311	2887	1	3569000.00	https://newegg.com	2026-04-10 01:08:32
887	861	1	15279000.00	\N	2026-04-10 09:47:38
312	2894	1	7629000.00	https://newegg.com	2026-04-10 01:08:57
313	2895	1	2549000.00	https://newegg.com	2026-04-10 01:09:13
314	2897	1	4339000.00	https://newegg.com	2026-04-10 01:09:29
315	2899	1	7399000.00	https://newegg.com	2026-04-10 01:09:43
316	2901	1	1529000.00	https://newegg.com	2026-04-10 01:09:57
317	2905	1	1789000.00	https://newegg.com	2026-04-10 01:10:54
318	2906	1	4149000.00	https://newegg.com	2026-04-10 01:11:09
319	2913	1	11079000.00	https://newegg.com	2026-04-10 01:11:37
320	2914	1	3189000.00	https://newegg.com	2026-04-10 01:11:51
321	2915	1	2399000.00	https://newegg.com	2026-04-10 01:12:03
322	2916	1	3909000.00	https://newegg.com	2026-04-10 01:12:17
323	2917	1	3569000.00	https://newegg.com	2026-04-10 01:12:32
324	2922	1	6929000.00	https://newegg.com	2026-04-10 01:12:44
325	2924	1	2729000.00	https://newegg.com	2026-04-10 01:13:11
326	2928	1	2149000.00	https://newegg.com	2026-04-10 01:13:52
327	2929	1	6509000.00	https://newegg.com	2026-04-10 01:14:04
328	2931	1	3449000.00	https://newegg.com	2026-04-10 01:14:18
329	2933	1	3569000.00	https://newegg.com	2026-04-10 01:14:32
330	2934	1	6889000.00	https://newegg.com	2026-04-10 01:14:45
331	2936	1	2039000.00	https://newegg.com	2026-04-10 01:15:00
332	2940	1	4079000.00	https://newegg.com	2026-04-10 01:15:29
333	2948	1	4819000.00	https://newegg.com	2026-04-10 01:15:58
334	2951	1	4589000.00	https://newegg.com	2026-04-10 01:16:26
335	2956	1	8929000.00	https://newegg.com	2026-04-10 01:17:08
336	2957	1	2049000.00	https://newegg.com	2026-04-10 01:17:20
337	2958	1	4309000.00	https://newegg.com	2026-04-10 01:17:31
338	2959	1	9909000.00	https://newegg.com	2026-04-10 01:17:43
339	2961	1	2039000.00	https://newegg.com	2026-04-10 01:17:55
340	2964	1	2219000.00	https://newegg.com	2026-04-10 01:18:19
341	2966	1	4029000.00	https://newegg.com	2026-04-10 01:18:34
342	2974	1	1559000.00	https://newegg.com	2026-04-10 01:19:28
343	2986	1	4849000.00	https://newegg.com	2026-04-10 01:20:34
344	2991	1	33129000.00	https://newegg.com	2026-04-10 01:21:04
345	2997	1	4569000.00	https://newegg.com	2026-04-10 01:21:44
346	3000	1	4249000.00	https://newegg.com	2026-04-10 01:22:09
347	3011	1	2419000.00	https://newegg.com	2026-04-10 01:22:34
348	3013	1	1789000.00	https://newegg.com	2026-04-10 01:22:47
349	3020	1	22159000.00	https://newegg.com	2026-04-10 01:23:00
350	3021	1	3059000.00	https://newegg.com	2026-04-10 01:23:15
351	3026	1	8929000.00	https://newegg.com	2026-04-10 01:23:43
352	3027	1	2809000.00	https://newegg.com	2026-04-10 01:23:56
353	3031	1	1659000.00	https://newegg.com	2026-04-10 01:24:37
354	3033	1	7649000.00	https://newegg.com	2026-04-10 01:25:01
355	3037	1	3929000.00	https://newegg.com	2026-04-10 01:25:15
356	3038	1	2299000.00	https://newegg.com	2026-04-10 01:25:30
357	3045	1	15279000.00	https://newegg.com	2026-04-10 01:25:42
358	3054	1	2609000.00	https://newegg.com	2026-04-10 01:25:56
359	3063	1	3829000.00	https://newegg.com	2026-04-10 01:26:22
360	3073	1	3059000.00	https://newegg.com	2026-04-10 01:26:47
361	3075	1	1919000.00	https://newegg.com	2026-04-10 01:27:11
362	3077	1	10149000.00	https://newegg.com	2026-04-10 01:27:37
363	3078	1	2939000.00	https://newegg.com	2026-04-10 01:27:48
364	3085	1	3829000.00	https://newegg.com	2026-04-10 01:28:02
365	3089	1	10969000.00	https://newegg.com	2026-04-10 01:28:29
366	3091	1	3519000.00	https://newegg.com	2026-04-10 01:28:43
367	3096	1	6109000.00	https://newegg.com	2026-04-10 01:29:09
368	3100	1	2249000.00	https://newegg.com	2026-04-10 01:29:38
369	3105	1	3319000.00	https://newegg.com	2026-04-10 01:30:19
370	3107	1	7719000.00	https://newegg.com	2026-04-10 01:30:31
371	3113	1	8339000.00	https://newegg.com	2026-04-10 01:30:43
372	3121	1	3799000.00	https://newegg.com	2026-04-10 01:31:20
373	3124	1	1739000.00	https://newegg.com	2026-04-10 01:31:29
374	3125	1	7629000.00	https://newegg.com	2026-04-10 01:31:43
375	3129	1	7649000.00	https://newegg.com	2026-04-10 01:32:06
376	3139	1	7479000.00	https://newegg.com	2026-04-10 01:33:17
377	3148	1	2549000.00	https://newegg.com	2026-04-10 01:34:01
378	3149	1	5539000.00	https://newegg.com	2026-04-10 01:34:17
379	3166	1	2549000.00	https://newegg.com	2026-04-10 01:35:40
380	3175	1	1789000.00	https://newegg.com	2026-04-10 01:36:35
381	3177	1	1529000.00	https://newegg.com	2026-04-10 01:36:50
382	3181	1	10749000.00	https://newegg.com	2026-04-10 01:37:04
383	3185	1	1149000.00	https://newegg.com	2026-04-10 01:37:17
384	3190	1	3009000.00	https://newegg.com	2026-04-10 01:37:54
385	3191	1	2549000.00	https://newegg.com	2026-04-10 01:38:06
386	3194	1	1529000.00	https://newegg.com	2026-04-10 01:38:17
387	3195	1	6969000.00	https://newegg.com	2026-04-10 01:38:29
388	3196	1	22809000.00	https://newegg.com	2026-04-10 01:38:43
389	3200	1	4009000.00	https://newegg.com	2026-04-10 01:38:56
390	3205	1	5079000.00	https://newegg.com	2026-04-10 01:39:23
391	3206	1	2039000.00	https://newegg.com	2026-04-10 01:39:35
392	3208	1	1739000.00	https://newegg.com	2026-04-10 01:39:48
393	3213	1	7629000.00	https://newegg.com	2026-04-10 01:40:12
394	3218	1	5259000.00	https://newegg.com	2026-04-10 01:40:38
395	3220	1	3549000.00	https://newegg.com	2026-04-10 01:41:09
396	3226	1	1479000.00	https://newegg.com	2026-04-10 01:41:20
397	3232	1	8929000.00	https://newegg.com	2026-04-10 01:41:33
398	3234	1	2299000.00	https://newegg.com	2026-04-10 01:41:43
399	3237	1	3909000.00	https://newegg.com	2026-04-10 01:41:59
888	862	1	32859000.00	\N	2026-04-10 09:47:57
400	3241	1	9629000.00	https://newegg.com	2026-04-10 01:42:12
401	3242	1	6639000.00	https://newegg.com	2026-04-10 01:42:26
402	3253	1	3699000.00	https://newegg.com	2026-04-10 01:43:20
403	3254	1	4929000.00	https://newegg.com	2026-04-10 01:43:36
404	3267	1	1659000.00	https://newegg.com	2026-04-10 01:45:12
405	3268	1	5609000.00	https://newegg.com	2026-04-10 01:45:23
406	3270	1	9219000.00	https://newegg.com	2026-04-10 01:45:51
407	3272	1	3569000.00	https://newegg.com	2026-04-10 01:46:05
408	3275	1	4079000.00	https://newegg.com	2026-04-10 01:46:19
409	3279	1	2499000.00	https://newegg.com	2026-04-10 01:46:32
410	3293	1	2839000.00	https://newegg.com	2026-04-10 01:46:56
411	3303	1	5099000.00	https://newegg.com	2026-04-10 01:47:50
412	3805	1	8289000.00	https://newegg.com	2026-04-10 01:48:03
413	3806	1	849000.00	https://newegg.com	2026-04-10 01:48:19
414	3807	1	3449000.00	https://newegg.com	2026-04-10 01:48:32
415	3809	1	9669000.00	https://newegg.com	2026-04-10 01:49:01
416	3810	1	9569000.00	https://newegg.com	2026-04-10 01:49:12
417	3814	1	639000.00	https://newegg.com	2026-04-10 01:49:53
418	3816	1	1539000.00	https://newegg.com	2026-04-10 01:50:18
419	3817	1	1659000.00	https://newegg.com	2026-04-10 01:50:29
420	3821	1	3699000.00	https://newegg.com	2026-04-10 01:50:52
421	3823	1	1659000.00	https://newegg.com	2026-04-10 01:51:05
422	3824	1	3569000.00	https://newegg.com	2026-04-10 01:51:18
423	3826	1	1029000.00	https://newegg.com	2026-04-10 01:51:46
424	3827	1	4849000.00	https://newegg.com	2026-04-10 01:51:58
425	3832	1	7019000.00	https://newegg.com	2026-04-10 01:52:08
426	3833	1	5059000.00	https://newegg.com	2026-04-10 01:52:23
427	3834	1	3069000.00	https://newegg.com	2026-04-10 01:52:38
428	3838	1	899000.00	https://newegg.com	2026-04-10 01:53:07
429	3839	1	1659000.00	https://newegg.com	2026-04-10 01:53:19
430	3840	1	2659000.00	https://newegg.com	2026-04-10 01:53:34
431	3841	1	1529000.00	https://newegg.com	2026-04-10 01:53:49
432	3842	1	10059000.00	https://newegg.com	2026-04-10 01:54:02
433	3843	1	2169000.00	https://newegg.com	2026-04-10 01:54:17
434	3847	1	3059000.00	https://newegg.com	2026-04-10 01:54:31
435	3848	1	1889000.00	https://newegg.com	2026-04-10 01:54:43
436	3850	1	12859000.00	https://newegg.com	2026-04-10 01:55:11
437	3851	1	3369000.00	https://newegg.com	2026-04-10 01:55:24
438	3859	1	9949000.00	https://newegg.com	2026-04-10 01:55:50
439	3860	1	2759000.00	https://newegg.com	2026-04-10 01:56:06
440	3863	1	1099000.00	https://newegg.com	2026-04-10 01:56:17
441	3865	1	4589000.00	https://newegg.com	2026-04-10 01:56:43
442	3868	1	2259000.00	https://newegg.com	2026-04-10 01:57:09
443	3870	1	10739000.00	https://newegg.com	2026-04-10 01:57:19
444	3871	1	7649000.00	https://newegg.com	2026-04-10 01:57:32
445	3872	1	1539000.00	https://newegg.com	2026-04-10 01:57:45
446	3874	1	1639000.00	https://newegg.com	2026-04-10 01:58:12
447	3875	1	10969000.00	https://newegg.com	2026-04-10 01:58:25
448	3879	1	2879000.00	https://newegg.com	2026-04-10 01:58:40
449	3881	1	17789000.00	https://newegg.com	2026-04-10 01:59:08
450	3886	1	8669000.00	https://newegg.com	2026-04-10 01:59:24
451	3888	1	769000.00	https://newegg.com	2026-04-10 01:59:49
452	3892	1	1199000.00	https://newegg.com	2026-04-10 02:00:02
453	3895	1	3829000.00	https://newegg.com	2026-04-10 02:00:19
454	3897	1	1019000.00	https://newegg.com	2026-04-10 02:00:31
455	3900	1	1539000.00	https://newegg.com	2026-04-10 02:00:47
456	3905	1	639000.00	https://newegg.com	2026-04-10 02:01:31
457	3908	1	2549000.00	https://newegg.com	2026-04-10 02:01:46
458	3918	1	1529000.00	https://newegg.com	2026-04-10 02:02:12
459	3919	1	6889000.00	https://newegg.com	2026-04-10 02:02:25
460	3931	1	1229000.00	https://newegg.com	2026-04-10 02:03:06
461	3936	1	16329000.00	https://newegg.com	2026-04-10 02:03:29
462	3937	1	4209000.00	https://newegg.com	2026-04-10 02:03:45
463	3942	1	39779000.00	https://newegg.com	2026-04-10 02:04:08
464	3949	1	8929000.00	https://newegg.com	2026-04-10 02:04:35
465	3954	1	4469000.00	https://newegg.com	2026-04-10 02:05:03
466	3956	1	5099000.00	https://newegg.com	2026-04-10 02:05:16
467	3959	1	5609000.00	https://newegg.com	2026-04-10 02:05:29
468	3961	1	1939000.00	https://newegg.com	2026-04-10 02:05:43
469	3966	1	1019000.00	https://newegg.com	2026-04-10 02:06:09
470	3969	1	1169000.00	https://newegg.com	2026-04-10 02:06:25
471	3976	1	949000.00	https://newegg.com	2026-04-10 02:06:55
472	3980	1	1419000.00	https://newegg.com	2026-04-10 02:07:08
473	3983	1	5609000.00	https://newegg.com	2026-04-10 02:07:24
474	3986	1	1739000.00	https://newegg.com	2026-04-10 02:07:36
475	3988	1	8009000.00	https://newegg.com	2026-04-10 02:07:48
476	3990	1	10179000.00	https://newegg.com	2026-04-10 02:08:03
477	3994	1	8419000.00	https://newegg.com	2026-04-10 02:08:15
478	3997	1	15049000.00	https://newegg.com	2026-04-10 02:08:30
479	4015	1	1409000.00	https://newegg.com	2026-04-10 02:08:54
480	4016	1	2529000.00	https://newegg.com	2026-04-10 02:09:08
481	4018	1	13779000.00	https://newegg.com	2026-04-10 02:09:21
482	4023	1	9669000.00	https://newegg.com	2026-04-10 02:09:49
483	4026	1	17219000.00	https://newegg.com	2026-04-10 02:10:02
484	4031	1	4589000.00	https://newegg.com	2026-04-10 02:10:17
485	4033	1	4089000.00	https://newegg.com	2026-04-10 02:10:43
486	4041	1	4849000.00	https://newegg.com	2026-04-10 02:11:08
487	4046	1	2049000.00	https://newegg.com	2026-04-10 02:11:22
889	863	1	1509000.00	\N	2026-04-10 09:48:24
488	4054	1	6309000.00	https://newegg.com	2026-04-10 02:11:33
489	4076	1	1869000.00	https://newegg.com	2026-04-10 02:11:47
490	4083	1	7869000.00	https://newegg.com	2026-04-10 02:13:21
491	4094	1	11479000.00	https://newegg.com	2026-04-10 02:13:49
492	4100	1	20399000.00	https://newegg.com	2026-04-10 02:14:04
493	4110	1	689000.00	https://newegg.com	2026-04-10 02:14:31
494	4147	1	769000.00	https://newegg.com	2026-04-10 02:15:26
495	4149	1	1689000.00	https://newegg.com	2026-04-10 02:15:42
496	4150	1	4589000.00	https://newegg.com	2026-04-10 02:15:57
497	4153	1	1919000.00	https://newegg.com	2026-04-10 02:16:11
498	4162	1	2279000.00	https://newegg.com	2026-04-10 02:16:37
499	4180	1	1789000.00	https://newegg.com	2026-04-10 02:17:32
500	4182	1	1149000.00	https://newegg.com	2026-04-10 02:18:00
501	4184	1	769000.00	https://newegg.com	2026-04-10 02:18:12
502	4189	1	2169000.00	https://newegg.com	2026-04-10 02:18:40
503	4191	1	1419000.00	https://newegg.com	2026-04-10 02:18:55
504	4197	1	6379000.00	https://newegg.com	2026-04-10 02:19:24
505	4201	1	1079000.00	https://newegg.com	2026-04-10 02:19:37
506	4248	1	1659000.00	https://newegg.com	2026-04-10 02:20:16
507	4275	1	769000.00	https://newegg.com	2026-04-10 02:20:56
508	4276	1	8339000.00	https://newegg.com	2026-04-10 02:21:09
509	4278	1	6349000.00	https://newegg.com	2026-04-10 02:21:24
510	4300	1	4469000.00	https://newegg.com	2026-04-10 02:22:07
511	4339	1	6539000.00	https://newegg.com	2026-04-10 02:22:20
512	4340	1	2809000.00	https://newegg.com	2026-04-10 02:22:32
513	4341	1	3189000.00	https://newegg.com	2026-04-10 02:22:44
514	4342	1	4849000.00	https://newegg.com	2026-04-10 02:22:56
515	4343	1	2299000.00	https://newegg.com	2026-04-10 02:23:08
516	4344	1	3059000.00	https://newegg.com	2026-04-10 02:23:22
517	4345	1	3649000.00	https://newegg.com	2026-04-10 02:23:35
518	4346	1	3319000.00	https://newegg.com	2026-04-10 02:23:47
519	4347	1	4719000.00	https://newegg.com	2026-04-10 02:24:01
520	4348	1	2549000.00	https://newegg.com	2026-04-10 02:24:15
521	4349	1	3829000.00	https://newegg.com	2026-04-10 02:24:28
522	4350	1	3569000.00	https://newegg.com	2026-04-10 02:24:42
523	4351	1	2039000.00	https://newegg.com	2026-04-10 02:24:54
524	4352	1	4589000.00	https://newegg.com	2026-04-10 02:25:06
525	4353	1	3059000.00	https://newegg.com	2026-04-10 02:25:19
526	4354	1	3829000.00	https://newegg.com	2026-04-10 02:25:28
527	4355	1	3319000.00	https://newegg.com	2026-04-10 02:25:43
528	4356	1	3059000.00	https://newegg.com	2026-04-10 02:25:53
529	4357	1	4339000.00	https://newegg.com	2026-04-10 02:26:05
530	4358	1	4439000.00	https://newegg.com	2026-04-10 02:26:17
531	4359	1	2779000.00	https://newegg.com	2026-04-10 02:26:30
532	4360	1	7349000.00	https://newegg.com	2026-04-10 02:26:41
533	4361	1	2499000.00	https://newegg.com	2026-04-10 02:26:55
534	4362	1	4689000.00	https://newegg.com	2026-04-10 02:27:07
535	4363	1	4029000.00	https://newegg.com	2026-04-10 02:27:21
536	4364	1	3569000.00	https://newegg.com	2026-04-10 02:27:35
537	4475	1	3169000.00	https://newegg.com	2026-04-10 02:27:50
538	4365	1	3059000.00	https://newegg.com	2026-04-10 02:28:05
539	4366	1	2499000.00	https://newegg.com	2026-04-10 02:28:17
540	4367	1	2939000.00	https://newegg.com	2026-04-10 02:28:28
541	4368	1	3959000.00	https://newegg.com	2026-04-10 02:28:41
542	4369	1	2549000.00	https://newegg.com	2026-04-10 02:28:52
543	4370	1	4469000.00	https://newegg.com	2026-04-10 02:29:05
544	4371	1	4929000.00	https://newegg.com	2026-04-10 02:29:18
545	4372	1	2349000.00	https://newegg.com	2026-04-10 02:29:31
546	4373	1	3569000.00	https://newegg.com	2026-04-10 02:29:44
547	4374	1	2449000.00	https://newegg.com	2026-04-10 02:29:55
548	4375	1	3289000.00	https://newegg.com	2026-04-10 02:30:05
549	4376	1	3319000.00	https://newegg.com	2026-04-10 02:30:17
550	4377	1	2039000.00	https://newegg.com	2026-04-10 02:30:32
551	4378	1	6269000.00	https://newegg.com	2026-04-10 02:30:45
552	4379	1	2029000.00	https://newegg.com	2026-04-10 02:31:00
553	4380	1	3959000.00	https://newegg.com	2026-04-10 02:31:15
554	4381	1	2809000.00	https://newegg.com	2026-04-10 02:31:29
555	4382	1	2609000.00	https://newegg.com	2026-04-10 02:31:40
556	4383	1	3189000.00	https://newegg.com	2026-04-10 02:31:53
557	4384	1	10709000.00	https://newegg.com	2026-04-10 02:32:05
558	4385	1	2709000.00	https://newegg.com	2026-04-10 02:32:15
559	4386	1	3059000.00	https://newegg.com	2026-04-10 02:32:26
560	4387	1	2609000.00	https://newegg.com	2026-04-10 02:32:37
561	4388	1	4079000.00	https://newegg.com	2026-04-10 02:32:53
562	4389	1	3569000.00	https://newegg.com	2026-04-10 02:33:06
563	4390	1	1659000.00	https://newegg.com	2026-04-10 02:33:21
564	4391	1	2809000.00	https://newegg.com	2026-04-10 02:33:33
565	4392	1	3829000.00	https://newegg.com	2026-04-10 02:33:45
566	4393	1	5359000.00	https://newegg.com	2026-04-10 02:33:57
567	4394	1	2039000.00	https://newegg.com	2026-04-10 02:34:10
568	4395	1	3829000.00	https://newegg.com	2026-04-10 02:34:21
569	4396	1	5609000.00	https://newegg.com	2026-04-10 02:34:34
570	4397	1	4849000.00	https://newegg.com	2026-04-10 02:34:48
571	4398	1	8929000.00	https://newegg.com	2026-04-10 02:35:00
572	4399	1	3449000.00	https://newegg.com	2026-04-10 02:35:15
573	4400	1	3699000.00	https://newegg.com	2026-04-10 02:35:28
574	4401	1	4589000.00	https://newegg.com	2026-04-10 02:35:39
575	4402	1	3649000.00	https://newegg.com	2026-04-10 02:35:52
890	864	1	7649000.00	\N	2026-04-10 09:48:44
576	4403	1	4439000.00	https://newegg.com	2026-04-10 02:36:07
577	4404	1	47429000.00	https://newegg.com	2026-04-10 02:36:18
578	4405	1	3569000.00	https://newegg.com	2026-04-10 02:36:31
579	4406	1	2549000.00	https://newegg.com	2026-04-10 02:36:44
580	4407	1	5359000.00	https://newegg.com	2026-04-10 02:36:56
581	4408	1	3569000.00	https://newegg.com	2026-04-10 02:37:11
582	4409	1	2499000.00	https://newegg.com	2026-04-10 02:37:21
583	4410	1	6379000.00	https://newegg.com	2026-04-10 02:37:35
584	4411	1	4809000.00	https://newegg.com	2026-04-10 02:37:48
585	4412	1	4589000.00	https://newegg.com	2026-04-10 02:38:02
586	4413	1	4719000.00	https://newegg.com	2026-04-10 02:38:17
587	4414	1	2039000.00	https://newegg.com	2026-04-10 02:38:29
588	4415	1	3469000.00	https://newegg.com	2026-04-10 02:38:41
589	4416	1	3059000.00	https://newegg.com	2026-04-10 02:38:54
590	4417	1	2299000.00	https://newegg.com	2026-04-10 02:39:06
591	4418	1	2809000.00	https://newegg.com	2026-04-10 02:39:17
592	4419	1	2649000.00	https://newegg.com	2026-04-10 02:39:29
593	4421	1	2549000.00	https://newegg.com	2026-04-10 02:39:54
594	4422	1	2019000.00	https://newegg.com	2026-04-10 02:40:06
595	4423	1	26929000.00	https://newegg.com	2026-04-10 02:40:17
596	4424	1	4719000.00	https://newegg.com	2026-04-10 02:40:30
597	4425	1	3829000.00	https://newegg.com	2026-04-10 02:40:42
598	4426	1	3599000.00	https://newegg.com	2026-04-10 02:40:53
599	4427	1	22929000.00	https://newegg.com	2026-04-10 02:41:06
600	4428	1	2329000.00	https://newegg.com	2026-04-10 02:41:20
601	4429	1	4039000.00	https://newegg.com	2026-04-10 02:41:34
602	4430	1	4439000.00	https://newegg.com	2026-04-10 02:41:46
603	4431	1	6059000.00	https://newegg.com	2026-04-10 02:41:58
604	4432	1	3829000.00	https://newegg.com	2026-04-10 02:42:11
605	4433	1	1529000.00	https://newegg.com	2026-04-10 02:42:24
606	4434	1	5999000.00	https://newegg.com	2026-04-10 02:42:38
607	4435	1	9719000.00	https://newegg.com	2026-04-10 02:42:49
608	4436	1	6989000.00	https://newegg.com	2026-04-10 02:43:04
609	4437	1	2809000.00	https://newegg.com	2026-04-10 02:43:15
610	4438	1	3319000.00	https://newegg.com	2026-04-10 02:43:26
611	4439	1	2299000.00	https://newegg.com	2026-04-10 02:43:37
612	4440	1	3059000.00	https://newegg.com	2026-04-10 02:43:52
613	4441	1	2809000.00	https://newegg.com	2026-04-10 02:44:04
614	4442	1	4339000.00	https://newegg.com	2026-04-10 02:44:15
615	4443	1	5739000.00	https://newegg.com	2026-04-10 02:44:27
616	4446	1	4339000.00	https://newegg.com	2026-04-10 02:44:53
617	4447	1	4589000.00	https://newegg.com	2026-04-10 02:45:08
618	4448	1	3319000.00	https://newegg.com	2026-04-10 02:45:21
619	4449	1	4589000.00	https://newegg.com	2026-04-10 02:45:36
620	4450	1	4339000.00	https://newegg.com	2026-04-10 02:45:49
621	4451	1	2149000.00	https://newegg.com	2026-04-10 02:46:04
622	4453	1	4439000.00	https://newegg.com	2026-04-10 02:46:31
623	4455	1	3569000.00	https://newegg.com	2026-04-10 02:46:44
624	4456	1	4079000.00	https://newegg.com	2026-04-10 02:46:56
625	4457	1	3959000.00	https://newegg.com	2026-04-10 02:47:09
626	4458	1	10429000.00	https://newegg.com	2026-04-10 02:47:21
627	4460	1	3569000.00	https://newegg.com	2026-04-10 02:47:48
628	4462	1	3829000.00	https://newegg.com	2026-04-10 02:48:01
629	4463	1	4079000.00	https://newegg.com	2026-04-10 02:48:16
630	4464	1	4059000.00	https://newegg.com	2026-04-10 02:48:31
631	4465	1	2429000.00	https://newegg.com	2026-04-10 02:48:43
632	4467	1	3599000.00	https://newegg.com	2026-04-10 02:48:55
633	4468	1	3059000.00	https://newegg.com	2026-04-10 02:49:06
634	4469	1	4419000.00	https://newegg.com	2026-04-10 02:49:19
635	4470	1	3569000.00	https://newegg.com	2026-04-10 02:49:33
636	4471	1	5669000.00	https://newegg.com	2026-04-10 02:49:47
637	4472	1	2789000.00	https://newegg.com	2026-04-10 02:50:00
638	4473	1	2549000.00	https://newegg.com	2026-04-10 02:50:12
639	4474	1	5869000.00	https://newegg.com	2026-04-10 02:50:23
640	4476	1	6859000.00	https://newegg.com	2026-04-10 02:50:35
641	4477	1	4849000.00	https://newegg.com	2026-04-10 02:50:48
642	4478	1	3569000.00	https://newegg.com	2026-04-10 02:51:01
643	4479	1	4589000.00	https://newegg.com	2026-04-10 02:51:14
644	4480	1	6379000.00	https://newegg.com	2026-04-10 02:51:28
645	4481	1	3829000.00	https://newegg.com	2026-04-10 02:51:42
646	4482	1	4339000.00	https://newegg.com	2026-04-10 02:51:53
647	4483	1	3979000.00	https://newegg.com	2026-04-10 02:52:08
648	4485	1	3799000.00	https://newegg.com	2026-04-10 02:52:22
649	4487	1	4749000.00	https://newegg.com	2026-04-10 02:52:32
650	4488	1	3219000.00	https://newegg.com	2026-04-10 02:52:45
651	4489	1	6829000.00	https://newegg.com	2026-04-10 02:52:58
652	4490	1	2149000.00	https://newegg.com	2026-04-10 02:53:11
653	4491	1	4079000.00	https://newegg.com	2026-04-10 02:53:24
654	4492	1	4539000.00	https://newegg.com	2026-04-10 02:53:35
655	4493	1	4169000.00	https://newegg.com	2026-04-10 02:53:49
656	4494	1	7139000.00	https://newegg.com	2026-04-10 02:54:03
657	4495	1	4339000.00	https://newegg.com	2026-04-10 02:54:14
658	4497	1	18869000.00	https://newegg.com	2026-04-10 02:54:31
659	4498	1	4819000.00	https://newegg.com	2026-04-10 02:54:44
660	4500	1	4079000.00	https://newegg.com	2026-04-10 02:54:56
661	4501	1	2299000.00	https://newegg.com	2026-04-10 02:55:09
662	4502	1	3319000.00	https://newegg.com	2026-04-10 02:55:21
663	4503	1	3569000.00	https://newegg.com	2026-04-10 02:55:34
891	867	1	17219000.00	\N	2026-04-10 09:49:00
664	4505	1	3059000.00	https://newegg.com	2026-04-10 02:55:45
665	4506	1	3829000.00	https://newegg.com	2026-04-10 02:55:59
666	4507	1	3319000.00	https://newegg.com	2026-04-10 02:56:12
667	4508	1	7129000.00	https://newegg.com	2026-04-10 02:56:25
668	4509	1	3569000.00	https://newegg.com	2026-04-10 02:56:35
669	4511	1	2299000.00	https://newegg.com	2026-04-10 02:56:59
670	4512	1	2429000.00	https://newegg.com	2026-04-10 02:57:11
671	4513	1	2939000.00	https://newegg.com	2026-04-10 02:57:21
672	4514	1	3189000.00	https://newegg.com	2026-04-10 02:57:32
673	4515	1	6379000.00	https://newegg.com	2026-04-10 02:57:48
674	4516	1	12219000.00	https://newegg.com	2026-04-10 02:58:03
675	4517	1	15649000.00	https://newegg.com	2026-04-10 02:58:15
676	4519	1	4079000.00	https://newegg.com	2026-04-10 02:58:40
677	4520	1	2069000.00	https://newegg.com	2026-04-10 02:58:53
678	4521	1	5489000.00	https://newegg.com	2026-04-10 02:59:06
679	4523	1	5099000.00	https://newegg.com	2026-04-10 02:59:31
680	4524	1	2349000.00	https://newegg.com	2026-04-10 02:59:42
681	4525	1	4849000.00	https://newegg.com	2026-04-10 02:59:53
682	4527	1	3549000.00	https://newegg.com	2026-04-10 03:00:07
683	4528	1	4079000.00	https://newegg.com	2026-04-10 03:00:22
684	4532	1	2569000.00	https://newegg.com	2026-04-10 03:00:46
685	4533	1	2609000.00	https://newegg.com	2026-04-10 03:01:02
686	4534	1	2399000.00	https://newegg.com	2026-04-10 03:01:15
687	4535	1	4589000.00	https://newegg.com	2026-04-10 03:01:25
688	4536	1	3059000.00	https://newegg.com	2026-04-10 03:01:39
689	4537	1	3319000.00	https://newegg.com	2026-04-10 03:01:52
690	4538	1	3059000.00	https://newegg.com	2026-04-10 03:02:06
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
892	869	1	9409000.00	\N	2026-04-10 09:49:20
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
794	50	1	4619000.00	https://newegg.com	2026-04-10 09:31:03
795	81	1	3289000.00	https://newegg.com	2026-04-10 09:31:14
796	84	1	1039000.00	https://newegg.com	2026-04-10 09:31:25
797	91	1	1919000.00	https://newegg.com	2026-04-10 09:31:38
798	103	1	1049000.00	https://newegg.com	2026-04-10 09:31:50
861	113	1	5409000.00	\N	2026-04-10 09:39:16
862	116	1	6749000.00	\N	2026-04-10 09:40:09
863	124	1	7649000.00	\N	2026-04-10 09:40:25
864	764	1	12249000.00	\N	2026-04-10 09:40:34
865	765	1	7629000.00	\N	2026-04-10 09:40:51
866	766	1	17219000.00	\N	2026-04-10 09:41:06
867	768	1	9179000.00	\N	2026-04-10 09:41:22
868	769	1	19229000.00	\N	2026-04-10 09:41:41
869	770	1	8289000.00	\N	2026-04-10 09:41:59
870	771	1	12169000.00	\N	2026-04-10 09:42:21
871	773	1	22419000.00	\N	2026-04-10 09:42:41
872	835	1	12239000.00	\N	2026-04-10 09:43:00
873	837	1	20379000.00	\N	2026-04-10 09:43:18
874	838	1	96899000.00	\N	2026-04-10 09:43:33
829	780	1	5849000.00	\N	2026-04-10 09:16:55
830	783	1	14789000.00	\N	2026-04-10 09:17:11
831	784	1	3339000.00	\N	2026-04-10 09:17:24
832	785	1	5589000.00	\N	2026-04-10 09:17:37
833	786	1	6349000.00	\N	2026-04-10 09:17:49
834	787	1	2019000.00	\N	2026-04-10 09:18:03
835	789	1	10179000.00	\N	2026-04-10 09:18:14
836	790	1	9409000.00	\N	2026-04-10 09:18:25
837	792	1	1659000.00	\N	2026-04-10 09:18:40
838	794	1	9189000.00	\N	2026-04-10 09:18:51
839	795	1	14999000.00	\N	2026-04-10 09:19:13
840	796	1	9179000.00	\N	2026-04-10 09:19:32
841	800	1	4589000.00	\N	2026-04-10 09:19:46
842	802	1	8929000.00	\N	2026-04-10 09:19:59
843	803	1	11429000.00	\N	2026-04-10 09:20:12
844	808	1	5719000.00	\N	2026-04-10 09:20:27
845	809	1	2529000.00	\N	2026-04-10 09:20:41
846	810	1	6349000.00	\N	2026-04-10 09:20:57
847	811	1	3699000.00	\N	2026-04-10 09:21:10
848	814	1	7599000.00	\N	2026-04-10 09:21:25
849	815	1	6859000.00	\N	2026-04-10 09:21:39
850	816	1	5589000.00	\N	2026-04-10 09:21:51
851	817	1	6119000.00	\N	2026-04-10 09:22:03
852	819	1	10199000.00	\N	2026-04-10 09:22:17
853	820	1	7629000.00	\N	2026-04-10 09:22:30
854	824	1	5609000.00	\N	2026-04-10 09:22:43
855	825	1	5589000.00	\N	2026-04-10 09:22:54
856	827	1	10199000.00	\N	2026-04-10 09:23:06
857	830	1	3549000.00	\N	2026-04-10 09:23:19
858	831	1	3959000.00	\N	2026-04-10 09:23:30
859	832	1	46639000.00	\N	2026-04-10 09:23:42
860	834	1	12169000.00	\N	2026-04-10 09:23:54
793	46	1	8369000.00	https://newegg.com	2026-04-10 09:30:23
875	839	1	38519000.00	\N	2026-04-10 09:43:52
876	840	1	38519000.00	\N	2026-04-10 09:44:12
877	844	1	2249000.00	\N	2026-04-10 09:44:32
878	847	1	10179000.00	\N	2026-04-10 09:44:52
879	849	1	1289000.00	\N	2026-04-10 09:45:10
880	852	1	2959000.00	\N	2026-04-10 09:45:30
881	854	1	10709000.00	\N	2026-04-10 09:45:49
882	855	1	22159000.00	\N	2026-04-10 09:46:10
883	856	1	8389000.00	\N	2026-04-10 09:46:32
884	858	1	18489000.00	\N	2026-04-10 09:46:49
885	859	1	11709000.00	\N	2026-04-10 09:47:05
895	876	1	3059000.00	\N	2026-04-10 09:50:06
896	880	1	40779000.00	\N	2026-04-10 09:50:24
897	883	1	17009000.00	\N	2026-04-10 09:50:41
898	888	1	15179000.00	\N	2026-04-10 09:50:57
899	893	1	17799000.00	\N	2026-04-10 09:51:15
900	895	1	9179000.00	\N	2026-04-10 09:51:37
901	896	1	7629000.00	\N	2026-04-10 09:51:58
902	897	1	1409000.00	\N	2026-04-10 09:52:15
903	901	1	2299000.00	\N	2026-04-10 09:52:35
904	902	1	39559000.00	\N	2026-04-10 09:52:49
905	906	1	85429000.00	\N	2026-04-10 09:53:04
906	911	1	16579000.00	\N	2026-04-10 09:53:29
907	912	1	9409000.00	\N	2026-04-10 09:53:46
908	913	1	18489000.00	\N	2026-04-10 09:54:04
909	915	1	7529000.00	\N	2026-04-10 09:54:23
910	917	1	36459000.00	\N	2026-04-10 09:54:44
911	918	1	9689000.00	\N	2026-04-10 09:54:57
912	919	1	9389000.00	\N	2026-04-10 09:55:16
913	920	1	9689000.00	\N	2026-04-10 09:55:32
914	923	1	7629000.00	\N	2026-04-10 09:55:49
915	925	1	2549000.00	\N	2026-04-10 09:56:09
916	929	1	15809000.00	\N	2026-04-10 09:56:29
917	931	1	9389000.00	\N	2026-04-10 09:56:43
918	932	1	11479000.00	\N	2026-04-10 09:56:58
919	936	1	8899000.00	\N	2026-04-10 09:57:16
920	938	1	7629000.00	\N	2026-04-10 09:57:34
921	941	1	22419000.00	\N	2026-04-10 09:57:51
922	952	1	18949000.00	\N	2026-04-10 09:58:09
923	955	1	8289000.00	\N	2026-04-10 09:58:28
924	960	1	40779000.00	\N	2026-04-10 09:58:46
925	962	1	6379000.00	\N	2026-04-10 09:59:04
926	968	1	6509000.00	\N	2026-04-10 09:59:23
927	969	1	7629000.00	\N	2026-04-10 09:59:44
928	971	1	16219000.00	\N	2026-04-10 10:00:00
929	974	1	19099000.00	\N	2026-04-10 10:00:19
930	977	1	5049000.00	\N	2026-04-10 10:00:39
931	980	1	22319000.00	\N	2026-04-10 10:00:56
932	986	1	12239000.00	\N	2026-04-10 10:01:17
933	987	1	7629000.00	\N	2026-04-10 10:01:41
934	995	1	9309000.00	\N	2026-04-10 10:02:02
935	997	1	11709000.00	\N	2026-04-10 10:02:16
936	1003	1	15809000.00	\N	2026-04-10 10:02:36
937	1006	1	3649000.00	\N	2026-04-10 10:03:21
938	1011	1	17729000.00	\N	2026-04-10 10:03:44
939	1012	1	8899000.00	\N	2026-04-10 10:04:00
940	1016	1	8899000.00	\N	2026-04-10 10:04:16
941	1017	1	1919000.00	\N	2026-04-10 10:04:31
942	1021	1	8929000.00	\N	2026-04-10 10:04:46
943	1023	1	1459000.00	\N	2026-04-10 10:05:03
944	1025	1	6509000.00	\N	2026-04-10 10:05:24
945	1026	1	7529000.00	\N	2026-04-10 10:05:43
946	1029	1	9819000.00	\N	2026-04-10 10:06:01
947	1030	1	2549000.00	\N	2026-04-10 10:06:24
948	1037	1	38519000.00	\N	2026-04-10 10:06:38
949	1047	1	9819000.00	\N	2026-04-10 10:07:31
950	1050	1	85429000.00	\N	2026-04-10 10:07:48
951	1052	1	12729000.00	\N	2026-04-10 10:08:13
952	1061	1	9409000.00	\N	2026-04-10 10:08:31
953	1064	1	14029000.00	\N	2026-04-10 10:08:49
954	1065	1	8809000.00	\N	2026-04-10 10:09:10
955	1070	1	22319000.00	\N	2026-04-10 10:09:26
956	1077	1	11709000.00	\N	2026-04-10 10:09:43
959	1082	1	6299000.00	\N	2026-04-10 10:10:32
960	1088	1	19099000.00	\N	2026-04-10 10:10:53
961	1089	1	25219000.00	\N	2026-04-10 10:11:09
962	1093	1	4399000.00	\N	2026-04-10 10:11:23
963	1095	1	7649000.00	\N	2026-04-10 10:11:39
964	1096	1	38519000.00	\N	2026-04-10 10:11:56
965	1098	1	8649000.00	\N	2026-04-10 10:12:17
966	1100	1	8809000.00	\N	2026-04-10 10:12:37
967	1101	1	6379000.00	\N	2026-04-10 10:12:57
968	1103	1	14029000.00	\N	2026-04-10 10:13:11
969	1106	1	4059000.00	\N	2026-04-10 10:13:25
970	1107	1	7529000.00	\N	2026-04-10 10:14:12
971	1110	1	22419000.00	\N	2026-04-10 10:14:27
972	1113	1	5609000.00	\N	2026-04-10 10:14:46
973	1118	1	2449000.00	\N	2026-04-10 10:15:01
974	1122	1	1019000.00	\N	2026-04-10 10:15:16
975	1129	1	8289000.00	\N	2026-04-10 10:15:31
976	1145	1	17929000.00	\N	2026-04-10 10:15:51
977	1146	1	6249000.00	\N	2026-04-10 10:16:12
978	1148	1	2249000.00	\N	2026-04-10 10:16:30
979	1149	1	7139000.00	\N	2026-04-10 10:16:57
980	1150	1	85429000.00	\N	2026-04-10 10:17:15
981	1154	1	104039000.00	\N	2026-04-10 10:17:42
982	1172	1	9819000.00	\N	2026-04-10 10:17:58
983	1176	1	8389000.00	\N	2026-04-10 10:18:13
984	1178	1	16199000.00	\N	2026-04-10 10:18:28
985	1180	1	9179000.00	\N	2026-04-10 10:18:49
986	1186	1	15939000.00	\N	2026-04-10 10:19:07
987	1187	1	17849000.00	\N	2026-04-10 10:19:24
988	1193	1	12629000.00	\N	2026-04-10 10:19:43
989	1194	1	8389000.00	\N	2026-04-10 10:20:00
990	1197	1	8289000.00	\N	2026-04-10 10:20:22
991	1199	1	22699000.00	\N	2026-04-10 10:20:46
992	1200	1	38519000.00	\N	2026-04-10 10:21:03
993	1205	1	9409000.00	\N	2026-04-10 10:21:25
994	1207	1	319000.00	\N	2026-04-10 10:21:38
995	1214	1	39559000.00	\N	2026-04-10 10:21:58
996	1215	1	11959000.00	\N	2026-04-10 10:22:17
997	1219	1	5589000.00	\N	2026-04-10 10:22:36
998	1220	1	8389000.00	\N	2026-04-10 10:22:54
999	1222	1	17299000.00	\N	2026-04-10 10:23:14
1000	1223	1	17849000.00	\N	2026-04-10 10:23:32
1001	1224	1	10179000.00	\N	2026-04-10 10:24:00
1002	1229	1	12249000.00	\N	2026-04-10 10:24:17
1003	1231	1	17849000.00	\N	2026-04-10 10:24:34
1004	1233	1	22699000.00	\N	2026-04-10 10:24:50
1005	1246	1	22699000.00	\N	2026-04-10 10:25:06
1006	1252	1	16579000.00	\N	2026-04-10 10:25:24
1007	1254	1	309000.00	\N	2026-04-10 10:25:40
1008	1256	1	10709000.00	\N	2026-04-10 10:25:56
1009	1261	1	17299000.00	\N	2026-04-10 10:26:15
1010	2331	1	38519000.00	\N	2026-04-10 10:26:29
1011	4739	1	6889000.00	\N	2026-04-10 10:26:56
1012	4740	1	11169000.00	\N	2026-04-10 10:27:15
1013	4741	1	3039000.00	\N	2026-04-10 10:27:32
1014	4742	1	5079000.00	\N	2026-04-10 10:27:52
1015	4743	1	4109000.00	\N	2026-04-10 10:28:11
1016	4744	1	5079000.00	\N	2026-04-10 10:28:32
1017	4745	1	9439000.00	\N	2026-04-10 10:28:50
1018	4746	1	22929000.00	\N	2026-04-10 10:29:08
1019	4747	1	17829000.00	\N	2026-04-10 10:29:22
1020	4748	1	6629000.00	\N	2026-04-10 10:29:36
1021	4749	1	12499000.00	\N	2026-04-10 10:29:49
1022	4750	1	9439000.00	\N	2026-04-10 10:30:06
1023	4751	1	6889000.00	\N	2026-04-10 10:30:23
1024	4754	1	3539000.00	\N	2026-04-10 10:30:38
1025	4755	1	3319000.00	\N	2026-04-10 10:30:56
1026	4757	1	7019000.00	\N	2026-04-10 10:31:15
1027	4758	1	22929000.00	\N	2026-04-10 10:31:32
1028	4759	1	6629000.00	\N	2026-04-10 10:31:46
1029	4762	1	4079000.00	\N	2026-04-10 10:32:02
1030	4763	1	4079000.00	\N	2026-04-10 10:32:22
1031	4764	1	4079000.00	\N	2026-04-10 10:32:41
1032	4765	1	10939000.00	\N	2026-04-10 10:32:59
1033	4766	1	21649000.00	\N	2026-04-10 10:33:18
1034	4767	1	3319000.00	\N	2026-04-10 10:33:38
1035	4768	1	6119000.00	\N	2026-04-10 10:33:54
1036	4771	1	30039000.00	\N	2026-04-10 10:34:10
1037	4772	1	9689000.00	\N	2026-04-10 10:34:27
1038	4776	1	4079000.00	\N	2026-04-10 10:34:41
1039	4778	1	3319000.00	\N	2026-04-10 10:34:57
1040	4779	1	569000.00	\N	2026-04-10 10:35:17
1041	4782	1	11479000.00	\N	2026-04-10 10:35:34
1042	4783	1	10939000.00	\N	2026-04-10 10:35:48
1043	4784	1	5869000.00	\N	2026-04-10 10:36:06
1044	4785	1	7649000.00	\N	2026-04-10 10:36:23
1045	4788	1	1429000.00	\N	2026-04-10 10:36:41
1046	4789	1	11479000.00	\N	2026-04-10 10:36:56
1047	4794	1	3829000.00	\N	2026-04-10 10:37:10
1048	4796	1	15809000.00	\N	2026-04-10 10:37:30
1049	4797	1	10199000.00	\N	2026-04-10 10:37:47
1050	4798	1	19129000.00	\N	2026-04-10 10:38:05
1051	4799	1	11219000.00	\N	2026-04-10 10:38:23
1052	4801	1	2709000.00	\N	2026-04-10 10:38:41
1053	4802	1	15049000.00	\N	2026-04-10 10:38:57
1054	4803	1	1429000.00	\N	2026-04-10 10:39:14
1055	4805	1	3039000.00	\N	2026-04-10 10:39:28
1056	4806	1	22569000.00	\N	2026-04-10 10:39:46
1057	4807	1	61199000.00	\N	2026-04-10 10:40:03
1058	4812	1	4079000.00	\N	2026-04-10 10:40:18
1059	4813	1	4079000.00	\N	2026-04-10 10:40:35
1060	4817	1	1629000.00	\N	2026-04-10 10:40:56
1061	4819	1	10199000.00	\N	2026-04-10 10:41:13
1062	4820	1	4079000.00	\N	2026-04-10 10:41:28
1063	4822	1	11169000.00	\N	2026-04-10 10:41:44
1064	4825	1	3319000.00	\N	2026-04-10 10:42:03
1065	4828	1	4469000.00	\N	2026-04-10 10:42:22
1066	4830	1	40679000.00	\N	2026-04-10 10:42:42
1067	4831	1	3959000.00	\N	2026-04-10 10:43:00
1068	4832	1	9139000.00	\N	2026-04-10 10:43:13
1069	4833	1	22929000.00	\N	2026-04-10 10:43:30
1070	4837	1	3959000.00	\N	2026-04-10 10:43:47
1071	4839	1	2709000.00	\N	2026-04-10 10:44:02
1072	4846	1	5099000.00	\N	2026-04-10 10:44:17
1073	4847	1	11169000.00	\N	2026-04-10 10:44:34
1074	4853	1	1429000.00	\N	2026-04-10 10:44:50
1075	4854	1	10929000.00	\N	2026-04-10 10:45:04
1076	4857	1	5869000.00	\N	2026-04-10 10:45:19
1077	4861	1	1759000.00	\N	2026-04-10 10:45:35
1078	4864	1	5079000.00	\N	2026-04-10 10:45:48
1079	4866	1	1659000.00	\N	2026-04-10 10:46:04
1080	4867	1	5609000.00	\N	2026-04-10 10:46:17
1081	4868	1	16679000.00	\N	2026-04-10 10:46:30
1082	4873	1	11169000.00	\N	2026-04-10 10:46:48
1083	4874	1	4329000.00	\N	2026-04-10 10:47:06
1084	4875	1	1789000.00	\N	2026-04-10 10:47:27
1085	4876	1	1429000.00	\N	2026-04-10 10:47:42
1086	4884	1	3169000.00	\N	2026-04-10 10:47:56
1087	4886	1	5439000.00	\N	2026-04-10 10:48:11
1088	4889	1	639000.00	\N	2026-04-10 10:48:27
1089	4891	1	1009000.00	\N	2026-04-10 10:48:49
1090	4896	1	2399000.00	\N	2026-04-10 10:49:02
1091	4899	1	8419000.00	\N	2026-04-10 10:49:21
1092	4901	1	9689000.00	\N	2026-04-10 10:49:35
1093	4902	1	1009000.00	\N	2026-04-10 10:49:49
1094	4903	1	23339000.00	\N	2026-04-10 10:50:07
1095	4910	1	1379000.00	\N	2026-04-10 10:50:25
1096	4916	1	5869000.00	\N	2026-04-10 10:50:42
1097	4922	1	4109000.00	\N	2026-04-10 10:50:59
1098	4934	1	889000.00	\N	2026-04-10 10:51:18
1099	4935	1	11169000.00	\N	2026-04-10 10:51:39
1100	3808	1	4599000.00	\N	2026-04-10 10:51:56
1101	3812	1	269000.00	\N	2026-04-10 10:52:11
1102	3813	1	999000.00	\N	2026-04-10 10:52:30
1103	3815	1	1129000.00	\N	2026-04-10 10:52:46
1104	3818	1	969000.00	\N	2026-04-10 10:53:04
1105	3825	1	1459000.00	\N	2026-04-10 10:53:21
1106	3837	1	769000.00	\N	2026-04-10 10:53:37
1107	3849	1	849000.00	\N	2026-04-10 10:53:55
1108	3857	1	3189000.00	\N	2026-04-10 10:54:14
1109	3864	1	899000.00	\N	2026-04-10 10:54:29
1110	3867	1	12729000.00	\N	2026-04-10 10:54:43
1111	3873	1	689000.00	\N	2026-04-10 10:55:00
1112	3880	1	1029000.00	\N	2026-04-10 10:55:21
1113	3887	1	1249000.00	\N	2026-04-10 10:55:41
1114	3902	1	969000.00	\N	2026-04-10 10:55:59
1115	3904	1	1099000.00	\N	2026-04-10 10:56:19
1116	3910	1	999000.00	\N	2026-04-10 10:56:36
1117	3921	1	849000.00	\N	2026-04-10 10:56:52
1118	3923	1	1029000.00	\N	2026-04-10 10:57:08
1119	3935	1	999000.00	\N	2026-04-10 10:57:28
1120	3938	1	2799000.00	\N	2026-04-10 10:57:46
1121	3946	1	1099000.00	\N	2026-04-10 10:58:04
1122	3953	1	999000.00	\N	2026-04-10 10:58:20
1123	3962	1	689000.00	\N	2026-04-10 10:58:37
1124	3972	1	3569000.00	\N	2026-04-10 10:58:56
1125	4006	1	309000.00	\N	2026-04-10 10:59:13
1126	4021	1	1029000.00	\N	2026-04-10 10:59:32
1127	4032	1	2549000.00	\N	2026-04-10 10:59:49
1128	4038	1	459000.00	\N	2026-04-10 11:00:08
1129	4079	1	899000.00	\N	2026-04-10 11:00:23
1130	4081	1	769000.00	\N	2026-04-10 11:00:41
1131	4091	1	999000.00	\N	2026-04-10 11:00:56
1132	4104	1	1259000.00	\N	2026-04-10 11:01:09
1133	4116	1	1149000.00	\N	2026-04-10 11:01:24
1134	4134	1	899000.00	\N	2026-04-10 11:01:42
1135	4145	1	869000.00	\N	2026-04-10 11:02:01
1136	4161	1	2399000.00	\N	2026-04-10 11:02:16
1137	4171	1	769000.00	\N	2026-04-10 11:02:36
1138	4172	1	969000.00	\N	2026-04-10 11:02:56
1139	4177	1	899000.00	\N	2026-04-10 11:03:14
1140	4181	1	999000.00	\N	2026-04-10 11:03:32
1141	4185	1	329000.00	\N	2026-04-10 11:03:52
1142	4193	1	1049000.00	\N	2026-04-10 11:04:08
1143	4231	1	3039000.00	\N	2026-04-10 11:04:28
1144	4247	1	899000.00	\N	2026-04-10 11:04:43
1145	4256	1	309000.00	\N	2026-04-10 11:05:03
1146	4272	1	999000.00	\N	2026-04-10 11:05:22
1147	4286	1	1379000.00	\N	2026-04-10 11:05:39
1148	4295	1	769000.00	\N	2026-04-10 11:05:59
1149	4420	1	7909000.00	\N	2026-04-10 11:06:15
1150	4444	1	4999000.00	\N	2026-04-10 11:06:31
1151	4452	1	3139000.00	\N	2026-04-10 11:06:45
1152	4459	1	3829000.00	\N	2026-04-10 11:07:03
1153	4510	1	2839000.00	\N	2026-04-10 11:07:19
1154	4518	1	2329000.00	\N	2026-04-10 11:07:35
1155	4522	1	2699000.00	\N	2026-04-10 11:07:53
1156	4530	1	1919000.00	\N	2026-04-10 11:08:11
1157	2856	1	2549000.00	\N	2026-04-10 11:08:25
1158	2859	1	7369000.00	\N	2026-04-10 11:08:43
1159	2861	1	10199000.00	\N	2026-04-10 11:09:03
1160	2862	1	8259000.00	\N	2026-04-10 11:09:20
1161	2864	1	2959000.00	\N	2026-04-10 11:09:32
1162	2866	1	729000.00	\N	2026-04-10 11:09:53
1163	2868	1	4509000.00	\N	2026-04-10 11:10:08
1164	2879	1	1789000.00	\N	2026-04-10 11:10:22
1165	2886	1	1529000.00	\N	2026-04-10 11:10:39
1166	2889	1	6379000.00	\N	2026-04-10 11:10:59
1167	2902	1	1659000.00	\N	2026-04-10 11:11:14
1168	2903	1	1919000.00	\N	2026-04-10 11:11:29
1169	2904	1	569000.00	\N	2026-04-10 11:11:43
1170	2907	1	1529000.00	\N	2026-04-10 11:11:58
1171	2923	1	1179000.00	\N	2026-04-10 11:12:16
1172	2925	1	2169000.00	\N	2026-04-10 11:12:35
1173	2926	1	309000.00	\N	2026-04-10 11:12:53
1174	2939	1	2299000.00	\N	2026-04-10 11:13:11
1175	2941	1	1279000.00	\N	2026-04-10 11:13:26
1176	2949	1	1529000.00	\N	2026-04-10 11:13:41
1177	2953	1	1019000.00	\N	2026-04-10 11:14:01
1178	2954	1	339000.00	\N	2026-04-10 11:14:17
1179	2963	1	2549000.00	\N	2026-04-10 11:14:33
1180	2967	1	1479000.00	\N	2026-04-10 11:14:49
1181	2970	1	289000.00	\N	2026-04-10 11:15:07
1182	2973	1	4589000.00	\N	2026-04-10 11:15:23
1183	2975	1	3189000.00	\N	2026-04-10 11:15:37
1184	2977	1	1019000.00	\N	2026-04-10 11:15:53
1185	2980	1	9159000.00	\N	2026-04-10 11:16:08
1186	2985	1	2299000.00	\N	2026-04-10 11:16:24
1187	2987	1	3219000.00	\N	2026-04-10 11:16:39
1188	2993	1	1529000.00	\N	2026-04-10 11:16:54
1189	2996	1	5639000.00	\N	2026-04-10 11:17:13
1190	2999	1	5609000.00	\N	2026-04-10 11:17:30
1191	3001	1	1279000.00	\N	2026-04-10 11:17:51
1192	3024	1	1019000.00	\N	2026-04-10 11:18:06
1193	3028	1	2299000.00	\N	2026-04-10 11:18:25
1194	3030	1	3319000.00	\N	2026-04-10 11:18:38
1195	3032	1	349000.00	\N	2026-04-10 11:18:57
1196	3057	1	2039000.00	\N	2026-04-10 11:19:15
1197	3069	1	3459000.00	\N	2026-04-10 11:19:33
1198	3074	1	2939000.00	\N	2026-04-10 11:19:48
1199	3076	1	4619000.00	\N	2026-04-10 11:20:08
1200	3088	1	4619000.00	\N	2026-04-10 11:20:26
1201	3092	1	3059000.00	\N	2026-04-10 11:20:39
1202	3097	1	1789000.00	\N	2026-04-10 11:20:56
1203	3103	1	3059000.00	\N	2026-04-10 11:21:13
1204	3104	1	3249000.00	\N	2026-04-10 11:21:27
1205	3117	1	2439000.00	\N	2026-04-10 11:21:42
1206	3119	1	1279000.00	\N	2026-04-10 11:22:02
1207	3126	1	2809000.00	\N	2026-04-10 11:22:18
1208	3131	1	2779000.00	\N	2026-04-10 11:22:36
1209	3132	1	1529000.00	\N	2026-04-10 11:22:57
1210	3137	1	2039000.00	\N	2026-04-10 11:23:16
1211	3138	1	1789000.00	\N	2026-04-10 11:23:33
1212	3146	1	289000.00	\N	2026-04-10 11:24:20
1213	3150	1	9069000.00	\N	2026-04-10 11:24:37
1214	3156	1	3569000.00	\N	2026-04-10 11:24:54
1215	3158	1	329000.00	\N	2026-04-10 11:25:14
1216	3160	1	289000.00	\N	2026-04-10 11:25:33
1217	3162	1	1789000.00	\N	2026-04-10 11:25:50
1218	3168	1	2889000.00	\N	2026-04-10 11:26:03
1219	3173	1	2939000.00	\N	2026-04-10 11:26:23
1220	3174	1	2039000.00	\N	2026-04-10 11:26:40
1221	3186	1	3349000.00	\N	2026-04-10 11:26:55
1222	3189	1	7029000.00	\N	2026-04-10 11:27:12
1223	3204	1	5099000.00	\N	2026-04-10 11:27:27
1224	3211	1	2169000.00	\N	2026-04-10 11:27:46
1225	3214	1	5089000.00	\N	2026-04-10 11:28:03
1226	3219	1	1269000.00	\N	2026-04-10 11:28:21
1227	3243	1	3829000.00	\N	2026-04-10 11:28:40
1228	3244	1	4229000.00	\N	2026-04-10 11:28:54
1229	3246	1	2299000.00	\N	2026-04-10 11:29:12
1230	3257	1	599000.00	\N	2026-04-10 11:29:26
1231	3260	1	2499000.00	\N	2026-04-10 11:29:46
1232	3262	1	2299000.00	\N	2026-04-10 11:30:02
1233	3263	1	7649000.00	\N	2026-04-10 11:30:15
1234	3264	1	2039000.00	\N	2026-04-10 11:30:30
1235	3266	1	3059000.00	\N	2026-04-10 11:30:45
1236	3269	1	419000.00	\N	2026-04-10 11:31:04
1237	3287	1	419000.00	\N	2026-04-10 11:31:22
1238	3294	1	3399000.00	\N	2026-04-10 11:31:36
1239	3297	1	4309000.00	\N	2026-04-10 11:31:52
1240	3300	1	4339000.00	\N	2026-04-10 11:32:07
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
1374	4716	1	359000.00	\N	2026-04-10 12:09:52
1375	4719	1	1279000.00	\N	2026-04-10 12:10:07
1376	4723	1	1919000.00	\N	2026-04-10 12:10:23
1377	3142	1	4379000.00	\N	2026-04-10 14:10:57
1378	22	1	799000.00	\N	2026-04-10 14:47:30
1379	1002	1	6379000.00	\N	2026-04-10 14:49:52
1380	1032	1	15299000.00	\N	2026-04-10 14:49:52
1381	1104	1	6379000.00	\N	2026-04-10 14:49:52
\.


--
-- TOC entry 5289 (class 0 OID 25513)
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
-- TOC entry 5291 (class 0 OID 25522)
-- Dependencies: 237
-- Data for Name: components; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.components (id, name, type_id, base_price) FROM stdin;
1	AMD Ryzen 7 7700	1	\N
3	Intel Core i5-7400T	1	\N
4	AMD Ryzen 7 7800X3D	1	\N
6	Intel Core i7-10700	1	\N
7	Intel Core i9-13900K	1	\N
8	Intel Core i5-4460	1	\N
9	Intel Core i7-4770K	1	\N
10	Intel Core i9-12900	1	\N
11	Intel Core i9-14900KS	1	\N
12	Intel Core i3-10105	1	\N
13	AMD Ryzen 9 7900X	1	\N
14	Intel Core i5-7600T	1	\N
15	Intel Core i3-9300	1	\N
16	Intel Core i5-7400	1	\N
17	Intel Core i5-9600	1	\N
18	Intel Core i7-9700	1	\N
19	AMD Ryzen 9 7950X3D	1	\N
20	AMD Ryzen 7 5700G	1	\N
21	AMD Ryzen 5 7600X	1	\N
22	Intel Core i5-3340	1	\N
25	Intel Core i5-8600	1	\N
26	Intel Core Ultra 5 235	1	\N
27	Intel Core Ultra 5 245K	1	\N
28	AMD Ryzen 5 2400G	1	\N
29	AMD A10-9700	1	\N
30	Intel Core i5-7500T	1	\N
31	Intel Core i3-10320	1	\N
32	Intel Core Ultra 7 265K	1	\N
33	Intel Core i7-4790	1	\N
34	Intel Core i5-12500	1	\N
35	Intel Core i9-10900K	1	\N
36	Intel Core i5-14400	1	\N
37	Intel Xeon E-2174G	1	\N
38	Intel Core i7-6700K	1	\N
39	Intel Core i5-4690K	1	\N
40	AMD Ryzen 9 9950X	1	\N
41	Intel Core i7-8700T	1	\N
42	Intel Core i5-11500	1	\N
43	Intel Core i3-14100	1	\N
44	AMD Ryzen 5 5500GT	1	\N
46	AMD EPYC 4244P	1	\N
48	Intel Core i3-10100	1	\N
49	Intel Xeon E-2176G	1	\N
50	AMD EPYC 4364P	1	\N
51	AMD Ryzen 5 8500G	1	\N
52	Intel Xeon E3-1285 V6	1	\N
53	AMD Ryzen 7 9700X	1	\N
54	Intel Core i5-14600K	1	\N
55	AMD A10-7850K	1	\N
56	Intel Core i7-8700	1	\N
57	Intel Core i5-7600	1	\N
58	Intel Core Ultra 7 265	1	\N
59	Intel Core i5-9500	1	\N
60	Intel Core i5-8500T	1	\N
61	Intel Core i5-3330S	1	\N
62	Intel Core i5-6500	1	\N
63	AMD A6-7400K	1	\N
64	Intel Core i5-8600K	1	\N
65	Intel Core i7-7700T	1	\N
66	Intel Core i5-6600T	1	\N
67	AMD Ryzen 5 7600X3D	1	\N
68	AMD Ryzen 9 7900	1	\N
70	Intel Core i9-10900	1	\N
71	AMD Ryzen 7 8700G	1	\N
72	Intel Core i3-9100	1	\N
73	Intel Core i7-14700	1	\N
74	Intel Core i5-12600K	1	\N
75	Intel Core i5-8500	1	\N
76	Intel Core i9-14900	1	\N
77	Intel Core i7-11700K	1	\N
78	AMD Ryzen 5 8600G	1	\N
79	Intel Core i7-7700K	1	\N
80	Intel Core Ultra 9 285K	1	\N
81	AMD EPYC 4344P	1	\N
82	Intel Core i5-8400	1	\N
84	Intel Core i5-6402P	1	\N
85	Intel Core i5-4440	1	\N
86	Intel Core i7-13700K	1	\N
88	Intel Core i7-8700K	1	\N
89	Intel Core i5-11600	1	\N
90	Intel Core i5-9400	1	\N
91	Intel Xeon E3-1275 V6	1	\N
92	AMD Ryzen 9 9900X	1	\N
93	AMD Ryzen 5 5600G	1	\N
94	Intel Core i5-8400T	1	\N
95	AMD Ryzen 7 7700X	1	\N
97	Intel Core i3-13100	1	\N
98	AMD Ryzen 5 3400G	1	\N
99	Intel Core i5-6600K	1	\N
100	AMD EPYC 4464P	1	\N
101	Intel Core i7-4790K	1	\N
103	AMD EPYC 4564P	1	\N
105	Intel Core i3-12100	1	\N
106	Intel Core i5-13500	1	\N
107	Intel Core i5-11400	1	\N
108	AMD Ryzen 9 7950X	1	\N
109	Intel Core i7-4770	1	\N
110	Intel Core i5-10500	1	\N
112	Intel Core i9-11900	1	\N
113	Intel Core i7-8086K	1	\N
114	AMD Ryzen 9 9900X3D	1	\N
115	Intel Core i9-13900	1	\N
116	Intel Core i9-9900K (Standard Folding Box)	1	\N
117	Intel Core i9-11900K	1	\N
118	AMD Ryzen 7 9800X3D	1	\N
119	Intel Core i7-14700K	1	\N
120	Intel Core i5-10400	1	\N
121	Intel Core Ultra 9 285	1	\N
123	Intel Core i9-9900	1	\N
124	Intel Xeon E3-1245 V6	1	\N
126	Intel Core i5-10600K	1	\N
127	AMD Ryzen 5 9600	1	\N
128	Intel Core i5-13400	1	\N
129	Intel Core i5-14500	1	\N
130	Intel Core i7-10700K	1	\N
131	Intel Core i5-7500	1	\N
133	Intel Core i7-6700	1	\N
134	Intel Xeon E3-1225 V6	1	\N
135	AMD Ryzen 5 5600GT	1	\N
136	Intel Core i9-14900K	1	\N
138	AMD Ryzen 9 9950X3D	1	\N
139	Intel Core i5-6500T	1	\N
141	Intel Core i5-10600	1	\N
142	Intel Core i7-13700	1	\N
143	Intel Core i9-9900KS	1	\N
144	Intel Core Ultra 5 225	1	\N
145	Intel Core i5-9600K	1	\N
147	Intel Core i9-13900KS	1	\N
148	Intel Core i7-9700K	1	\N
149	Intel Core i7-7700	1	\N
151	Intel Core i5-4690	1	\N
152	AMD Ryzen 3 3200G	1	\N
154	Intel Core i5-12600	1	\N
157	Intel Core i7-12700K	1	\N
158	Intel Xeon E-2124G	1	\N
160	Intel Core i7-12700	1	\N
161	AMD Ryzen 5 7600	1	\N
162	Intel Core i5-7600K	1	\N
164	Intel Core i9-9900K	1	\N
165	AMD A8-7600	1	\N
166	Intel Core i7-11700	1	\N
168	Intel Core i5-13600K	1	\N
169	Intel Core i9-12900K	1	\N
172	Intel Core i9-12900KS	1	\N
173	Intel Core i5-12400	1	\N
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
762	ASRock Challenger	2	\N
763	MSI GeForce GTX 1650 SUPER	2	\N
764	MSI VENTUS 2X OC	2	\N
765	Gigabyte OC	2	\N
766	MSI MSI RTX 2070 Ventus 8G Video Card	2	\N
768	MSI GAMING TRIO OC	2	\N
769	Asus KO Gaming OC	2	\N
770	Gigabyte XTREME	2	\N
771	Asus ProArt OC	2	\N
772	PNY Dual Fan	2	\N
773	Gigabyte AORUS XTREME WATERFORCE	2	\N
774	Gigabyte AORUS MASTER	2	\N
775	Sapphire PULSE	2	\N
777	Zotac Solid Core OC	2	\N
778	Gigabyte EAGLE OC	2	\N
780	ASRock Phantom Gaming D OC	2	\N
781	Gigabyte WINDFORCE OC	2	\N
783	PowerColor Hellhound OC	2	\N
784	Asus STRIX	2	\N
785	EVGA FTW3 ULTRA GAMING	2	\N
786	EVGA FTW GAMING ACX 3.0	2	\N
787	MSI VENTUS 3X OC	2	\N
789	Zotac GAMING Trinity OC	2	\N
790	MSI SUPRIM X	2	\N
792	EVGA ACX 2.0+	2	\N
793	XFX Black Edition	2	\N
794	MSI GAMING X	2	\N
795	PNY Blower	2	\N
796	Asus PRIME OC	2	\N
798	PowerColor Reaper	2	\N
800	MSI Founders Edition	2	\N
802	Asus DUAL OC	2	\N
803	Asus STRIX GAMING	2	\N
806	Asus TUF GAMING OC	2	\N
807	Asus PRIME	2	\N
808	XFX THICC II	2	\N
809	PNY VCNRTX4500ADA-PB	2	\N
810	EVGA SC GAMING ACX 3.0	2	\N
811	ASRock Challenger OC	2	\N
813	PowerColor RX 7900 XT 20G	2	\N
814	Asus KO GAMING OC V2	2	\N
815	EVGA FTW3 GAMING	2	\N
816	Gigabyte EAGLE OC Rev 2.0	2	\N
817	Asus ROG STRIX GAMING OC V2	2	\N
818	MSI GAMING X TRIO	2	\N
819	MSI SHADOW 3X OC	2	\N
820	Zotac GAMING Twin Edge	2	\N
821	XFX Quicksilver	2	\N
824	Asus ROG STRIX GAMING OC	2	\N
825	Inno3D Twin X2	2	\N
827	Zotac GAMING AMP	2	\N
830	XFX RX-VEGMTSFX6	2	\N
831	Zotac GAMING SOLO	2	\N
832	MSI D6 VENTUS XS OC	2	\N
833	MSI ARMOR OC	2	\N
834	Zotac GAMING AMP Extreme AIRO	2	\N
835	XFX Speedster QICK 319 BLACK	2	\N
836	Zotac AMP Extreme	2	\N
837	MSI VENTUS 3X E1 OC	2	\N
838	Zotac GAMING SOLID OC	2	\N
839	Zotac GAMING AMP Extreme Holo	2	\N
840	Gigabyte GAMING OC	2	\N
841	XFX Swift	2	\N
842	MSI Radeon RX 6800 XT Gaming X Trio 16G	2	\N
843	Sapphire NITRO+	2	\N
844	XFX Speedster MERC 319 Black	2	\N
847	XFX RX-570P8DFD6	2	\N
849	XFX Speedster SWFT 210 Core	2	\N
850	PowerColor Fighter	2	\N
852	PNY VCQP400-PB	2	\N
854	MSI VENTUS 2X BLACK OC	2	\N
855	Gigabyte AORUS ELITE	2	\N
856	EVGA Classified ACX 2.0	2	\N
858	EVGA KO GAMING	2	\N
859	Gigabyte GAMING OC Rev 2.0	2	\N
860	EVGA FTW DT GAMING	2	\N
861	EVGA SC GAMING	2	\N
862	Zotac GAMING Trinity	2	\N
863	PNY VCQM5000-PB	2	\N
864	EVGA SC ULTRA GAMING	2	\N
867	MSI GeForce RTX 2070 SUPER VENTUS GP OC	2	\N
868	MSI GeForce RTX 3090 TI GAMING X TRIO 24G	2	\N
869	MSI ARMOR OCV1	2	\N
871	Gigabyte OC Low Profile	2	\N
874	MSI VENTUS 2X XS OC	2	\N
876	Sparkle ORC OC	2	\N
880	PNY VERTO OC	2	\N
881	XFX Speedster QICK 210	2	\N
883	Asus DUAL EVO OC	2	\N
884	Gigabyte GAMING	2	\N
888	EVGA XC GAMING	2	\N
893	Zotac GAMING AMP Holo	2	\N
895	MSI VENTUS 2X	2	\N
896	Asus ROG STRIX-GTX1070-O8G-GAMING	2	\N
897	AMD 100-300000077	2	\N
900	Gigabyte WINDFORCE	2	\N
901	PNY VCQK1200DVI-PB	2	\N
902	Zotac GAMING SOLID CORE OC	2	\N
903	Yeston Sakura	2	\N
904	Asus TUF GAMING	2	\N
906	Asus TUF Gaming OG OC	2	\N
911	MSI SHADOW 3X	2	\N
912	PNY Founders Edition	2	\N
913	EVGA Black	2	\N
915	EVGA FTW GAMING	2	\N
917	MSI VENTUS 3X	2	\N
918	XFX Mercury OC	2	\N
919	PNY ARGB EPIC-X RGB OC	2	\N
920	XFX Swift OC	2	\N
923	PNY VCGGTX1070T8PB-CG	2	\N
925	PNY VCQP2000-PB	2	\N
926	MSI VENTUS	2	\N
929	Acer Predator BiFrost OC	2	\N
931	PNY VCG50608DFXPB1	2	\N
932	Zotac GAMING Twin Edge OC	2	\N
936	EVGA DT GAMING	2	\N
938	Asus TURBO-GTX1070-8G	2	\N
941	Gigabyte AORUS XTREME	2	\N
944	Asus ROG STRIX	2	\N
947	PNY VCQP4000-PB	2	\N
948	ASRock Steel Legend	2	\N
952	Gigabyte AERO OC	2	\N
955	Gigabyte MINI ITX OC	2	\N
958	Sapphire PURE	2	\N
960	PNY XLR8 Gaming VERTO EPIC-X RGB OC	2	\N
962	Sparkle TITAN OC	2	\N
963	Asus DUAL	2	\N
966	MSI ARMOR	2	\N
968	ASRock Challenger D OC	2	\N
969	EVGA GAMING	2	\N
970	Asus Turbo	2	\N
971	Inno3D X3 OC	2	\N
973	EVGA Superclocked	2	\N
974	MSI VENTUS 3X PLUS OC	2	\N
976	PowerColor Hellhound	2	\N
977	EVGA 02G-P4-6333-KR	2	\N
980	EVGA XC3 ULTRA GAMING	2	\N
982	Zotac Twin Edge OC	2	\N
986	MSI GAMING Z TRIO	2	\N
987	EVGA FTW ULTRA SILENT GAMING	2	\N
988	AMD RADEON PRO WX 5100	2	\N
993	MSI EXPERT	2	\N
995	MSI ARMOR MK2 OC	2	\N
997	Gigabyte GAMING OC PRO Rev 3.0	2	\N
1002	PowerColor Red Devil OC	2	\N
1003	XFX Mercury OC RGB	2	\N
1006	PNY VCQRTX8000-PB	2	\N
1011	PNY XLR8 Gaming Overclocked Edition	2	\N
1012	EVGA Founders Edition	2	\N
1015	PowerColor Red Dragon	2	\N
1016	MSI DUKE OC	2	\N
1017	PNY T-Series	2	\N
1019	Zotac Twin Edge	2	\N
1021	Gainward Ghost	2	\N
1022	PNY VCQM2000-PB	2	\N
1023	Gigabyte GV-N970TTOC-4GD	2	\N
1025	MSI GAMING GE	2	\N
1026	EVGA SSC GAMING	2	\N
1029	Palit StormX	2	\N
1030	PNY VCQP620-PB	2	\N
1032	Sapphire NITRO+ SE	2	\N
1033	Zotac AMP	2	\N
1037	MSI RTX 3090 SUPRIM X 24G	2	\N
1047	MSI GeForce RTX 2060 VENTUS GP OC	2	\N
1049	PNY VERTO	2	\N
1050	MSI RTX 4090 GAMING SLIM 24G	2	\N
1052	Asus Turbo EVO	2	\N
1056	MSI GAMING	2	\N
1061	PNY VCG16606SSFPPB	2	\N
1064	XFX RX-79TMBABF9	2	\N
1065	MSI SHADOW 2X OC	2	\N
1066	NVIDIA TITAN RTX	2	\N
1067	Zotac SOLID SFF OC	2	\N
1070	EVGA FTW3 ULTRA GAMING LHR	2	\N
1073	PNY UPRISING	2	\N
1077	Gigabyte AORUS ELITE Rev 2.0	2	\N
1079	PNY VCQRTX5000-PB	2	\N
1080	MSI VENTUS 2X PLUS OC	2	\N
1081	Asus TUF GAMING OC P	2	\N
1082	Asus GTX950-2G	2	\N
1088	MSI GeForce RTX 3080 RTX 3080 SUPRIM X 10G	2	\N
1089	MSI Radeon RX 6900 XT GAMING Z TRIO 16G	2	\N
1092	Asus Phoenix	2	\N
1093	Gigabyte GV-N1030D4-2GL	2	\N
1095	MSI AIR BOOST OC	2	\N
1096	EVGA K|NGP|N HYBRID GAMING	2	\N
1098	MSI VENTUS XS OC	2	\N
1100	MSI GAMING OC	2	\N
1101	ONIX LUMI OC	2	\N
1103	XFX RX-79GMERCB9	2	\N
1104	EVGA XC ULTRA GAMING	2	\N
1106	PNY VCNRTX4000ADA-PB	2	\N
1107	EVGA FTW+ GAMING	2	\N
1110	Gigabyte AORUS MASTER Rev 2.0	2	\N
1113	MSI LP OC	2	\N
1118	Asus GT1030-2G-BRK	2	\N
1122	MSI MECH OC	2	\N
1125	Gigabyte EAGLE	2	\N
1129	Gigabyte GV-N107TGAMING-8GD	2	\N
1138	EVGA 06G-P4-3790-KR	2	\N
1145	Zotac ZT-70601-10M	2	\N
1146	Gigabyte GV-N105TD5-4GD	2	\N
1148	XFX Speedster QICK 319 Core	2	\N
1149	ASRock Steel Legend OC	2	\N
1150	Asus ROG STRIX GAMING	2	\N
1154	PNY EPIC-X RGB OC	2	\N
1166	MSI GeForce RTX 3060 Ventus 2X 12G OC	2	\N
1172	MSI GAMING Z	2	\N
1174	PNY VCG508016TFXPB1	2	\N
1176	MSI GeForce GTX 1060 6G OCV1	2	\N
1178	MSI DUKE	2	\N
1179	ASRock Phantom Gaming	2	\N
1180	MSI VENTUS 2X PLUS	2	\N
1186	Asus STRIX GAMING OC	2	\N
1187	PowerColor Red Devil E/OC	2	\N
1192	PowerColor Red Devil	2	\N
1193	Asus DUAL V2	2	\N
1194	EVGA FTW ACX 2.0	2	\N
1197	MSI RTX 3070 GAMING X TRIO	2	\N
1199	ASRock Phantom Gaming OC	2	\N
1200	PNY XLR8 Gaming EPIC-X RGB	2	\N
1205	Asus TUF Gaming EVO OC	2	\N
1207	AMD 100-506001	2	\N
1214	Zotac GAMING SOLID CORE	2	\N
1215	Gigabyte OC Rev 2.0	2	\N
1219	Yeston LP	2	\N
1220	EVGA 04G-P4-2980-KR	2	\N
1222	PNY VCG507012TFXPB1	2	\N
1223	Sapphire Toxic Extreme Edition	2	\N
1224	EVGA 06G-P4-4990-KR	2	\N
1229	MSI VENTUS 2X OCV1	2	\N
1231	PowerColor Red Devil Limited Edition OC	2	\N
1233	ASRock Taichi OC	2	\N
1238	PowerColor Hellhound Spectral	2	\N
1243	XFX RS XXX	2	\N
1246	ASRock Creator	2	\N
1252	MSI GAMING TRIO OC PLUS	2	\N
1254	AMD 100-506061	2	\N
1256	MSI GAMING X SLIM	2	\N
1259	MSI GTX 1050 Ti 4GT OC	2	\N
1261	PNY OC	2	\N
2331	Asus STRIX LC GAMING OC	2	\N
2849	Silverstone Essential	6	\N
2851	SeaSonic S12III	6	\N
2852	ASRock Steel Legend SL-750G	6	\N
2853	Asus ROG LOKI	6	\N
2855	Apevia Prestige	6	\N
2856	Thermaltake Toughpower GF A3 - TT Premium Edition	6	\N
2857	Montech TITAN PLA	6	\N
2859	Corsair HX1500i (2023)	6	\N
2860	Lian Li EDGE	6	\N
2861	ASRock Taichi TC-1650T	6	\N
2862	Silverstone SX1000R-PL	6	\N
2863	Super Flower Zillion FG	6	\N
2864	Asus Prime AP-750G	6	\N
2866	Silverstone DA1000R	6	\N
2868	Asus ROG Strix Aura Edition	6	\N
2872	MSI MEG Ai1300P PCIE5	6	\N
2875	Cooler Master V1300 Platinum	6	\N
2877	Thermaltake Toughpower GF A3 Snow	6	\N
2878	ASRock Phantom Gaming PG-750G	6	\N
2879	Thermaltake Smart BX1 650	6	\N
2883	Super Flower Leadex Titanium	6	\N
2884	Montech APX	6	\N
2885	ASRock Steel Legend SL-650G	6	\N
2886	Antec NE1000G M ATX3.0	6	\N
2887	Asus ROG Strix	6	\N
2889	SeaSonic SSP-300SUG	6	\N
2894	Corsair RM850	6	\N
2895	be quiet! Power Zone 2	6	\N
2897	Thermaltake Toughpower SFX	6	\N
2899	be quiet! Straight Power 12	6	\N
2901	ASRock Challenger CL-750B	6	\N
2902	Corsair SF850 (2024)	6	\N
2903	Antec Signature Platinum	6	\N
2904	PC Cooler YS1000	6	\N
2905	MSI MAG A750BN PCIE5	6	\N
2906	EVGA 610 BP	6	\N
2907	be quiet! System Power 10	6	\N
2913	EVGA 500 BA	6	\N
2914	Lian Li SP	6	\N
2915	ASRock Phantom Gaming PG-850G	6	\N
2916	Lian Li SP850	6	\N
2917	SeaSonic FOCUS GX	6	\N
2922	SeaSonic VERTEX GX-1200	6	\N
2923	Apevia ATX-PR850W PCIE5.0	6	\N
2924	NZXT C550	6	\N
2925	Lian Li EDGE GOLD	6	\N
2926	SeaSonic Prime Fanless PX-500	6	\N
2928	Silverstone SST-TX300	6	\N
2929	EVGA 850 B5	6	\N
2931	Thermaltake Toughpower iRGB PLUS 750	6	\N
2933	MSI MPG A1000GS PCIE5	6	\N
2934	SeaSonic VERTEX PX-1000	6	\N
2936	be quiet! Pure Power 12	6	\N
2939	SeaSonic PRIME 1300 Gold	6	\N
2940	Corsair RM1200x SHIFT	6	\N
2941	Silverstone FX500-G	6	\N
2948	EVGA 710 BP	6	\N
2949	Corsair SF750 (2024)	6	\N
2951	be quiet! Dark Power 13	6	\N
2953	Azza ARGB	6	\N
2954	SHARKOON SilentStorm Cool Zero 650	6	\N
2956	Corsair HX1500i (2025)	6	\N
2957	Apevia Galaxy	6	\N
2958	be quiet! Pure Power 12 M	6	\N
2959	SeaSonic VERTEX PX-1200	6	\N
2961	Montech CENTURY G5	6	\N
2963	Rosewill CMG1000G5	6	\N
2964	ASRock Steel Legend SL-850GW	6	\N
2966	Cooler Master V850 SFX GOLD	6	\N
2967	GameMax RGB	6	\N
2970	Gigabyte P850GM	6	\N
2973	Corsair RM1000x SHIFT	6	\N
2974	Montech CENTURY II	6	\N
2975	MSI A1000G PCIE5	6	\N
2977	Azza PSAZ-650W	6	\N
2980	In Win P105II	6	\N
2985	Cooler Master MWE Gold V2 ATX3.0	6	\N
2986	MSI MAG A1250GL PCIE5	6	\N
2987	Silverstone ST75F-GS-V3	6	\N
2991	EVGA SuperNOVA 1300 P+	6	\N
2993	Antec NE1000G M White ATX 3.0	6	\N
2996	Asus TUF Gaming 1200G	6	\N
2997	Cougar POLAR	6	\N
2999	Asus ROG STRIX 1000G	6	\N
3000	Cooler Master V750 SFX GOLD	6	\N
3001	Super Flower LEADEX VII Platinum PRO	6	\N
3011	be quiet! Pure Power 13 M	6	\N
3013	ASRock Challenger CL-750G	6	\N
3020	SeaSonic PRIME TX-1600 Noctua Edition	6	\N
3021	be quiet! SFX L Power	6	\N
3024	Corsair RM650	6	\N
3026	NZXT C1500	6	\N
3027	MSI MPG A850G PCIE5	6	\N
3028	Cooler Master V Platinum V2	6	\N
3030	FSP Group Hydro PTM X PRO,Gen5	6	\N
3031	ASRock Challenger CL-550B	6	\N
3032	Razer Katana Chroma	6	\N
3033	Corsair HX1200i (2025)	6	\N
3037	Silverstone Extreme 500 Bronze	6	\N
3038	Cooler Master MWE Gold 850 V3	6	\N
3045	EVGA SuperNOVA 1600 P+	6	\N
3054	ASRock Phantom Gaming PG-1000G	6	\N
3057	Corsair RM750	6	\N
3063	NZXT E850	6	\N
3069	Asus TUF Gaming 750G	6	\N
3073	MSI MAG A850GL PCIE5	6	\N
3074	MSI MAG A750GL PCIE5 II	6	\N
3075	Azza PSAZ-750W	6	\N
3076	Asus TUF Gaming 1000G	6	\N
3077	SeaSonic PRIME TX	6	\N
3078	MSI MAG A750GL PCIE5	6	\N
3085	NZXT C650	6	\N
3088	Asus ROG THOR 1600T Gaming	6	\N
3089	be quiet! Dark Power Pro 13	6	\N
3091	MSI MAG A1000GL PCIE5	6	\N
3092	MSI MAG A850GL PCIE5 II	6	\N
3096	Silverstone SX700-PT	6	\N
3097	Lian Li SP750	6	\N
3100	ASRock Steel Legend SL-1000G	6	\N
3103	Rosewill CMG1200G5	6	\N
3104	Silverstone FX350-G	6	\N
3105	Super Flower LEADEX VII XG	6	\N
3107	Thermaltake Smart BM2	6	\N
3113	SHARKOON SilentStorm	6	\N
3117	Thermaltake Toughpower GF3 Snow	6	\N
3119	NZXT C650 (2022)	6	\N
3121	In Win IP-S300FF1-0	6	\N
3124	ASRock Challenger CL-850G	6	\N
3125	Cooler Master XG850 Plus	6	\N
3126	MSI MPG A850GF	6	\N
3129	Corsair HX1200i	6	\N
3131	Silverstone SX500-G	6	\N
3132	Corsair RM750x SHIFT	6	\N
3137	Cooler Master MWE Gold 850 - V2	6	\N
3138	Corsair RM850x SHIFT	6	\N
3139	Silverstone HELA 1200R	6	\N
3142	Thermaltake Smart BX1 550	6	\N
3146	ENDORFY Vero L5	6	\N
3148	Cougar GEX	6	\N
3149	SeaSonic SS-600ES	6	\N
3150	Asus ROG STRIX 1200P Gaming	6	\N
3156	FSP Group Hydro PTM PRO	6	\N
3158	Silverstone DA750 Gold	6	\N
3160	SeaSonic FOCUS SGX (2021)	6	\N
3162	Corsair SF1000 (2024)	6	\N
3166	SeaSonic SSP-300SFG	6	\N
3168	Silverstone TX300	6	\N
3173	Corsair RM1200e	6	\N
3174	SeaSonic SS-300TFX Bronze	6	\N
3175	Thermaltake Smart BM3	6	\N
3177	Thermaltake Toughpower GX2	6	\N
3181	SeaSonic PRIME Fanless	6	\N
3185	ASRock Challenger CL-650B	6	\N
3186	Corsair HX1000i (2023)	6	\N
3189	Asus ROG-STRIX-850G	6	\N
3190	Cooler Master MWE Gold 750 V3	6	\N
3191	Thermaltake Toughpower GX3	6	\N
3194	MSI MAG A650BN	6	\N
3195	NZXT C1200	6	\N
3196	EVGA 700 GD	6	\N
3200	Silverstone DA850R-GMA	6	\N
3204	GAMDIAS HELIOS P2-850G	6	\N
3205	EVGA SuperNOVA 650 GA	6	\N
3206	Silverstone SFX	6	\N
3208	ASRock Steel Legend SL-850G	6	\N
3211	Vetroo GV1000	6	\N
3213	SeaSonic VERTEX GX-850	6	\N
3214	Silverstone TX700-G	6	\N
3218	FSP Group FSP400-60FGGBA	6	\N
3219	Apevia Premier	6	\N
3220	Silverstone Strider	6	\N
3226	MSI MAG A550BN	6	\N
3232	ASRock Phantom Gaming PG-1600G	6	\N
3234	MSI MAG A650GL	6	\N
3237	Cooler Master MWE GOLD 750 V2 FULL MODULAR	6	\N
3241	SeaSonic VERTEX GX-1000	6	\N
3242	Silverstone HELA 850R	6	\N
3243	Asus TUF Gaming 850G	6	\N
3244	Silverstone TX500-G	6	\N
3246	SeaSonic CORE GX ATX 3 (2024)	6	\N
3253	ASRock Phantom Gaming PG-1300G	6	\N
3254	Athena Power AP-MFATX50P8	6	\N
3257	PC Cooler YS850	6	\N
3260	Gigabyte UD1300GM PG5	6	\N
3262	SeaSonic PRIME TX-1600 ATX 3.1	6	\N
3263	ASRock Taichi TC-1300T	6	\N
3264	Rosewill CMG850	6	\N
3266	Asus TUF Gaming B	6	\N
3267	MSI MAG A750BE	6	\N
3268	In Win P85	6	\N
3269	Silverstone SX1000-LPT	6	\N
3270	Thermaltake Toughpower GF2 ARGB	6	\N
3272	MSI MPG A1000G	6	\N
3275	SeaSonic VERTEX GX-750	6	\N
3279	Athena Power AP-MFATX40P8	6	\N
3287	Silverstone SX-G	6	\N
3293	MSI MPG A850GS PCIE5	6	\N
3294	Asus Prime AP-850G	6	\N
3297	Antec NE1300G M ATX3.0	6	\N
3300	MSI MPG A1250GS PCIE5	6	\N
3303	Cooler Master V750 Gold V2	6	\N
3805	Seagate SkyHawk AI	4	\N
3806	Seagate Momentus Thin	4	\N
3807	Seagate EXOS Enterprise	4	\N
3808	Western Digital WD Red Pro	4	\N
3809	Toshiba X300	4	\N
3810	Western Digital Purple Pro	4	\N
3812	Toshiba MQ04ABF100	4	\N
3813	Seagate ST2000NX0253	4	\N
3814	Western Digital Caviar Blue	4	\N
3815	Seagate IronWolf NAS	4	\N
3816	Seagate Enterprise Capacity	4	\N
3817	Seagate BarraCuda	4	\N
3818	Seagate Momentus 7200.4	4	\N
3821	Seagate SkyHawk Surveillance	4	\N
3823	Toshiba MK3276GSX	4	\N
3824	Samsung 870 Evo	4	\N
3825	Gigabyte AORUS Gen4 7300	4	\N
3826	Samsung Spinpoint M8	4	\N
3827	Western Digital WD Blue	4	\N
3832	Seagate IronWolf Pro	4	\N
3833	Toshiba S300	4	\N
3834	Seagate Enterprise Performance	4	\N
3837	Western Digital Scorpio Blue	4	\N
3838	Western Digital Blue	4	\N
3839	Seagate Constellation ES.3	4	\N
3840	Western Digital Caviar Green	4	\N
3841	Seagate Constellation ES.2	4	\N
3842	Seagate Exos X18	4	\N
3843	Gigabyte AORUS Gen4	4	\N
3847	Samsung 860 Evo	4	\N
3848	Seagate Constellation ES	4	\N
3849	Toshiba MG09 512e	4	\N
3850	Seagate Exos X24	4	\N
3851	Toshiba MK7559GSXP	4	\N
3857	Western Digital Red	4	\N
3859	Western Digital Purple	4	\N
3860	Western Digital WD_BLACK	4	\N
3863	Western Digital AV-GP	4	\N
3864	Hitachi Ultrastar 7K6000	4	\N
3865	Samsung 860 Pro	4	\N
3867	Toshiba MG08ADA600E	4	\N
3868	Seagate Exos 7E8	4	\N
3870	Toshiba N300 NAS	4	\N
3871	Acer Predator GM7000	4	\N
3872	Western Digital Gold	4	\N
3873	Toshiba MG04ACA600E	4	\N
3874	Western Digital Green	4	\N
3875	Toshiba N300 Pro	4	\N
3879	Toshiba P300	4	\N
3880	Seagate IronWolf Pro NAS	4	\N
3881	Toshiba MD04ACA600	4	\N
3886	Toshiba N300	4	\N
3887	Western Digital Red Plus	4	\N
3888	Hitachi Travelstar	4	\N
3892	Seagate Barracuda ES	4	\N
3895	Crucial MX500	4	\N
3897	Seagate Barracuda ES.2	4	\N
3900	Hitachi Ultrastar 7K3000	4	\N
3902	Hitachi Ultrastar He8	4	\N
3904	Hitachi 0Y30055	4	\N
3905	Western Digital RE	4	\N
3908	Hitachi Deskstar 5K3000	4	\N
3910	Seagate Momentus 5400.3	4	\N
3918	Western Digital Caviar Black	4	\N
3919	MSI SPATIUM M480 PRO	4	\N
3921	Seagate Barracuda Compute	4	\N
3923	Western Digital SE	4	\N
3931	Seagate Momentus XT	4	\N
3935	Seagate SkyHawk Surveillance +Rescue	4	\N
3936	Western Digital Ultrastar DC HC560	4	\N
3937	Seagate Archive HDD v2	4	\N
3938	Samsung 980 Pro w/Heatsink	4	\N
3942	Samsung 9100 PRO	4	\N
3946	Seagate Exos 7E10 512e/4Kn	4	\N
3949	Seagate Exos X14	4	\N
3953	Seagate Momentus 5400.6	4	\N
3954	Seagate Enterprise	4	\N
3956	Samsung 960 Evo	4	\N
3959	Seagate Exos X10	4	\N
3961	Seagate Barracuda Green	4	\N
3962	Toshiba MG06ACA800E	4	\N
3966	Toshiba L200	4	\N
3969	Seagate Constellation.2	4	\N
3972	Mushkin Source	4	\N
3976	Western Digital VelociRaptor	4	\N
3980	Seagate ST1000NX0313	4	\N
3983	Crucial P5 Plus	4	\N
3986	Seagate Barracuda 7200.9	4	\N
3988	Samsung 990 Pro	4	\N
3990	Western Digital Ultrastar DC HC550	4	\N
3994	Samsung 980 Pro	4	\N
3997	Toshiba S300 Pro	4	\N
4006	Mushkin Vortex Redline	4	\N
4015	Western Digital Black	4	\N
4016	Seagate BarraCuda Pro	4	\N
4018	Seagate Exos X20	4	\N
4021	Seagate ST4000NM0034	4	\N
4023	Toshiba X300 Pro	4	\N
4026	Samsung 990 Pro w/Heatsink	4	\N
4031	Samsung 970 Evo	4	\N
4032	Western Digital Purple NV	4	\N
4033	Seagate ST4000LM016	4	\N
4038	Western Digital Blue Mobile	4	\N
4041	Seagate SkyHawk	4	\N
4046	Seagate ST1000LM035	4	\N
4054	Seagate ST6000NM0024	4	\N
4076	Seagate Barracuda LP	4	\N
4079	Hitachi 7K1000.C	4	\N
4081	Seagate Constellation CS	4	\N
4083	Seagate Exos X16	4	\N
4091	Seagate ST2000NX0273	4	\N
4094	Samsung 960 Pro	4	\N
4100	Seagate Exos X22	4	\N
4104	Western Digital WDBMYH0010BNC-NRSN	4	\N
4110	Seagate Momentus	4	\N
4116	Seagate ST2000NM0024	4	\N
4134	Hitachi A7K2000	4	\N
4145	Hitachi Deskstar 7K2000	4	\N
4147	Western Digital RE3	4	\N
4149	Samsung Spinpoint MP4	4	\N
4150	Samsung 970 Evo Plus	4	\N
4153	Western Digital AV-25	4	\N
4161	MSI SPATIUM M570 FROZR	4	\N
4162	Seagate Surveillance HDD	4	\N
4171	Western Digital Ultrastar DC HC330	4	\N
4172	Hitachi Ultrastar He10	4	\N
4177	Western Digital DC HC530	4	\N
4180	Seagate SV35.5	4	\N
4181	Seagate BarraCuda Pro Compute	4	\N
4182	Western Digital Scorpio Black	4	\N
4184	Hitachi Travelstar Z7K320	4	\N
4185	Toshiba MG09 4Kn	4	\N
4189	Toshiba MG04ACA400N	4	\N
4191	Toshiba AL13SEB600	4	\N
4193	Hitachi Ultrastar He12	4	\N
4197	Samsung 970 Pro	4	\N
4201	Seagate Constellation	4	\N
4231	Western Digital WD_BLACK SN8100	4	\N
4247	Hitachi Travelstar Z7K500	4	\N
4248	Hitachi Ultrastar	4	\N
4256	HP EX920	4	\N
4272	Seagate Exos 7E8 512e	4	\N
4275	Seagate ST500LM021	4	\N
4276	Gigabyte AORUS Gen5 14000	4	\N
4278	Toshiba MG08	4	\N
4286	Toshiba MG07ACA12TE	4	\N
4295	Seagate Constellation Product Series:ES.3	4	\N
4300	Seagate Enterprise NAS	4	\N
4339	Asus PRIME B650-PLUS WIFI	5	\N
4340	MSI B650 GAMING PLUS WIFI	5	\N
4341	MSI MAG B650 TOMAHAWK WIFI	5	\N
4342	Gigabyte X870E AORUS ELITE WIFI7	5	\N
4343	Asus PRIME B550M-A WIFI II	5	\N
4344	Gigabyte B650 EAGLE AX	5	\N
4345	Asus TUF GAMING B850-PLUS WIFI	5	\N
4346	ASRock B650M Pro RS WiFi	5	\N
4347	MSI MAG X870 TOMAHAWK WIFI	5	\N
4348	Gigabyte A520M K V2	5	\N
4349	Asus B650E MAX GAMING WIFI W	5	\N
4350	MSI PRO B650-S WIFI	5	\N
4351	Gigabyte B550M K	5	\N
4352	ASRock B850I Lightning WiFi	5	\N
4353	MSI B760 GAMING PLUS WIFI	5	\N
4354	MSI PRO B550M-VC WIFI	5	\N
4355	MSI PRO Z790-A MAX WIFI	5	\N
4356	Asus TUF GAMING B650-PLUS WIFI	5	\N
4357	Gigabyte X870 EAGLE WIFI7	5	\N
4358	Gigabyte X870 AORUS ELITE WIFI7 ICE	5	\N
4359	MSI B550M PRO-VDH WIFI	5	\N
4360	Asus ROG STRIX X870E-E GAMING WIFI	5	\N
4361	ASRock B850M-X WiFi R2.0	5	\N
4362	Gigabyte B850 EAGLE WIFI6E	5	\N
4363	MSI MAG B850 TOMAHAWK MAX WIFI	5	\N
4364	Gigabyte B760M GAMING PLUS WIFI DDR4	5	\N
4475	Gigabyte A520M DS3H V2	5	\N
4365	Asus ROG STRIX B650-A GAMING WIFI	5	\N
4366	Gigabyte B650M GAMING PLUS WIFI	5	\N
4367	MSI MAG B550 TOMAHAWK MAX WIFI	5	\N
4368	Gigabyte B850 AORUS ELITE WIFI7	5	\N
4369	Gigabyte B650 GAMING X AX V2	5	\N
4370	Asus ROG STRIX X870-A GAMING WIFI	5	\N
4371	ASRock A620I LIGHTNING WIFI	5	\N
4372	Asus TUF GAMING B550-PLUS WIFI II	5	\N
4373	Asus TUF GAMING B650-E WIFI	5	\N
4374	Gigabyte Z790 EAGLE AX	5	\N
4375	MSI B450M-A PRO MAX II	5	\N
4376	MSI PRO B650M-P	5	\N
4377	ASRock B450M/ac R2.0	5	\N
4378	Asus TUF GAMING B850M-PLUS WIFI	5	\N
4379	ASRock B450M-HDV R4.0	5	\N
4380	Gigabyte B850 AORUS ELITE WIFI7 ICE	5	\N
4381	MSI PRO B760M-P DDR4	5	\N
4382	Asus ROG STRIX B550-F GAMING WIFI II	5	\N
4383	Gigabyte B850M GAMING X WIFI6E	5	\N
4384	Asus ROG CROSSHAIR X870E HERO	5	\N
4385	Gigabyte A520I AC	5	\N
4386	Gigabyte B550M AORUS ELITE AX	5	\N
4387	ASRock B850M Pro-A WiFi	5	\N
4388	ASRock B650M PG Lightning Wifi	5	\N
4389	MSI MPG B550 GAMING PLUS	5	\N
4390	MSI A520M-A PRO	5	\N
4391	MSI PRO B650M-A WIFI	5	\N
4392	Asus ROG STRIX B650E-F GAMING WIFI	5	\N
4393	Asus ROG STRIX B850-A GAMING WIFI	5	\N
4394	ASRock B550M Pro4	5	\N
4395	MSI MAG X670E TOMAHAWK WIFI	5	\N
4396	Asus ROG STRIX B850-I GAMING WIFI	5	\N
4397	Asus ROG STRIX B650E-I GAMING WIFI	5	\N
4398	MSI MPG X870E CARBON WIFI	5	\N
4399	Gigabyte B850 GAMING WIFI6	5	\N
4400	MSI B850 GAMING PLUS WIFI	5	\N
4401	Asus TUF GAMING X870-PLUS WIFI	5	\N
4402	Gigabyte Z790 AORUS ELITE AX	5	\N
4403	MSI B550-A PRO	5	\N
4404	Asus ROG CROSSHAIR X870E EXTREME	5	\N
4405	ASRock B850M Pro RS WiFi	5	\N
4406	Asus TUF GAMING Z790-PLUS WIFI	5	\N
4407	Gigabyte X870E AORUS PRO ICE	5	\N
4408	Gigabyte B650 AORUS ELITE AX	5	\N
4409	Gigabyte A620I AX	5	\N
4410	Gigabyte X870I AORUS PRO ICE	5	\N
4411	MSI B650M GAMING PLUS WIFI	5	\N
4412	Asus ROG STRIX B850-F GAMING WIFI	5	\N
4413	ASRock X870 Pro RS	5	\N
4414	MSI PRO A620M-E	5	\N
4415	Asus TUF GAMING B650E-PLUS WIFI	5	\N
4416	Gigabyte B850 GAMING X WIFI6E	5	\N
4417	Gigabyte B550 GAMING X V2	5	\N
4418	ASRock B650M-HDV/M.2	5	\N
4419	Asus Z790 GAMING WIFI7	5	\N
4420	MSI MAG X870E TOMAHAWK WIFI	5	\N
4421	Gigabyte B550 EAGLE WIFI6	5	\N
4422	MSI PRO H610M-G DDR4	5	\N
4423	MSI MEG X870E GODLIKE	5	\N
4424	ASRock X870 Pro RS WiFi	5	\N
4425	Gigabyte B850M AORUS ELITE WIFI6E ICE	5	\N
4426	ASRock B760M-HDV/M.2	5	\N
4427	Gigabyte TRX40 DESIGNARE	5	\N
4428	ASRock A520M-HDV	5	\N
4429	ASRock B550 Phantom Gaming 4/ac	5	\N
4430	Gigabyte X870 AORUS ELITE WIFI7	5	\N
4431	Asus ROG STRIX B760-I GAMING WIFI	5	\N
4432	Gigabyte X870 GAMING WIFI6	5	\N
4433	ASRock A620M-HDV/M.2	5	\N
4434	MSI MAG Z890 TOMAHAWK WIFI	5	\N
4435	Asus ProArt X870E-CREATOR WIFI	5	\N
4436	ASRock B650 PG LIGHTNING	5	\N
4437	MSI MAG B550 TOMAHAWK	5	\N
4438	MSI MAG B760 TOMAHAWK WIFI	5	\N
4439	Gigabyte B550 UD AC	5	\N
4440	Gigabyte B650M D3HP AX	5	\N
4441	Asus PRIME B650M-A AX II	5	\N
4442	ASRock B650I Lightning Wifi	5	\N
4443	ASRock X870E Taichi	5	\N
4444	MSI MPG X870E EDGE TI WIFI	5	\N
4446	MSI PRO X870E-P WIFI	5	\N
4447	MSI PRO B850-P WIFI	5	\N
4448	Gigabyte B760M DS3H AX	5	\N
4449	ASRock B850 Riptide WiFi	5	\N
4450	MSI B840 GAMING PLUS WIFI	5	\N
4451	ASRock B650M Pro RS	5	\N
4452	Asus TUF GAMING A520M-PLUS WIFI	5	\N
4453	ASRock B760M PG Riptide Wifi	5	\N
4455	Gigabyte B650 AORUS ELITE AX ICE	5	\N
4456	MSI X670E GAMING PLUS WIFI	5	\N
4457	Gigabyte B650 AORUS ELITE AX V2	5	\N
4458	Asus ROG STRIX X870-I GAMING WIFI	5	\N
4459	Asus ROG STRIX Z790-A GAMING WIFI II	5	\N
4460	MSI PRO Z790-P WIFI	5	\N
4462	ASRock B850M Steel Legend WiFi	5	\N
4463	Asus TUF GAMING B650M-PLUS WIFI	5	\N
4464	MSI B760M GAMING PLUS WIFI	5	\N
4465	Gigabyte B550M DS3H AC	5	\N
4467	MSI PRO B760-P WIFI DDR4	5	\N
4468	Gigabyte B650 EAGLE	5	\N
4469	MSI X870 GAMING PLUS WIFI	5	\N
4470	Asus TUF GAMING B760-PLUS WIFI	5	\N
4471	ASRock Z790 PRO RS WIFI	5	\N
4472	Gigabyte A520M S2H	5	\N
4473	Asus Prime B450M-A II	5	\N
4474	Gigabyte B850I AORUS PRO	5	\N
4476	MSI B550 GAMING GEN3	5	\N
4477	MSI MAG B850M MORTAR WIFI	5	\N
4478	Gigabyte B550 AORUS ELITE AX V2	5	\N
4479	ASRock B850 Steel Legend WiFi	5	\N
4480	MSI MPG B650I EDGE WIFI	5	\N
4481	MSI MAG Z790 TOMAHAWK WIFI	5	\N
4482	Gigabyte B550I AORUS PRO AX	5	\N
4483	Asus ROG STRIX B860-I GAMING WIFI	5	\N
4485	Asus ROG STRIX B550-A GAMING	5	\N
4487	Gigabyte X870E AORUS PRO	5	\N
4488	MSI Z790 GAMING PLUS WIFI	5	\N
4489	MSI MPG B850I EDGE TI WIFI	5	\N
4490	ASRock B650 PRO RS	5	\N
4491	Gigabyte B650E AORUS ELITE X AX ICE	5	\N
4492	MSI PRO B840-P WIFI	5	\N
4493	ASRock B550M-ITX/ac	5	\N
4494	Gigabyte X870E AORUS MASTER	5	\N
4495	ASRock B850 Pro-A	5	\N
4497	Asus ROG STRIX B850-E GAMING WIFI	5	\N
4498	MSI MAG B650M MORTAR WIFI	5	\N
4500	MSI PRO X870-P WIFI	5	\N
4501	Asus PRIME B550-PLUS AC-HES	5	\N
4502	Asus PRIME X870-P WIFI	5	\N
4503	Gigabyte B650M AORUS ELITE AX	5	\N
4505	Asus Z790-AYW WIFI W II	5	\N
4506	ASRock B850M Riptide WiFi	5	\N
4507	Gigabyte B760M DS3H DDR4	5	\N
4508	Asus TUF GAMING B760M-PLUS WIFI II	5	\N
4509	Gigabyte B650M AORUS ELITE AX ICE	5	\N
4510	Asus PRIME H610I-PLUS D4-CSM	5	\N
4511	Asus PRIME B760M-A AX	5	\N
4512	Gigabyte B550M DS3H	5	\N
4513	MSI PRO B650-P WIFI	5	\N
4514	ASRock B650M-H/M.2+	5	\N
4515	ASRock X870 Steel Legend WiFi	5	\N
4516	Asus ROG MAXIMUS Z790 DARK HERO	5	\N
4517	Gigabyte Z790 AORUS ELITE X WIFI7	5	\N
4518	ASRock H610M/ac	5	\N
4519	Gigabyte B650I AORUS ULTRA	5	\N
4520	Gigabyte A620M S2H	5	\N
4521	Gigabyte Z890 EAGLE WIFI7	5	\N
4522	Asus ROG STRIX B450-F GAMING II	5	\N
4523	Asus ROG STRIX X870-F GAMING WIFI	5	\N
4524	Gigabyte B450M DS3H	5	\N
4525	Asus PRIME B840-PLUS WIFI	5	\N
4527	Asus TUF GAMING B550M-PLUS WIFI II	5	\N
4528	ASRock B450M PRO4 R2.0	5	\N
4530	ASRock A620M Pro RS WiFi	5	\N
4532	ASRock H510M-HDV/M.2 SE	5	\N
4533	Asus ROG STRIX B550-F GAMING	5	\N
4534	ASRock B550M-HDV	5	\N
4535	MSI PRO Z890-P WIFI	5	\N
4536	MSI PRO B650-A WIFI	5	\N
4537	ASRock B850M-X WiFi	5	\N
4538	Gigabyte B550M AORUS ELITE	5	\N
4539	Montech XR	8	\N
4540	Phanteks XT PRO	8	\N
4541	NZXT H5 Flow (2024)	8	\N
4542	Corsair 3500X ARGB	8	\N
4543	Cooler Master MasterBox Q300L	8	\N
4544	Corsair 4000D Airflow	8	\N
4545	Lian Li Lancool 207	8	\N
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
4576	Lian Li LANCOOL 216 RGB	8	\N
4577	HYTE Y70	8	\N
4578	Fractal Design Pop Air	8	\N
4579	NZXT H7 Flow (2024)	8	\N
4580	MUSETEX Y6	8	\N
4581	Corsair 3000D AIRFLOW	8	\N
4582	Lian Li O11 Vision	8	\N
4586	Montech X3 Mesh	8	\N
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
4603	Zalman T3 PLUS	8	\N
4604	Antec FLUX PRO	8	\N
4605	Cooler Master Elite 301	8	\N
4607	Jonsbo Jonsplus Z20	8	\N
4608	Fractal Design Pop Mini Air	8	\N
4612	MSI MAG FORGE 321R AIRFLOW	8	\N
4613	Jonsbo D32 PRO	8	\N
4614	Lian Li A4-H20 X4	8	\N
4618	Okinos Cypress 3	8	\N
4619	Fractal Design Focus G	8	\N
4620	Thermaltake View 170 ARGB	8	\N
4621	NZXT H5 Flow RGB (2024)	8	\N
4623	NZXT H9 Flow RGB+ (2025)	8	\N
4627	Lian Li ODYSSEY X	8	\N
4628	Lian Li LANCOOL 216	8	\N
4629	Thermaltake View 270 Plus TG ARGB	8	\N
4630	Antec FLUX	8	\N
4632	Cooler Master MasterBox NR200P V2	8	\N
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
4656	Lian Li LANCOOL III RGB	8	\N
4657	SAMA SV01	8	\N
4661	Fractal Design Torrent	8	\N
4664	Thermaltake Versa H16 ARGB	8	\N
4666	Phanteks Eclipse G370A	8	\N
4669	MSI MAG PANO 100R PZ	8	\N
4670	GAMDIAS TALOS E3 MESH	8	\N
4671	Antec NX200M	8	\N
4672	Fractal Design Node 804	8	\N
4674	Phanteks EVOLV X2	8	\N
4675	NZXT H7 Flow RGB (2024)	8	\N
4676	HYTE Y40	8	\N
4677	Montech X5	8	\N
4681	Fractal Design Meshify 3	8	\N
4690	Jonsbo TK-0	8	\N
4691	Corsair 2500X	8	\N
4698	Fractal Design Meshify 2 XL	8	\N
4701	MSI MAG FORGE 112R	8	\N
4702	Lian Li O11 Vision Chrome	8	\N
4708	Thermaltake The Tower 300	8	\N
4709	Asus TUF Gaming GT502	8	\N
4710	Thermaltake The Tower 600	8	\N
4711	Corsair iCUE LINK 3500X RGB	8	\N
4712	Corsair 3000D RGB AIRFLOW	8	\N
4716	BGears b-Vortex-RGB	8	\N
4718	Jonsbo N4	8	\N
4719	be quiet! Light Base 600 LX	8	\N
4720	BGears b-Pellucid	8	\N
4721	Vetroo AL900	8	\N
4723	Thermaltake View 380 ARGB	8	\N
4731	Antec C3 ARGB	8	\N
4734	Fractal Design Focus 2	8	\N
4735	Asus A31	8	\N
4737	Antec C8 Curve Wood	8	\N
4738	Jonsbo C6 MAX	8	\N
4739	Corsair Vengeance RGB 32 GB	3	\N
4740	G.Skill Flare X5 32 GB	3	\N
4741	Corsair Vengeance LPX 16 GB	3	\N
4742	Corsair Vengeance 32 GB	3	\N
4743	TEAMGROUP T-Create Expert 32 GB	3	\N
4744	Corsair Vengeance LPX 32 GB	3	\N
4745	Crucial Pro Overclocking 32 GB	3	\N
4746	G.Skill Trident Z5 RGB 64 GB	3	\N
4747	Corsair Vengeance RGB 64 GB	3	\N
4748	TEAMGROUP T-Force Delta RGB 32 GB	3	\N
4749	G.Skill Trident Z5 Neo RGB 32 GB	3	\N
4750	Patriot Viper Venom 32 GB	3	\N
4751	Corsair Vengeance RGB Pro 32 GB	3	\N
4754	Silicon Power GAMING 16 GB	3	\N
4755	TEAMGROUP T-Force Vulcan Z 16 GB	3	\N
4757	Kingston FURY Beast 32 GB	3	\N
4758	G.Skill Trident Z5 Neo RGB 64 GB	3	\N
4759	G.Skill Ripjaws V 32 GB	3	\N
4762	Kingston FURY Beast 16 GB	3	\N
4763	Corsair Vengeance RGB Pro 16 GB	3	\N
4764	Silicon Power Value Gaming 32 GB	3	\N
4765	Corsair Vengeance 64 GB	3	\N
4766	G.Skill Flare X5 64 GB	3	\N
4767	TEAMGROUP T-Force Vulcan 32 GB	3	\N
4768	Silicon Power GAMING 32 GB	3	\N
4771	Corsair Dominator Titanium 64 GB	3	\N
4772	G.Skill Ripjaws V 64 GB	3	\N
4776	G.Skill Trident Z RGB 32 GB	3	\N
4778	G.Skill Ripjaws V 16 GB	3	\N
4779	Crucial Classic 16 GB	3	\N
4782	G.Skill Ripjaws S5 32 GB	3	\N
4783	Corsair Vengeance LPX 64 GB	3	\N
4784	Crucial Pro 32 GB	3	\N
4785	Kingston FURY Beast RGB 32 GB	3	\N
4788	Patriot Venom 64 GB	3	\N
4789	Crucial Pro 64 GB	3	\N
4794	TEAMGROUP T-Force Delta RGB 16 GB	3	\N
4796	Kingston FURY Beast 64 GB	3	\N
4797	G.Skill Trident Z5 RGB 48 GB	3	\N
4798	Patriot Viper Venom 64 GB	3	\N
4799	G.Skill Trident Z5 RGB 32 GB	3	\N
4801	Timetec PINNACLE Konduit 16 GB	3	\N
4802	Corsair Dominator Titanium 32 GB	3	\N
4803	Patriot Viper Steel 32 GB	3	\N
4805	Corsair Vengeance 16 GB	3	\N
4806	G.Skill Ripjaws S5 64 GB	3	\N
4807	Crucial CP2K64G56C46U5 128 GB	3	\N
4812	Corsair Vengeance RGB 128 GB	3	\N
4813	Corsair Vengeance RGB Pro SL 32 GB	3	\N
4817	TEAMGROUP T-Create Classic 32 GB	3	\N
4819	Patriot Viper Elite 5 RGB 32 GB	3	\N
4820	TEAMGROUP T-Force Delta RGB 64 GB	3	\N
4822	G.Skill Trident Z5 Royal 32 GB	3	\N
4825	TEAMGROUP T-Force Vulcan Z 32 GB	3	\N
4828	G.Skill Trident Z RGB 16 GB	3	\N
4830	Corsair Vengeance 128 GB	3	\N
4831	Corsair Vengeance RGB 16 GB	3	\N
4832	Crucial CT2K8G48C40U5 16 GB	3	\N
4833	G.Skill Trident Z5 Neo 64 GB	3	\N
4837	PNY XLR8 Gaming RGB 32 GB	3	\N
4839	Kingston FURY Beast 8 GB	3	\N
4846	Patriot Viper Venom 16 GB	3	\N
4847	G.Skill Trident Z5 Royal 64 GB	3	\N
4853	Patriot Signature Line 32 GB	3	\N
4854	Crucial CT2K16G48C40U5 32 GB	3	\N
4857	Crucial Pro Overclocking 64 GB	3	\N
4861	Corsair Vengeance LPX 8 GB	3	\N
4864	Crucial CT2K8G4DFRA32A 16 GB	3	\N
4866	Crucial CT8G4DFS824A 8 GB	3	\N
4867	Timetec PINNACLE Konduit 32 GB	3	\N
4868	Kingston FURY Beast RGB 64 GB	3	\N
4873	G.Skill Trident Z5 Neo 32 GB	3	\N
4874	G.Skill Aegis 16 GB	3	\N
4875	PNY XLR8 32 GB	3	\N
4876	TEAMGROUP Elite 16 GB	3	\N
4884	Silicon Power XPOWER Turbine 16 GB	3	\N
4886	Crucial CT16G48C40U5 16 GB	3	\N
4889	Klevv FIT V 32 GB	3	\N
4891	Kingston FURY Beast RGB 16 GB	3	\N
4896	Patriot Viper Xtreme 5 32 GB	3	\N
4899	G.Skill Trident Z Neo 32 GB	3	\N
4901	Patriot Viper Venom RGB 32 GB	3	\N
4902	Kingston FURY Beast 128 GB	3	\N
4903	Corsair Vengeance 48 GB	3	\N
4910	Silicon Power SP016GBLFU320B22 16 GB	3	\N
4916	G.Skill Aegis 32 GB	3	\N
4922	TEAMGROUP T-Create Expert 64 GB	3	\N
4934	Kingston KCP424NS6/4 4 GB	3	\N
4935	G.Skill Trident Z5 Royal 48 GB	3	\N
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
\.


--
-- TOC entry 5293 (class 0 OID 25549)
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
-- TOC entry 5292 (class 0 OID 25536)
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
46	6	3.8	5.1	Zen 4	65	Radeon	AM5
50	8	4.5	5.4	Zen 4	105	Radeon	AM5
51	6	4.1	5	Zen 4	65	Radeon 740M	AM5
67	6	4.1	4.7	Zen 4	65	Radeon	AM5
68	12	3.7	5.4	Zen 4	65	Radeon	AM5
71	8	4.2	5.1	Zen 4	65	Radeon 780M	AM5
78	6	4.3	5	Zen 4	65	Radeon 760M	AM5
81	8	3.8	5.3	Zen 4	65	Radeon	AM5
95	8	4.5	5.4	Zen 4	105	Radeon	AM5
100	12	3.7	5.4	Zen 4	65	Radeon	AM5
103	16	4.5	5.7	Zen 4	170	Radeon	AM5
108	16	4.5	5.7	Zen 4	170	Radeon	AM5
161	6	3.8	5.1	Zen 4	65	Radeon	AM5
20	8	3.8	4.6	Zen 3	65	Radeon Vega 8	AM4
44	6	3.6	4.4	Zen 3	65	Radeon Vega 7	AM4
93	6	3.9	4.4	Zen 3	65	Radeon Vega 7	AM4
135	6	3.6	4.6	Zen 3	65	Radeon Vega 7	AM4
98	4	3.7	4.2	Zen+	65	Radeon Vega 11	AM4
152	4	3.6	4	Zen+	65	Radeon Vega 8	AM4
28	4	3.6	3.9	Zen	65	Radeon Vega 11	AM4
55	4	3.7	4	Steamroller	95	Radeon R7 (on-die)	FM2+
63	2	3.5	3.9	Steamroller	65	Radeon R5 (on die)	FM2+
165	4	3.1	3.8	Steamroller	65	Radeon R7 (on-die)	FM2+
29	4	3.5	3.8	Excavator	65	Radeon R7 (on-die)	FM2+
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
34	6	3	4.6	Alder Lake	65	Intel UHD Graphics 770	LGA1700
74	10	3.7	4.9	Alder Lake	125	Intel UHD Graphics 770	LGA1700
105	4	3.3	4.3	Alder Lake	60	Intel UHD Graphics 730	LGA1700
154	6	3.3	4.8	Alder Lake	65	Intel UHD Graphics 770	LGA1700
157	12	3.6	5	Alder Lake	125	Intel UHD Graphics 770	LGA1700
160	12	2.1	4.9	Alder Lake	65	Intel UHD Graphics 770	LGA1700
169	16	3.2	5.2	Alder Lake	125	Intel UHD Graphics 770	LGA1700
172	16	3.4	5.5	Alder Lake	150	Intel UHD Graphics 770	LGA1700
173	6	2.5	4.4	Alder Lake	65	Intel UHD Graphics 730	LGA1700
42	6	2.7	4.6	Rocket Lake	65	Intel UHD Graphics 750	LGA1200
77	8	3.6	5	Rocket Lake	125	Intel UHD Graphics 750	LGA1200
89	6	2.8	4.8	Rocket Lake	65	Intel UHD Graphics 750	LGA1200
107	6	2.6	4.4	Rocket Lake	65	Intel UHD Graphics 730	LGA1200
112	8	2.5	5.2	Rocket Lake	65	Intel UHD Graphics 750	LGA1200
117	8	3.5	5.3	Rocket Lake	125	Intel UHD Graphics 750	LGA1200
166	8	2.5	4.9	Rocket Lake	65	Intel UHD Graphics 750	LGA1200
6	8	2.9	4.8	Comet Lake	65	Intel UHD Graphics 630	LGA1200
12	4	3.7	4.4	Comet Lake	65	Intel UHD Graphics 630	LGA1200
31	4	3.8	4.6	Comet Lake	65	Intel UHD Graphics 630	LGA1200
35	10	3.7	5.3	Comet Lake	125	Intel UHD Graphics 630	LGA1200
48	4	3.6	4.3	Comet Lake	65	Intel UHD Graphics 630	LGA1200
70	10	2.8	5.2	Comet Lake	65	Intel UHD Graphics 630	LGA1200
110	6	3.1	4.5	Comet Lake	65	Intel UHD Graphics 630	LGA1200
120	6	2.9	4.3	Comet Lake	65	Intel UHD Graphics 630	LGA1200
126	6	4.1	4.8	Comet Lake	125	Intel UHD Graphics 630	LGA1200
130	8	3.8	5.1	Comet Lake	125	Intel UHD Graphics 630	LGA1200
141	6	3.3	4.8	Comet Lake	65	Intel UHD Graphics 630	LGA1200
15	4	3.7	4.3	Coffee Lake Refresh	62	Intel UHD Graphics 630	LGA1151
17	6	3.1	4.6	Coffee Lake Refresh	65	Intel UHD Graphics 630	LGA1151
18	8	3	4.7	Coffee Lake Refresh	65	Intel HD Graphics 630	LGA1151
59	6	3	4.4	Coffee Lake Refresh	65	Intel UHD Graphics 630	LGA1151
72	4	3.6	4.2	Coffee Lake Refresh	65	Intel UHD Graphics 630	LGA1151
90	6	2.9	4.1	Coffee Lake Refresh	65	Intel UHD Graphics 630	LGA1151
116	8	3.6	5	Coffee Lake Refresh	95	Intel UHD Graphics 630	LGA1151
123	8	3.1	5	Coffee Lake Refresh	65	Intel UHD Graphics 630	LGA1151
143	8	4	5	Coffee Lake Refresh	127	Intel UHD Graphics 630	LGA1151
145	6	3.7	4.6	Coffee Lake Refresh	95	Intel UHD Graphics 630	LGA1151
148	8	3.6	4.9	Coffee Lake Refresh	95	Intel UHD Graphics 630	LGA1151
164	8	3.6	5	Coffee Lake Refresh	95	Intel UHD Graphics 630	LGA1151
25	6	3.1	4.3	Coffee Lake	65	Intel UHD Graphics 630	LGA1151
37	4	3.8	4.7	Coffee Lake	71	Intel HD Graphics P630	LGA1151
41	6	2.4	4	Coffee Lake	35	Intel UHD Graphics 630	LGA1151
49	6	3.7	4.7	Coffee Lake	80	Intel HD Graphics P630	LGA1151
56	6	3.2	4.6	Coffee Lake	65	Intel UHD Graphics 630	LGA1151
60	6	2.1	3.5	Coffee Lake	35	Intel UHD Graphics 630	LGA1151
64	6	3.6	4.3	Coffee Lake	95	Intel UHD Graphics 630	LGA1151
75	6	3	4.1	Coffee Lake	65	Intel UHD Graphics 630	LGA1151
82	6	2.8	4	Coffee Lake	65	Intel UHD Graphics 630	LGA1151
88	6	3.7	4.7	Coffee Lake	95	Intel UHD Graphics 630	LGA1151
94	6	1.7	3.3	Coffee Lake	35	Intel UHD Graphics 630	LGA1151
113	6	4	5	Coffee Lake	95	Intel UHD Graphics 630	LGA1151
158	4	3.4	4.5	Coffee Lake	71	Intel HD Graphics P630	LGA1151
3	4	2.4	3	Kaby Lake	35	Intel HD Graphics 630	LGA1151
14	4	2.8	3.7	Kaby Lake	35	Intel HD Graphics 630	LGA1151
16	4	3	3.5	Kaby Lake	65	Intel HD Graphics 630	LGA1151
30	4	2.7	3.3	Kaby Lake	35	Intel HD Graphics 630	LGA1151
52	4	4.1	4.5	Kaby Lake	79	Intel HD Graphics 630	LGA1151
57	4	3.5	4.1	Kaby Lake	65	Intel HD Graphics 630	LGA1151
65	4	2.9	3.8	Kaby Lake	35	Intel HD Graphics 630	LGA1151
79	4	4.2	4.5	Kaby Lake	91	Intel HD Graphics 630	LGA1151
91	4	3.8	4.2	Kaby Lake	73	Intel HD Graphics P630	LGA1151
124	4	3.7	4.1	Kaby Lake	73	Intel HD Graphics P630	LGA1151
131	4	3.4	3.8	Kaby Lake	65	Intel HD Graphics 630	LGA1151
134	4	3.3	3.7	Kaby Lake	73	Intel HD Graphics P630	LGA1151
149	4	3.6	4.2	Kaby Lake	65	Intel HD Graphics 630	LGA1151
162	4	3.8	4.2	Kaby Lake	91	Intel HD Graphics 630	LGA1151
38	4	4	4.2	Skylake	91	Intel HD Graphics 530	LGA1151
62	4	3.2	3.6	Skylake	65	Intel HD Graphics 530	LGA1151
66	4	2.7	3.5	Skylake	35	Intel HD Graphics 530	LGA1151
84	4	2.8	3.4	Skylake	65	Intel HD Graphics 510	LGA1151
99	4	3.5	3.9	Skylake	91	Intel HD Graphics 530	LGA1151
133	4	3.4	4	Skylake	65	Intel HD Graphics 530	LGA1151
139	4	2.5	3.1	Skylake	35	Intel HD Graphics 530	LGA1151
8	4	3.2	3.4	Haswell Refresh	84	Intel HD Graphics 4600	LGA1150
33	4	3.6	4	Haswell Refresh	84	Intel HD Graphics 4600	LGA1150
39	4	3.5	3.9	Haswell Refresh	88	Intel HD Graphics 4600	LGA1150
101	4	4	4.4	Haswell Refresh	88	Intel HD Graphics 4600	LGA1150
151	4	3.5	3.9	Haswell Refresh	84	Intel HD Graphics 4600	LGA1150
9	4	3.5	3.9	Haswell	84	Intel HD Graphics 4600	LGA1150
85	4	3.1	3.3	Haswell	84	Intel HD Graphics 4600	LGA1150
109	4	3.4	3.9	Haswell	84	Intel HD Graphics 4600	LGA1150
22	4	3.1	3.3	Ivy Bridge	77	Intel HD Graphics 2500	LGA1155
61	4	2.7	3.2	Ivy Bridge	65	Intel HD Graphics 2500	LGA1155
\.


--
-- TOC entry 5301 (class 0 OID 25637)
-- Dependencies: 247
-- Data for Name: dealers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dealers (id, name, website, logo_url) FROM stdin;
1	PCPartPicker (US)	\N	\N
2	Newegg	https://www.newegg.com	\N
\.


--
-- TOC entry 5287 (class 0 OID 25494)
-- Dependencies: 233
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- TOC entry 5297 (class 0 OID 25597)
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
-- TOC entry 5285 (class 0 OID 25479)
-- Dependencies: 231
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- TOC entry 5284 (class 0 OID 25464)
-- Dependencies: 230
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- TOC entry 5295 (class 0 OID 25573)
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
-- TOC entry 5276 (class 0 OID 25396)
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
\.


--
-- TOC entry 5294 (class 0 OID 25560)
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
-- TOC entry 5279 (class 0 OID 25420)
-- Dependencies: 225
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- TOC entry 5309 (class 0 OID 25707)
-- Dependencies: 255
-- Data for Name: pc_builds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pc_builds (id, user_id, build_name, total_price, usage_profile_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5313 (class 0 OID 25748)
-- Dependencies: 259
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (id, user_id, title, content, post_type, build_id, created_at, updated_at) FROM stdin;
1	1	Xin chào	Đây là bài viết đầu tiên	discussion	\N	2026-04-12 04:17:54	2026-04-12 04:17:54
2	1	hello	1234567890	discussion	\N	2026-04-12 07:46:12	2026-04-12 07:46:12
\.


--
-- TOC entry 5299 (class 0 OID 25623)
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
-- TOC entry 5280 (class 0 OID 25429)
-- Dependencies: 226
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
QGQSQ02p0dUfPb5MOIAuPbpON9JjSkTdn1Mlrwvt	1	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36	eyJfdG9rZW4iOiJ3TURrMnNzZ3k4SEwxcVVnakhXbURSY0JUTTk4RmNzZGhnVDlSb09tIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119LCJfcHJldmlvdXMiOnsidXJsIjoiaHR0cDpcL1wvbG9jYWxob3N0OjgwMDBcL2J1aWxkZXIiLCJyb3V0ZSI6ImJ1aWxkZXIubWFudWFsIn0sImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjoxLCJidWlsZF9wYyI6eyJjcHUiOnsiaWQiOjEsIm5hbWUiOiJBTUQgUnl6ZW4gNyA3NzAwIiwicHJpY2UiOiI0NDI5MDAwLjAwIiwiaW1hZ2UiOm51bGx9fX0=	1780651545
\.


--
-- TOC entry 5316 (class 0 OID 26127)
-- Dependencies: 262
-- Data for Name: temp_cases; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.temp_cases (name, price, type, color, psu, side_panel, external_volume, internal_35_bays) FROM stdin;
Montech XR	83.59	ATX Mid Tower	Black	\N	Tempered Glass	45	2
Phanteks XT PRO	67.98	ATX Mid Tower	Black	\N	Tempered Glass	51.8	2
NZXT H5 Flow (2024)	84.99	ATX Mid Tower	Black	\N	Tempered Glass	45	1
Corsair 3500X ARGB	115.99	ATX Mid Tower	White	\N	Tempered Glass	55.9	2
Cooler Master MasterBox Q300L	45.98	MicroATX Mini Tower	Black	\N	Acrylic	33.6	1
Corsair 4000D Airflow	94.99	ATX Mid Tower	Black	\N	Tinted Tempered Glass	48.6	2
Lian Li Lancool 207	81.99	ATX Mid Tower	Blue	\N	Tempered Glass	45.5	2
NZXT H9 Flow (2023)	119.99	ATX Mid Tower	Black	\N	Tempered Glass	66.9	2
Lian Li O11 VISION COMPACT	124.99	ATX Mid Tower	White	\N	Tempered Glass	57.4	2
Corsair 3500X ARGB	115.99	ATX Mid Tower	Black	\N	Tempered Glass	55.9	2
Montech AIR 100 ARGB	69.9	MicroATX Mid Tower	Black	\N	Tempered Glass	36.1	2
Montech AIR 903 MAX	74.99	ATX Mid Tower	Black	\N	Tempered Glass	54.2	2
Lian Li A3-mATX	72.98	MicroATX Mini Tower	Black	\N	Mesh	26.3	1
Fractal Design North	139.99	ATX Mid Tower	Black	\N	Tempered Glass	45.1	2
HYTE Y70 Touch Infinite	439.95	ATX Mid Tower	White	\N	Tempered Glass	70.7	2
Fractal Design North XL	179.99	ATX Full Tower	Black	\N	Tinted Tempered Glass	61.4	2
Lian Li O11 VISION COMPACT	124.99	ATX Mid Tower	Black	\N	Tempered Glass	57.4	2
NZXT H5 Flow (2024)	59.99	ATX Mid Tower	White	\N	Tempered Glass	45	1
Lian Li A3-mATX	89.99	MicroATX Mini Tower	Black / Brown	\N	Mesh	26.3	1
Phanteks XT PRO ULTRA	80.98	ATX Mid Tower	Black	\N	Tempered Glass	51.8	2
NZXT H9 Flow (2023)	99.99	ATX Mid Tower	White	\N	Tempered Glass	66.9	2
Montech XR	79.89	ATX Mid Tower	White	\N	Tempered Glass	45	2
Lian Li O11D EVO RGB	159.99	ATX Mid Tower	Black	\N	Tempered Glass	65.3	4
NZXT H6 Flow	109.97	ATX Mid Tower	Black	\N	Tempered Glass	51.8	1
Montech AIR 903 BASE	64.98	ATX Mid Tower	Black	\N	Tempered Glass	54.2	2
HYTE Y70 Touch Infinite	564.4	ATX Mid Tower	Black	\N	Tempered Glass	70.7	2
NZXT H6 Flow	89.97	ATX Mid Tower	White	\N	Tempered Glass	51.8	1
Corsair FRAME 4000D RS ARGB	104.99	ATX Mid Tower	Black	\N	Tempered Glass	56.7	2
NZXT H3 Flow	69.98	MicroATX Mid Tower	Black	\N	Tinted Tempered Glass	35	1
Fractal Design Terra	179.99	Mini ITX Desktop	Black / Brown	\N	Mesh	11.4	0
Antec C5 ARGB	114.99	ATX Mid Tower	Black	\N	Tempered Glass	\N	1
Fractal Design Pop XL Air	119.97	ATX Full Tower	Black	\N	Tempered Glass	62.4	3
Lian Li LANCOOL 217	127.5	ATX Mid Tower	Black / Brown	\N	Tempered Glass	57.7	1
Lian Li O11 Dynamic EVO XL	254.98	ATX Full Tower	Black	\N	Tempered Glass	84.4	4
Montech KING 95 PRO	148.98	ATX Mid Tower	Black	\N	Tempered Glass	63	5
Fractal Design Meshify C	109.99	ATX Mid Tower	Black	\N	Tinted Tempered Glass	40.6	2
Cooler Master MasterBox NR200	67.29	Mini ITX Desktop	Black	\N	\N	20.3	2
Okinos Aqua 3	64.98	MicroATX Mini Tower	Black	\N	Tempered Glass	28.8	2
Lian Li LANCOOL 216 RGB	102.97	ATX Mid Tower	Black	\N	Tempered Glass	55.6	2
HYTE Y70	219.99	ATX Mid Tower	White	\N	Tempered Glass	70.7	2
Fractal Design Pop Air	79.99	ATX Mid Tower	Black	\N	Tempered Glass	46.2	2
NZXT H7 Flow (2024)	129.99	ATX Mid Tower	Black	\N	Tempered Glass	62.1	2
MUSETEX Y6	85.48	ATX Mid Tower	White	\N	Tempered Glass	40.9	2
Corsair 3000D AIRFLOW	94.99	ATX Mid Tower	Black	\N	Tempered Glass	49.5	2
Lian Li O11 Vision	142.99	ATX Mid Tower	Black	\N	Tempered Glass	67.8	2
Fractal Design North	139.99	ATX Mid Tower	Black	\N	Mesh	45.1	2
HYTE Y70	219.99	ATX Mid Tower	Black	\N	Tempered Glass	70.7	2
Lian Li O11D EVO RGB	159.99	ATX Mid Tower	White	\N	Tempered Glass	65.3	4
Montech X3 Mesh	54.99	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cooler Master Elite 301 Lite	64.94	MicroATX Mini Tower	Black	\N	Tempered Glass	34.1	1
Fractal Design Terra	179.99	Mini ITX Desktop	Green / Brown	\N	Mesh	11.4	0
Corsair FRAME 4000D	104.99	ATX Mid Tower	Black	\N	Tempered Glass	56.7	2
NZXT H6 Flow RGB	129.97	ATX Mid Tower	White	\N	Tempered Glass	51.8	1
Asus Prime AP201	89.97	MicroATX Mini Tower	Black	\N	Mesh	33	3
Montech XR Wood	79.9	ATX Mid Tower	Black / Brown	\N	Tempered Glass	49.8	2
Deepcool CH160	\N	Mini ITX Desktop	Black	\N	Tempered Glass	19.1	1
Montech X5M	56	MicroATX Mini Tower	Black	\N	Tempered Glass	45.3	2
Lian Li A3-mATX	89.99	MicroATX Mini Tower	White / Brown	\N	Tempered Glass	26.3	1
Antec C8	99.99	ATX Full Tower	Black	\N	Tempered Glass	66.9	2
Thermaltake Versa H18	118.5	MicroATX Mini Tower	Black	\N	Acrylic	30.4	2
Silverstone ALTA F2	1062.27	ATX Full Tower	Black	\N	Tempered Glass	98.9	8
NZXT H6 Flow RGB	134.97	ATX Mid Tower	Black	\N	Tempered Glass	51.8	1
Corsair 5000D AIRFLOW	174.99	ATX Mid Tower	Black	\N	Tempered Glass	66.2	2
Fractal Design Ridge PCIe 4.0	129.99	Mini ITX Tower	Black	\N	Mesh	16.3	0
Corsair 3500X	99.99	ATX Mid Tower	Black	\N	Tempered Glass	55.9	2
NZXT H9 Elite	169.97	ATX Mid Tower	White	\N	Tempered Glass	66.9	2
Zalman T3 PLUS	39.5	MicroATX Mid Tower	Black	\N	Tempered Glass	30.9	1
Antec FLUX PRO	164.99	ATX Full Tower	Black / Brown	\N	Tempered Glass	70.8	4
Cooler Master Elite 301	49.99	MicroATX Mid Tower	Black	\N	Tempered Glass	34.1	1
Lian Li O11 Dynamic EVO XL	249.99	ATX Full Tower	White	\N	Tempered Glass	84.4	4
Jonsbo Jonsplus Z20	99	MicroATX Desktop	Black	\N	Tempered Glass	25.3	1
Fractal Design Pop Mini Air	99.99	MicroATX Mid Tower	Black	\N	Tempered Glass	36.5	2
Azza Fighter	59.99	ATX Mid Tower	Black	\N	Tempered Glass	34.2	2
Fractal Design North XL	194.97	ATX Full Tower	Black	\N	Mesh	61.4	2
Corsair 4000D Airflow	103.59	ATX Mid Tower	White	\N	Tinted Tempered Glass	48.6	2
MSI MAG FORGE 321R AIRFLOW	89.99	ATX Mid Tower	Black	\N	Tempered Glass	49.4	2
Jonsbo D32 PRO	71.99	MicroATX Desktop	Black	\N	Tempered Glass	25.7	2
Lian Li A4-H20 X4	154.99	Mini ITX Desktop	Black	\N	Mesh	11.1	0
Lian Li O11 Vision	138.97	ATX Mid Tower	White	\N	Tempered Glass	67.8	2
Fractal Design North	139.99	ATX Mid Tower	White	\N	Tempered Glass	45.1	2
Antec C5 ARGB	104.99	ATX Mid Tower	White	\N	Tempered Glass	\N	1
Okinos Cypress 3	64.98	MicroATX Mini Tower	Black / Brown	\N	Tempered Glass	\N	2
Fractal Design Focus G	59.99	ATX Mid Tower	Black	\N	Acrylic	42.2	2
Thermaltake View 170 ARGB	62.99	MicroATX Mini Tower	Black	\N	Tempered Glass	35	1
NZXT H5 Flow RGB (2024)	119.99	ATX Mid Tower	Black	\N	Tempered Glass	45	1
Fractal Design Terra	179.99	Mini ITX Desktop	Silver / Brown	\N	Mesh	11.4	0
NZXT H9 Flow RGB+ (2025)	289.99	ATX Mid Tower	Black	\N	Tinted Tempered Glass	76.7	2
Lian Li Lancool 207	89.99	ATX Mid Tower	White	\N	Tempered Glass	45.5	2
NZXT H9 Elite	211.99	ATX Mid Tower	Black	\N	Tempered Glass	66.9	2
Corsair 7000D AIRFLOW	289.99	ATX Full Tower	Black	\N	Tempered Glass	81.8	6
Lian Li ODYSSEY X	1468.05	ATX Full Tower	Black	\N	Tempered Glass	\N	3
Lian Li LANCOOL 216	111.97	ATX Mid Tower	Black	\N	Tempered Glass	55.6	2
Thermaltake View 270 Plus TG ARGB	78.99	ATX Mid Tower	Black	\N	Tempered Glass	47.6	2
Antec FLUX	104.99	ATX Mid Tower	Black / Brown	\N	Tempered Glass	58.1	2
Lian Li A3-mATX	72.98	MicroATX Mini Tower	White	\N	Mesh	26.3	1
Cooler Master MasterBox NR200P V2	109.99	Mini ITX Desktop	Black	\N	Mesh	20.1	1
Montech KING 95 PRO	139	ATX Mid Tower	White	\N	Tempered Glass	63	5
Corsair 9000D RGB AIRFLOW	519.99	ATX Full Tower	Black	\N	Tempered Glass	149.6	5
Thermaltake V100 Perforated	49.99	ATX Mid Tower	Black	\N	\N	36.6	2
Mars Gaming MC-S2	79.34	ATX Mid Tower	White	\N	Acrylic	19.5	1
Corsair FRAME 4000D RS	94.99	ATX Mid Tower	Black	\N	Tempered Glass	56.7	2
Fractal Design Focus 2	74.99	ATX Mid Tower	Black	\N	\N	45.8	2
Asus ROG Strix Helios	234.97	ATX Full Tower	Black	\N	Tempered Glass	83.5	2
Deepcool CH260	\N	MicroATX Desktop	Black	\N	Tempered Glass	30.8	1
Fractal Design Pop Air RGB	99.99	ATX Mid Tower	Black	\N	Tempered Glass	46.2	2
Zalman CUBIX	37.99	MicroATX Mini Tower	Black	\N	\N	\N	1
Deepcool CG530 4F	\N	ATX Mid Tower	Black	\N	Tinted Acrylic	50	2
NZXT H9 Flow (2025)	164.99	ATX Mid Tower	Black	\N	Tinted Tempered Glass	76.7	2
Montech KING 65 PRO	94.99	ATX Mid Tower	Black	\N	Tempered Glass	63	2
Deepcool CC560 V2	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.9	2
Fractal Design Define R5	124.99	ATX Mid Tower	Black	\N	\N	54.2	8
NZXT H510	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.3	2
Lian Li Vector V100R	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.2	1
Cooler Master MasterBox Q300L	36.99	MicroATX Mini Tower	White	\N	Acrylic	33.6	1
NZXT H9 Flow RGB+ (2025)	289.99	ATX Mid Tower	White	\N	Tempered Glass	76.7	2
Cooler Master Q300L V2	55.98	MicroATX Mini Tower	Black	\N	Tempered Glass	34.1	1
Antec C8 Wood	119.99	ATX Full Tower	Black / Brown	\N	Tempered Glass	66.9	2
Lian Li O11 Dynamic Mini	229	ATX Mid Tower	Black	\N	Tempered Glass	43	2
Montech AIR 100 ARGB	69.98	MicroATX Mid Tower	White	\N	Tempered Glass	36.1	2
HYTE Y60	179.99	ATX Mid Tower	Black	\N	Tempered Glass	60	2
MUSETEX K2	74.98	ATX Mid Tower	Black	\N	Tempered Glass	44.4	2
Fractal Design Ridge PCIe 4.0	142.97	Mini ITX Tower	White	\N	Mesh	16.3	0
HYTE Y70 Touch Infinite	399.99	ATX Mid Tower	White / Black	\N	Tempered Glass	70.7	2
Zalman S2	49.98	ATX Mid Tower	Black	\N	Acrylic	38.4	2
Fractal Design North XL	179.99	ATX Full Tower	White	\N	Tempered Glass	61.4	2
Zalman T8	42.95	ATX Mid Tower	Black	\N	\N	33.4	2
Jonsbo C6-ITX	62	Mini ITX Desktop	Black	\N	Mesh	15.9	1
Lian Li A4-H20 A4	154.99	Mini ITX Desktop	Silver / Black	\N	Mesh	11.1	0
MSI MAG FORGE M100R	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	32.8	2
NZXT H510	\N	ATX Mid Tower	White	\N	Tempered Glass	41.3	2
Deepcool CH370	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	38.3	2
GameMax Nova N5	50.99	ATX Mid Tower	Black	\N	Tempered Glass	37.6	2
Lian Li LANCOOL III RGB	179.99	ATX Mid Tower	Black	\N	Tempered Glass	65.5	4
SAMA SV01	79.99	ATX Mid Tower	Black	\N	Tempered Glass	43.5	2
be quiet! Pure Base 500DX	109.9	ATX Mid Tower	Black	\N	Tempered Glass	48.3	2
NZXT H3 Flow	69.98	MicroATX Mid Tower	White	\N	Tempered Glass	35	1
NZXT H5 Flow RGB (2024)	89.99	ATX Mid Tower	White	\N	Tempered Glass	45	1
Fractal Design Torrent	204.99	ATX Mid Tower	Black	\N	Tinted Tempered Glass	69.8	2
Montech AIR 100 LITE	79.98	MicroATX Mid Tower	Black	\N	Tempered Glass	36.1	2
Lian Li PC-O11 Dynamic	\N	ATX Full Tower	Black	\N	Tempered Glass	54	3
Lian Li A3-mATX	89.99	MicroATX Mini Tower	Black / Brown	\N	Tempered Glass	26.3	1
Thermaltake Versa H16 ARGB	54.99	MicroATX Mini Tower	Black	\N	Tempered Glass	33	2
Lian Li O11 Dynamic Mini Snow Edition	\N	ATX Mid Tower	White	\N	Tempered Glass	43	2
GameMax Vista M	53.9	MicroATX Mini Tower	Black	\N	Tempered Glass	40.9	2
Phanteks Eclipse G370A	56.98	ATX Mid Tower	Black	\N	Tempered Glass	48.7	0
Thermaltake View 170 ARGB	67.99	MicroATX Mini Tower	White	\N	Tempered Glass	35	1
Montech AIR 903 BASE	69	ATX Mid Tower	White	\N	Tempered Glass	54.2	2
MSI MAG PANO 100R PZ	159.99	ATX Mid Tower	Black	\N	Tempered Glass	72.5	2
GAMDIAS TALOS E3 MESH	59.99	ATX Mid Tower	Black	\N	Tempered Glass	34.1	2
Antec NX200M	92.97	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	2
MSI MAG FORGE 320R AIRFLOW	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.4	2
Fractal Design Meshify 2	164.99	ATX Mid Tower	Black	\N	\N	61.7	6
Fractal Design Node 804	134.99	MicroATX Mid Tower	Black	\N	Acrylic	41.1	10
Phanteks NV5 MKII	120.98	ATX Mid Tower	Black	\N	Tempered Glass	60.2	3
Phanteks EVOLV X2	174.98	ATX Mid Tower	Black	\N	Tempered Glass	60.9	2
NZXT H7 Flow RGB (2024)	149.99	ATX Mid Tower	Black	\N	Tempered Glass	62.1	2
Cooler Master MasterBox NR200	89.99	Mini ITX Desktop	White / Black	\N	\N	20.3	2
HYTE Y40	129.99	ATX Mid Tower	Black	\N	Tempered Glass	49.7	1
Montech X5	75	ATX Mid Tower	Black	\N	Tempered Glass	51.6	2
HAVN HS420	229.99	ATX Mid Tower	Black	\N	Tempered Glass	76.8	5
Thermaltake Versa H18	54.99	MicroATX Mini Tower	Black	\N	Tempered Glass	30.4	2
Corsair iCUE 4000X RGB	144.99	ATX Mid Tower	Black	\N	Tempered Glass	48.6	2
Fractal Design Meshify 3	154.99	ATX Mid Tower	Black	\N	Tinted Tempered Glass	50.3	2
Fractal Design North	154.97	ATX Mid Tower	White	\N	Mesh	45.1	2
Thermaltake Core V1	53.68	Mini ITX Desktop	Black	\N	\N	22.4	2
HYTE Y60 Snow White	179.99	ATX Mid Tower	White	\N	Tempered Glass	60	2
Fractal Design Node 304	109.99	Mini ITX Tower	Black / White	\N	\N	19.5	6
Cooler Master MasterBox TD500 Mesh V2	107.89	ATX Mid Tower	\N	\N	Tempered Glass	52.4	2
Lian Li Lancool 207 Digital	104.99	ATX Mid Tower	Black	\N	Tempered Glass	45.5	2
Corsair 6500X	199.99	ATX Mid Tower	Black	\N	Tempered Glass	78.3	2
Deepcool MATREXX 40 3FS	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	\N	2
Lian Li O11 Dynamic EVO	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	60.8	6
MSI MAG PANO 100R PZ	159.99	ATX Mid Tower	White	\N	Tempered Glass	72.5	2
Montech X5M	56	MicroATX Mini Tower	White	\N	Tempered Glass	45.3	2
Fractal Design Pop Mini Air	99.99	MicroATX Mid Tower	White	\N	Tempered Glass	36.5	2
MSI MAG FORGE 120A AIRFLOW	\N	ATX Mid Tower	Black	\N	Tempered Glass	43	3
DIYPC DIY-S07	43.97	ATX Mid Tower	Black	\N	Acrylic	27.5	2
Thermaltake Versa H17	49.99	MicroATX Mini Tower	Black	\N	\N	30.4	2
Jonsbo TK-0	129.99	Mini ITX Desktop	Black	\N	Tempered Glass	16.4	1
Aerocool CS-107 RGB	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	23.7	1
Deepcool CH370	\N	MicroATX Mid Tower	White	\N	Tempered Glass	38.3	2
Thermaltake Versa H21	47.99	ATX Mid Tower	Black	\N	\N	42.8	3
Corsair 2500X	145.13	MicroATX Mini Tower	Black	\N	Tempered Glass	54.8	2
Thermaltake View 270 Plus TG ARGB	89.99	ATX Mid Tower	White	\N	Tempered Glass	47.6	2
Lian Li PC-O11 Dynamic	\N	ATX Full Tower	White	\N	Tempered Glass	54	3
HYTE Y70	219.99	ATX Mid Tower	Pink	\N	Tempered Glass	70.7	2
Antec AX20	98.32	ATX Mid Tower	Black	\N	Tempered Glass	33.4	2
Deepcool CH160	\N	Mini ITX Desktop	White	\N	Tempered Glass	19.1	1
Montech AIR 903 MAX	89.99	ATX Mid Tower	White	\N	Tempered Glass	54.2	2
Fractal Design Define 7	194.99	ATX Mid Tower	Black	\N	\N	62.4	6
Aerocool Bolt Mini Glass	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	\N	2
MSI MAG FORGE 100R	157.02	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
NZXT H7 Flow (2024)	109.99	ATX Mid Tower	White	\N	Tempered Glass	62.1	2
FormD T1 V2.1 CNC Anodized	\N	Mini ITX Desktop	Black	\N	Mesh	\N	0
Fractal Design Meshify 2 XL	219.99	ATX Full Tower	Black	\N	Tinted Tempered Glass	81.5	6
Corsair 3500X	89.99	ATX Mid Tower	White	\N	Tempered Glass	55.9	2
Corsair FRAME 4000D RS ARGB	124.99	ATX Mid Tower	White	\N	Tempered Glass	56.7	2
MSI MAG FORGE 112R	89.99	ATX Mid Tower	Black	\N	Tempered Glass	42.5	2
Lian Li O11 Vision Chrome	164	ATX Mid Tower	Black	\N	Tinted Tempered Glass	67.8	2
HAVN HS420 VGPU	299.99	ATX Mid Tower	Black	\N	Tempered Glass	76.8	5
Corsair iCUE 4000X RGB	86.99	ATX Mid Tower	White	\N	Tempered Glass	48.6	2
Asus Prime AP201	79.98	MicroATX Mini Tower	White	\N	Mesh	33	3
Lian Li ODYSSEY X	1486.88	ATX Full Tower	Silver / Black	\N	Tempered Glass	\N	3
Lian Li Vector V100R	94	ATX Mid Tower	White	\N	Tempered Glass	53.2	1
Thermaltake The Tower 300	99.99	MicroATX Mini Tower	Black	\N	Tempered Glass	53	3
Asus TUF Gaming GT502	179.97	ATX Mid Tower	Black	\N	Tempered Glass	57.2	4
Thermaltake The Tower 600	169.99	ATX Mid Tower	Black	\N	Tempered Glass	66.2	1
Jonsbo D32 STD	\N	MicroATX Desktop	Black	\N	Tempered Glass	25.7	1
Corsair iCUE LINK 3500X RGB	159.99	ATX Mid Tower	Black	\N	Tempered Glass	55.9	2
Corsair 3000D RGB AIRFLOW	124.99	ATX Mid Tower	Black	\N	Tempered Glass	49.5	2
Cooler Master N400	64.99	ATX Mid Tower	Black	\N	\N	40.2	7
Asus Prime AP201	83.99	MicroATX Mini Tower	Black	\N	Tempered Glass	33	3
Lian Li LANCOOL 216 RGB	105.97	ATX Mid Tower	White	\N	Tempered Glass	55.6	2
NZXT H9 Flow (2025)	159.99	ATX Mid Tower	White	\N	Tempered Glass	76.7	2
Fractal Design Define 7 XL	224.99	ATX Full Tower	Black	\N	\N	82	6
be quiet! Pure Base 501 Airflow	106.99	ATX Mid Tower	Black	\N	\N	48.1	2
Cooler Master N200	59.99	MicroATX Mini Tower	Black	\N	\N	33.8	2
Fractal Design Pop Air	84.99	ATX Mid Tower	Black	\N	\N	46.2	2
BGears b-Vortex-RGB	48.99	ATX Mid Tower	Black	\N	Tempered Glass	38.3	2
Lian Li LANCOOL 205M MESH	89.99	MicroATX Mini Tower	Black	\N	Tempered Glass	33.8	2
Jonsbo N4	119.99	MicroATX Desktop	Black / Brown	\N	Mesh	19.6	6
be quiet! Light Base 600 LX	179.9	ATX Mid Tower	Black	\N	Tempered Glass	59.7	1
BGears b-Pellucid	54.99	MicroATX Mini Tower	Black	\N	Tinted Tempered Glass	36.6	1
Vetroo AL900	84.99	ATX Mid Tower	Pink	\N	Tempered Glass	48.1	0
Deepcool MATREXX 30	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	29.6	3
Lian Li O11 Dynamic EVO	\N	ATX Mid Tower	White / Gray	\N	Tempered Glass	60.8	6
Aerocool P500C	\N	ATX Mid Tower	Black	\N	Mesh	54	2
Phanteks XT PRO ULTRA	81.98	ATX Mid Tower	White	\N	Tempered Glass	51.8	2
Deepcool CG530 4F	\N	ATX Mid Tower	White	\N	Tinted Acrylic	50	2
Phanteks Eclipse G400A	\N	ATX Mid Tower	Black	\N	Tempered Glass	59.4	2
Thermaltake View 380 ARGB	103.99	ATX Mid Tower	Black	\N	Tinted Tempered Glass	51.6	1
Fractal Design Pop XL Silent	109.99	ATX Full Tower	Black	\N	\N	62.4	3
HYTE Y70 Touch Infinite	419.99	ATX Mid Tower	Red / Black	\N	Tempered Glass	70.7	2
Corsair iCUE 7000X RGB	359.99	ATX Full Tower	Black	\N	Tempered Glass	81.8	6
SAMA SV01	79.99	ATX Mid Tower	White	\N	Tempered Glass	43.5	2
PC Cooler I100 PRO MESH	101.69	Mini ITX Desktop	Gray	\N	Mesh	7.5	1
Montech X3 Mesh	69.98	ATX Mid Tower	White	\N	Tempered Glass	\N	2
Cooler Master MasterBox NR200P V2	104.99	Mini ITX Desktop	White	\N	Mesh	20.1	1
Lian Li LANCOOL 217	124.99	ATX Mid Tower	White / Brown	\N	Tempered Glass	57.7	1
Antec C3 ARGB	97.19	ATX Mid Tower	Black	\N	Tempered Glass	47.9	1
Thermaltake Versa H16 ARGB	49.99	MicroATX Mini Tower	White	\N	Tempered Glass	33	2
Deepcool CC360 ARGB	\N	MicroATX Mini Tower	Black	\N	Tinted Tempered Glass	38.7	2
NZXT H5 Flow RGB (2023)	59.99	ATX Mid Tower	Black	\N	Tempered Glass	47	1
Lian Li O11 Air Mini	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.2	4
Fractal Design Focus 2	77.98	ATX Mid Tower	Black	\N	Tempered Glass	45.8	2
Asus A31	74.98	ATX Mid Tower	Black	\N	Tempered Glass	52.9	2
Corsair iCUE 5000D RGB AIRFLOW	204.99	ATX Mid Tower	Black	\N	Tempered Glass	66.2	2
Antec C8 Curve Wood	152.99	ATX Mid Tower	Black / Brown	\N	Tempered Glass	66.9	1
Jonsbo NV10	\N	Mini ITX Desktop	Black / Brown	\N	Mesh	4.5	0
Jonsbo C6 MAX	79.99	MicroATX Desktop	Black	\N	Tempered Glass	20.8	1
Zalman S3	49.99	ATX Mid Tower	Black	\N	Acrylic	38.4	2
Phanteks XT View	99.98	ATX Mid Tower	Black	\N	Tempered Glass	50.6	2
Cooler Master QUBE 500 Flatpack	79.98	ATX Mid Tower	Black	\N	Tempered Glass	38.9	4
Lian Li Vector V100	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.2	1
Thermaltake TR100	149.99	Mini ITX Desktop	Black	\N	Mesh	20.6	0
Montech SKY TWO	99.99	ATX Mid Tower	Black	\N	Tempered Glass	45.3	2
BitFenix Nova Mesh SE	69.9	ATX Mid Tower	Black	\N	Tempered Glass	36.1	2
Corsair iCUE LINK 3500X RGB	159.99	ATX Mid Tower	White	\N	Tempered Glass	55.9	2
MSI MPG GUNGNIR 110R	109.97	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
KOLINK Stronghold Prime	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.8	2
DIYPC DIY-CUBE01	58.98	MicroATX Mini Tower	White	\N	Tempered Glass	40	0
Phanteks Enthoo Pro Tempered Glass	143.98	ATX Full Tower	Black	\N	Tinted Tempered Glass	69.1	6
MSI MAG PANO M100R PZ	129.99	MicroATX Mid Tower	White	\N	Tempered Glass	41.9	1
Cooler Master MasterBox NR200P	\N	Mini ITX Desktop	Black	\N	Tempered Glass	20.3	2
Jonsbo D31 MESH	87.99	MicroATX Mini Tower	Black	\N	Tempered Glass	31.3	1
Montech XR Wood	67.9	ATX Mid Tower	White / Brown	\N	Tempered Glass	49.8	2
Asus ProArt PA602	275.99	ATX Mid Tower	Black	\N	Tempered Glass	81.4	4
GAMDIAS ATHENA M3	74.98	ATX Mid Tower	Black	\N	Tempered Glass	45.1	2
Corsair Obsidian Series 1000D	\N	ATX Full Tower	Black	\N	Tempered Glass	149.1	5
Asus A21	57.99	MicroATX Mini Tower	Black	\N	Tempered Glass	44	2
Fractal Design North XL	194.99	ATX Full Tower	White	\N	Mesh	61.4	2
Corsair 6500X	199.99	ATX Mid Tower	White	\N	Tempered Glass	78.3	2
Jonsbo N5	254.99	ATX Full Tower	Black / Brown	\N	Mesh	50.1	12
Phanteks EVOLV X2	219.98	ATX Mid Tower	White	\N	Tempered Glass	60.9	2
NZXT H5 Flow (2022)	\N	ATX Mid Tower	Black	\N	Tempered Glass	47	1
Corsair 2500X	144.38	MicroATX Mini Tower	White	\N	Tempered Glass	54.8	2
Aerocool Prism V2 RGB	59.99	ATX Mid Tower	Black	\N	Tempered Glass	41.7	2
SSUPD Meshroom D	99.99	Mini ITX Desktop	Black	\N	Mesh	15	3
Okinos Aqua 3	67.98	MicroATX Mini Tower	White	\N	Tempered Glass	28.8	2
SAMA ARGB-Q5	63.99	MicroATX Mini Tower	White	\N	Tempered Glass	31.5	2
Antec NX410	54.99	ATX Mid Tower	White	\N	Tempered Glass	39.7	2
Antec C8	119.99	ATX Full Tower	White / Silver	\N	Tempered Glass	66.9	2
Fractal Design Pop Mini Silent	84.99	MicroATX Mid Tower	Black	\N	\N	36.5	2
Lian Li Q58 (PCIe 4.0)	94.99	Mini ITX Desktop	White	\N	Tempered Glass	14.5	0
Thermaltake Core V21	\N	MicroATX Mini Tower	Black	\N	Acrylic	45.6	3
HYTE Y70	219.99	ATX Mid Tower	White / Black	\N	Tempered Glass	70.7	2
Corsair iCUE 4000D RGB AIRFLOW	89.99	ATX Mid Tower	White	\N	Tempered Glass	48.6	2
MSI MAG PANO M100R PZ	127.76	MicroATX Mid Tower	Black	\N	Tempered Glass	41.9	1
Fractal Design Era 2	212.98	Mini ITX Tower	Black / Brown	\N	Mesh	19	0
ZZEW A1 Plus	109.99	Mini ITX Tower	Silver	\N	Mesh	5.8	0
Fractal Design Meshify 3 Ambience Pro RGB	239.99	ATX Mid Tower	Black	\N	Tinted Tempered Glass	50.3	2
Jonsbo C6	60	MicroATX Mini Tower	Black	\N	Mesh	15.9	1
Deepcool MACUBE 110	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	38.8	2
Jonsbo N3	154.99	Mini ITX Desktop	Black	\N	\N	18.2	0
be quiet! Light Base 900 FX	249.9	ATX Full Tower	Black	\N	Tempered Glass	84.2	1
Thermaltake View 380 XL TG ARGB	99.99	ATX Mid Tower	Black	\N	Tempered Glass	63.6	1
Cooler Master HAF 700 EVO	449.99	ATX Full Tower	Gray / Black	\N	Tempered Glass	\N	12
darkFlash DB330M	59.49	MicroATX Mini Tower	Black	\N	Tempered Glass	29	1
Corsair 2000D AIRFLOW	139.99	Mini ITX Tower	Black	\N	Mesh	24.8	0
Corsair 2500D Airflow	101.93	MicroATX Mini Tower	Black	\N	Tempered Glass	54.8	2
Corsair 2000D AIRFLOW	119.99	Mini ITX Tower	White	\N	Mesh	24.8	0
be quiet! Silent Base 802	189.9	ATX Mid Tower	Black	\N	\N	83.8	3
Fractal Design Mood	162.97	Mini ITX Tower	Black	\N	Mesh	20.4	1
KOLINK Observatory MX Glass ARGB	\N	ATX Mid Tower	Black / White	\N	Tempered Glass	30.8	2
HYTE Y40	129.99	ATX Mid Tower	White	\N	Tempered Glass	49.7	1
Antec C8	199.8	ATX Full Tower	White	\N	Tempered Glass	66.9	2
Fractal Design Meshify 3	154.99	ATX Mid Tower	Black	\N	\N	50.3	2
DARKROCK Classico Storage Master	89.99	ATX Mid Tower	Black	\N	Mesh	\N	10
Corsair iCUE 220T RGB Airflow	84.98	ATX Mid Tower	Black	\N	Tempered Glass	37.3	2
HYTE Y40	129.99	ATX Mid Tower	White / Black	\N	Tempered Glass	49.7	1
Zalman P30	79.99	MicroATX Mini Tower	White	\N	Tempered Glass	45.7	2
Corsair 9000D RGB AIRFLOW	519.99	ATX Full Tower	White	\N	Tempered Glass	149.6	5
Jonsbo N10	61.99	Mini ITX Tower	Black	\N	Mesh	4.5	0
ENDORFY Ventum 200 Air	64	ATX Mid Tower	Black	\N	Tempered Glass	35.4	1
HAVN HS420 VGPU	299.99	ATX Mid Tower	White	\N	Tempered Glass	76.8	5
NZXT H5 Flow (2022)	\N	ATX Mid Tower	White	\N	Tempered Glass	47	1
Jonsbo N2	136.99	Mini ITX Desktop	Black	\N	\N	11.1	5
CyberPowerPC MASTERBOX NR640	\N	ATX Mid Tower	Black	\N	Tempered Glass	47.3	4
KOLINK KLA-003	\N	ATX Mid Tower	Black	\N	\N	26.2	0
Antec AX61 ELITE	79.03	ATX Mid Tower	Black	\N	Tempered Glass	36.4	2
Thermaltake TR100	149.99	Mini ITX Desktop	Green / Black	\N	Mesh	20.6	0
Fractal Design Core 1000 USB 3.0	49.99	MicroATX Mid Tower	Black	\N	\N	25.8	2
HYTE Y60	179.99	ATX Mid Tower	White / Black	\N	Tempered Glass	60	2
Phanteks XT M3	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	40	1
MSI MAG FORGE M100A	108.62	MicroATX Mid Tower	Black	\N	Tempered Glass	32.8	2
HYTE Y70	219.99	ATX Mid Tower	Purple	\N	Tempered Glass	70.7	2
DIYPC ARGB-N1	71.99	MicroATX Mid Tower	White	\N	Tempered Glass	44.7	2
Phanteks XT M3	67.98	MicroATX Mid Tower	White	\N	Tempered Glass	40	1
Fractal Design Focus 2 RGB	89.99	ATX Mid Tower	Black	\N	Tempered Glass	45.8	2
SAMA 3509	64.99	ATX Mid Tower	Black	\N	Tempered Glass	41.4	2
DIYPC DIY-CUBE01	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	40	0
Asus Prime AP201	84.99	MicroATX Mini Tower	White	\N	Tempered Glass	33	3
be quiet! Light Base 900 DX	204.9	ATX Full Tower	Black	\N	Tempered Glass	84.2	1
DIYPC ARGB Q10	72.99	ATX Mid Tower	Black	\N	Tempered Glass	50.4	1
Asus TUF Gaming GT501	164.99	ATX Mid Tower	Black / Gray	\N	Tempered Glass	75.5	4
Asus TUF Gaming GT302 ARGB	166.03	ATX Mid Tower	Black	\N	Tempered Glass	59.3	2
NZXT H5 Elite	195	ATX Mid Tower	Black	\N	Tempered Glass	47	1
Fractal Design Pop XL Air	119.99	ATX Full Tower	White	\N	Tempered Glass	62.4	3
Silverstone ALTA D1	838.88	ATX Full Tower	Black	\N	Mesh	78.8	4
Corsair 6500D Airflow	199.99	ATX Mid Tower	Black	\N	Tempered Glass	78.3	2
Fractal Design Meshify 3 XL Ambience Pro RGB	274.99	ATX Full Tower	Black	\N	Tinted Tempered Glass	72.6	2
Fractal Design Core 1100	49.99	MicroATX Mini Tower	Black	\N	\N	25.7	2
Fractal Design Pop Air	99.99	ATX Mid Tower	White	\N	Tempered Glass	46.2	2
Cooler Master Elite 301 Lite	55.99	MicroATX Mini Tower	White	\N	Tempered Glass	34.1	1
Corsair iCUE 4000D RGB AIRFLOW	149.99	ATX Mid Tower	Black	\N	Tempered Glass	48.6	2
KOLINK Observatory HF Mesh ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	35	4
NCASE M1	\N	Mini ITX Tower	Black	\N	\N	13.9	2
Deepcool CH260	\N	MicroATX Desktop	White	\N	Tempered Glass	30.8	1
NZXT H7 Flow RGB (2024)	149.99	ATX Mid Tower	White	\N	Tempered Glass	62.1	2
DIYPC ARGB-R1	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	0
Corsair iCUE LINK 6500X RGB	269.99	ATX Mid Tower	Black	\N	Tempered Glass	78.3	2
SAMA IM01	\N	MicroATX Mini Tower	Black	\N	\N	21.9	5
Fractal Design Torrent	204.99	ATX Mid Tower	Black	\N	\N	69.8	2
ADATA XPG VALOR MESH	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.8	2
MSI MPG GUNGNIR 300R AIRFLOW	129.99	ATX Mid Tower	Black	\N	Tempered Glass	60.5	2
Fractal Design Torrent RGB	236.99	ATX Mid Tower	Black	\N	Tinted Tempered Glass	69.8	2
Corsair iCUE 5000X RGB	204.99	ATX Mid Tower	Black	\N	Tempered Glass	66.2	2
Asus ProArt PA602 Wood Edition	279.99	ATX Mid Tower	Black / Brown	\N	Tempered Glass	81.4	4
Silverstone FLP01	\N	HTPC	White	\N	\N	27.1	1
Fractal Design Define 7 Compact	124.99	ATX Mid Tower	Black	\N	\N	42.5	2
Zalman S4	49.98	ATX Mid Tower	Black	\N	Tinted Acrylic	\N	2
Fractal Design Meshify 3 XL	184.99	ATX Full Tower	Black	\N	\N	72.6	2
Lian Li Lancool II Mesh	295	ATX Mid Tower	Black	\N	Tempered Glass	54.1	3
NZXT H510 Elite	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	41.3	2
Cooler Master NCORE 100 AIR	139.99	Mini ITX Tower	Black	\N	Mesh	16.4	0
Fractal Design Meshify 2 Compact TG Light Tint	147.98	ATX Mid Tower	Black	\N	Tempered Glass	42.3	2
Fractal Design Mood	164.99	Mini ITX Tower	Gray	\N	Mesh	20.4	1
Raidmax INFINITA i802 AIR	59.99	ATX Mid Tower	Black	\N	Tempered Glass	38	2
be quiet! Pure Base 600	99.9	ATX Mid Tower	Black	\N	\N	50.9	3
Deepcool CG580	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.5	2
GAMDIAS ATLAS M1	84.99	ATX Mid Tower	Black	\N	Tempered Glass	41	1
Lian Li O11D EVO RGB Automobili Lamborghini	299.99	ATX Mid Tower	Black / Gold	\N	Tempered Glass	65.3	4
ENDORFY Ventum 200 ARGB	72	ATX Mid Tower	Black	\N	Tempered Glass	35.4	1
Corsair 2500X Walnut	159.99	MicroATX Mini Tower	Black / Brown	\N	Tempered Glass	54.8	2
GameMax F46	66.99	ATX Mid Tower	Black	\N	Tempered Glass	40.6	2
MUSETEX NN8	79.98	ATX Mid Tower	Black	\N	Tempered Glass	39.5	2
be quiet! Dark Base Pro 901	\N	ATX Full Tower	Black	\N	Tempered Glass	94.5	2
Zalman CUBIX	37.99	MicroATX Mini Tower	White	\N	\N	\N	1
be quiet! Pure Base 500 FX	124.93	ATX Mid Tower	Black	\N	Tempered Glass	48.3	2
Corsair FRAME 4000D	104.99	ATX Mid Tower	White	\N	Tempered Glass	56.7	2
MSI MAG FORGE 100M	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.1	2
Jonsbo Jonsplus Z20	104.98	MicroATX Desktop	White	\N	Tempered Glass	25.3	1
Jonsbo Jonsplus Z20	104	MicroATX Desktop	Orange / Black	\N	Tempered Glass	25.3	1
Deepcool MATREXX 50 ADD-RGB 4F	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.5	2
Jonsbo D32 PRO	80.99	MicroATX Desktop	White	\N	Tempered Glass	25.7	2
Thermaltake AX700	399.99	ATX Full Tower	Black	\N	Mesh	141.4	18
Vetroo AL800	59.99	ATX Mid Tower	Pink	\N	Tempered Glass	46.4	2
Thermaltake View 380 ARGB	114.99	ATX Mid Tower	White	\N	Tinted Tempered Glass	51.6	1
Deepcool MATREXX 40	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	\N	2
iBuypower Trace 7 Mesh Pro ARGB	114.99	ATX Mid Tower	Black	\N	Tempered Glass	51.8	2
BitFenix TRITON	69.9	ATX Mid Tower	Black	\N	Tempered Glass	45.1	2
Fractal Design Pop Silent	84.99	ATX Mid Tower	Black	\N	\N	46.2	2
Antec CX200M RGB ELITE	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	28.8	2
Asus TUF Gaming GT301	92.99	ATX Mid Tower	Black	\N	Tempered Glass	43.9	2
HYTE REVOLT 3	129.99	Mini ITX Tower	Black	\N	Mesh	18.4	1
Cooler Master MasterBox TD500 Mesh V2	109.99	ATX Mid Tower	White	\N	Tempered Glass	52.4	2
Fractal Design Meshify C	99.99	ATX Mid Tower	Black	\N	\N	40.6	2
Zalman i4	59.99	ATX Mid Tower	Black	\N	Mesh	43.1	2
Jonsbo TK-0	\N	Mini ITX Desktop	White	\N	Tempered Glass	16.4	1
HAVN HS420	229.99	ATX Mid Tower	White	\N	Tempered Glass	76.8	5
Deepcool CG530	\N	ATX Mid Tower	Black	\N	Tinted Acrylic	50	2
Thermaltake The Tower 300	112.99	MicroATX Mini Tower	White	\N	Tempered Glass	53	3
Montech X5	75	ATX Mid Tower	White	\N	Tempered Glass	51.6	2
Jonsbo C6 Handle	64	MicroATX Mini Tower	Black	\N	Mesh	15.9	1
Montech Heritage PRO	109.9	MicroATX Mid Tower	Black	\N	Tempered Glass	41.5	1
Phanteks NV5 MKII	135.98	ATX Mid Tower	White	\N	Tempered Glass	60.2	3
Thermaltake View 270 Plus TG ARGB	86.99	ATX Mid Tower	Green	\N	Tempered Glass	47.6	2
Phanteks Eclipse P300A Mesh	\N	ATX Mid Tower	Black	\N	Tempered Glass	36.4	2
Montech SKY TWO GX	117.1	ATX Mid Tower	Black	\N	Tempered Glass	49.5	2
Thermaltake The Tower 250	149.95	Mini ITX Tower	Black	\N	Tempered Glass	42.7	1
SAMA ARGB-Q5	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	31.5	2
Zalman i3 NEO	\N	ATX Mid Tower	Black / Silver	\N	Tempered Glass	44.7	2
NZXT H9 Flow RGB (2025)	209.99	ATX Mid Tower	Black	\N	Tinted Tempered Glass	76.7	2
Corsair 5000D AIRFLOW	174.99	ATX Mid Tower	White / Gray	\N	Tempered Glass	66.2	2
Deepcool CH270 DIGITAL	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	32.4	1
Montech KING 65 PRO	\N	ATX Mid Tower	White	\N	Tempered Glass	63	2
Deepcool CH170 DIGITAL	\N	Mini ITX Tower	Black	\N	Mesh	19	1
Lian Li LANCOOL III	\N	ATX Mid Tower	Black	\N	Tempered Glass	65.5	4
Thermaltake The Tower 600	189.99	ATX Mid Tower	White	\N	Tempered Glass	66.2	1
NZXT H5 Elite	69.99	ATX Mid Tower	White	\N	Tempered Glass	47	1
be quiet! Light Base 600 DX	140.62	ATX Mid Tower	Black	\N	Tempered Glass	59.7	1
Jonsbo T6	\N	Mini ITX Tower	Black / Brown	\N	\N	13.7	0
KOLINK Unity Lateral Performance	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.4	2
Corsair 4000D Airflow	\N	ATX Mid Tower	Black	750	Tempered Glass	48.6	2
Corsair 3000D AIRFLOW	99.99	ATX Mid Tower	White	\N	Tempered Glass	49.5	2
Jonsbo Jonsplus Z20	104	MicroATX Desktop	Pink / White	\N	Tempered Glass	25.3	1
Cooler Master MasterBox 600	294.6	ATX Mid Tower	Black	\N	Tempered Glass	52.4	2
Phanteks XT View	98.99	ATX Mid Tower	White	\N	Tempered Glass	50.6	2
Fractal Design Meshify 2	159.99	ATX Mid Tower	Black	\N	Tinted Tempered Glass	61.7	6
Lian Li LANCOOL 205M MESH	89.99	MicroATX Mini Tower	White	\N	Tempered Glass	33.8	2
Antec Performance 1 FT	122.99	ATX Full Tower	Black	\N	Tempered Glass	62.7	2
darkFlash DB330M	69.98	MicroATX Mini Tower	White	\N	Tempered Glass	29	1
Rosewill Helium NAS	79.98	ATX Mid Tower	Black	\N	Mesh	\N	10
Asus ProArt PA401 Wood Edition	139.99	ATX Mid Tower	Black	\N	Tempered Glass	46.6	2
Zalman T6	52.08	ATX Mid Tower	Black	\N	\N	32.4	2
MSI MEG MAESTRO 700L PZ	409.99	ATX Mid Tower	Black	\N	Tempered Glass	66.8	0
Cougar MX330-X	55.99	ATX Mid Tower	Black	\N	\N	39.4	2
DIYPC ARGB-G5	56.9	ATX Mid Tower	White	\N	Tempered Glass	\N	1
Rosewill FBM-X3	89.99	MicroATX Mid Tower	Black	650	Tempered Glass	37	2
Cooler Master HAF 500	99.99	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
NZXT H510i	\N	ATX Mid Tower	White	\N	Tempered Glass	41.3	2
Corsair 2000D RGB AIRFLOW	199.99	Mini ITX Tower	Black	\N	Mesh	24.8	0
be quiet! Pure Base 500	79.9	ATX Mid Tower	Black	\N	\N	46	2
Corsair Carbide Series SPEC-DELTA RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.6	2
Thermaltake Versa J25 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Vetroo AL700	68.98	ATX Mid Tower	White	\N	Tempered Glass	48.1	1
Corsair 2500D Airflow	103.67	MicroATX Mini Tower	White	\N	Tempered Glass	54.8	2
Fractal Design Meshify 3 XL	184.99	ATX Full Tower	Black	\N	Tinted Tempered Glass	72.6	2
Phanteks NV5	\N	ATX Mid Tower	Black	\N	Tempered Glass	60.2	3
Antec CX600M ARGB	80.73	MicroATX Mini Tower	Black	\N	Tempered Glass	46.8	1
Asus TUF Gaming GT502 Horizon	194.99	ATX Mid Tower	Black	\N	Tempered Glass	57.2	4
DIYPC ARGB-G5	57.94	ATX Mid Tower	Black	\N	Tempered Glass	\N	1
NZXT H7 Flow (2022)	129.99	ATX Mid Tower	Black	\N	Tempered Glass	55.8	2
Lian Li PC-O11 Dynamic Razer	\N	ATX Full Tower	Black	\N	Tempered Glass	54	3
MSI MPG VELOX 100R	139.99	ATX Mid Tower	Black	\N	Tempered Glass	53.7	2
Thermaltake View 270 Plus TG ARGB	88.99	ATX Mid Tower	Blue	\N	Tempered Glass	47.6	2
Lian Li O11 Air Mini	209.95	ATX Mid Tower	White	\N	Tempered Glass	44.2	4
Aerocool CS-1103	\N	ATX Mid Tower	Black	\N	\N	29.9	2
be quiet! Silent Base 802	205.31	ATX Mid Tower	Black	\N	Tempered Glass	83.8	3
ENDORFY Arx 700 ARGB	124.5	ATX Mid Tower	Black	\N	Tempered Glass	54.2	1
Fractal Design Define 7 XL Dark	254.99	ATX Full Tower	Black	\N	Tinted Tempered Glass	82	6
NZXT H5 Flow RGB (2023)	119.99	ATX Mid Tower	White	\N	Tempered Glass	47	1
Corsair FRAME 4000D RS	94.99	ATX Mid Tower	White	\N	Tempered Glass	56.7	2
be quiet! Pure Base 501 Airflow	109.9	ATX Mid Tower	Black	\N	Tempered Glass	48.1	2
Phanteks Enthoo Pro Closed Panel	155.16	ATX Full Tower	Black	\N	\N	69.1	6
Aerocool Cylon	\N	ATX Mid Tower	Black	\N	Acrylic	37.5	2
Antec C8 ARGB	136.99	ATX Full Tower	Black	\N	Tempered Glass	66.9	2
Thermaltake Core V1	59.99	Mini ITX Desktop	White	\N	Acrylic	22.4	2
HYTE Y70	219.99	ATX Mid Tower	Black / Red	\N	Tempered Glass	70.7	2
BitFenix CETO300	79	ATX Mid Tower	Black	\N	Tempered Glass	47.9	1
Lian Li LANCOOL 205 Mesh C	117.99	ATX Mid Tower	Pink	\N	Tempered Glass	41.3	2
Antec NX410	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.7	2
Silverstone SG13	74.61	Mini ITX Tower	Black	\N	\N	11.5	1
NZXT H7 Flow (2022)	129.99	ATX Mid Tower	White / Black	\N	Tempered Glass	55.8	2
DARKROCK EC2	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.5	2
Antec CX500M RGB	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	40.8	2
Lian Li LANCOOL 205 Mesh C	119.99	ATX Mid Tower	Black	\N	Tempered Glass	41.3	2
Thermaltake TR100	137.99	Mini ITX Desktop	White	\N	Mesh	20.6	0
Phanteks Eclipse G360A	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.3	2
Xigmatek Master X	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Zalman S3	52.99	ATX Mid Tower	Black	\N	Tempered Glass	38.4	2
Corsair 6500X	\N	ATX Mid Tower	Black / Brown	\N	Tempered Glass	78.3	2
Fractal Design Meshify 2 Compact	\N	ATX Mid Tower	Black	\N	\N	42.3	2
SSUPD Meshroom S V2	\N	MicroATX Mini Tower	Black	\N	Mesh	14.9	2
NZXT H510 Flow	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.3	3
Fractal Design Focus G Mini	76.51	MicroATX Mini Tower	Black	\N	Acrylic	36.4	2
Okinos Cypress 3	64.98	MicroATX Mini Tower	Black	\N	Tempered Glass	\N	2
Corsair 3000D RGB AIRFLOW	129.99	ATX Mid Tower	White	\N	Tempered Glass	49.5	2
Deepcool CH560 DIGITAL	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.6	2
NZXT H9 Flow RGB (2025)	209.99	ATX Mid Tower	White	\N	Tempered Glass	76.7	2
be quiet! Shadow Base 800 FX	219.9	ATX Mid Tower	Black	\N	Tempered Glass	70.9	2
Phanteks NV7	215.98	ATX Full Tower	Black	\N	Tempered Glass	78.9	2
Lian Li LANCOOL 215	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Asus A31	74.98	ATX Mid Tower	White	\N	Tempered Glass	52.9	2
GAMDIAS AURA GC1 ELITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	34.7	2
Cooler Master QUBE 500 Flatpack	80.99	ATX Mid Tower	White	\N	Tempered Glass	38.9	4
Thermaltake S100	74.98	MicroATX Mini Tower	Black	\N	Tempered Glass	\N	2
Fractal Design Define 7 Mini	119.99	MicroATX Mini Tower	Black	\N	\N	33.2	2
Silverstone GD09 Type-C	119.46	HTPC	Black	\N	Mesh	26.5	2
be quiet! Light Base 600 LX	172.05	ATX Mid Tower	White	\N	Tempered Glass	59.7	1
Corsair iCUE LINK 6500X RGB	269.99	ATX Mid Tower	White	\N	Tempered Glass	78.3	2
Antec FLUX SE	104.99	ATX Mid Tower	Black / Brown	\N	Tempered Glass	58.1	2
DIYPC ARGB-R1	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	0
Phanteks NV9	\N	ATX Full Tower	Black	\N	Tempered Glass	99	3
GAMDIAS AURA GC2 ELITE	\N	ATX Mid Tower	White	\N	Tempered Glass	34.7	2
Silverstone FARA H1M	85.34	MicroATX Mini Tower	Black	\N	Tempered Glass	30.1	2
BitFenix CETO300	79	ATX Mid Tower	White	\N	Tempered Glass	47.9	1
GAMDIAS TALOS E3 MESH	59.99	ATX Mid Tower	White	\N	Tempered Glass	34.1	2
Fractal Design Focus 2 RGB	89.99	ATX Mid Tower	White / Black	\N	Tempered Glass	45.8	2
Jonsbo D32 PRO MESH	74.99	MicroATX Desktop	\N	\N	Mesh	25.7	2
Cooler Master MasterBox NR400 (w/ODD)	77.98	MicroATX Mid Tower	Black	\N	Tempered Glass	35.5	4
Deepcool MACUBE 110	\N	MicroATX Mini Tower	White	\N	Tempered Glass	38.8	2
Jonsbo TK-3	124.88	ATX Mid Tower	Black	\N	Tempered Glass	52.3	2
Asus TUF Gaming GT502	173.73	ATX Mid Tower	White	\N	Tempered Glass	57.2	4
Lian Li LANCOOL III RGB	300.47	ATX Mid Tower	White	\N	Tempered Glass	65.5	4
Fractal Design Meshify 2 Nano	\N	Mini ITX Tower	Black	\N	Tempered Glass	29.3	1
Corsair iCUE 7000X RGB	359.99	ATX Full Tower	White	\N	Tempered Glass	81.8	6
GameMax Defender MB	58.99	MicroATX Mini Tower	Black	\N	Tempered Glass	43.6	2
Asus GX601	239.99	ATX Full Tower	White / Black	\N	Tempered Glass	83.5	2
Phanteks Eclipse P400A	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.9	2
Cooler Master MasterBox MB520 ARGB	268.13	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Phanteks Enthoo Elite	\N	ATX Full Tower	Black	\N	Tinted Tempered Glass	124.5	6
Fractal Design Era 2	218.14	Mini ITX Tower	Blue / Brown	\N	Mesh	19	0
Lian Li SUP01	79.99	ATX Mid Tower	Black	\N	Tempered Glass	45.7	2
darkFlash DS900	\N	ATX Mid Tower	Black	\N	Tempered Glass	43	2
NZXT H7 Elite (2023)	109.99	ATX Mid Tower	White	\N	Tempered Glass	55.8	2
Fractal Design Epoch	109.99	ATX Mid Tower	Black	\N	\N	45.1	2
darkFlash DK352	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.1	2
Jonsbo N1	\N	Mini ITX Desktop	Silver	\N	\N	12.7	5
Corsair iCUE 5000D RGB AIRFLOW	219.99	ATX Mid Tower	White	\N	Tempered Glass	66.2	2
Antec FLUX PRO	173.99	ATX Full Tower	White / Brown	\N	Tempered Glass	70.8	4
SAMA NEVIEW 4503	114.99	ATX Mid Tower	Black	\N	Tempered Glass	54.7	0
Deepcool CC560 ARGB V2	\N	ATX Mid Tower	\N	\N	Tempered Glass	44.9	2
Jonsbo D41 Mesh Screen	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.4	2
HYTE Y70 Touch	\N	ATX Mid Tower	Black	\N	Tempered Glass	70.7	2
Fractal Design Meshify 2 Nano	\N	Mini ITX Tower	White	\N	Tempered Glass	29.3	1
Corsair iCUE 5000T LX RGB	344.99	ATX Mid Tower	Black	\N	Tempered Glass	74.5	2
Thermaltake Core W200	549.99	ATX Full Tower	Black	\N	Acrylic	\N	4
Fractal Design Era 2	219.99	Mini ITX Tower	Silver / Brown	\N	Mesh	19	0
NZXT H7 Flow (2022)	139.98	ATX Mid Tower	White	\N	Tempered Glass	55.8	2
Jonsbo D31 MESH Screen	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	31.3	1
Cooler Master MasterBox NR200P	\N	Mini ITX Desktop	White / Black	\N	Tempered Glass	20.3	2
Jonsbo C6-ITX	62	Mini ITX Desktop	White	\N	Mesh	15.9	1
Gigabyte C102 GLASS	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	42.5	2
Fractal Design Torrent Compact RGB	184.99	ATX Mid Tower	Black	\N	Tinted Tempered Glass	46.7	1
Deepcool CC360 ARGB	\N	MicroATX Mini Tower	White	\N	Tinted Tempered Glass	38.7	2
ENDORFY Arx 700 Air	114	ATX Mid Tower	Black	\N	Tempered Glass	54.2	1
Antec C3 ARGB	92.99	ATX Mid Tower	White	\N	Tempered Glass	47.9	1
HYTE Y70	219.99	ATX Mid Tower	Blue	\N	Tempered Glass	70.7	2
Fractal Design Meshify C	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	40.6	2
Fractal Design Meshify 2 Mini	289.73	MicroATX Mid Tower	Black	\N	Tinted Tempered Glass	33	2
APNX V1	149.99	ATX Mid Tower	Black / Brown	\N	Tempered Glass	70.4	2
Cooler Master TD300 Mesh	80.99	MicroATX Mini Tower	Black	\N	Tempered Glass	\N	2
Deepcool CG530	\N	ATX Mid Tower	White	\N	Tinted Acrylic	50	2
Cooler Master Elite 302	64.98	MicroATX Mini Tower	Black	\N	Tempered Glass	34.1	1
Antec FLUX	99.99	ATX Mid Tower	White / Brown	\N	Tempered Glass	58.1	2
Montech SKY TWO	109.31	ATX Mid Tower	White	\N	Tempered Glass	45.3	2
Corsair Carbide Series 200R	\N	ATX Mid Tower	Black	\N	\N	44.8	4
CiT Flash	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	2
Zalman P10	69.96	MicroATX Mini Tower	White	\N	Tempered Glass	\N	2
Aerocool Trinity Mini V2	89.66	MicroATX Mini Tower	Black	\N	Tempered Glass	28.1	2
Thermaltake S100 Snow Edition	74.98	MicroATX Mini Tower	White / Black	\N	Tempered Glass	\N	2
Silverstone FARA H1M PRO	89.99	MicroATX Mini Tower	Black	\N	Tempered Glass	30.1	2
Apevia PRISM	79.98	MicroATX Mid Tower	Black	\N	Tempered Glass	35.4	2
HP OMEN 45L	349.99	ATX Mid Tower	Black	\N	Tempered Glass	53.2	2
Corsair Obsidian Series 750D	\N	ATX Full Tower	Black	\N	Acrylic	71.3	6
Jonsbo NV10	85	Mini ITX Desktop	Silver / Brown	\N	Mesh	4.5	0
Phanteks NV9	272.99	ATX Full Tower	White	\N	Tempered Glass	99	3
Deepcool MATREXX 55 MESH ADD-RGB 4F	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.4	2
Jonsbo TK-3	131	ATX Mid Tower	White	\N	Tempered Glass	52.3	2
Thermaltake View 270 Plus TG ARGB	89.99	ATX Mid Tower	Pink / Blue	\N	Tempered Glass	47.6	2
Lian Li Lancool II Mesh C RGB	239.95	ATX Mid Tower	White	\N	Tempered Glass	54.1	3
Fractal Design Pop Air	99.99	ATX Mid Tower	Pink / Black	\N	Tempered Glass	46.2	2
Antec VSK4000E U3	98.69	ATX Mid Tower	Black	\N	\N	\N	5
KOLINK Observatory MX Glass ARGB	\N	ATX Mid Tower	White	\N	Tempered Glass	30.8	2
Jonsbo D31 MESH	87.99	MicroATX Mini Tower	White	\N	Tempered Glass	31.3	1
Lian Li Q58 (PCIe 4.0)	\N	Mini ITX Desktop	Black	\N	Tempered Glass	14.5	0
Montech HS02 Pro	119.9	ATX Mid Tower	Black	\N	Tempered Glass	55.3	2
SAMA V40	79.99	ATX Mid Tower	Black	\N	Tempered Glass	47.9	3
Mars Gaming MCV4	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.9	2
DIYPC ARGB-Q3 V2	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	38.6	2
Corsair Crystal 570X RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	57.5	2
Corsair 4000D Airflow	\N	ATX Mid Tower	White	850	Tempered Glass	48.6	2
Fractal Design Pop Air	99.99	ATX Mid Tower	Orange / Black	\N	Tempered Glass	46.2	2
Xigmatek Aquarius Plus	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.6	2
Thermaltake Core P7	\N	ATX Full Tower	Black	\N	Tempered Glass	281.9	3
NZXT S340	\N	ATX Mid Tower	Black	\N	Acrylic	38.4	3
Thermaltake Versa H15	\N	MicroATX Mid Tower	Black	\N	\N	\N	3
Jonsbo C6 MAX	88.9	MicroATX Desktop	White	\N	Tempered Glass	20.8	1
Corsair 275R Airflow	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Phanteks ECLIPSE G500A DRGB	141.99	ATX Mid Tower	White	\N	Tempered Glass	61.8	2
NZXT H510 Elite	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.3	2
Thermaltake View 380 XL TG ARGB	89.99	ATX Mid Tower	White	\N	Tempered Glass	63.6	1
Fractal Design North XL RC	179.99	ATX Full Tower	Black	\N	Tinted Tempered Glass	61.4	2
darkFlash DY470	87.51	ATX Mid Tower	White	\N	Tempered Glass	70.1	2
Thermaltake TR100	149.99	Mini ITX Desktop	Blue / White	\N	Mesh	20.6	0
darkFlash DY470	\N	ATX Mid Tower	Black	\N	Tempered Glass	70.1	2
Gigabyte C301 GLASS	99.99	ATX Mid Tower	Black	\N	Tempered Glass	50.6	2
Cooler Master Cosmos C700M	557.99	ATX Full Tower	Silver / Black	\N	Tempered Glass	\N	4
Thermaltake View 380 ARGB	99.99	ATX Mid Tower	Green	\N	Tinted Tempered Glass	51.6	1
Corsair 6500X	199.99	ATX Mid Tower	White / Brown	\N	Tempered Glass	78.3	2
Deepcool CH360 DIGITAL	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	39.7	2
In Win CE685.FH300TB3	115.4	MicroATX Slim	Black	300	\N	11.8	1
be quiet! Pure Base 500DX	181.99	ATX Mid Tower	White	\N	Tempered Glass	48.3	2
Montech Heritage	89.9	MicroATX Mid Tower	Black	\N	Tempered Glass	41.5	1
Fractal Design Pop Air	99.99	ATX Mid Tower	Cyan / Black	\N	Tempered Glass	46.2	2
Fractal Design Torrent Nano RGB	155.22	Mini ITX Tower	White	\N	Tempered Glass	34.6	1
Cooler Master MasterCase H500	246.75	ATX Mid Tower	Black	\N	Tinted Tempered Glass	\N	2
be quiet! Dark Base 701	229.9	ATX Mid Tower	Black	\N	Tempered Glass	73.6	2
ADATA XPG VALOR AIR	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.8	3
Phanteks Enthoo Pro 2 Server Edition	221.98	ATX Full Tower	Black	\N	\N	78	4
Corsair 7000D AIRFLOW	289.99	ATX Full Tower	White / Black	\N	Tempered Glass	81.8	6
Lian Li Vector V100	\N	ATX Mid Tower	White	\N	Tempered Glass	53.2	1
DIYPC ARGB-Q3 V2	\N	MicroATX Mini Tower	White	\N	Tempered Glass	38.6	2
HYTE Y40	129.99	ATX Mid Tower	Red / Black	\N	Tempered Glass	49.7	1
MSI MEG PROSPECT 700R	379.99	ATX Mid Tower	Black	\N	Tempered Glass	80.7	2
Thermaltake The Tower 300 Matcha	105.99	MicroATX Mini Tower	Green	\N	Tempered Glass	53	3
DIYPC Rainbow-Flash-F4	\N	ATX Mid Tower	Black	\N	Tempered Glass	33.2	2
teenage engineering Computer-1	\N	Mini ITX Desktop	Orange / Silver	\N	\N	10.4	0
MUSETEX G07-S6	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.9	1
NZXT H500	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.3	3
Zalman S2	58.98	ATX Mid Tower	Black	\N	Tempered Glass	38.4	2
Fractal Design Torrent	204.99	ATX Mid Tower	White	\N	Tempered Glass	69.8	2
Antec CX500M RGB	\N	MicroATX Mini Tower	White	\N	Tempered Glass	40.8	2
Phanteks NV7	201.38	ATX Full Tower	White	\N	Tempered Glass	78.9	2
KOLINK Citadel Mesh	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	34.5	2
SSUPD Meshlicious (PCIe 4.0)	\N	Mini ITX Tower	Black	\N	Mesh	14.7	0
GameMax M60	50.98	MicroATX Mid Tower	Black	\N	Mesh	29.4	2
Apevia Matrix	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.8	3
Cooler Master MasterBox MB311L ARGB	140.38	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	2
Fractal Design Epoch	109.99	ATX Mid Tower	Black	\N	Tinted Tempered Glass	45.1	2
MSI MAG PANO 100L PZ	116.99	ATX Mid Tower	Black	\N	Tempered Glass	72.5	2
MSI MAG FORGE 320R AIRFLOW	\N	ATX Mid Tower	White	\N	Tempered Glass	49.4	2
Montech KING 95	183.73	ATX Mid Tower	Black	\N	Tempered Glass	63	5
Zalman P30	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	45.7	2
Cougar MX330	59.99	ATX Mid Tower	Black	\N	Acrylic	39.4	2
Phanteks NV5	\N	ATX Mid Tower	White	\N	Tempered Glass	60.2	3
Cooler Master NCORE 100 AIR	139.99	Mini ITX Tower	Silver / White	\N	Mesh	16.4	0
Mars Gaming MC-S2	64.02	ATX Mid Tower	Black	\N	Acrylic	19.5	1
Montech AIR 1000 PREMIUM	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.3	2
Antec P101 Silent	\N	ATX Mid Tower	Black	\N	\N	\N	8
Cooler Master Cosmos Infinity 30th Anniversary	\N	ATX Full Tower	Black / Silver	\N	Tempered Glass	129.5	2
Fractal Design Node 202	\N	HTPC	Black	\N	\N	11	0
Cooler Master QUBE 500 Flatpack Macaron Edition	99.99	ATX Mid Tower	Multicolor	\N	Tempered Glass	38.9	4
Geometric Future Model 5	134.9	ATX Mid Tower	Black / Gray	\N	Tempered Glass	51.1	2
KOLINK Observatory Duo ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	38.9	2
Thermaltake The Tower 600	189.99	ATX Mid Tower	Green	\N	Tempered Glass	66.2	1
RAIJINTEK Enyo	\N	ATX Full Tower	Black	\N	Tempered Glass	185.4	4
APNX Creator C1	99.99	ATX Mid Tower	Black	\N	Tempered Glass	53.6	3
Asus A21 PLUS	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	44	2
Corsair 2500X Bamboo	159.99	MicroATX Mini Tower	White / Brown	\N	Tempered Glass	54.8	2
Fractal Design Torrent Compact	\N	ATX Mid Tower	Black	\N	\N	46.7	1
Cougar MX330-G	59.99	ATX Mid Tower	Black	\N	Tempered Glass	39.4	2
Lian Li SUP01	78.73	ATX Mid Tower	White	\N	Tempered Glass	45.7	2
Montech AIR 100 LITE	\N	MicroATX Mid Tower	White	\N	Tempered Glass	36.1	2
Corsair iCUE 220T RGB Airflow	\N	ATX Mid Tower	White	\N	Tempered Glass	37.3	2
Deepcool MATREXX 55 MESH	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.4	2
Mars Gaming MC-VIEW	\N	MicroATX Mid Tower	White	\N	Tempered Glass	32.1	1
DAN Cases A4-SFXv4.1	\N	Mini ITX Desktop	Black	\N	\N	7.5	0
Montech X1	\N	ATX Mid Tower	Black	\N	Tempered Glass	32.3	1
Jonsbo C6	60	MicroATX Mini Tower	White	\N	Mesh	15.9	1
SAMA 3509	64.99	ATX Mid Tower	White	\N	Tempered Glass	41.4	2
SSUPD Xhuttle	120	ATX Mid Tower	Black	\N	Tempered Glass	50.2	2
Fractal Design Meshify C	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.6	2
Fractal Design Torrent Nano	\N	Mini ITX Tower	Black	\N	Tinted Tempered Glass	34.6	1
MUSETEX K2	\N	ATX Mid Tower	Black	1000	Tempered Glass	44.4	2
be quiet! Light Base 900 FX	259.89	ATX Full Tower	White	\N	Tempered Glass	84.2	1
Fractal Design Meshify 3	154.99	ATX Mid Tower	White	\N	Tempered Glass	50.3	2
Phanteks Enthoo Pro 2	\N	ATX Full Tower	Black	\N	Tempered Glass	\N	12
SHARKOON Rebel C20 ITX	\N	Mini ITX Desktop	Black	\N	Mesh	29.5	1
HYTE REVOLT 3	129.99	Mini ITX Tower	White	\N	Mesh	18.4	1
Thermaltake View 200 TG ARGB	79.98	ATX Mid Tower	Black	\N	Tempered Glass	38.2	2
KOLINK KLM-003	\N	MicroATX Mini Tower	Black	\N	\N	23.2	0
Phanteks Eclipse P360A	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.3	2
Antec C8 ARGB	149.99	ATX Full Tower	White	\N	Tempered Glass	66.9	2
HYTE Y60	179.99	ATX Mid Tower	Red / Black	\N	Tempered Glass	60	2
iBuypower Slate 8 Mesh Pro ARGB	134.99	ATX Mid Tower	Black	\N	Tempered Glass	54.2	1
Thermaltake AX700	404.98	ATX Full Tower	Black	\N	Tempered Glass	141.4	18
NZXT H7 Elite (2023)	199	ATX Mid Tower	Black	\N	Tempered Glass	55.8	2
Jonsbo N4	119.99	MicroATX Desktop	White / Brown	\N	Mesh	19.6	6
Rosewill FBM-X3	89.99	MicroATX Mid Tower	Black	650	Mesh	37	2
Thermaltake S200 TG ARGB	123.73	ATX Mid Tower	Black	\N	Tempered Glass	38.2	2
Antec CX500M ARGB	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	40.8	2
Corsair Crystal Series 680X RGB	269.49	ATX Mid Tower	Black	\N	Tempered Glass	73.5	3
Thermaltake The Tower 300	89.99	MicroATX Mini Tower	Gray	\N	Tempered Glass	53	3
Jonsbo D41 Mesh	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.4	2
Corsair FRAME 5000D RS	\N	ATX Mid Tower	Black	\N	Tempered Glass	75.3	2
Cooler Master MasterBox K501L	161.36	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Thermaltake View 270	69.87	ATX Mid Tower	White	\N	Tempered Glass	47.6	2
BitFenix Apollo	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.2	2
Apevia PRISM	79.98	MicroATX Mid Tower	Pink	\N	Tempered Glass	35.4	2
Cooler Master MasterBox NR600 (w/o ODD)	\N	ATX Mid Tower	Black	\N	Tempered Glass	47.3	4
Thermaltake Level 20	1004.98	ATX Full Tower	Black / Silver	\N	Tempered Glass	141	8
NZXT H510 Flow	\N	ATX Mid Tower	White	\N	Tempered Glass	41.3	3
GAMDIAS NESO P1	124.99	ATX Full Tower	Black / Red	\N	Tempered Glass	75.2	5
Fractal Design Define Nano S	\N	Mini ITX Desktop	Black	\N	Acrylic	28.8	2
Tecware Forge M2	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	27.3	2
Gigabyte C500 PANORAMIC STEALTH	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.6	2
Fractal Design Define 7 Dark	204.99	ATX Mid Tower	Black	\N	Tinted Tempered Glass	62.4	6
Montech AIR 1000 LITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.3	2
Thermaltake The Tower 600	189.99	ATX Mid Tower	Purple	\N	Tempered Glass	66.2	1
Thermaltake The Tower 300 Bubble Pink	169.99	MicroATX Mini Tower	Pink / White	\N	Tempered Glass	53	3
Aerocool P500C	\N	ATX Mid Tower	White	\N	Mesh	54	2
In Win CJ712	98	MicroATX Desktop	Black	265	\N	8	1
Cooler Master MasterBox Q500L	\N	ATX Mid Tower	Black	\N	Acrylic	33.8	1
Lian Li O11 Dynamic EVO	\N	ATX Mid Tower	Gray / Black	\N	Tinted Tempered Glass	60.8	6
Silverstone GD09B	\N	HTPC	Black	\N	\N	26.5	2
be quiet! Pure Base 501	109.9	ATX Mid Tower	Black	\N	\N	48.1	2
Deepcool CH560	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.6	2
NZXT H500	\N	ATX Mid Tower	White	\N	Tempered Glass	41.3	3
Thermaltake The Tower 250	149.95	Mini ITX Tower	White	\N	Tempered Glass	42.7	1
Fractal Design Define R4	\N	ATX Mid Tower	Black	\N	Acrylic	56	8
Corsair Carbide Series 275R	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.2	2
Corsair Carbide Series Air 540	\N	ATX Mid Tower	Black	\N	Acrylic	62.6	2
Montech SKY TWO GX	79	ATX Mid Tower	White	\N	Tempered Glass	49.5	2
Phanteks Enthoo Pro 2 Server Edition	233.98	ATX Full Tower	Black	\N	Tempered Glass	78	4
Vetroo AL900	79.98	ATX Mid Tower	Black	\N	Tempered Glass	48.1	0
BitFenix Nova Mesh SE	69.9	ATX Mid Tower	White	\N	Tempered Glass	36.1	2
Antec CX200M RGB ELITE	\N	MicroATX Mini Tower	White	\N	Tempered Glass	28.8	2
Asus TUF Gaming GT302 ARGB	312.7	ATX Mid Tower	White	\N	Tempered Glass	59.3	2
iBuypower Scale Mesh ARGB	119.99	ATX Mid Tower	Black	\N	Tempered Glass	50.9	1
HYTE Y70 Touch	\N	ATX Mid Tower	White	\N	Tempered Glass	70.7	2
Silverstone GD11	198.43	HTPC	Black	\N	\N	30.9	3
Corsair 6500D Airflow	150.1	ATX Mid Tower	White	\N	Tempered Glass	78.3	2
be quiet! Pure Base 501 LX	149.9	ATX Mid Tower	Black	\N	Tempered Glass	48.1	2
Gigabyte C200 Glass	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.8	2
Montech HS02 Pro	139.9	ATX Mid Tower	White	\N	Tempered Glass	55.3	2
Gigabyte C500 PANORAMIC STEALTH	259.57	ATX Mid Tower	White	\N	Tempered Glass	50.6	2
SHARKOON AK6 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	47.5	2
Cooler Master NR200P V3	139.99	Mini ITX Desktop	Black	\N	Acrylic	20.4	1
Thermaltake The Tower 600	184.99	ATX Mid Tower	Green / Black	\N	Tempered Glass	66.2	1
Lian Li LANCOOL 216 RGB w/Controller	132.99	ATX Mid Tower	Black	\N	Tinted Tempered Glass	55.6	2
Azza Sanctum	349.99	ATX Desktop	Silver / Black	\N	Tempered Glass	76.9	2
Thermaltake View 91	\N	ATX Full Tower	Black	\N	Tempered Glass	153.3	12
Segotep T3 Aeolus	71.48	ATX Mid Tower	White	\N	Tempered Glass	54.4	3
GAMDIAS TALOS E3 WH	59.99	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
Rosewill FBM-X2-400-HELIX	59.99	MicroATX Mini Tower	Black	400	\N	25.3	1
Deepcool CH690 DIGITAL	\N	ATX Mid Tower	Black	\N	Tempered Glass	107.9	1
MSI MAG PANO 100L PZ	129.99	ATX Mid Tower	White	\N	Tempered Glass	72.5	2
Jonsbo D300	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	45.8	2
be quiet! Light Base 600 DX	152.85	ATX Mid Tower	White	\N	Tempered Glass	59.7	1
MSI MAG VAMPIRIC 100R	86.2	ATX Mid Tower	Black	\N	Tempered Glass	36.5	2
Razer Tomahawk Mini-ITX	179.99	Mini ITX Tower	Black / Green	\N	Tinted Tempered Glass	\N	0
Razer Tomahawk ATX	219.98	ATX Mid Tower	Black	\N	Tinted Tempered Glass	\N	3
NZXT S340	\N	ATX Mid Tower	White	\N	Acrylic	38.4	3
BitFenix FLOW	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.3	2
Silverstone SG05-LITE	75.05	Mini ITX Desktop	Black	\N	\N	10.7	1
Gigabyte AORUS C500 GLASS	\N	ATX Mid Tower	Black	\N	Tempered Glass	116.6	2
Asus TUF Gaming GT502 Plus	\N	ATX Mid Tower	Black	\N	Tempered Glass	57.2	4
Lian Li O11D XL-W	\N	ATX Full Tower	White / Black	\N	Tempered Glass	68.9	4
Rosewill Helium Flow	79.98	ATX Mid Tower	Black	\N	\N	50.5	3
Silverstone SETA D1	169.7	ATX Mid Tower	Black	\N	\N	56.5	8
Fractal Design North XL RC	194.99	ATX Full Tower	White	\N	Tempered Glass	61.4	2
Thermaltake Core P3 TG Pro	140.71	ATX Mid Tower	\N	\N	Tempered Glass	71.7	4
Silverstone SUGO 15	181.04	Mini ITX Desktop	Black	\N	\N	19.1	0
In Win Chopin MAX	\N	Mini ITX Desktop	Gray	200	Mesh	4.4	0
Apevia PRISM	79.98	MicroATX Mid Tower	White	\N	Tempered Glass	35.4	2
NZXT H710i	\N	ATX Mid Tower	White	\N	Tempered Glass	58.6	4
Cooler Master Elite 500 ODD	134.13	ATX Mid Tower	Black	\N	\N	43.1	2
Thermaltake View 380 ARGB	114.99	ATX Mid Tower	Blue	\N	Tinted Tempered Glass	51.6	1
SAMA V40	79.99	ATX Mid Tower	White	\N	Tempered Glass	47.9	3
CiT F3 ARGB	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	25.5	2
MSI MPG GUNGNIR 300R AIRFLOW	155.99	ATX Mid Tower	White	\N	Tempered Glass	60.5	2
Fractal Design Meshify C Mini	\N	MicroATX Mini Tower	Black	\N	Tinted Tempered Glass	36.6	2
GAMDIAS TALOS E3	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Deepcool CG580	\N	ATX Mid Tower	White	\N	Tempered Glass	51.5	2
DIYPC ARGB-Q3	\N	MicroATX Mini Tower	Pink	\N	Tempered Glass	38.6	2
Cooler Master Elite 301	78.59	MicroATX Mid Tower	White	\N	Tempered Glass	34.1	1
Cooler Master MasterBox 600	100.99	ATX Mid Tower	White	\N	Tempered Glass	52.4	2
Deepcool CH270 DIGITAL	\N	MicroATX Mini Tower	White	\N	Tempered Glass	32.4	1
Thermaltake The Tower 200	\N	Mini ITX Tower	Black	\N	Tempered Glass	45.1	2
KOLINK Unity Meshbay Performance	\N	ATX Mid Tower	Black	\N	\N	41	2
Fractal Design Meshify 2 Mini	204	MicroATX Mid Tower	White / Black	\N	Tempered Glass	33	2
Fractal Design Meshify 3 Ambience Pro RGB	239.99	ATX Mid Tower	White	\N	Tempered Glass	50.3	2
Antec VSK3000E U3	\N	MicroATX Mini Tower	Black	\N	\N	24.8	2
GameMax F45	60.99	ATX Mid Tower	Black / Brown	\N	Tempered Glass	40.6	2
NZXT H510	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	41.3	2
Antec Performance 1 M	194.99	Mini ITX Desktop	Black	\N	Mesh	19.3	0
Lian Li LANCOOL 215	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
GameMax Infinity	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.7	1
Corsair Carbide Series 175R RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Corsair iCUE 5000X RGB	214.99	ATX Mid Tower	White / Gray	\N	Tempered Glass	66.2	2
Phanteks Eclipse P400A Digital	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.9	2
Cougar MX360 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	36.5	2
Tecware Forge M	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	34.4	1
Mars Gaming MCV4	\N	ATX Mid Tower	White	\N	Tempered Glass	50.9	2
MSI MPG Sekira 500G	1050	ATX Mid Tower	Black	\N	Tempered Glass	67.1	6
Corsair 275R Airflow	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
Chieftec APEX AIR	\N	ATX Mid Tower	Black	\N	Tempered Glass	52.9	2
HYTE Persona 3 Reload Y70	259.99	ATX Mid Tower	Black / Multicolor	\N	Tempered Glass	70.7	2
Fractal Design Meshify 3	159.99	ATX Mid Tower	Black	\N	Tinted Tempered Glass	50.3	2
SSUPD Xhuttle	120	ATX Mid Tower	White	\N	Tempered Glass	50.2	2
be quiet! Dark Base Pro 901	299.89	ATX Full Tower	White	\N	Tempered Glass	94.5	2
DIYPC ARGB-N1	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	44.7	2
Antec CX700 RGB ELITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.5	2
Thermaltake Ceres 330 ARGB	68.99	ATX Mid Tower	Black	\N	Tempered Glass	53.9	1
Lian Li LANCOOL 205 Mesh C	117.99	ATX Mid Tower	White	\N	Tempered Glass	41.3	2
GAMDIAS TALOS E2 ELITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
NZXT H710	\N	ATX Mid Tower	White	\N	Tempered Glass	58.6	4
be quiet! Pure Base 600	119.9	ATX Mid Tower	Black	\N	Tempered Glass	50.9	3
Montech KING 95 PRO	169	ATX Mid Tower	Blue / Black	\N	Tempered Glass	63	5
Cooler Master HAF 700	299.99	ATX Full Tower	Black	\N	Tempered Glass	83.6	9
MSI MPG VELOX 100P AIRFLOW	292.33	ATX Mid Tower	Black	\N	Tempered Glass	53.7	2
Lian Li Lancool II Mesh	\N	ATX Mid Tower	Black	\N	Tempered Glass	54.1	3
Thermaltake The Tower 600	189.99	ATX Mid Tower	Yellow	\N	Tempered Glass	66.2	1
Asus TUF Gaming GT501	169.99	ATX Mid Tower	White / Black	\N	Tempered Glass	75.5	4
Phanteks Eclipse P500A D-RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cooler Master HAF 500	98.08	ATX Mid Tower	White	\N	Tempered Glass	\N	2
KOLINK Satellite	\N	MicroATX Desktop	Black	\N	Mesh	13.8	3
be quiet! Light Base 900 DX	214.9	ATX Full Tower	White	\N	Tempered Glass	84.2	1
Azza Spectra	59.99	ATX Mid Tower	Black	\N	Tempered Glass	33.4	2
FSP Group S380	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	48.2	2
Vetroo AL900	79.98	ATX Mid Tower	White	\N	Tempered Glass	48.1	0
Phanteks Eclipse P300	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	36	2
Silverstone FARA 515XR	79.59	ATX Mid Tower	White	\N	Tempered Glass	39.9	2
RAIJINTEK OPHION EVO	69.9	Mini ITX Desktop	Black	\N	Acrylic	\N	1
KOLINK Observatory MX Mesh ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	30.8	2
KOLINK Rocket Complex	\N	Mini ITX Tower	Black	\N	Mesh	20.4	0
Corsair iCUE 5000T RGB	239.99	ATX Mid Tower	Black	\N	Tempered Glass	74.5	2
Thermaltake The Tower 300	134.99	MicroATX Mini Tower	Green / Black	\N	Tempered Glass	53	3
Aerocool Bolt	82.79	ATX Mid Tower	Black	\N	Acrylic	35.3	2
Jonsbo TK-2 2.0	162	ATX Mid Tower	Black	\N	Tempered Glass	53.2	1
Antec CX300 RGB ELITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.9	2
GameMax Vista A	\N	ATX Mid Tower	White	\N	Tempered Glass	44.1	2
KOLINK Stronghold Barricade	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.6	2
Jonsbo D31 STD	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	31.3	1
Fractal Design Torrent Nano RGB	\N	Mini ITX Tower	Black	\N	Tinted Tempered Glass	34.6	1
Thermaltake View 380 XL TG ARGB	79	ATX Mid Tower	Yellow / Black	\N	Tempered Glass	63.6	1
APNX Creator C1	99.99	ATX Mid Tower	White	\N	Tempered Glass	53.6	3
Thermaltake The Tower 600	169.99	ATX Mid Tower	Blue	\N	Tempered Glass	66.2	1
Cooler Master MasterBox MB320L ARGB	84.99	MicroATX Mini Tower	Black	\N	Tempered Glass	38.8	2
Antec DF600 FLUX	104.99	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Thermaltake The Tower 300 Hydrangea	153.99	MicroATX Mini Tower	Blue	\N	Tempered Glass	53	3
GAMDIAS ATLAS M1	84.99	ATX Mid Tower	White	\N	Tempered Glass	41	1
Silverstone PS16B	75.15	MicroATX Mini Tower	Black	\N	\N	\N	3
Cooler Master TD300 Mesh	84.99	MicroATX Mini Tower	White / Black	\N	Tempered Glass	\N	2
Cooler Master MasterCase H500M	462.49	ATX Mid Tower	Black	\N	Tempered Glass	73.7	2
Antec DF700 FLUX	148.98	ATX Mid Tower	Black	\N	Tempered Glass	49.9	3
Deepcool CG580 4F	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.5	2
Corsair iCUE 465X RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Corsair Vengeance C70	\N	ATX Mid Tower	Green	\N	Acrylic	61.4	6
Antec C7 ARGB	173.49	ATX Mid Tower	Black	\N	Tempered Glass	58.9	2
Montech Heritage PRO	109.9	MicroATX Mid Tower	White	\N	Tempered Glass	41.5	1
Corsair 2500X Obsidian	159.99	MicroATX Mini Tower	Black	\N	Tempered Glass	54.8	2
Cooler Master HAF XB EVO	\N	ATX Desktop	Black	\N	Mesh	61.7	2
Cougar MX330-G Pro	68.09	ATX Mid Tower	Black	\N	Tempered Glass	49.1	2
Apevia Destiny Flow	75.98	ATX Mid Tower	Pink	\N	Tempered Glass	\N	2
Asus ProArt PA602 Wood Edition	500.94	ATX Mid Tower	Black / Brown	\N	\N	81.4	4
MSI MPG VELOX 100R	139.99	ATX Mid Tower	White	\N	Tempered Glass	53.7	2
Corsair 6500X	\N	ATX Mid Tower	Black / Gray	\N	Tempered Glass	78.3	2
Montech HS01 PRO	114.9	ATX Mid Tower	Black	\N	Tempered Glass	55.3	2
Cooler Master Force 500	\N	ATX Mid Tower	Black	\N	\N	39.8	7
be quiet! Shadow Base 800 DX	\N	ATX Mid Tower	Black	\N	Tempered Glass	70.9	2
Lian Li O11D XL-X	\N	ATX Full Tower	Black	\N	Tempered Glass	68.9	4
PC Cooler I100 PRO MESH	101.69	Mini ITX Desktop	White	\N	Mesh	7.5	1
Silverstone MILO 11	92.77	MicroATX Desktop	Black / Silver	\N	\N	10.3	1
BitFenix Nova Mesh SE	\N	ATX Mid Tower	Black	\N	\N	36.1	2
Silverstone SG13 V2	74.13	Mini ITX Tower	Black	\N	\N	11.5	1
Zalman Z7 NEO	69.98	ATX Mid Tower	Black	\N	Tempered Glass	41.2	2
NZXT H210	\N	Mini ITX Tower	Black	\N	Tempered Glass	27.3	1
HYTE Hoshimachi Suisei Y70	\N	ATX Mid Tower	Blue / Black	\N	Tempered Glass	70.7	2
Antec CX800 Wood ARGB	\N	ATX Mid Tower	Black / Brown	\N	Tempered Glass	51.2	2
iBuypower Slate 9 Mesh	124.99	ATX Mid Tower	Black	\N	Tempered Glass	53.4	1
Phanteks ECLIPSE G500A DRGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	61.8	2
KRUX Leda	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.5	2
ENDORFY Ventum 200	93.74	ATX Mid Tower	Black	\N	\N	34.6	1
Phanteks XT PRO	119.98	ATX Mid Tower	\N	\N	\N	51.8	2
Silverstone RM52	533.01	ATX Full Tower	Black	\N	\N	58.6	2
be quiet! Dark Base 700	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	7
be quiet! Pure Base 500	92.9	ATX Mid Tower	White	\N	Tempered Glass	46	2
Deepcool CH360	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	39.7	2
GAMDIAS ATHENA M3	82.43	ATX Mid Tower	White	\N	Tempered Glass	45.1	2
Aerocool CS-1102	\N	ATX Mid Tower	Black	\N	\N	33.8	3
Phanteks Eclipse G400A	\N	ATX Mid Tower	White	\N	Tempered Glass	59.4	2
Deepcool CH510	\N	ATX Mid Tower	Black	\N	Tempered Glass	47.1	2
Deepcool CC560	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.7	2
NZXT H210i	\N	Mini ITX Tower	White	\N	Tempered Glass	27.3	1
NCASE M1	\N	Mini ITX Tower	Silver / Black	\N	\N	13.9	2
Cooler Master MasterBox Lite 5	\N	ATX Mid Tower	Black	\N	Acrylic	42.7	2
Fractal Design Torrent RGB	229.99	ATX Mid Tower	White	\N	Tempered Glass	69.8	2
Jonsbo D41 Mesh	\N	ATX Mid Tower	White	\N	Tempered Glass	35.4	2
Thermaltake View 170 ARGB	84.98	MicroATX Mini Tower	Pink / Blue	\N	Tempered Glass	35	1
Thermaltake The Tower 100	\N	Mini ITX Tower	Black	\N	Tempered Glass	32.7	2
Vetroo AL800	59.99	ATX Mid Tower	Green	\N	Tempered Glass	46.4	2
Corsair Obsidian 500D RGB SE	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	59.4	2
NZXT S340 Elite	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.6	2
Antec VSK3000B U3	\N	MicroATX Mini Tower	Black	\N	\N	\N	2
Mars Gaming MC-3TCORE	\N	ATX Mid Tower	White	\N	Tempered Glass	50.5	1
Anidees AI Crystal XL AR 3	\N	ATX Full Tower	Black	\N	Tempered Glass	86.7	15
FormD T1 V2.1 Aluminum Coated	\N	Mini ITX Desktop	Black	\N	Mesh	\N	0
Corsair 3500X CALL OF DUTY BLACK OPS 6 EDITION	99.99	ATX Mid Tower	Black / Orange	\N	Tempered Glass	55.9	2
Fractal Design Meshify 3 XL RGB	189.99	ATX Full Tower	Black	\N	Tinted Tempered Glass	72.6	2
Phanteks Eclipse G300A (3 Fan)	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.2	1
Apevia Prism Elite	109.99	ATX Mid Tower	Pink	\N	Tempered Glass	47.9	2
Deepcool CH170 DIGITAL	\N	Mini ITX Tower	White	\N	Mesh	19	1
be quiet! Pure Base 501 DX	129.9	ATX Mid Tower	Black	\N	Tempered Glass	48.1	2
Cougar Duoface Pro RGB	125.91	ATX Mid Tower	Black	\N	Tempered Glass	55.4	2
darkFlash DLM 21	\N	MicroATX Mid Tower	White	\N	Tempered Glass	\N	2
Silverstone FARA 515XR	69.98	ATX Mid Tower	Black	\N	Tempered Glass	39.9	2
Silverstone Sugo 16	95.5	Mini ITX Tower	Black	\N	\N	13	1
Montech KING 95 PRO	169	ATX Mid Tower	Red / Black	\N	Tempered Glass	63	5
Thermaltake View 71 TG RGB	219.99	ATX Full Tower	Black	\N	Acrylic	\N	4
Corsair Carbide Series SPEC-02	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	3
Corsair iCUE 5000X RGB	\N	ATX Mid Tower	Black	850	Tempered Glass	66.2	2
HYTE Gundam Wing Y70 Touch Infinite	499.99	ATX Mid Tower	White / Gold	\N	Tempered Glass	70.7	2
Fractal Design Epoch	109.99	ATX Mid Tower	White	\N	Tempered Glass	45.1	2
Fractal Design Meshify 2 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	61.7	6
Fractal Design Torrent Nano	\N	Mini ITX Tower	White / Black	\N	Tempered Glass	34.6	1
Jonsbo BO400	315	ATX Mid Tower	Gray / Black	\N	Tempered Glass	72.1	4
Corsair FRAME 5000D RS ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	75.3	2
be quiet! Shadow Base 800	\N	ATX Mid Tower	Black	\N	Tempered Glass	70.9	2
NZXT H510i	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.3	2
Jonsbo N10	61.99	Mini ITX Tower	Silver	\N	Mesh	4.5	0
CiT DS240	\N	MicroATX Mini Tower	White	\N	Tempered Glass	36.7	1
Silverstone CS382	259.61	ATX Mid Tower	Black	\N	\N	39.6	1
MSI MAG VAMPIRIC 100L	\N	ATX Mid Tower	Black	\N	Tempered Glass	36.5	2
Phanteks Eclipse G360A	\N	ATX Mid Tower	White	\N	Tempered Glass	42.3	2
SAMA NEVIEW 2851A	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.9	1
Gigabyte C102 GLASS	\N	MicroATX Mid Tower	White	\N	Tempered Glass	42.5	2
ADATA XPG VALOR MESH	\N	ATX Mid Tower	White	\N	Tempered Glass	35.8	2
Xigmatek Aquarius Plus Arctic	\N	ATX Mid Tower	White	\N	Tempered Glass	49.6	2
MSI MPG GUNGNIR 110R	119.99	ATX Mid Tower	White	\N	Tempered Glass	\N	2
GAMDIAS NESO P1	\N	ATX Full Tower	Black	\N	Tempered Glass	75.2	5
KOLINK KLM-002	\N	MicroATX Mini Tower	Black	\N	\N	9.6	0
Lian Li LANCOOL II-X	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Cougar MX600 RGB	\N	ATX Full Tower	Black	\N	Tempered Glass	57.8	1
Jonsbo D31 MESH Screen	\N	MicroATX Mini Tower	White	\N	Tempered Glass	31.3	1
ENDORFY Signum 300 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.9	2
Cooler Master MasterBox TD500 Mesh White w/ Controller	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
YEYIAN Hussar	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	26.6	1
Thermaltake View 380 ARGB	114.99	ATX Mid Tower	Pink / Blue	\N	Tempered Glass	51.6	1
CiT DS240	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	36.7	1
Antec NX360	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.5	1
MSI MPG GUNGNIR 111R	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.4	2
ENDORFY Regnum 400 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.9	2
Deepcool MORPHEUS	\N	ATX Full Tower	White	\N	Tempered Glass	72.7	2
Mars Gaming MC-VIEW	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	32.1	1
ENDORFY ARX 500 ARGB	114	ATX Mid Tower	Black	\N	Tempered Glass	47.5	1
iBuypower Element 9 PRO	134.99	ATX Mid Tower	Black	\N	Tempered Glass	49.2	2
Fractal Design Meshify 3 XL Ambience Pro RGB	274.99	ATX Full Tower	White	\N	Tempered Glass	72.6	2
Silverstone RM42-502	425.16	ATX Mid Tower	Black	\N	\N	35.4	0
Thermaltake S200 TG ARGB	136.84	ATX Mid Tower	White	\N	Tempered Glass	38.2	2
Aerocool CS-106	\N	MicroATX Mini Tower	Black	\N	\N	23.9	1
Silverstone SUGO 14	\N	Mini ITX Desktop	Black / Yellow	\N	\N	19.5	0
Corsair Crystal Series 680X RGB	164.99	ATX Mid Tower	White / Black	\N	Tempered Glass	73.5	3
darkFlash DLM 21	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	2
Asus ROG Strix Helios Gundam Edition	\N	ATX Full Tower	Silver / Multicolor	\N	Tempered Glass	83.5	2
Thermaltake The Tower 600	186.99	ATX Mid Tower	Pink	\N	Tempered Glass	66.2	1
Silverstone SETA H2	184.17	ATX Full Tower	Black	\N	Mesh	70.3	12
Fractal Design Torrent Nano	\N	Mini ITX Tower	Black	\N	\N	34.6	1
DIYPC Rainbow-Flash-F4	65.98	ATX Mid Tower	Pink	\N	Tempered Glass	33.2	2
DIYPC ARGB-Q3	\N	MicroATX Mini Tower	Green	\N	Tempered Glass	38.6	2
Deepcool Wave V2	\N	MicroATX Mini Tower	Black	\N	\N	24	2
Corsair Carbide Series SPEC-05	\N	ATX Mid Tower	Black	\N	Acrylic	41.6	2
Geometric Future Model 5	149.9	ATX Mid Tower	Black / Green	\N	Tempered Glass	51.1	2
Thermaltake Core P3	151.77	ATX Mid Tower	Black	\N	Tempered Glass	80.1	2
NZXT H7 Flow RGB (2023)	168.99	ATX Mid Tower	Black	\N	Tempered Glass	55.8	2
Jonsbo D41 Mesh Screen	\N	ATX Mid Tower	White	\N	Tempered Glass	35.4	2
Cooler Master HAF 912	\N	ATX Mid Tower	Black	\N	\N	54.9	6
Vetroo M05	64.98	MicroATX Mid Tower	Green	\N	Tempered Glass	36.3	2
Silverstone Crown 04	549.99	HTPC	Black	\N	Mesh	48.2	2
KOLINK Observatory Y AMD SE	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.1	2
Fractal Design Define Mini C	\N	MicroATX Mid Tower	Black	\N	\N	35.7	2
NZXT H440	\N	ATX Mid Tower	Black / White	\N	Acrylic	53.3	8
be quiet! Pure Base 501 Airflow	94.99	ATX Mid Tower	White	\N	\N	48.1	2
Silverstone PS15	59.99	MicroATX Mid Tower	Black	\N	Tempered Glass	25.7	1
SHARKOON VS8	\N	ATX Mid Tower	Black	\N	\N	42.1	2
GAMDIAS Talos M3 Mesh	84.99	ATX Mid Tower	Black	\N	Tempered Glass	48.6	2
Lian Li LANCOOL 206	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.6	3
Phanteks Eclipse P600S	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	\N	4
Phanteks Eclipse P400	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	45.9	2
Thermaltake V200 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Mars Gaming MC-S1	\N	MicroATX Mini Tower	Black	\N	Acrylic	18.6	1
GAMDIAS ATHENA P1	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.6	2
KOLINK Observatory HF Mesh Core	\N	ATX Mid Tower	Black	\N	Tempered Glass	35	4
Corsair iCUE 5000X RGB QL Edition	209.99	ATX Mid Tower	White	\N	Tempered Glass	66.2	2
Thermaltake Tower 900	\N	ATX Full Tower	Black	\N	Tempered Glass	153.6	6
darkFlash DS900	\N	ATX Mid Tower	White	\N	Tempered Glass	43	2
FormD T1 V2.1 Steel Coated	\N	Mini ITX Desktop	Black	\N	Mesh	\N	0
Silverstone GD08B	246.29	HTPC	Black	\N	\N	33.4	8
Fractal Design Epoch RGB	129.99	ATX Mid Tower	Black	\N	Tinted Tempered Glass	45.1	2
Lian Li V3000 PLUS	\N	ATX Full Tower	Black	\N	Tempered Glass	127.6	8
Jonsbo D31 STD	\N	MicroATX Mini Tower	White	\N	Tempered Glass	31.3	1
Thermaltake Versa H25	\N	ATX Mid Tower	Black	\N	\N	42.6	3
Asus TUF Gaming GT502 Horizon	194.91	ATX Mid Tower	White	\N	Tempered Glass	57.2	4
Lian Li TU150	\N	Mini ITX Desktop	Silver	\N	Tempered Glass	23.8	1
Phanteks Eclipse P350X	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	41	2
Cooler Master Silencio S600	143.57	ATX Mid Tower	Black	\N	\N	47	4
Thermaltake The Tower 200	104.98	Mini ITX Tower	Green	\N	Tempered Glass	45.1	2
Thermaltake Divider 370 TG ARGB	150.99	ATX Mid Tower	Black	\N	Tempered Glass	50.7	2
Phanteks Enthoo Pro 2	\N	ATX Full Tower	Black	\N	\N	\N	12
Thermaltake View 71 TG Snow	224.98	ATX Full Tower	White	\N	Acrylic	\N	4
MOROVOL TW7-S2-BL	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	27.1	2
KOLINK Observatory MX Mesh ARGB	\N	ATX Mid Tower	White	\N	Tempered Glass	30.8	2
Thermaltake CTE E550	169.95	ATX Mid Tower	Orange	\N	Tempered Glass	77.4	3
MSI MAG FORGE 110R	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.5	2
Lian Li Lancool II Mesh C RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	54.1	3
Corsair Obsidian Series 900D	\N	ATX Full Tower	Black	\N	Acrylic	112.6	9
DAN Cases C4-SFXv1	\N	Mini ITX Desktop	Black	\N	Mesh	15.9	0
Montech SKY TWO	135.97	ATX Mid Tower	Blue	\N	Tempered Glass	45.3	2
BGears b-Voguish	58.99	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cooler Master MasterFrame 600	179.99	ATX Mid Tower	Black	\N	Tempered Glass	61.2	2
Lian Li LANCOOL III	\N	ATX Mid Tower	White	\N	Tempered Glass	65.5	4
GameMax Vista A	79.99	ATX Mid Tower	Black	\N	Tempered Glass	44.1	2
Mars Gaming MC-3TCORE	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.5	1
Fractal Design Define C	\N	ATX Mid Tower	Black	\N	\N	39.3	2
Lian Li LANCOOL 205	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Lian Li LANCOOL 205M	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	2
KOLINK Inspire K7 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	33.4	2
FSP Group S380	\N	MicroATX Mini Tower	White	\N	Tempered Glass	48.2	2
Lian Li O11 Dynamic Mini	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	43	2
Corsair Carbide Series 275R	\N	ATX Mid Tower	White	\N	Tempered Glass	44.2	2
GAMDIAS AURA GC1	\N	ATX Mid Tower	Black	\N	Tempered Glass	31.1	2
GAMDIAS Talos M3 Mesh	99.06	ATX Mid Tower	White	\N	Tempered Glass	48.6	2
Jonsbo D300	\N	MicroATX Mid Tower	White	\N	Tempered Glass	45.8	2
Jonsbo T6	\N	Mini ITX Tower	\N	\N	\N	13.7	0
Ocypus Gamma C50	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	34.6	2
Antec NX416L	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.9	2
be quiet! Silent Base 802	192.48	ATX Mid Tower	White	\N	Tempered Glass	83.8	3
Fractal Design Era ITX	\N	Mini ITX Desktop	Silver	\N	Tinted Tempered Glass	16.7	1
ENDORFY ARX 500 Air	103.5	ATX Mid Tower	Black	\N	Tempered Glass	47.5	1
Corsair Crystal 280X RGB	239.99	MicroATX Mid Tower	White	\N	Tempered Glass	\N	2
Corsair Graphite Series 760T	\N	ATX Full Tower	Black	\N	Acrylic	78.8	6
Cooler Master Silencio S400	\N	MicroATX Mini Tower	Black	\N	\N	\N	4
Thermaltake CTE C750 ARGB	184.98	ATX Full Tower	Black	\N	Tempered Glass	110.7	7
Phanteks EVOLV SHIFT XT	\N	Mini ITX Desktop	Silver / Black	\N	Tempered Glass	17.5	0
Antec Dark Phantom DP301M	\N	MicroATX Mid Tower	Black	\N	Acrylic	\N	2
Cooler Master Storm Stryker	\N	ATX Full Tower	White / Black	\N	Acrylic	86.7	8
Corsair 5000D CORE AIRFLOW	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	66.2	2
Aerocool Shard	\N	ATX Mid Tower	Black	\N	Acrylic	36.5	2
Thermaltake AX700	399.99	ATX Full Tower	White	\N	Tempered Glass	141.4	18
Apex MI-008	68.39	Mini ITX Tower	Black	250	\N	8.5	1
Lian Li LANCOOL 216 RGB w/Controller	\N	ATX Mid Tower	White	\N	Tinted Tempered Glass	55.6	2
Aerocool Bolt Mini	\N	MicroATX Mini Tower	Black	\N	Acrylic	\N	2
Fractal Design Meshify 2 Compact TG Dark Tint	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	42.3	2
Corsair Crystal 460X RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.9	2
Jonsbo N2	\N	Mini ITX Desktop	White	\N	\N	11.1	5
Fractal Design Define 7 Compact	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.5	2
NZXT H7 Flow RGB (2023)	159.99	ATX Mid Tower	White	\N	Tempered Glass	55.8	2
1STPLAYER T3	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	32.4	2
Thermaltake View 380 XL TG ARGB	84.99	ATX Mid Tower	Red / Copper	\N	Tempered Glass	63.6	1
Silverstone SG13	75.81	Mini ITX Tower	White / Black	\N	\N	11.5	1
GAMDIAS NESO P1	150.99	ATX Full Tower	Black / White	\N	Tempered Glass	75.2	5
be quiet! Silent Base 601	\N	ATX Mid Tower	Black	\N	\N	\N	3
SSUPD Meshlicious (PCIe 4.0)	\N	Mini ITX Tower	White	\N	Mesh	14.7	0
Lian Li V3000 PLUS White GGF Edition	494.99	ATX Full Tower	White	\N	Tempered Glass	127.6	8
Fractal Design Define R6	\N	ATX Mid Tower	Black / White	\N	\N	56.7	6
KOLINK OBSERVATORY RGB	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	\N	3
Deepcool TESSERACT BF	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	36.4	4
SHARKOON TG5	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	3
NZXT H440	\N	ATX Mid Tower	Black / Red	\N	Acrylic	53.3	8
Xigmatek SS04	\N	MicroATX Mid Tower	Black	\N	\N	22.1	2
Apevia Genesis-BK	74.98	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Thermaltake Core P3 TG Pro Snow	129.99	ATX Mid Tower	\N	\N	Tempered Glass	71.7	4
Genesis Irid 503	\N	ATX Mini Tower	Black	\N	Tempered Glass	38.8	2
Antec CX700 RGB ELITE	96.61	ATX Mid Tower	White	\N	Tempered Glass	44.5	2
Montech HS02	95.9	ATX Mid Tower	Black	\N	Tempered Glass	55.3	2
Thermaltake The Tower 300 Bumblebee	104.99	MicroATX Mini Tower	Yellow / Black	\N	Tempered Glass	53	3
Asus A21	\N	MicroATX Mini Tower	White	\N	Tempered Glass	44	2
Deepcool MATREXX 55 V3 ADD-RGB 3F	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cooler Master HAF X	\N	ATX Full Tower	Black	\N	Acrylic	75	5
Corsair Carbide Series 100R	\N	ATX Mid Tower	Black	\N	\N	\N	4
Anidees AI CRYSTAL XL PRO LITE	309.89	ATX Full Tower	Black	\N	Tempered Glass	\N	0
Corsair iCUE 4000D RGB Airflow QL Edition	149.99	ATX Mid Tower	White	\N	Tempered Glass	48.6	2
darkFlash L280	143.22	ATX Mid Tower	White	\N	Tempered Glass	54.6	2
CiT Slammer	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	31.7	2
HYTE Y70 Silver Wolf	299.99	ATX Mid Tower	Black / Purple	\N	Tempered Glass	70.7	2
KOLINK Observatory MX Mesh ARGB	\N	ATX Mid Tower	Black / White	\N	Tempered Glass	30.8	2
PC Cooler C3 T500 ARGB	119.99	ATX Mid Tower	White	\N	Tempered Glass	45.1	2
Thermaltake S300 Tempered Glass Snow Edition	83.99	ATX Mid Tower	White	\N	Tempered Glass	\N	2
Antec CX500M ARGB	\N	MicroATX Mini Tower	White	\N	Tempered Glass	40.8	2
Cooler Master MasterBox NR400 (w/o ODD)	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	35.5	3
Fractal Design Define 7 Nano	\N	Mini ITX Tower	Black	\N	\N	29.5	1
darkFlash DLM 22	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	2
MSI MAG VAMPIRIC 010	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.9	2
Linkworld 920-01C2121U	49.5	HTPC	Black	150	\N	5.3	0
Silverstone CS351	189.99	MicroATX Desktop	Black	\N	\N	22.8	2
Thermaltake The Tower 200	104.98	Mini ITX Tower	Beige	\N	Tempered Glass	45.1	2
Corsair 2000D RGB AIRFLOW	\N	Mini ITX Tower	White	\N	Mesh	24.8	0
Thermaltake Ceres 300 TG ARGB	119.98	ATX Mid Tower	Green	\N	Tempered Glass	53.9	1
GameMax HYPE	\N	ATX Mid Tower	Black	\N	Tempered Glass	113.8	2
BitFenix Nova Mesh M ARGB	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	31.6	2
Fractal Design Define S	\N	ATX Mid Tower	Black	\N	\N	57.7	3
Antec VSK 3000 Elite	113.43	MicroATX Mini Tower	Black	\N	\N	27.5	4
be quiet! Pure Base 500	99.9	ATX Mid Tower	White	\N	\N	46	2
PC Cooler CPS C3D310 ARGB	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	36.6	2
Corsair iCUE 5000T LX RGB	339.99	ATX Mid Tower	White	\N	Tempered Glass	74.5	2
KOLINK Rocket V2	\N	Mini ITX Tower	Silver	\N	Mesh	14.2	0
Thermaltake V250 TG ARGB	134.96	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Antec AX81 ELITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.9	2
Fractal Design Pop Mini Silent	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	36.5	2
HYTE Y70 Touch	\N	ATX Mid Tower	Black / White	\N	Tempered Glass	70.7	2
Corsair 480T RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.4	0
Tecware Forge M ARGB	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	34.4	1
Phanteks Eclipse P360A	\N	ATX Mid Tower	White	\N	Tempered Glass	42.3	2
KOLINK Observatory HF Mesh ARGB	\N	ATX Mid Tower	White	\N	Tempered Glass	35	4
ADATA XPG INVADER X	169	ATX Mid Tower	Black	\N	Tempered Glass	52.1	3
Raidmax ATX-818WB	\N	MicroATX Mid Tower	Black	\N	Acrylic	\N	4
Cooler Master HAF 932 Advanced	\N	ATX Full Tower	Black	\N	Acrylic	71.7	5
Montech X2 Mesh	\N	ATX Mid Tower	Black	\N	Tempered Glass	32.3	2
Xigmatek Cubi ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	62.8	2
GameMax MeshBox	\N	ATX Mid Tower	Black	\N	Mesh	33.5	1
Antec P20C	79.99	ATX Mid Tower	Black	\N	Tempered Glass	50.6	2
Fractal Design Pop XL Silent	536.73	ATX Full Tower	Black	\N	Tempered Glass	62.4	3
Antec CX600M Wood ARGB	\N	MicroATX Mini Tower	Black / Brown	\N	Tempered Glass	46.8	1
Thermaltake The Tower 300	169.99	MicroATX Mini Tower	Brown / Gold	\N	Tempered Glass	53	3
SHARKOON Rebel C70G RGB	\N	ATX Mid Tower	Brown / Black	\N	Tempered Glass	54.5	3
Cooler Master Elite 130	\N	Mini ITX Tower	Black	\N	\N	19.8	3
Corsair Carbide Series 500R	\N	ATX Mid Tower	Black	\N	\N	54.2	6
HEC 6T10LITE	\N	MicroATX Mini Tower	Black	\N	\N	24	2
Lian Li LANCOOL 206	169.99	ATX Mid Tower	White	\N	Tempered Glass	49.6	3
Silverstone Lucid 04	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	38.2	2
KOLINK OBSERVATORY LITE MESH RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
be quiet! Pure Base 600	\N	ATX Mid Tower	Black / Orange	\N	Tempered Glass	50.9	3
Thermaltake The Tower 250	149.99	Mini ITX Tower	Green / Black	\N	Tempered Glass	42.7	1
KOLINK Observatory Lite	\N	ATX Mid Tower	Black	\N	Tempered Glass	33.4	2
Antec CX800 RGB ELITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.2	2
AQIRYS Sargas	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	50.1	2
Cooler Master MasterCase Pro 5	\N	ATX Mid Tower	Black	\N	Acrylic	\N	5
NZXT S340 Elite	\N	ATX Mid Tower	White	\N	Tempered Glass	41.6	2
Phanteks Eclipse P400A Digital	\N	ATX Mid Tower	White	\N	Tempered Glass	45.9	2
Mars Gaming MCZ	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	1
Cooler Master MasterBox TD500 Mesh w/ Controller	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cooler Master MasterBox MB511 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
SSUPD Meshroom S w/PCIe 4.0 Riser	\N	ATX Mini Tower	Black	\N	Mesh	14.9	0
Thermaltake CTE C700 Air	134.98	ATX Mid Tower	Black	\N	Tempered Glass	93.8	7
Mars Gaming MCV4	\N	ATX Mid Tower	Pink / Black	\N	Tempered Glass	50.9	2
Thermaltake CTE C750 Air ARGB	\N	ATX Full Tower	White	\N	Tempered Glass	110.7	7
CiT Seven	\N	MicroATX Mid Tower	Black	\N	Acrylic	\N	1
ENDORFY Signum 300 Air	130.61	ATX Mid Tower	Black	\N	Tempered Glass	39.9	2
Fractal Design Focus G	\N	ATX Mid Tower	White	\N	Acrylic	42.2	2
Fractal Design Core 500	\N	Mini ITX Desktop	Black	\N	\N	18.6	3
KOLINK Observatory HF Glass ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	35	2
Fractal Design Meshify 2 Compact Lite	\N	ATX Mid Tower	White	\N	Tempered Glass	42.3	2
Fractal Design Pop Air	154.62	ATX Mid Tower	White	\N	Tempered Glass	46.2	2
Deepcool CH360 DIGITAL	\N	MicroATX Mid Tower	White	\N	Tempered Glass	39.7	2
Chieftec Hunter	111.29	ATX Mid Tower	Black	\N	Tempered Glass	39.8	2
Deepcool CH780	\N	ATX Full Tower	Black	\N	Tempered Glass	72.7	2
Silverstone ML06B	92.54	HTPC	Black	\N	\N	7.1	0
Corsair 4000D Airflow Teak	117.5	ATX Mid Tower	Black / Brown	\N	Tempered Glass	48.6	2
Silverstone ML03B	101.41	HTPC	Black	\N	\N	15.5	2
Inter-Tech IM-1 POCKET	\N	MicroATX Mini Tower	Black	\N	Mesh	21.9	4
Silverstone ML07B	118.72	HTPC	Black	\N	\N	13.9	1
SHARKOON Rebel C20 ITX RGB	\N	Mini ITX Desktop	Black	\N	Mesh	29.5	1
MSI MPG GUNGNIR 300P AIRFLOW	361.98	ATX Mid Tower	Black	\N	Tempered Glass	60.5	2
Phanteks Evolv X	\N	ATX Mid Tower	Silver	\N	Tinted Tempered Glass	64.9	4
Phanteks Eclipse P500A	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Lian Li O11 Dynamic Mini	\N	ATX Mid Tower	Black	750	Tempered Glass	43	2
BitFenix CETO Premium	\N	ATX Mid Tower	Black	\N	Tempered Glass	49	3
CiT SO14B	\N	MicroATX Desktop	Black	300	\N	12.3	2
Thermaltake The Tower 250	149.95	Mini ITX Tower	Blue / White	\N	Tempered Glass	42.7	1
be quiet! Pure Base 500	\N	ATX Mid Tower	Black	\N	Tempered Glass	46	2
iBuypower Element 9	114.99	ATX Mid Tower	Black	\N	Tempered Glass	49.2	2
Antec C7 ARGB	181.99	ATX Mid Tower	White	\N	Tempered Glass	58.9	2
Corsair 5000D	\N	ATX Mid Tower	White / Gray	\N	Tempered Glass	66.2	2
Thermaltake H200 TG RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.7	2
Tempest Umbra	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Thermaltake Level 20 RS ARGB	89.98	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Jonsbo D41 STD	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.4	2
Jonsbo TK-2 2.0	162	ATX Mid Tower	White	\N	Tempered Glass	53.2	1
Fractal Design Meshify 2 Compact Lite RGB	321.05	ATX Mid Tower	Black	\N	Tinted Tempered Glass	42.3	2
BitFenix Nova Mesh M ARGB	\N	MicroATX Mini Tower	White	\N	Tempered Glass	31.6	2
Asus ROG Strix Helios EVA Edition	\N	ATX Full Tower	Black / Multicolor	\N	Tinted Tempered Glass	83.5	2
Antec NX292	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.6	2
GAMDIAS ARGUS E4 ELITE	61.47	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GAMDIAS TALOS E3 MESH ELITE	\N	ATX Mid Tower	White	\N	Tempered Glass	48.6	2
Deepcool MORPHEUS	\N	ATX Full Tower	Black	\N	Tempered Glass	72.7	2
Corsair iCUE 465X RGB	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
Corsair iCUE 220T RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.3	2
Aerocool P300C	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	49.8	2
Zalman CHRONIX	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.7	2
Rosewill Helium Flow	79.98	ATX Mid Tower	White	\N	\N	50.5	3
Vetroo AL800	64.98	ATX Mid Tower	Black	\N	Tempered Glass	46.4	2
Asus ProArt PA401 Wood Edition	273.96	ATX Mid Tower	Black	\N	\N	46.6	2
Thermaltake The Tower 200	\N	Mini ITX Tower	White	\N	Tempered Glass	45.1	2
Lian Li LANCOOL 205 Mesh	195	ATX Mid Tower	Black	\N	Tempered Glass	41.3	2
Gigabyte AORUS C700	\N	ATX Full Tower	Black	\N	Tempered Glass	144.2	4
Gigabyte AORUS C300	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	\N	2
GAMDIAS AURA GC2 ELITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	34.7	2
Corsair 4000D	\N	ATX Mid Tower	Black	\N	Tempered Glass	48.6	2
Apex DM-387	87.99	HTPC	Black	275	\N	12.8	1
MagniumGear NEO QUBE 2	\N	ATX Mid Tower	Black	\N	Tempered Glass	55.9	2
be quiet! Pure Base 600	\N	ATX Mid Tower	Black / Silver	\N	\N	50.9	3
Chieftec CI-02B-OP	\N	MicroATX Desktop	Black	\N	Mesh	32.8	2
Thermaltake The Tower 500	\N	ATX Mid Tower	Black	\N	Tempered Glass	93.9	8
Zalman Z1 Iceberg	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	38.5	2
Montech KING 95	\N	ATX Mid Tower	White	\N	Tempered Glass	63	5
Corsair Crystal Series 280X	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	2
Lian Li Lancool II Mesh	\N	ATX Mid Tower	White	\N	Tempered Glass	54.1	3
Corsair Carbide Series 110R	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.1	2
Montech HS01	89.9	ATX Mid Tower	Black	\N	Tempered Glass	55.3	2
GAMDIAS ATLAS E1	84.84	ATX Mid Tower	White	\N	Tempered Glass	36.3	1
Fractal Design Meshify 2 RGB	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	61.7	6
Fractal Design Torrent Compact	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	46.7	1
Deepcool CH560 DIGITAL	\N	ATX Mid Tower	White	\N	Tempered Glass	49.6	2
Lian Li Lancool II Mesh C Performance	\N	ATX Mid Tower	Black	\N	Tempered Glass	54.1	3
Deepcool CH360	\N	MicroATX Mid Tower	White	\N	Tempered Glass	39.7	2
Phanteks Eclipse P600S	158.98	ATX Mid Tower	White	\N	Tempered Glass	\N	4
Chieftec APEX	178.78	ATX Mid Tower	Black	\N	Tempered Glass	52.9	2
Corsair SPEC-OMEGA RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Deepcool CK560	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Tecware Nexus M	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	2
Deepcool MATREXX 50	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.5	2
Silverstone FARA 313 Type-C	78.59	MicroATX Mid Tower	Black	\N	\N	26.7	3
Geometric Future Model 5	149.9	ATX Mid Tower	White	\N	Tempered Glass	51.1	2
KOLINK STRONGHOLD	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	3
Asiahorse Perseus	179.99	ATX Mid Tower	Black	\N	Tempered Glass	73.9	2
HYTE Persona 3 Reload Y60	229.99	ATX Mid Tower	Black / Blue	\N	Tempered Glass	60	2
NZXT H7	\N	ATX Mid Tower	White	\N	Tempered Glass	55.8	2
Lian Li TU150	\N	Mini ITX Desktop	Black	\N	Tempered Glass	23.8	1
Corsair Carbide Series 400C	\N	ATX Mid Tower	Black	\N	Acrylic	42.4	2
Silverstone FARA H1M	79.95	MicroATX Mini Tower	Black	\N	\N	30.1	2
Geometric Future Model 5 Fanless	109.9	ATX Mid Tower	Black / Gray	\N	Tempered Glass	51.1	2
Thermaltake Ceres 300 TG ARGB	99.99	ATX Mid Tower	White	\N	Tempered Glass	53.9	1
Thermaltake AX700	404.98	ATX Full Tower	White	\N	Mesh	141.4	18
Cougar Archon 2 Mesh RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.5	2
GameMax Infinity	\N	ATX Mid Tower	White	\N	Tempered Glass	45.7	1
FormD T1 V2.1 CNC Anodized	\N	Mini ITX Desktop	Silver	\N	Mesh	\N	0
Thermaltake The Tower 200 Bumblebee	104.98	Mini ITX Tower	Yellow / Black	\N	Tempered Glass	45.1	2
Mars Gaming MC-VIEW	\N	MicroATX Mid Tower	Pink	\N	Tempered Glass	32.1	1
Antec CX600M Trio ARGB	111.84	MicroATX Mini Tower	Black	\N	Tempered Glass	46.8	1
Cooler Master MasterCase H500 ARGB	246.75	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Fractal Design Define 7 Mini	\N	MicroATX Mini Tower	Black	\N	Tinted Tempered Glass	33.2	2
KOLINK VOID RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Fractal Design Meshify 2	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	61.7	6
Montech AIR 1000 PREMIUM	\N	ATX Mid Tower	White	\N	Tempered Glass	45.3	2
Thermaltake Core X9	\N	ATX Desktop	Black	\N	Acrylic	\N	7
Montech Heritage	89.9	MicroATX Mid Tower	White	\N	Tempered Glass	41.5	1
Antec CX600M Trio ARGB	185.73	MicroATX Mini Tower	White	\N	Tempered Glass	46.8	1
Mars Gaming MC-S1	\N	MicroATX Mini Tower	White	\N	Acrylic	18.6	1
Azza Aero	109.99	ATX Mid Tower	Black	\N	Mesh	47.3	2
ADATA XPG INVADER	84.93	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cooler Master HAF 700 EVO	\N	ATX Full Tower	White	\N	Tempered Glass	\N	12
Fractal Design Define 7 Nano	\N	Mini ITX Tower	Black	\N	Tinted Tempered Glass	29.5	1
Cooler Master MasterBox 520 Mesh	\N	ATX Mid Tower	Black / White	\N	Tempered Glass	52.5	2
NZXT H630	\N	ATX Full Tower	Black	\N	\N	\N	8
SAMA IM01 Pro	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	26.1	4
Thermaltake The Tower 600	185.99	ATX Mid Tower	Red	\N	Tempered Glass	66.2	1
MagniumGear Neo-G Mini V2	\N	Mini ITX Tower	Black	\N	Tempered Glass	\N	1
Antec P20CE	172.61	ATX Mid Tower	Black	\N	\N	50.6	2
Thermaltake View 200 TG ARGB	84.98	ATX Mid Tower	White	\N	Tempered Glass	38.2	2
Silverstone Lucid 04	\N	MicroATX Mid Tower	White	\N	Tempered Glass	38.2	2
Fractal Design Meshify 2	\N	ATX Mid Tower	Gray	\N	Tinted Tempered Glass	61.7	6
PC Cooler C3 T500 ARGB	168.56	ATX Mid Tower	Black	\N	Tempered Glass	45.1	2
Phanteks Enthoo Pro	\N	ATX Full Tower	White	\N	Acrylic	68.6	6
Corsair Crystal 570X RGB	\N	ATX Mid Tower	White	\N	Acrylic	57.5	2
be quiet! Dark Base Pro 900 Rev. 2	\N	ATX Full Tower	Black / Orange	\N	Tempered Glass	\N	7
Deepcool CC560	\N	ATX Mid Tower	White	\N	Tempered Glass	41.7	2
Aerocool Hexform RGB	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	28	2
Silverstone FARA 513 Type-C	98.31	ATX Mid Tower	Black	\N	\N	44.6	2
Cougar Archon 2 Mesh RGB	\N	ATX Mid Tower	White	\N	Tempered Glass	37.5	2
MagniumGear Neo Micro V2	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	2
CiT MTX-007B	\N	Mini ITX Desktop	Black	180	\N	5.1	0
Lian Li TU150	\N	Mini ITX Desktop	Black	\N	\N	23.8	1
MUSETEX G06MN6-B	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.7	2
Asus ROG Z11	\N	Mini ITX Tower	Black	\N	Tinted Tempered Glass	\N	1
Phanteks Eclipse P400S	\N	ATX Mid Tower	Black / White	\N	Tinted Tempered Glass	45.9	2
Corsair Carbide Series SPEC-06	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Aerocool Aero One Eclipse	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Silverstone SG13 V2	75.3	Mini ITX Tower	Pink	\N	\N	11.5	1
CiT Mirage F6	\N	ATX Mid Tower	Black	\N	Tempered Glass	29.9	2
DIYPC F2	\N	MicroATX Mini Tower	Black / Orange	\N	Acrylic	\N	2
NZXT H710	\N	ATX Mid Tower	Black	\N	Tempered Glass	58.6	4
Antec Performance 1 M	214.99	Mini ITX Desktop	Green / Black	\N	Mesh	19.3	0
Thermaltake CTE T500 Air	134.98	ATX Full Tower	White	\N	Tempered Glass	87.3	4
Corsair 5000D CORE AIRFLOW	\N	ATX Mid Tower	White	\N	Tempered Glass	66.2	2
Antec AX90	\N	ATX Mid Tower	Black	\N	Tempered Glass	48.3	2
Corsair Graphite Series 780T	\N	ATX Full Tower	Black	\N	Acrylic	109.9	6
SHARKOON T9 Value	\N	MicroATX Mid Tower	Black / Red	\N	Acrylic	\N	0
MUSETEX Phantom	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
SilentiumPC Signum SG1 TG	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Silverstone SUGO 17	212.48	MicroATX Desktop	Black	\N	Mesh	26.1	1
CiT DS360	\N	ATX Mid Tower	White	\N	Tempered Glass	52.1	0
Thermaltake View 51 Snow ARGB Edition	214.6	ATX Full Tower	White	\N	Tempered Glass	91	2
In Win BL040.300TB3LF	102.58	HTPC	Black	300	\N	11.6	2
Thermaltake The Tower 100	128.99	Mini ITX Tower	Turquoise / Black	\N	Tempered Glass	32.7	2
iBuypower Snowblind S	199.99	ATX Mid Tower	White	\N	Tempered Glass	43	2
Fractal Design Define R6 USB-C	\N	ATX Mid Tower	Black / White	\N	Tempered Glass	56.7	6
G.Skill LT1	69.98	MicroATX Mini Tower	Black	\N	Tempered Glass	35	1
Fractal Design Arc Mini	\N	MicroATX Mini Tower	Black	\N	\N	40.9	6
Silverstone RVZ03	141.04	Mini ITX Desktop	Black	\N	\N	\N	0
Fractal Design Meshify 2 Lite	\N	ATX Mid Tower	Black	\N	Tempered Glass	61.7	2
Corsair 5000T	244.99	ATX Mid Tower	Black	\N	Tempered Glass	74.5	2
Fractal Design Meshify 2 Compact White TG Clear Tint	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	42.3	2
Cooler Master MasterBox MB400L	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	36.7	2
Empire Gaming Diamond	\N	ATX Mid Tower	Black	\N	Tempered Glass	48.5	2
SHARKOON MK6 RGB	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	43.6	2
Thermaltake The Tower 300	169.99	MicroATX Mini Tower	Turquoise / Black	\N	Tempered Glass	53	3
DAN Cases C4-SFXv1	\N	Mini ITX Desktop	Silver	\N	Mesh	15.9	0
Deepcool CG560	\N	ATX Mid Tower	Black	\N	Tempered Glass	48.9	2
Cougar Airface Pro RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	55.4	2
Lian Li LANCOOL II-W	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	3
Cooler Master Elite 110	\N	Mini ITX Tower	Black	\N	\N	15.3	3
Phanteks Eclipse P400S	\N	ATX Mid Tower	White	\N	Tinted Tempered Glass	45.9	2
Rosewill SPECTRA D100	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
MSI MAG FORGE 112R	\N	ATX Mid Tower	Black	750	Tempered Glass	42.5	2
MagniumGear NEO QUBE 2 Infinity Mirror	106.98	ATX Mid Tower	White	\N	Tempered Glass	55.9	2
Phanteks Eclipse P200A Performance	\N	Mini ITX Tower	Black	\N	\N	29.9	0
TRYX LUCA L70	249.99	ATX Mid Tower	Black	\N	Tempered Glass	80.9	0
Antec NX260	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Geometric Future Model 5	134.9	ATX Mid Tower	Black / Yellow	\N	Tempered Glass	51.1	2
Asus A21 PLUS	\N	MicroATX Mini Tower	White	\N	Tempered Glass	44	2
ENDORFY Regnum 400 Air	151.28	ATX Mid Tower	Black	\N	Tempered Glass	45.9	2
Jonsbo MOD-3	325.31	ATX Mid Tower	Black	\N	Tempered Glass	93.1	1
KOLINK VOID X ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GAMDIAS APOLLO E2 ELITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Fractal Design Meshify 2	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	61.7	6
Cooler Master MasterBox Lite 3.1	\N	MicroATX Mid Tower	Black / Red	\N	Tempered Glass	36.1	2
Apex MW-100	\N	Mini ITX Tower	Black / White	60	\N	2.9	0
NZXT H500i	\N	ATX Mid Tower	White	\N	Tempered Glass	41.3	3
In Win BK623.BH300TB3	108.05	MicroATX Mini Tower	Black / Silver	300	\N	12.3	1
BGears b-Optillusion	59.99	ATX Mid Tower	Black	\N	Tempered Glass	38.7	1
Thermaltake Ceres 350 MX	129.71	ATX Mid Tower	Pink	\N	Tempered Glass	52.5	1
Thermaltake CTE T500	110.49	ATX Full Tower	White	\N	Tempered Glass	87.3	4
Silverstone FARA 514X	108.69	ATX Mid Tower	Black	\N	Tempered Glass	49.7	2
Thermaltake The Tower 250	154.98	Mini ITX Tower	Blue / Pink	\N	Tempered Glass	42.7	1
Antec NX500M ARGB	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	34.6	2
Corsair Obsidian Series 250D	\N	Mini ITX Tower	Black	\N	Acrylic	28.1	2
Thermaltake Ceres 330 ARGB	64.99	ATX Mid Tower	White	\N	Tempered Glass	53.9	1
Silverstone Sugo SG11	131.62	MicroATX Mini Tower	Black	\N	\N	\N	3
Silverstone Milo 12	198.47	HTPC	Black	\N	Mesh	15.6	0
PrimoChill Praxis WetBench	234.99	ATX Test Bench	Black	\N	\N	\N	4
Thermaltake View 71 ARGB	\N	ATX Full Tower	Black	\N	Tempered Glass	\N	4
Fractal Design Define Nano S	\N	Mini ITX Desktop	Black	\N	\N	28.8	2
Fractal Design Define R4	\N	ATX Mid Tower	Black	\N	\N	56	8
GAMDIAS ATLAS E1	84.84	ATX Mid Tower	Black	\N	Tempered Glass	36.3	1
Thermaltake CTE C700 TG ARGB	154.93	ATX Mid Tower	Black	\N	Tempered Glass	93.8	7
Cooler Master MasterBox MB600L V2	186	ATX Mid Tower	Black	\N	\N	37.7	2
Zalman S5	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Corsair Crystal 280X RGB	239.99	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	2
Thermaltake The Tower 100 Snow	\N	Mini ITX Tower	White	\N	Tempered Glass	32.7	2
Fractal Design Define R5	\N	ATX Mid Tower	Black	\N	Acrylic	54.2	8
HYTE Y70 Touch	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	70.7	2
Rosewill THOR V2	\N	ATX Full Tower	Black	\N	\N	74.8	6
Corsair Carbide Series 100R	\N	ATX Mid Tower	Black	\N	Acrylic	\N	4
Phanteks Enthoo EVOLV ATX	\N	ATX Mid Tower	Black	\N	Acrylic	\N	5
Corsair Obsidian Series 750D	\N	ATX Full Tower	Black	\N	Acrylic	71.3	6
DIYPC ARGB Q10	\N	ATX Mid Tower	White	\N	Tempered Glass	50.4	1
FSP Group CUT593P	109.99	ATX Full Tower	White	\N	Tempered Glass	62.6	3
Asiahorse Perseus	179.99	ATX Mid Tower	White	\N	Tempered Glass	73.9	2
Zalman T7	\N	ATX Mid Tower	Black	\N	Tinted Acrylic	34	2
Thermaltake The Tower 300	153.99	MicroATX Mini Tower	Green / Pink	\N	Tempered Glass	53	3
In Win 101	119.2	ATX Mid Tower	Black	\N	Tempered Glass	48.3	2
ADATA XPG INVADER X	169	ATX Mid Tower	White	\N	Tempered Glass	52.1	3
Antec VSK2000-U3	\N	HTPC	Black	\N	\N	\N	1
Corsair 4000D	\N	ATX Mid Tower	White	\N	Tempered Glass	48.6	2
Apevia Prodigy	74.98	MicroATX Mini Tower	Black	\N	Tempered Glass	32.5	2
Phanteks Eclipse G300A (1 Fan)	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.2	1
Cougar Uniface RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.9	2
Cooler Master CMP 520	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.5	2
SAMA NEVIEW 4503	\N	ATX Mid Tower	White	\N	Tempered Glass	54.7	0
GAMDIAS NESO P1 PRO	\N	ATX Full Tower	Black	\N	Tempered Glass	75.2	2
CiT Alpha	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	27.1	2
Thermaltake The Tower 600	189.99	ATX Mid Tower	Green / White	\N	Tempered Glass	66.2	1
MSI MPG GUNGNIR 100	\N	ATX Mid Tower	Black	\N	Tempered Glass	60.8	2
NOX Hummer ASTRA	\N	ATX Mid Tower	White	\N	Tempered Glass	54.7	2
Rosewill PRISM S500	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Azza Spectra	64.98	ATX Mid Tower	White	\N	Tempered Glass	33.4	2
Fractal Design Meshify 3 XL RGB	209.99	ATX Full Tower	White	\N	Tempered Glass	72.6	2
Silverstone FARA R1 PRO V2	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.1	2
Thermaltake Versa H17	\N	MicroATX Mini Tower	Black	\N	Acrylic	30.4	2
NZXT S340 Elite	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	41.6	2
NZXT H510i	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	41.3	2
In Win BQS656.DD120BL	\N	Mini ITX Desktop	Black	120	\N	3.3	0
NZXT H210	\N	Mini ITX Tower	White	\N	Tempered Glass	27.3	1
aigo AZ300	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.6	2
Zalman P10	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	\N	2
Raidmax X921 MESHIAN	69.98	ATX Mid Tower	Black	\N	Tempered Glass	36.8	2
Thermaltake CTE E600	154.98	ATX Mid Tower	Black	\N	Tempered Glass	77.4	2
SHARKOON VK2	\N	ATX Mid Tower	Black	\N	\N	40.5	2
DIYPC DIY-S08	\N	ATX Mid Tower	Gray / Black	\N	Tempered Glass	33.2	2
Cooler Master MasterBox NR200P	\N	Mini ITX Desktop	Pink	\N	Tempered Glass	20.3	2
Thermaltake AH T600 Snow	\N	ATX Full Tower	White / Black	\N	Tempered Glass	161.6	2
Fractal Design Meshify S2	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	58.3	3
Lian Li PC-V650	\N	ATX Mini Tower	Black	\N	\N	38.2	7
Corsair Carbide Series SPEC-04	\N	ATX Mid Tower	Black / Red	\N	Acrylic	42.8	3
NZXT H710i	\N	ATX Mid Tower	Black	\N	Tempered Glass	58.6	4
SAMA NEVIEW 2851A	\N	ATX Mid Tower	White	\N	Tempered Glass	53.9	1
Azza Celesta 340F	67.98	ATX Mid Tower	Black	\N	Tempered Glass	40.2	2
Fractal Design Meshify 3	159.99	ATX Mid Tower	White	\N	Tempered Glass	50.3	2
CiT F3 ARGB	\N	MicroATX Mid Tower	White	\N	Tempered Glass	25.5	2
SSUPD Meshlicious	\N	Mini ITX Tower	White	\N	Mesh	14.7	0
Fractal Design Pop Silent	\N	ATX Mid Tower	Black	\N	Tempered Glass	46.2	2
Deepcool CH690 DIGITAL	\N	ATX Mid Tower	White	\N	Tempered Glass	107.9	1
be quiet! Shadow Base 800 FX	239.89	ATX Mid Tower	White	\N	Tempered Glass	70.9	2
ADATA XPG VALOR AIR	\N	ATX Mid Tower	White	\N	Tempered Glass	35.8	3
Phanteks Enthoo Pro M TG	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	56.4	2
Lian Li LANCOOL 205	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
Phanteks Eclipse P500A D-RGB	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
darkFlash DK352	\N	ATX Mid Tower	White	\N	Tempered Glass	43.1	2
Antec P10C	113.64	ATX Mid Tower	Black	\N	\N	51	3
Xilence Xilent Blade II	\N	ATX Mid Tower	\N	\N	Tempered Glass	33.7	2
GameMax Spark	\N	MicroATX Mid Tower	White	\N	Tempered Glass	26.5	1
KOLINK Citadel Mesh RGB	\N	MicroATX Mini Tower	White	\N	Tempered Glass	34.5	2
SSUPD Meshlicious	\N	Mini ITX Tower	Black	\N	Mesh	14.7	0
Fractal Design Pop Air	\N	ATX Mid Tower	Green / Black	\N	Tempered Glass	46.2	2
Thermaltake AH T600	\N	ATX Full Tower	Black	\N	Tempered Glass	161.6	2
NZXT H710	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	58.6	4
Thermaltake H200 TG Snow RGB Light Strip	\N	ATX Mid Tower	White	\N	Tempered Glass	39.7	2
Antec Nine Hundred	\N	ATX Mid Tower	Black	\N	Acrylic	47.1	6
Corsair Carbide Series SPEC-01	\N	ATX Mid Tower	Black	\N	Acrylic	38.3	4
DIYPC ARGB-Q3	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	38.6	2
KOLINK Observatory HF Glass ARGB	\N	ATX Mid Tower	White	\N	Tempered Glass	35	2
KOLINK Rocket Heavy Vented	\N	Mini ITX Desktop	Black	\N	Mesh	16.7	1
Thermaltake Divider 170 TG ARGB	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	36.5	2
Jonsbo D30	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	26.6	1
DIYPC DIY-S08	\N	ATX Mid Tower	Green / Black	\N	Tempered Glass	33.2	2
Thermaltake Ceres 500	\N	ATX Mid Tower	Black	\N	Tempered Glass	65.3	2
Zalman Z10 DUO	99.99	ATX Mid Tower	Black	\N	Tempered Glass	51.6	2
Cooler Master CMP 510	\N	ATX Mid Tower	Black	\N	Tempered Glass	42	2
GameMax MeshBox Pro	\N	ATX Mid Tower	Black	\N	Mesh	33.5	1
Deepcool CG580 4F	\N	ATX Mid Tower	White	\N	Tempered Glass	51.5	2
NZXT H400i	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	36.9	1
NZXT H700i	\N	ATX Mid Tower	Black / White	\N	Tempered Glass	58.6	2
Fractal Design Define R6	\N	ATX Mid Tower	Black / White	\N	Tempered Glass	56.7	6
Phanteks EVOLV SHIFT XT	\N	Mini ITX Desktop	Black	\N	Tempered Glass	17.5	0
darkFlash DPW90M	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	48.5	2
Silverstone ML05B	74.99	HTPC	Black	\N	\N	\N	0
Cougar Panzer Max	\N	ATX Full Tower	Black	\N	Acrylic	90.5	2
ENDORFY Signum 300 Solid	\N	ATX Mid Tower	Black	\N	\N	37.8	2
GAMDIAS NESO P1	165.99	ATX Full Tower	White	\N	Tempered Glass	75.2	5
Fractal Design Focus G	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	42.2	2
FSP Group CMT380	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.5	2
SHARKOON Rebel C50	459.39	ATX Mid Tower	White	\N	Mesh	52.4	3
Thermaltake Core P8 TG	\N	ATX Full Tower	Black	\N	Tempered Glass	107.4	3
Fractal Design Focus 2	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	45.8	2
Cooler Master MasterBox TD500 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.1	2
Phanteks Enthoo 719	\N	ATX Full Tower	Black	\N	Tempered Glass	81.4	4
Corsair Obsidian Series 450D	\N	ATX Mid Tower	Black	\N	Acrylic	51.6	3
Cooler Master MasterCase H500P Mesh ARGB	\N	ATX Mid Tower	White	\N	Tempered Glass	71.4	2
Montech X1	\N	ATX Mid Tower	White	\N	Tempered Glass	32.3	1
Apevia Genesis Pro	79.98	ATX Mid Tower	White	\N	Tempered Glass	35.7	3
Mars Gaming MC-400	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	29.9	2
Cougar Purity	\N	MicroATX Mini Tower	Black	\N	\N	28.2	2
Silverstone FARA 312X	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	37.2	2
Fractal Design Meshify 2 Compact RGB	273.63	ATX Mid Tower	Black	\N	Tinted Tempered Glass	42.3	2
Zalman M4	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	34	2
SHARKOON M25-V	\N	ATX Mid Tower	Black	\N	\N	43.9	3
Antec Performance 1 FT ARGB	\N	ATX Full Tower	Black / Gray	\N	Tempered Glass	62.7	2
Cooler Master CMP 320	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	38.6	2
Fractal Design Torrent	\N	ATX Mid Tower	Gray	\N	Tinted Tempered Glass	69.8	2
Lian Li PC-D8000	\N	ATX Full Tower	Black	\N	\N	144.9	20
HP Omen X	\N	MicroATX Desktop	Black / Red	\N	\N	\N	0
Cooler Master MasterBox Q300L TUF Gaming Edition	\N	MicroATX Mini Tower	Black / Gold	\N	Acrylic	33.6	1
GAMDIAS TALOS E3 MESH ELITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	48.6	2
Cooler Master Elite 300 Steel	\N	MicroATX Mid Tower	Black	\N	\N	35.8	2
Thermaltake The Tower 200	104.98	Mini ITX Tower	Turquoise	\N	Tempered Glass	45.1	2
darkFlash L280	125.99	ATX Mid Tower	Black	\N	Tempered Glass	54.6	2
Antec Dark League DF800 FLUX	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Thermaltake View 270	\N	ATX Mid Tower	Black	\N	Tempered Glass	47.6	2
Xilence Xilent Breeze	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.5	2
CiT DS360	\N	ATX Mid Tower	Black	\N	Tempered Glass	52.1	0
Fractal Design Torrent Compact RGB	\N	ATX Mid Tower	White	\N	Tempered Glass	46.7	1
Cooler Master MasterBox MB511 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Corsair Graphite Series 780T	\N	ATX Full Tower	Black / White	\N	Acrylic	109.9	6
Corsair Crystal 570X RGB	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	57.5	2
Cooler Master MasterBox MB530P	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Montech HS02	95.9	ATX Mid Tower	White	\N	Tempered Glass	55.3	2
Streacom DA2 V2	259	Mini ITX Desktop	Black	\N	\N	17.5	0
Silverstone SUGO 15	160.08	Mini ITX Desktop	Silver	\N	\N	19.1	0
SHARKOON REV300	\N	ATX Full Tower	Black	\N	Tempered Glass	65.6	4
Vetroo AL800	64.98	ATX Mid Tower	White	\N	Tempered Glass	46.4	2
Silverstone ML04B	116.1	HTPC	Black	\N	\N	16	2
Corsair iCUE 5000T RGB	239.99	ATX Mid Tower	White / Gray	\N	Tempered Glass	74.5	2
Cooler Master MasterFrame 700	191.99	ATX Full Tower	Black	\N	Tempered Glass	\N	4
Corsair 2500X Satin	159.99	MicroATX Mini Tower	White / Gray	\N	Tempered Glass	54.8	2
Fractal Design Core 2300	\N	ATX Mid Tower	Black	\N	\N	37.8	3
Phanteks Eclipse P600S	\N	ATX Mid Tower	Gray / Black	\N	Tinted Tempered Glass	\N	4
Deepcool MATREXX 70 ADD-RGB 3F	\N	ATX Mid Tower	Black	\N	Tempered Glass	54.2	2
NZXT Phantom	\N	ATX Full Tower	White / Black	\N	\N	74.3	7
Topower TP-3030BB-450	\N	MicroATX Mini Tower	Black	450	\N	25.3	4
SHARKOON VS4-W	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	3
MSI MAG SHIELD M301	\N	MicroATX Mini Tower	Black	\N	\N	25	1
Aerocool Viewport Mini V2	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	35	1
Vetroo M05	64.98	MicroATX Mid Tower	White	\N	Tempered Glass	36.3	2
Thermaltake CTE E550	166.99	ATX Mid Tower	Black	\N	Tempered Glass	77.4	3
MagniumGear Neo V2	\N	ATX Mid Tower	Black	\N	Tempered Glass	38.3	2
Silverstone ML09	110.43	HTPC	Black	\N	\N	\N	0
Cougar Duoface Pro RGB	\N	ATX Mid Tower	White	\N	Tempered Glass	55.4	2
Gigabyte C301 GLASS V2	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.6	2
Jonsbo T8 PLUS	\N	Mini ITX Desktop	Black	\N	Tempered Glass	12.5	0
Cooler Master MasterBox MB511	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	2
Corsair Obsidian Series 500D Premium	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	59.4	2
Antec CX300M RGB	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	41.1	2
Cougar Archon 2 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.5	2
HYTE Y60 Ouro Kronii	280	ATX Mid Tower	White / Gold	\N	Tempered Glass	60	2
Thermaltake CTE E550	169.95	ATX Mid Tower	Green / Black	\N	Tempered Glass	77.4	3
CiT S8i	\N	MicroATX Desktop	Black	\N	\N	8.6	1
MSI MPG Sekira 100R	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	42.9	2
DAN Cases A4-SFXv4.1	\N	Mini ITX Desktop	Silver	\N	\N	7.5	0
Corsair Graphite Series 600T	\N	ATX Mid Tower	White / Black	\N	Acrylic	79.3	6
Corsair SPEC-OMEGA RGB	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	3
Chieftec CI-01B-OP	184.88	MicroATX Desktop	Black	\N	\N	33.6	2
In Win A3	69.56	MicroATX Mini Tower	Black	\N	Tempered Glass	29.9	2
MSI MAG VAMPIRIC 300R MIDNIGHT GREEN	\N	ATX Mid Tower	Green	\N	Tempered Glass	54.1	2
KOLINK Stronghold M	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	28.5	2
Aerocool CS-109-G	\N	ATX Mid Tower	Black	\N	Tempered Glass	23.7	2
MagniumGear NEO QUBE 2	\N	ATX Mid Tower	White	\N	Tempered Glass	55.9	2
be quiet! Silent Base 802	\N	ATX Mid Tower	White	\N	\N	83.8	3
Thermaltake CTE T500 Air	\N	ATX Full Tower	Black	\N	Tempered Glass	87.3	4
Thermaltake Level 20 MT	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.7	2
Cooler Master Elite 100	\N	MicroATX Slim	Black	150	\N	5.6	2
NZXT Phantom 410	\N	ATX Mid Tower	White / Black	\N	Acrylic	58.5	6
NZXT S340	\N	ATX Mid Tower	Black / Red	\N	Acrylic	38.4	3
Thermaltake Level 20 XT	\N	ATX Desktop	Black / Silver	\N	Tempered Glass	126.4	6
Aerocool Cylon Mini	\N	MicroATX Mini Tower	Black	\N	Acrylic	\N	2
Cooler Master MasterBox Pro 5 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	53	2
Corsair 480T	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.4	0
SHARKOON QB ONE	159.76	Mini ITX Desktop	Black	\N	Mesh	14.9	2
Antec Performance 1 FT	305.87	ATX Full Tower	White	\N	Tempered Glass	62.7	2
MagniumGear Neo Micro V2	\N	MicroATX Mid Tower	Silver / Black	\N	Tempered Glass	\N	2
SHARKOON MK6 RGB	\N	MicroATX Mid Tower	White	\N	Tempered Glass	43.6	2
Thermaltake Core P6	187.9	ATX Mid Tower	White / Black	\N	Tempered Glass	76.4	4
Fractal Design Meshify 2 Lite	466.15	ATX Mid Tower	White / Black	\N	Tempered Glass	61.7	2
Fractal Design Epoch RGB	129.99	ATX Mid Tower	White	\N	Tempered Glass	45.1	2
be quiet! Pure Base 500	\N	ATX Mid Tower	Gray	\N	Tempered Glass	46	2
Corsair 6500X	199.99	ATX Mid Tower	White / Gray	\N	Tempered Glass	78.3	2
Phanteks Eclipse P200A DRGB	\N	Mini ITX Tower	Black	\N	Tempered Glass	29.9	0
Fractal Design Define 7	\N	ATX Mid Tower	White	\N	Tempered Glass	62.4	6
Corsair Carbide Series 300R	\N	ATX Mid Tower	Black	\N	\N	45.7	4
Corsair Vengeance C70	\N	ATX Mid Tower	Black	\N	Acrylic	61.4	6
Fractal Design Node 605	\N	HTPC	Black	\N	\N	25.5	4
Corsair Carbide Series 270R	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Silverstone SETA A2	199.99	ATX Mid Tower	Black	\N	Tempered Glass	68.7	11
HYTE Watson Amelia Y40	279.99	ATX Mid Tower	Gold / Black	\N	Tempered Glass	49.7	1
SHARKOON VS9	\N	ATX Mid Tower	Black	\N	\N	42.1	2
Deepcool CH780	\N	ATX Full Tower	White	\N	Tempered Glass	72.7	2
Jonsbo U4 Mini	\N	MicroATX Desktop	Black	\N	Tempered Glass	37.6	1
NZXT H7 Elite (2022)	199.99	ATX Mid Tower	\N	\N	Tempered Glass	55.8	2
KOLINK STRONGHOLD	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	\N	3
Fractal Design Define 7 XL Light	\N	ATX Full Tower	Black	\N	Tempered Glass	82	6
Fractal Design Define Mini C TG	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	36.9	2
NZXT S340	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	38.4	3
Cougar PANZER MAX-G	\N	ATX Full Tower	Black	\N	Tempered Glass	90.5	2
MUSETEX ‎TW8-S6 Mesh	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.5	2
Streacom DA6	139	Mini ITX Test Bench	Silver	\N	\N	19.9	4
Antec NX100	\N	ATX Mid Tower	Black / Gray	\N	Acrylic	37.7	2
Antec P20C ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.6	2
Mars Gaming MCZW	\N	MicroATX Mid Tower	White / Black	\N	Tempered Glass	\N	1
Thermaltake Ceres 300 TG ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.9	1
Deepcool CH510 MESH DIGITAL	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.2	2
Deepcool CH560	\N	ATX Mid Tower	White	\N	Tempered Glass	49.6	2
Jonsbo D30	\N	MicroATX Mini Tower	White	\N	Tempered Glass	26.6	1
Zalman Z10 PLUS	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.6	2
Phanteks Evolv X	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	64.9	4
Cooler Master Elite 430	\N	ATX Mid Tower	Black	\N	Acrylic	39.5	5
Raidmax Simplex ATX-618B	\N	MicroATX Mid Tower	Black	\N	\N	43.4	5
Cooler Master Storm Trooper	\N	ATX Full Tower	Black	\N	\N	87.7	8
NZXT H500i	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.3	3
NZXT H7	\N	ATX Mid Tower	Black	\N	Tempered Glass	55.8	2
Aerocool Dryft Mini V2	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	47	1
FormD T1 V2.1 Aluminum Coated	\N	Mini ITX Desktop	Silver	\N	Mesh	\N	0
Montech HS01	89.9	ATX Mid Tower	White	\N	Tempered Glass	55.3	2
Azza Pyramid Mesh	419.99	ATX Mid Tower	Silver / Black	\N	Mesh	140.5	1
HYTE Mori Calliope Y40	349.99	ATX Mid Tower	Black / Red	\N	Tempered Glass	49.7	1
Zalman M2 Mini Silver	\N	Mini ITX Desktop	Silver / Black	\N	Tempered Glass	11.6	0
Azza Legionaire 470	109.99	ATX Mid Tower	Black	\N	Mesh	46.8	2
SHARKOON TG6 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Corsair Carbide Series Air 240	\N	MicroATX Mid Tower	Black	\N	Acrylic	32.8	3
Cooler Master MasterBox Lite 5 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.7	2
In Win A5	105	ATX Mid Tower	Black	\N	Tempered Glass	34.9	2
Thermaltake Tower 900 Snow Edition	\N	ATX Full Tower	White	\N	Tempered Glass	153.6	6
ADATA XPG Battlecruiser II	179.99	ATX Mid Tower	Black	\N	Tempered Glass	62.6	5
Silverstone ML08	136.22	HTPC	Black	\N	Acrylic	\N	0
KOLINK Citadel Mesh RGB	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	34.5	2
be quiet! Silent Base 601	184.35	ATX Mid Tower	Black / Silver	\N	Tempered Glass	\N	3
Cougar MX410 MESH-G RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	36.3	2
Fractal Design Node 202	\N	HTPC	Black	450	\N	11	0
Corsair 5000D	\N	ATX Mid Tower	Black	\N	Tempered Glass	66.2	2
Corsair Carbide Series SPEC-03	\N	ATX Mid Tower	Black / Red	\N	Acrylic	36.1	3
NOX Hummer MC	\N	ATX Mid Tower	Black / Red	\N	Acrylic	43.6	2
YEYIAN Armageddon 2200	\N	ATX Mid Tower	Black	\N	Tempered Glass	44	2
SSUPD Meshroom S V2	\N	MicroATX Mini Tower	White	\N	Mesh	14.9	2
be quiet! Pure Base 501 Airflow	114.9	ATX Mid Tower	White	\N	Tempered Glass	48.1	2
GAMDIAS MARS E2	79.99	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	2
Mars Gaming MC-MPRO	\N	MicroATX Mini Tower	\N	\N	Tempered Glass	29.9	2
CiT MTX-008B	\N	Mini ITX Desktop	Black	300	\N	8.6	1
Asus TUF Gaming GT502 Plus	\N	ATX Mid Tower	White	\N	Tempered Glass	57.2	4
Thermaltake Core P1	\N	Mini ITX Tower	Black	\N	Tempered Glass	53.2	1
Thermaltake The Tower 200	\N	Mini ITX Tower	Pink	\N	Tempered Glass	45.1	2
In Win 101	\N	ATX Mid Tower	White	\N	Tempered Glass	48.3	2
GameMax White Diamond ARGB	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
Cooler Master MasterBox NR200P	\N	Mini ITX Desktop	Pink / White	\N	Tempered Glass	20.3	2
MSI MPG GUNGNIR 120R	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.5	2
Thermaltake Ceres 350 MX	144.98	ATX Mid Tower	Green / Black	\N	Tempered Glass	52.5	1
Antec ISK 110 VESA U3	537.2	Mini ITX Desktop	Black	90	\N	4.1	0
Cougar Duoface RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.6	2
KOLINK Void Rift	\N	ATX Mid Tower	Black	\N	Tempered Glass	38.8	2
Corsair FRAME 5000D RS ARGB	\N	ATX Mid Tower	White	\N	Tempered Glass	75.3	2
Cooler Master Silencio S400	356.98	MicroATX Mini Tower	Black	\N	Tempered Glass	\N	4
Mars Gaming MCM	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	20.5	2
SHARKOON PURE STEEL RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Thermaltake Core W100	\N	ATX Full Tower	Black	\N	Acrylic	\N	10
Cougar Conquer 2	\N	ATX Mid Tower	Black / Orange	\N	Tempered Glass	172.8	2
Thermaltake Core P6	\N	ATX Mid Tower	Green / Black	\N	Tempered Glass	76.4	4
NZXT H210	\N	Mini ITX Tower	Black / Red	\N	Tempered Glass	27.3	1
Corsair Obsidian Series 800D	\N	ATX Full Tower	Black	\N	Acrylic	84.6	2
Raidmax Cyclone	\N	ATX Mid Tower	Black / Red	\N	\N	34.1	5
Cooler Master Cosmos II	\N	ATX Full Tower	Black	\N	\N	160.8	13
Cooler Master MasterBox 5	\N	ATX Mid Tower	Black	\N	Acrylic	52.2	2
Phanteks ECLIPSE G500A Performance	\N	ATX Mid Tower	Black	\N	Tempered Glass	61.8	2
GALAX REV-05	\N	ATX Full Tower	White	\N	Tempered Glass	39.5	2
MagniumGear Neo Air 2	\N	ATX Mid Tower	Black / Brown	\N	Tempered Glass	41.9	2
Aerocool Cipher	186	ATX Mid Tower	Black	\N	\N	48.2	12
Mars Gaming MC-CORE	103.8	MicroATX Mid Tower	Black	\N	Tempered Glass	14.6	3
Azza Elise	69.98	MicroATX Mid Tower	Black / Pink	\N	Tempered Glass	34.4	2
Thermaltake CTE T500	154.98	ATX Full Tower	Black	\N	Tempered Glass	87.3	4
KOLINK Inspire K12 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	35	2
Streacom DA6 XL	\N	Mini ITX Test Bench	Black / Silver	\N	\N	21.5	4
SSUPD Meshroom D	\N	Mini ITX Desktop	White	\N	Mesh	15	3
Fractal Design Define XL R2	\N	ATX Full Tower	Black	\N	\N	72.1	8
Jonsbo D400	\N	ATX Mid Tower	Black	\N	Tempered Glass	59.9	2
Thermaltake The Tower 500	\N	ATX Mid Tower	White	\N	Tempered Glass	93.9	8
Cougar Uniface	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.9	2
NOX Hummer ASTRA	\N	ATX Mid Tower	Black	\N	Tempered Glass	54.7	2
Cooler Master Storm Enforcer	\N	ATX Mid Tower	Black	\N	Acrylic	57.5	6
Phanteks Eclipse P300	\N	ATX Mid Tower	\N	\N	Tinted Tempered Glass	36	2
Silverstone TJ08B-E	155.97	MicroATX Mini Tower	Black	\N	\N	30.2	4
Silverstone CS380	253.2	ATX Mid Tower	Black	\N	\N	45	8
Silverstone FARA H1M	72.89	MicroATX Mini Tower	White	\N	Tempered Glass	30.1	2
Montech HS01 PRO	114.9	ATX Mid Tower	White	\N	Tempered Glass	55.3	2
Geometric Future M4 King Arthur	\N	ATX Mid Tower	Black / Yellow	\N	Tempered Glass	37.9	2
darkFlash J11	79.98	ATX Mid Tower	Black	\N	Tempered Glass	38.7	2
KOLINK UNITY PEAK ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	41	2
Fractal Design Meshify 2 Compact TG Light Tint	\N	ATX Mid Tower	Gray / Black	\N	Tempered Glass	42.3	2
Cooler Master Cosmos C700P Black Edition	\N	ATX Full Tower	Black	\N	Tempered Glass	127.3	2
Thermaltake View 51 ARGB Edition	\N	ATX Full Tower	Black	\N	Tempered Glass	91	2
Fractal Design Ridge PCIe 3.0	\N	Mini ITX Tower	Black	\N	Mesh	16.3	0
Deepcool MATREXX 55	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Antec NX200M RGB	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	30.6	2
eBlaztr eBlaztr	\N	Mini ITX Desktop	Black	\N	Mesh	19.4	0
Thermaltake Core P3 TG Snow Edition	\N	ATX Mid Tower	White	\N	Tempered Glass	80.1	2
Corsair Graphite Series 760T	\N	ATX Full Tower	White	\N	Acrylic	78.8	6
Corsair Carbide Series 88R	\N	MicroATX Mid Tower	Black	\N	Acrylic	\N	2
Corsair Carbide Series SPEC-ALPHA	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	3
NZXT H210i	\N	Mini ITX Tower	Black	\N	Tempered Glass	27.3	1
BitFenix BitFenix Neos Window Side Panel Computer Case, White/Red BFC-NEO-100-WWWKR-RP, ATX/Micro ATX/Mini-ITX Form Factor, Compatible with ATX PSU	\N	ATX Mid Tower	White / Red	\N	Acrylic	37	3
Phanteks Enthoo Pro	\N	ATX Full Tower	Black	\N	\N	68.6	6
Gigabyte AORUS C400	329.02	ATX Mid Tower	Black	\N	Tempered Glass	42.8	2
KOLINK Observatory MX Glass ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	30.8	2
Cooler Master MasterBox MB600L V2	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.7	2
be quiet! Shadow Base 800 DX	147.9	ATX Mid Tower	White	\N	Tempered Glass	70.9	2
Fractal Design Pop Silent	\N	ATX Mid Tower	White	\N	Tempered Glass	46.2	2
SHARKOON VK2 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.5	2
Chieftec BE-10B-300	\N	MicroATX Mini Tower	Black	300	\N	8.8	2
Fractal Design Meshify 2 Compact RGB	\N	ATX Mid Tower	White	\N	Tempered Glass	42.3	2
NZXT H7 Elite (2022)	\N	ATX Mid Tower	\N	\N	Tempered Glass	55.8	2
Deepcool CG540	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.2	2
Jonsbo D31 STD Screen	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	31.3	1
Segotep Phoenix T1	\N	ATX Mid Tower	White	\N	Tempered Glass	65.5	2
APNX V1	\N	ATX Mid Tower	Black	\N	Tempered Glass	70.4	2
Fractal Design Node 304	\N	Mini ITX Tower	White	\N	\N	19.5	6
Antec TORQUE	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	114	1
NOX Hummer Quantum	\N	ATX Mid Tower	Black	\N	Tempered Glass	47.9	2
Thermaltake Level 20 VT	\N	MicroATX Desktop	Black / Silver	\N	Tempered Glass	49.4	3
Fractal Design Arc Midi R2	\N	ATX Mid Tower	Black	\N	Acrylic	55.6	8
NZXT Noctis 450	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	6
NZXT H710i	191.65	ATX Mid Tower	Black / Red	\N	Tempered Glass	58.6	4
Segotep Phoenix	\N	ATX Mid Tower	Black	\N	Tempered Glass	52.9	2
Svive Halo S650	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Lian Li Lancool 170M	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	22.2	1
Aerocool P300C	\N	MicroATX Mini Tower	White	\N	Tempered Glass	49.8	2
KOLINK UNITY CODE X	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Mars Gaming MC-S1	\N	MicroATX Mini Tower	Pink	\N	Acrylic	18.6	1
Lian Li LL01	154.99	ATX Mid Tower	Black	\N	Tempered Glass	49.5	2
Silverstone ML04 Type-C	140.85	HTPC	Black	\N	Mesh	16	2
Thermaltake Versa H24	161	ATX Mid Tower	Black	\N	\N	42.6	3
Azza Cube 802 RGB	379.99	ATX Mid Tower	Black	\N	Tempered Glass	\N	1
Silverstone SUGO 14	\N	Mini ITX Desktop	White	\N	\N	19.5	0
MSI MPG GUNGNIR 110M	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.6	2
Thermaltake Core X71	\N	ATX Full Tower	Black	\N	Acrylic	\N	3
SSUPD Meshroom S w/PCIe 4.0 Riser	\N	ATX Mini Tower	Green	\N	Mesh	14.9	0
Lian Li O11D XL-A	\N	ATX Full Tower	Silver / Black	\N	Tempered Glass	68.9	4
DIYPC V3Plus	\N	Mini ITX Tower	Black	\N	\N	10.5	1
Corsair Carbide Series 600C	\N	ATX Full Tower	Black	\N	Acrylic	63.2	2
Rosewill NAUTILUS	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	3
Enermax StarryFort SF30	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Rosewill CULLINAN V500 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cougar FV270 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	72.7	2
APNX V1	\N	ATX Mid Tower	White / Brown	\N	Tempered Glass	70.4	2
RAIJINTEK Metis Plus	74.9	Mini ITX Tower	White	\N	Acrylic	13.4	2
Silverstone DS380B	221.99	Mini ITX Tower	Black	\N	\N	\N	0
Cooler Master Elite 500 ODD	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.1	2
Fractal Design Torrent Compact	\N	ATX Mid Tower	White	\N	Tempered Glass	46.7	1
Silverstone FARA 512Z	94.46	ATX Mid Tower	Black	\N	Tempered Glass	43.3	2
Thermaltake Ceres 350 MX	139.99	ATX Mid Tower	Blue	\N	Tempered Glass	52.5	1
Armoury D60	\N	ATX Mid Tower	Black	\N	Tempered Glass	59.3	1
Nanoxia NXDS4B	\N	MicroATX Mini Tower	Black	\N	\N	\N	6
LC-Power Gaming 8001B Pro-Storm	\N	ATX Mid Tower	White	\N	Tempered Glass	53.6	2
Gigabyte C301 GLASS	\N	ATX Mid Tower	White	\N	Tempered Glass	50.6	2
NZXT Phantom 820	\N	ATX Full Tower	Black	\N	Acrylic	92.8	6
Cooler Master HAF 912 New	\N	ATX Mid Tower	Black	\N	\N	\N	6
Thermaltake View 31 TG	\N	ATX Mid Tower	Black	\N	Acrylic	63.5	3
be quiet! Dark Base Pro 900 Rev. 2	\N	ATX Full Tower	Black	\N	Tempered Glass	\N	7
Zalman i3	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.8	2
Antec AX20 Elite	\N	ATX Mid Tower	Black	\N	Tempered Glass	33.4	2
Silverstone FARA R1 PRO	91.99	ATX Mid Tower	Black	\N	Tempered Glass	36	1
Geometric Future Model 5 Vent	149.9	ATX Mid Tower	Black	\N	Tempered Glass	53.8	2
In Win F5	149	ATX Full Tower	Black	\N	Tempered Glass	65.1	2
SHARKOON VK3	\N	ATX Mid Tower	Black	\N	\N	40.5	2
Thermaltake View 71 TG	199.99	ATX Full Tower	Black	\N	Acrylic	\N	4
Aerocool Atomic V1	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	36.2	2
Mars Gaming MC-400	\N	MicroATX Mini Tower	White	\N	Tempered Glass	29.9	2
KOLINK Stronghold Prism	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.6	2
Gigabyte C301 GLASS V2	\N	ATX Mid Tower	White	\N	Tempered Glass	50.6	2
Cooler Master MasterBox NR200P	\N	Mini ITX Desktop	Blue	\N	Tempered Glass	20.3	2
iTek Dark Cave DS	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.6	2
Aerocool AirHawk Duo	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Thermaltake Suppressor F31	\N	ATX Mid Tower	Black	\N	\N	\N	3
SSUPD Meshlicious	\N	Mini ITX Tower	White	\N	Tempered Glass	14.7	0
Deepcool CK500 WH	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	49.4	2
Deepcool CC560 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.7	2
Deepcool MATREXX 55 V3 ADD-RGB WH 3F	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
Cougar Airface RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.6	2
Phanteks ECLIPSE P500A	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
iBuypower Element 9 PRO	134.99	ATX Mid Tower	White	\N	Tempered Glass	49.2	2
Cooler Master HAF 922	\N	ATX Mid Tower	Black	\N	\N	71.5	5
darkFlash DLX21 Mesh	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Montech X3 Glass	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Aerocool Prism V1	75.26	ATX Mid Tower	Black	\N	Tempered Glass	41.7	2
Geometric Future Model 5 Vent	149.9	ATX Mid Tower	Black / Yellow	\N	Tempered Glass	53.8	2
In Win ModFree Deluxe	269	ATX Full Tower	Black	\N	Tempered Glass	84.5	1
PC Cooler CPS C3D310 ARGB	\N	MicroATX Mid Tower	White	\N	Tempered Glass	36.6	2
Apevia Prism Elite	105.99	ATX Mid Tower	Black	\N	Tempered Glass	47.9	2
Zalman M4	\N	MicroATX Mini Tower	White	\N	Tempered Glass	34	2
In Win 503	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	4
Antec P120 Crystal	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Zalman Z10	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.6	2
Zalman CHRONIX	\N	ATX Mid Tower	White	\N	Tempered Glass	45.7	2
Thermaltake Versa H22	\N	ATX Mid Tower	Black	\N	\N	42.8	0
Jonsbo D31 STD Screen	\N	MicroATX Mini Tower	White	\N	Tempered Glass	31.3	1
Zalman Z3 Iceberg	\N	ATX Mid Tower	White	\N	Tempered Glass	41.3	2
NZXT H5 Flow Starfield	\N	ATX Mid Tower	White / Blue	\N	Tempered Glass	47	1
Antec CX800 RGB ELITE	\N	ATX Mid Tower	White	\N	Tempered Glass	51.2	2
BitFenix Prodigy	\N	Mini ITX Tower	Black	\N	\N	36	5
NZXT Source 530	\N	ATX Full Tower	Black	\N	Acrylic	60.4	6
EVGA Hadron	\N	Mini ITX Tower	Black	500	Acrylic	14.2	2
Phanteks Enthoo Pro M	\N	ATX Mid Tower	Black	\N	Acrylic	56.4	2
Empire Gaming Warfare	\N	ATX Mid Tower	Black	\N	Acrylic	49.3	2
Vetroo AL600	\N	ATX Mid Tower	Pink	\N	Tempered Glass	41.7	3
Aerocool Falcon V2	\N	ATX Mid Tower	Black	\N	Tempered Glass	33.6	1
Thermaltake Divider 170 TG Snow ARGB	\N	MicroATX Mid Tower	White / Black	\N	Tempered Glass	36.5	2
Apevia Destiny Flow	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
Thermaltake Core P6	\N	ATX Mid Tower	Black	\N	Tempered Glass	76.4	4
Deepcool CH510	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	47.1	2
NOX HUMMER HORUS	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.5	2
Cougar MX600 RGB	\N	ATX Full Tower	White	\N	Tempered Glass	57.8	1
ADATA XPG STARKER AIR	\N	ATX Mid Tower	Black	\N	Tempered Glass	40	2
Corsair Carbide Series 300R Windowed	\N	ATX Mid Tower	Black	\N	Acrylic	45.7	4
Cooler Master N300	\N	ATX Mid Tower	Black	\N	\N	39.5	7
Cooler Master MasterBox MB520 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Fractal Design Meshify S2	\N	ATX Mid Tower	Black	\N	Tempered Glass	58.3	3
Corsair Carbide Series Air 540	\N	ATX Mid Tower	White / Black	\N	Acrylic	62.6	2
In Win 303	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
Corsair Carbide Series 400C	\N	ATX Mid Tower	White	\N	Acrylic	42.4	2
Fractal Design Define R6 USB-C Blackout	\N	ATX Mid Tower	Black	\N	\N	56.7	6
Tecware Nexus	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Rosewill Helium Flow RGB	89.99	ATX Mid Tower	Black	\N	Tempered Glass	50.5	3
Cooler Master MasterBox MB400L with ODD	71.06	MicroATX Mini Tower	Black	\N	\N	35.4	2
Cooler Master Elite 302	81.03	MicroATX Mini Tower	White / Black	\N	Tempered Glass	34.1	1
Silverstone GD07B	230.07	HTPC	Black	\N	\N	33.4	5
Antec Performance 1 SILENT	\N	ATX Full Tower	Black / Silver	\N	\N	62.7	2
Silverstone ALTA G1M	171.13	MicroATX Mid Tower	\N	\N	\N	\N	4
Fractal Design Focus G	\N	ATX Mid Tower	Black / Red	\N	Acrylic	42.2	2
ADATA XPG STARKER AIR	89.99	ATX Mid Tower	Pink	\N	Tempered Glass	40	2
Apevia Prism Elite	105.99	ATX Mid Tower	White	\N	Tempered Glass	47.9	2
Thermaltake View 27	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Deepcool CK560	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
Thermaltake CTE C750 ARGB	184.98	ATX Full Tower	White	\N	Tempered Glass	110.7	7
Cooler Master MasterBox NR200P	\N	Mini ITX Desktop	Orange	\N	Tempered Glass	20.3	2
be quiet! Dark Base 701	239.9	ATX Mid Tower	White	\N	Tempered Glass	73.6	2
KOLINK Citadel Mesh ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.4	2
Cooler Master MasterBox NR200P	\N	Mini ITX Desktop	Purple	\N	Tempered Glass	20.3	2
GAMDIAS ARGUS M1	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.5	2
Cooler Master Silencio 352	\N	MicroATX Mini Tower	Black	\N	\N	\N	2
Thermaltake Chaser MK-I	\N	ATX Full Tower	Black	\N	Acrylic	77.9	6
In Win BQ656T.AD120TBL	\N	Mini ITX Desktop	Black	120	\N	3.3	0
NZXT Phantom 530	\N	ATX Full Tower	White	\N	Acrylic	72.7	6
Corsair Carbide Series 275R	\N	ATX Mid Tower	Black	\N	Acrylic	44.2	2
NZXT H700	\N	ATX Mid Tower	White	\N	Tempered Glass	58.6	2
NZXT H200	\N	Mini ITX Tower	White	\N	Tempered Glass	27.3	1
Phanteks Eclipse P600S	\N	ATX Mid Tower	White / Black	\N	Tinted Tempered Glass	\N	4
Deepcool MACUBE 310	\N	ATX Mid Tower	White	\N	Tempered Glass	45.2	2
Lian Li O11D-PCMR	\N	ATX Full Tower	Black	\N	Tinted Tempered Glass	54	3
SilentiumPC Ventum VT4V EVO TG ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
aigo AZ300	\N	ATX Mid Tower	White	\N	Tempered Glass	49.6	2
GameMax Vista M	\N	MicroATX Mini Tower	White	\N	Tempered Glass	40.9	2
Cougar FV270 RGB	\N	ATX Mid Tower	White	\N	Tempered Glass	72.7	2
SAMA IM01 Pro	\N	MicroATX Mini Tower	White	\N	Tempered Glass	26.1	4
FormD T1 V2.1 Steel Coated	\N	Mini ITX Desktop	Silver	\N	Mesh	\N	0
Asus Prime AP202	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	47.9	2
Chieftec BS-10B-300	167.02	MicroATX Mini Tower	Black	300	\N	14.4	1
Apevia Genesis Pro	79.98	ATX Mid Tower	Black	\N	Tempered Glass	35.7	3
G.Skill Z5i	139.99	Mini ITX Tower	Black	\N	Tempered Glass	24.4	1
Silverstone Precision PS15 RGB	73.15	MicroATX Mid Tower	Black	\N	Tempered Glass	25.7	1
Silverstone CS381B	457.99	MicroATX Desktop	Black	\N	\N	\N	0
Thermaltake H570 TG ARGB	124.98	ATX Mid Tower	White	\N	Tempered Glass	48.8	2
Aerocool Delta	\N	ATX Mid Tower	Black	\N	Tempered Glass	30.3	2
Thermaltake The Tower 250	132.49	Mini ITX Tower	Yellow / Brown	\N	Tempered Glass	42.7	1
Cougar Gemini M	159.43	MicroATX Mini Tower	Black	\N	Tempered Glass	35.7	2
Enermax MarbleShell MS31 RGB	\N	ATX Mid Tower	White	\N	Tempered Glass	41	2
Azza Pyramid Mini 806	339.99	Mini ITX Tower	Silver / Black	\N	Tempered Glass	\N	0
Lian Li TU150	\N	Mini ITX Desktop	Silver	\N	\N	23.8	1
MSI MAG VAMPIRIC 300R	\N	ATX Mid Tower	Black	\N	Tempered Glass	54.1	2
Antec P20C	\N	ATX Mid Tower	White	\N	Tempered Glass	50.6	2
GameMax Spark	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	26.5	1
Aerocool Cronus	119.91	ATX Mid Tower	Black	\N	Tempered Glass	54	3
iTek DARK CAVE	\N	ATX Mid Tower	Black	\N	Tempered Glass	54.7	2
iBuypower Element 9	114.99	ATX Mid Tower	White	\N	Tempered Glass	49.2	2
Fractal Design Node 202	\N	HTPC	Black	450	\N	11	0
Antec Three Hundred Two	\N	ATX Mid Tower	Black	\N	\N	54.9	6
Deepcool TESSERACT BF	\N	ATX Mid Tower	Black / Red	\N	Acrylic	36.4	4
In Win H-Frame 2.0	\N	ATX Full Tower	\N	1065	Tempered Glass	\N	6
Corsair Carbide Series 275Q	\N	ATX Mid Tower	Black	\N	\N	44.1	2
Fractal Design Era ITX	\N	Mini ITX Desktop	Silver / Black	\N	\N	16.7	1
Anidees AI CRYSTAL XL PRO	\N	ATX Full Tower	Black	\N	Tempered Glass	\N	0
CiT S8i-300	\N	MicroATX Desktop	Black	300	\N	8.6	1
In Win DUBILI	\N	ATX Full Tower	Gold / Black	\N	Tempered Glass	72.4	2
Silverstone FTZ01	182.65	Mini ITX Desktop	Black	\N	\N	\N	1
Corsair FRAME 5000D RS	\N	ATX Mid Tower	White	\N	Tempered Glass	75.3	2
HYTE REVOLT 3	249.99	Mini ITX Tower	Black	700	Mesh	18.4	1
Silverstone RVZ02B	118.98	HTPC	Black / Clear	\N	Acrylic	\N	1
Enermax MarbleShell MS31 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	41	2
Zalman S5	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
Fractal Design Meshify 2 XL	\N	ATX Full Tower	Black	\N	Tinted Tempered Glass	81.5	6
MSI MPG SEKIRA 500X	\N	ATX Mid Tower	Black	\N	Tempered Glass	67.1	4
BGears b-Voguish RGB	83.99	ATX Mid Tower	Black	\N	Tempered Glass	40.8	2
Phanteks Evolv Shift 2	\N	Mini ITX Tower	Gray	\N	Tempered Glass	22.8	1
Cooler Master MasterBox K501L RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Corsair Carbide Series SPEC-06	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	\N	2
Aerocool Rift	\N	ATX Mid Tower	Black	\N	Acrylic	36.9	2
NZXT Phantom 530	\N	ATX Full Tower	Red	\N	Acrylic	72.7	6
Phanteks Enthoo Luxe TG	\N	ATX Full Tower	Black	\N	Tinted Tempered Glass	72.4	6
Corsair Carbide Series SPEC-04	\N	ATX Mid Tower	Black / Red	\N	Acrylic	42.8	3
SHARKOON TG5	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	3
Cooler Master MasterCase H500P	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Anidees AI Crystal XL AR	\N	ATX Full Tower	Black	\N	Tempered Glass	86.7	0
Phanteks Evolv X	\N	ATX Mid Tower	Gray	\N	Tinted Tempered Glass	64.9	4
Phanteks Eclipse P600S	\N	ATX Mid Tower	Black	\N	\N	\N	4
Antec TORQUE	\N	ATX Mid Tower	White	\N	Tempered Glass	114	1
Thermaltake S300 Tempered Glass Edition	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Xigmatek Master X	\N	ATX Mid Tower	Black	600	Tempered Glass	\N	2
NZXT H7	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	55.8	2
GAMDIAS ATLAS P1	\N	ATX Mid Tower	Black	\N	Tempered Glass	58.8	2
Chieftec CN-01B-OP	94.15	Mini ITX Desktop	Black	\N	Mesh	13	3
Geometric Future M4 Caliburn	\N	ATX Mid Tower	Black / Silver	\N	Tempered Glass	37.9	2
Cooler Master MasterCase H100	171	Mini ITX Desktop	Black	\N	\N	\N	1
CiT Range	\N	ATX Mid Tower	Black	\N	Tempered Glass	26.8	1
Corsair 5000T	244.99	ATX Mid Tower	White	\N	Tempered Glass	74.5	2
DIYPC MA08	\N	MicroATX Mini Tower	Black	\N	\N	20.5	1
Fractal Design Define Mini	\N	MicroATX Mini Tower	Black	\N	\N	40.5	6
Montech AIR 1000 SILENT	\N	ATX Mid Tower	Black	\N	\N	\N	2
Cooler Master MasterBox 520 Mesh	\N	ATX Mid Tower	White	\N	Tempered Glass	52.5	2
Zalman Z3 Iceberg	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.3	2
Thermaltake Versa N21	\N	ATX Mid Tower	Black	\N	Acrylic	51.5	3
NZXT H440	\N	ATX Mid Tower	Black	\N	Acrylic	53.3	8
Cooler Master Cosmos C700P	\N	ATX Full Tower	Black / Silver	\N	Tempered Glass	127.3	2
Streacom BC1	\N	ATX Test Bench	Black	\N	\N	\N	2
GameMax Centauri	\N	MicroATX Mid Tower	Black / Gray	\N	Acrylic	34.7	2
Xigmatek Athena	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.7	2
Lian Li A4-H20 X3	\N	Mini ITX Desktop	Black	\N	Mesh	11.1	0
Asus TUF Gaming GT501 Demon Slayer Edition	\N	ATX Mid Tower	Yellow / Black	\N	Tempered Glass	75.5	4
GAMDIAS ATHENA M6	\N	ATX Mid Tower	Black	\N	Tempered Glass	45	2
DIYPC ARGB-Q3	\N	MicroATX Mini Tower	White	\N	Tempered Glass	38.6	2
Thermaltake CTE C700 Air	134.98	ATX Mid Tower	White	\N	Tempered Glass	93.8	7
Silverstone SG13	74.27	Mini ITX Tower	Black	\N	\N	11.5	1
YEYIAN Mirage X	280.45	ATX Full Tower	Black	\N	Tempered Glass	60.4	1
Rosewill Helium Flow RGB	89.99	ATX Mid Tower	White	\N	Tempered Glass	50.5	3
be quiet! Pure Base 501 DX	139.9	ATX Mid Tower	White	\N	Tempered Glass	48.1	2
Streacom DA2	288.86	Mini ITX Desktop	Silver	\N	\N	\N	3
NOX Hummer ZX	\N	ATX Mid Tower	Black	\N	Acrylic	48.8	2
Montech Fighter 500	\N	ATX Mid Tower	Black	\N	Tempered Glass	38.6	2
Cooler Master MasterBox MB600L V2 w/ODD	\N	ATX Mid Tower	Black	\N	\N	42.7	2
Zalman Z1 Iceberg	\N	MicroATX Mid Tower	White	\N	Tempered Glass	38.5	2
Thermaltake Core G3	\N	ATX Mid Tower	Black	\N	Acrylic	23.6	2
MagniumGear NEO QUBE 2 Infinity Mirror	\N	ATX Mid Tower	Black	\N	Tempered Glass	55.9	2
MSI MAG FORGE 130A AIRFLOW	\N	ATX Mid Tower	Black	\N	Tempered Glass	43	2
Antec ISK 110 VESA	\N	Mini ITX Desktop	Black / Silver	90	\N	3.7	0
Thermaltake Versa H22	\N	ATX Mid Tower	Black	500	\N	42.8	0
Fractal Design Define R5	\N	ATX Mid Tower	White	\N	\N	54.2	8
Corsair Carbide Series 400R	\N	ATX Mid Tower	Black	\N	\N	53.5	6
Corsair Obsidian Series 350D Window	\N	MicroATX Mid Tower	Black	\N	Acrylic	41.4	2
Fractal Design Arc Mini R2	\N	MicroATX Mini Tower	Black	\N	Acrylic	41.1	6
Enermax OSTROG	\N	ATX Mid Tower	Black / Red	\N	Acrylic	43.8	5
NZXT S340 Razer	\N	ATX Mid Tower	Black / Green	\N	Acrylic	38.4	3
Phanteks Enthoo EVOLV ATX TG	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	\N	5
NZXT H400i	\N	MicroATX Mini Tower	Black / White	\N	Tempered Glass	36.9	1
Lian Li PC-O11 Air	\N	ATX Full Tower	Black	\N	Tempered Glass	60.2	3
Cooler Master MasterBox TD500	\N	ATX Mid Tower	Black	\N	Acrylic	50.1	2
SilentiumPC Signum SG1X TG RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.9	2
Antec CX300 RGB ELITE	\N	ATX Mid Tower	White	\N	Tempered Glass	44.9	2
darkFlash DK415P	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	39.7	2
Fractal Design Core 1000	77.27	MicroATX Mini Tower	Black	\N	\N	26.1	2
Thermaltake Ceres 500	109.66	ATX Mid Tower	White	\N	Tempered Glass	65.3	2
Jonsbo D41 STD Screen	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.4	2
Jonsbo RM2	\N	ATX Mid Tower	Silver	\N	\N	21.5	1
KOLINK Observatory Lite	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	33.4	2
Inter-Tech C-501 Aspect	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	41.1	2
Xilence Xilent X	\N	ATX Mid Tower	\N	\N	Tempered Glass	51.3	2
Asus A23 PLUS	129	MicroATX Mid Tower	Black	\N	Tempered Glass	47.4	2
Cougar MG140 Air RGB	\N	MicroATX Mini Tower	Black / Gray	\N	Tempered Glass	35.3	2
NOX Hummer TGM	\N	ATX Mid Tower	\N	\N	Tempered Glass	36.6	2
NZXT H510i All Might	249.99	ATX Mid Tower	Blue / Red	\N	Tempered Glass	41.3	2
Antec NX200M	\N	MicroATX Mid Tower	White	\N	Tempered Glass	\N	2
ADATA XPG Battlecruiser	160	ATX Mid Tower	Black	\N	Tempered Glass	55.2	2
Cooler Master Elite 502	\N	ATX Mid Tower	Black	\N	Tempered Glass	52.4	2
Lian Li PC-A05N	\N	ATX Mini Tower	Black	\N	\N	39.1	3
DIYPC Alpha-DB6	\N	ATX Test Bench	Black	\N	\N	21.8	0
Zalman Z3 Plus	\N	ATX Mid Tower	Black	\N	Acrylic	38.4	4
Zalman Z1 NEO	\N	ATX Mid Tower	Black	\N	Acrylic	\N	4
Cooler Master MasterBox MB500	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.5	2
Corsair Carbide Series SPEC-06	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
SaharaGaming P35	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Rosewill SPECTRA C100	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Fractal Design Meshify S2	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	58.3	3
Deepcool Matrexx 55 V3	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Jonsbo Jonsplus i100 Pro	\N	Mini ITX Desktop	Black	\N	Tempered Glass	25.9	1
KOLINK Castle	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.4	2
Fractal Design Ridge PCIe 3.0	\N	Mini ITX Tower	White	\N	Mesh	16.3	0
Segotep Phoenix T1	\N	ATX Mid Tower	Black	\N	Tempered Glass	65.5	2
Montech KING 95 PRO	\N	ATX Mid Tower	Pink	\N	Tempered Glass	63	5
Aerocool Viewport Mini V1	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	35	1
Geometric Future Model 6	99.9	ATX Mid Tower	Black / Yellow	\N	Tinted Tempered Glass	43.5	4
GameMax Mini Abyss H608	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	32.3	2
Thermaltake Divider 300 TG	79.98	ATX Mid Tower	Black	\N	Tempered Glass	48.2	2
ADATA XPG DEFENDER	106.84	ATX Mid Tower	Black	\N	Tempered Glass	47.7	2
TRYX LUCA L70	249.99	ATX Mid Tower	White	\N	Tempered Glass	80.9	0
MSI MAG PANO 120R PZ	235.4	ATX Mid Tower	Black	\N	Tempered Glass	70.2	2
Cougar Archon 2 RGB	\N	ATX Mid Tower	White	\N	Tempered Glass	37.5	2
Silverstone ALTA G1M	183.71	MicroATX Mid Tower	White	\N	\N	\N	4
Fractal Design Define 7 Compact	\N	ATX Mid Tower	White	\N	Tempered Glass	42.5	2
KOLINK Unity Lateral ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.4	2
KOLINK Big Chungus UNIT	\N	ATX Full Tower	Black	\N	Tempered Glass	146.1	2
Cooler Master MasterBox 540	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
KOLINK Inspire K11 ARGB	\N	ATX Mid Tower	\N	\N	Tempered Glass	32.1	2
Corsair Carbide Series 500R	\N	ATX Mid Tower	White / Black	\N	\N	54.2	6
Rosewill Zircon I	189.99	ATX Mid Tower	Black	\N	Tempered Glass	43.4	2
Cooler Master HAF 700	\N	ATX Full Tower	White	\N	Tempered Glass	83.6	9
APNX Creator C1 ChromaFlair	\N	ATX Mid Tower	Purple / Blue	\N	Tempered Glass	53.6	3
Corsair Carbide Series Air 240	\N	MicroATX Mid Tower	White	\N	Acrylic	32.8	3
Deepcool MATREXX 50 MESH 4FS	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.5	2
Thermaltake S250 TG ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.4	2
Apex MW-107V	\N	Mini ITX Tower	Black / White	60	\N	2.9	0
Rosewill BLACKHAWK	\N	ATX Mid Tower	Black	\N	Acrylic	55.1	6
Corsair Obsidian Series 550D	\N	ATX Mid Tower	Black	\N	\N	57.7	6
Zalman Z11	\N	ATX Mid Tower	Black	\N	Acrylic	68	5
NZXT H630	\N	ATX Full Tower	White	\N	\N	\N	8
Lian Li PC-A79	\N	ATX Full Tower	Silver	\N	\N	\N	6
Cooler Master CM Storm Scout 2 Advanced	\N	ATX Mid Tower	Black	\N	Acrylic	61.6	7
NZXT H440	\N	ATX Mid Tower	Black / Green	\N	Acrylic	53.3	8
In Win 303	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cooler Master CM 590 III	\N	ATX Mid Tower	Black	\N	Acrylic	45.1	4
NZXT H200i	\N	Mini ITX Tower	White / Black	\N	Tempered Glass	27.3	1
Cooler Master MasterCase H500P Mesh	\N	ATX Mid Tower	White	\N	Acrylic	71.4	2
darkFlash DLM 21 Mesh	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	32.1	2
In Win Chopin Pro	\N	HTPC	Black	200	Mesh	4.4	0
GALAX REV-06 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.5	2
GameMax Black Hole	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.7	2
GAMDIAS NESO P1 PRO	\N	ATX Full Tower	White	\N	Tempered Glass	75.2	2
Antec GX700	208.44	ATX Mid Tower	Black	\N	\N	44.9	5
Antec P10 FLUX	106.99	ATX Mid Tower	Black	\N	\N	\N	3
Thermaltake CTE E660 MX	184.98	ATX Mid Tower	Blue / White	\N	Tempered Glass	77.4	3
BGears ‎b-BlackWidow-RGB	85.47	ATX Mid Tower	Black	\N	Tinted Tempered Glass	41.2	2
SHARKOON S1000	\N	MicroATX Mini Tower	Black	\N	\N	35.5	2
CiT S015B	\N	MicroATX Desktop	Black	300	\N	11.9	2
In Win 301	\N	MicroATX Mini Tower	Black / Red	\N	Tempered Glass	28.1	1
In Win A1 Plus	\N	Mini ITX Tower	White	650	Tempered Glass	21.8	0
Fractal Design Define S	\N	ATX Mid Tower	Black	\N	Acrylic	57.7	3
Antec NX400	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.5	2
Jonsbo V9	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	17.6	1
Thermaltake Core V71	\N	ATX Full Tower	Black	\N	Acrylic	75.3	8
Jonsbo D40	\N	ATX Mid Tower	Black	\N	Tempered Glass	31.6	3
Thermaltake V3 Black Edition	\N	ATX Mid Tower	Black	\N	Acrylic	38.5	4
Zalman Z11 Plus	\N	ATX Mid Tower	Black	\N	Acrylic	68	5
Cooler Master N200	\N	MicroATX Mini Tower	Black	500	\N	33.8	2
NZXT H700i	\N	ATX Mid Tower	Black	\N	Tempered Glass	58.6	2
Cooler Master MasterBox TD500 Mesh White w/o Controller	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
Cougar MG120 G	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	\N	2
darkFlash DLX21 Mesh	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
Lian Li A4-H20 A3	\N	Mini ITX Desktop	Silver / Black	\N	Mesh	11.1	0
Ocelot OGEC02	\N	ATX Mid Tower	Black	\N	Tempered Glass	35	2
SSUPD Meshroom S	\N	ATX Mini Tower	Green	\N	Mesh	14.9	0
darkFlash Space	\N	ATX Desktop	Black	\N	Tempered Glass	48.6	2
SAMA AR01-RGB	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	46.2	2
DIYPC ARGB-Q1.V2	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	\N	1
Chieftec UK-02B-OP	155.09	ATX Mid Tower	Black	\N	\N	29.6	2
Thermaltake Ceres 350 MX	144.98	ATX Mid Tower	Green	\N	Tempered Glass	52.5	1
Thermaltake View 270	\N	ATX Mid Tower	Blue	\N	Tempered Glass	47.6	2
Apevia Destiny Pro	81.99	ATX Mid Tower	White / Black	\N	Tempered Glass	42	2
Thermaltake Ceres 350 MX	119.99	ATX Mid Tower	White	\N	Tempered Glass	52.5	1
YEYIAN Hussar Plus	\N	ATX Mid Tower	Black	\N	Tempered Glass	33.5	1
Silverstone PS15	74.56	MicroATX Mid Tower	White	\N	Tempered Glass	25.7	1
Silverstone FARA 511Z	103.99	ATX Mid Tower	Black	\N	Tempered Glass	42.9	2
Antec NX210	\N	ATX Mid Tower	Black	\N	Tempered Glass	36.9	1
Streacom DA2 V2	259.99	Mini ITX Desktop	Silver	\N	\N	17.5	0
Fractal Design Torrent	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	69.8	2
HYTE Y60 Hakos Baelz	280	ATX Mid Tower	Black / Red	\N	Tempered Glass	60	2
Montech KING 95	\N	ATX Mid Tower	Blue / Black	\N	Tempered Glass	63	5
Thermaltake Core P3	\N	ATX Mid Tower	Red	\N	Tempered Glass	80.1	2
Lazer3D LZX-8 Stealth	\N	Mini ITX Desktop	Black	\N	\N	8.6	0
Fractal Design Define Mini C	\N	MicroATX Mid Tower	Black	\N	Acrylic	35.7	2
Phanteks Enthoo EVOLV TG	\N	MicroATX Mini Tower	Black	\N	Tinted Tempered Glass	41.7	2
NZXT H700	\N	ATX Mid Tower	Black	\N	Tempered Glass	58.6	2
Corsair 110Q	\N	ATX Mid Tower	Black	\N	\N	\N	2
Fractal Design Define 7 Compact	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	42.5	2
GameMax Nova N6	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.6	2
Cooler Master HAF 932	\N	ATX Full Tower	Black	\N	Acrylic	76.7	5
Fractal Design Define R3	\N	ATX Mid Tower	Black	\N	\N	47.5	8
Linkworld 617-03-c2228U	\N	MicroATX Slim	Black / Silver	400	\N	16.2	1
be quiet! Silent Base 801	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	5
Montech Air 900 MESH	\N	ATX Mid Tower	Black	\N	Tempered Glass	44	2
Thermaltake Level 20 HT	\N	ATX Full Tower	Black	\N	Tempered Glass	144.3	4
Fractal Design Era ITX	\N	Mini ITX Desktop	Blue / Black	\N	Tinted Tempered Glass	16.7	1
Antec Dark Phantom DP502 Flux	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.5	3
ABKONCORE C750	\N	ATX Mid Tower	Black	\N	Tempered Glass	32.3	2
Lian Li LANCOOL 205M	\N	MicroATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
Geometric Future Model 5 Vent Fanless	109.9	ATX Mid Tower	Black	\N	Tempered Glass	53.8	2
Montech AIR 1000 LITE	\N	ATX Mid Tower	White	\N	Tempered Glass	45.3	2
ADATA XPG DEFENDER	96.74	ATX Mid Tower	White / Black	\N	Tempered Glass	47.7	2
Streacom DA6	\N	Mini ITX Test Bench	Black / Silver	\N	\N	19.9	4
Inter-Tech IM-2 Expander	\N	MicroATX Mid Tower	Black	\N	Mesh	30.7	6
Deepcool MACUBE 110	\N	MicroATX Mini Tower	Pink	\N	Tempered Glass	38.8	2
Fractal Design Core 2500	\N	ATX Mid Tower	Black	\N	\N	37.8	4
Cooler Master Masterbox 520	\N	ATX Mid Tower	Black	\N	Tempered Glass	52.5	2
Cougar FV270	\N	ATX Mid Tower	Black	\N	Tempered Glass	72.7	2
Corsair Crystal Series 280X	\N	MicroATX Mid Tower	White	\N	Tempered Glass	\N	2
Inter-Tech X-908 Infini2	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Rosewill CHALLENGER	\N	ATX Mid Tower	Black	\N	\N	38.4	5
In Win BL631.300TBL	\N	MicroATX Slim	Black	300	\N	11.6	2
Corsair Obsidian Series 650D	\N	ATX Mid Tower	Black	\N	Acrylic	64.7	5
Fractal Design Define XL	\N	ATX Full Tower	Black	\N	\N	72.6	10
Xigmatek Elysium Black Server Edition	\N	ATX Full Tower	Black	\N	\N	93.9	8
Rosewill THOR V2	\N	ATX Full Tower	White / Black	\N	\N	74.8	6
Silverstone Black Grandia GD01B-MXR-USB3.0	\N	HTPC	Black	\N	\N	31.2	6
NZXT Phantom 240	\N	ATX Mid Tower	Black / White	\N	Acrylic	\N	6
Lian Li PC-A51	\N	ATX Mini Tower	Black	\N	Acrylic	\N	5
BitFenix Nova	\N	ATX Mid Tower	Black	\N	\N	\N	4
In Win Chopin	\N	HTPC	Black	150	\N	\N	0
Thermaltake Core X5	\N	ATX Desktop	Black	\N	Acrylic	92.8	4
Phanteks Eclipse P400S	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	45.9	2
Cooler Master Trooper SE	\N	ATX Full Tower	Black / Red	\N	Tempered Glass	87.7	2
Montech AIR X Black	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Montech AIR X White	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
Cooler Master MasterBox NR600P	\N	ATX Mid Tower	Black	\N	\N	\N	3
GAMDIAS ARGUS E4 ELITE WH	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
Asus TUF Gaming GT301 ZAKU II EDITION	\N	ATX Mid Tower	Red / Black	\N	Tempered Glass	43.9	2
GAMDIAS ATHENA M6	\N	ATX Mid Tower	White	\N	Tempered Glass	45	2
Lian Li O11 Air Mini Glass	\N	ATX Mid Tower	White	\N	Tempered Glass	44.2	4
APNX V1	\N	ATX Mid Tower	White	\N	Tempered Glass	70.4	2
KOLINK Inspire K9	\N	ATX Mid Tower	Black	\N	Tempered Glass	30.8	2
Jonsbo D41 STD	\N	ATX Mid Tower	White	\N	Tempered Glass	35.4	2
Montech KING 95	\N	ATX Mid Tower	Red / Black	\N	Tempered Glass	63	5
Thermaltake Divider 200 TG Air Snow	149.96	MicroATX Mini Tower	White	\N	Tempered Glass	51.6	3
Silverstone FARA H1M PRO	91.97	MicroATX Mini Tower	White / Black	\N	Tempered Glass	30.1	2
Antec NX416L	\N	ATX Mid Tower	White	\N	Tempered Glass	49.9	2
In Win IW-MS04	148.86	Mini ITX Desktop	Black	\N	\N	\N	4
Thermaltake Divider 370 TG Snow ARGB	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	50.7	2
Chieftec BU-12B-300	\N	Mini ITX Tower	Black	300	\N	7.5	1
KOLINK INSPIRE K5 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	37	2
Zalman S4 Plus	\N	ATX Mid Tower	Black	\N	Tinted Acrylic	\N	2
ENDORFY Signum 300 Core	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.9	2
be quiet! Silent Base 601	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Thermaltake CTE C750 Air ARGB	\N	ATX Full Tower	Black	\N	Tempered Glass	110.7	7
Silverstone PM02-G	158.71	ATX Mid Tower	Black / Red	\N	Tempered Glass	49.3	3
Cougar Purity RGB	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	28.2	2
KOLINK Horizon	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.9	2
Aerocool Graphite v2	\N	ATX Mid Tower	\N	\N	Tempered Glass	43	2
Thermaltake V250 TG ARGB Air	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.4	2
SSUPD Meshroom D	\N	Mini ITX Desktop	Gray	\N	Mesh	15	3
Zalman Z1	\N	ATX Mid Tower	Black	\N	\N	\N	4
Corsair Carbide Series 678C	\N	ATX Mid Tower	Black	\N	Tempered Glass	65.2	6
Deepcool E-Shield	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.9	2
GAMDIAS TALOS E1	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	25.3	1
Fractal Design Meshify 2 Lite RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	61.7	2
NZXT Phantom	\N	ATX Full Tower	Black	\N	\N	74.3	7
Cooler Master Storm Trooper	\N	ATX Full Tower	Black / Silver	\N	Acrylic	87.7	8
MSI Blitz	\N	ATX Mid Tower	Black / Blue	650	Acrylic	76.1	5
Corsair Carbide Series 200R	\N	ATX Mid Tower	Black	\N	Acrylic	44.8	4
be quiet! Silent Base 800	\N	ATX Mid Tower	Black	\N	\N	\N	7
Corsair Graphite Series 760T	\N	ATX Full Tower	Black / Red	\N	Acrylic	78.8	6
Zalman Z9 NEO	\N	ATX Mid Tower	Black	\N	Acrylic	\N	4
EVGA DG-86	\N	ATX Full Tower	Gray	\N	Acrylic	\N	8
NZXT S340	\N	ATX Mid Tower	White / Purple	\N	Acrylic	38.4	3
Cooler Master MasterBox Lite 3.1	\N	MicroATX Mid Tower	Black	\N	Acrylic	36.1	2
Phanteks Enthoo EVOLV ITX TG	\N	Mini ITX Desktop	Black	\N	Tinted Tempered Glass	34.1	2
Raidmax Vortex	\N	ATX Mid Tower	Black	\N	Acrylic	42.4	3
Corsair Carbide Series SPEC OMEGA	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	\N	3
Segotep SG-K8	\N	ATX Mid Tower	Black	\N	Acrylic	53.5	2
In Win 101	\N	ATX Mid Tower	White / Pink	\N	Tempered Glass	48.3	2
Phanteks Eclipse P350X	\N	ATX Mid Tower	Black / White	\N	Tinted Tempered Glass	41	2
Mars Gaming MC7	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Tecware Nexus M	\N	MicroATX Mid Tower	Black / White	\N	Tempered Glass	\N	2
Cooler Master MasterBox NR600 (w/ODD)	\N	ATX Mid Tower	Black	\N	Tempered Glass	47.3	4
NZXT H210i	\N	Mini ITX Tower	Black / Red	\N	Tempered Glass	27.3	1
Apevia CRUSADER-F-PK	\N	ATX Mid Tower	Pink	\N	Tempered Glass	\N	2
In Win B1	\N	Mini ITX Desktop	Black	200	\N	\N	0
Azza Pyramid L	\N	ATX Mid Tower	Gray / Black	\N	Tempered Glass	\N	1
OCPC MINI	\N	Mini ITX Test Bench	White	\N	\N	7.2	0
Chieftec SCORPION 3	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.3	2
YEYIAN Lancer	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.1	2
Raidmax Infinita i600	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	43.8	2
APNX V1	\N	ATX Mid Tower	Multicolor	\N	Tempered Glass	70.4	2
darkFlash DPW90M	\N	MicroATX Mid Tower	White	\N	Tempered Glass	48.5	2
Segotep T3 Aeolus	\N	ATX Mid Tower	Black	\N	Tempered Glass	54.4	3
Ocypus Gamma C70 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.3	2
Thermaltake CTE C700 TG ARGB	110.49	ATX Mid Tower	White	\N	Tempered Glass	93.8	7
RAIJINTEK Ponos Ultra MS4	79.98	ATX Mid Tower	Black	\N	Tempered Glass	46.3	2
Jonsbo D32 STD	\N	MicroATX Desktop	White	\N	Tempered Glass	25.7	1
Enermax MarbleShell MS21 RGB	\N	MicroATX Mid Tower	White	\N	Tempered Glass	33.8	2
Silverstone SUGO 17	216.37	MicroATX Desktop	White	\N	Mesh	26.1	1
Thermaltake The Tower 300	159.99	MicroATX Mini Tower	Pink / Blue	\N	Tempered Glass	53	3
Jonsbo Jonsplus i100 Pro	\N	Mini ITX Desktop	Silver	\N	\N	25.9	1
Jonsbo MOD-3	\N	ATX Mid Tower	White	\N	Tempered Glass	93.1	1
Cougar Uniface RGB	\N	ATX Mid Tower	White	\N	Tempered Glass	53.9	2
Thermaltake Versa H26	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Fractal Design Define R5	\N	ATX Mid Tower	Silver	\N	\N	54.2	8
Thermaltake View 37	\N	ATX Mid Tower	Black	\N	Acrylic	73.7	3
Antec Three Hundred	\N	ATX Mid Tower	Black	\N	\N	43.5	6
Zalman Z9 Plus	\N	ATX Mid Tower	Black	\N	Acrylic	48.3	5
Thermaltake Level 10 GT	\N	ATX Full Tower	White / Black	\N	Acrylic	97.2	5
Cooler Master Silencio 550	\N	ATX Mid Tower	Black	\N	\N	47.9	7
NZXT H440	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	53.3	8
Deepcool TESSERACT BF	\N	ATX Mid Tower	Black / Blue	\N	\N	36.4	4
Zalman Z11 NEO	\N	ATX Mid Tower	Black	\N	Acrylic	\N	6
Corsair Carbide 600Q	\N	ATX Full Tower	Black	\N	\N	63.2	2
FSP Group CMT210	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	39.7	3
Thermaltake Versa N21	\N	ATX Mid Tower	White / Black	\N	Acrylic	51.5	3
Lazer3D LZ7-v1	\N	Mini ITX Desktop	Black	\N	\N	7.1	0
Thermaltake Core X5 TG	\N	ATX Desktop	Black	\N	Tempered Glass	92.8	4
NZXT H500i	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	41.3	3
Phanteks Eclipse P300	\N	ATX Mid Tower	\N	\N	Tinted Tempered Glass	36	2
In Win D-Frame 2.0	\N	ATX Full Tower	Black / Gold	1065	Tempered Glass	\N	4
Antec NX310	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.5	2
SilentiumPC Regnum RG4T	\N	ATX Mid Tower	Black	\N	Tempered Glass	46.8	3
NZXT Cyberpunk 2077 H710i	\N	ATX Mid Tower	Red / Black	\N	Tempered Glass	58.6	4
BitFenix NOVA MESH SE TG	\N	ATX Mid Tower	Black	\N	Tempered Glass	36.1	2
Thermaltake The Tower 100	\N	Mini ITX Tower	Green / Black	\N	Tempered Glass	32.7	2
Jonsbo C6 Handle	\N	MicroATX Mini Tower	White	\N	Mesh	15.9	1
Antec NX500M	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	34.6	2
Frontier Technology Trendsonic Amalthea AM20A-1	\N	ATX Mid Tower	Black	\N	Tempered Glass	33.7	2
Armoury C802	\N	ATX Mid Tower	White	\N	Tempered Glass	51.4	2
Mars Gaming MC-CORE	\N	MicroATX Mid Tower	White	\N	Tempered Glass	14.6	3
Chieftec BT-02B-U3-250VS (230V)	165.78	Mini ITX Tower	\N	250	\N	9.6	1
Silverstone PS15 PRO	192.49	MicroATX Mid Tower	Black	\N	Tempered Glass	25.7	1
Cougar MX330-F	86.84	ATX Mid Tower	Black	\N	Acrylic	39.4	2
Asus TUF Gaming GT301	229.99	ATX Mid Tower	Pink / Black	\N	Tempered Glass	43.9	2
Fractal Design Focus G	\N	ATX Mid Tower	Black / Gray	\N	Acrylic	42.2	2
ADATA XPG DEFENDER PRO	\N	ATX Mid Tower	Black	\N	Tempered Glass	47.7	2
KOLINK Rocket Heavy	\N	Mini ITX Desktop	Black	\N	Tempered Glass	16.7	1
SHARKOON VG7-W RGB	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
In Win Chopin MAX	\N	Mini ITX Desktop	Silver	200	Mesh	4.4	0
SHARKOON Rebel C50 RGB	481.35	ATX Mid Tower	Black	\N	Tempered Glass	52.4	3
FSP Group CUT593A	\N	ATX Full Tower	Black	\N	Tempered Glass	62.6	3
Aerocool Trinity Mini V3	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	28.1	2
Cougar Duoface RGB	122	ATX Mid Tower	White	\N	Tempered Glass	43.6	2
Geometric Future Model 8	\N	ATX Mid Tower	Black / Silver	\N	Tinted Tempered Glass	57.5	3
Phanteks Enthoo Series Primo Aluminum	\N	ATX Full Tower	Black	\N	Acrylic	96.8	6
Cooler Master MasterBox Pro 5 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	53	2
Cougar MX430 Air RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.6	2
Thermaltake H570 TG ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	48.8	2
Antec Twelve Hundred	\N	ATX Full Tower	Black	\N	Acrylic	63.5	9
Apevia X-FIT-100	\N	Mini ITX Tower	Black	250	\N	4.7	0
Corsair Vengeance C70	\N	ATX Mid Tower	White / Black	\N	Acrylic	61.4	6
Corsair Graphite Series 600T	\N	ATX Mid Tower	Silver / Black	\N	Acrylic	79.3	6
Cooler Master HAF XB	\N	ATX Desktop	Black	\N	\N	61.7	0
Cooler Master Elite 350	\N	ATX Mid Tower	Black	500	\N	33	6
Cooler Master HAF Stacker 935	\N	ATX Full Tower	Black	\N	Acrylic	96.9	9
NZXT Phantom 630	\N	ATX Full Tower	White	\N	Acrylic	92	6
Phanteks Mini XL	\N	MicroATX Desktop	Black	\N	Acrylic	\N	6
Phanteks Enthoo EVOLV ATX TG	\N	ATX Mid Tower	Silver	\N	Tinted Tempered Glass	\N	5
be quiet! Dark Base 900	\N	ATX Full Tower	Black	\N	\N	82	7
Rosewill TYRFING	\N	ATX Mid Tower	Black	\N	Acrylic	44	3
Corsair Carbide Series 270R	\N	ATX Mid Tower	Black	\N	\N	\N	2
Cougar Panzer	\N	ATX Mid Tower	Black	\N	Tempered Glass	61.1	2
Cooler Master MasterBox Pro 5	\N	ATX Mid Tower	Black	\N	Tempered Glass	53	2
Corsair Carbide Series 275R	\N	ATX Mid Tower	White	\N	Acrylic	44.2	2
NZXT H400	\N	MicroATX Mini Tower	White	\N	Tempered Glass	36.9	1
Lian Li LANCOOL ONE Digital	\N	ATX Mid Tower	Gold / White	\N	Tempered Glass	46.7	2
Antec NX600	\N	ATX Mid Tower	Black	\N	Tempered Glass	46.8	2
MagniumGear Neo Air	\N	ATX Mid Tower	\N	\N	Tempered Glass	41.4	2
SilentiumPC Regnum RG6V TG	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
AQIRYS Bellatrix	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	0
Jonsbo Jonsplus i100 Pro	\N	Mini ITX Desktop	Silver / Black	\N	Tempered Glass	25.9	1
CiT Blaze Red	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	31.4	2
Deepcool CC560 Limited	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.7	2
Tecware Forge M2	\N	MicroATX Mid Tower	Black / White	\N	Tempered Glass	27.3	2
Vetroo M05	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	36.3	2
SAMA AR01-RGB	\N	MicroATX Mini Tower	White	\N	Tempered Glass	46.2	2
DARKROCK A8-M	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
MagniumGear Neo V2	\N	ATX Mid Tower	Silver	\N	Tempered Glass	38.3	2
Montech SKY ONE LITE	119.95	ATX Mid Tower	Black	\N	Tempered Glass	44.8	2
be quiet! Pure Base 501 LX	154.9	ATX Mid Tower	White	\N	Tempered Glass	48.1	2
GameMax Silent	\N	ATX Mid Tower	Black	\N	\N	51.1	2
SHARKOON Rebel C70M RGB	\N	ATX Mid Tower	Brown / Black	\N	Mesh	54.5	3
SHARKOON VS9 RGB	342.8	ATX Mid Tower	White	\N	Tempered Glass	42.1	2
GameMax Spark Pro	\N	ATX Mid Tower	Black	\N	Tempered Glass	33.5	1
Silverstone FARA R1 PRO V2	\N	ATX Mid Tower	White	\N	Tempered Glass	40.1	2
Aerocool Menace Saturn RGB	88.11	ATX Mid Tower	Black	\N	Tempered Glass	36.7	2
Silverstone RL08BR-RGB	\N	MicroATX Mini Tower	Black / Red	\N	Tempered Glass	\N	3
darkFlash LEO	\N	ATX Mid Tower	Black	\N	Tempered Glass	30.9	2
Aerocool Aero One Mini Eclipse	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	\N	2
Fractal Design Meshify 2 Compact Lite	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	42.3	2
Zalman i3 Edge	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.8	2
Cougar MX600 Mini RGB	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	47.1	2
Antec P7 Silent	\N	ATX Mid Tower	Black / Silver	\N	\N	\N	2
Tempest Shade RGB	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
KOLINK Void	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
Aerocool Prism V3 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.7	2
Thermaltake Versa H15	192	MicroATX Mid Tower	Black	\N	Acrylic	\N	3
Cooler Master MasterBox 5	\N	ATX Mid Tower	White	\N	Acrylic	52.2	2
Thermaltake V100	\N	ATX Mid Tower	Black	500	\N	36.6	2
MSI MPG GUNGNIR 100D	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	60.8	2
Cougar Cratus	\N	ATX Mid Tower	Black	\N	Tempered Glass	114.3	2
Thermaltake V4 Black Edition	\N	ATX Mid Tower	Black	\N	Acrylic	38.6	4
Thermaltake Level 10 GT	\N	ATX Full Tower	Black	\N	Acrylic	97.2	5
Lian Li PC-Q25B	\N	Mini ITX Tower	Black	\N	\N	20.2	7
Corsair Graphite Series 380T	\N	Mini ITX Tower	Black / Red	\N	\N	41	2
Corsair Carbide Series SPEC-ALPHA	\N	ATX Mid Tower	White / Red	\N	Acrylic	\N	3
Corsair Carbide Series Air 740	\N	ATX Full Tower	Black	\N	Acrylic	73.9	3
Corsair Crystal 460X RGB	\N	ATX Mid Tower	White	\N	Tempered Glass	44.9	2
Corsair Crystal 570X RGB Mirror Black	\N	ATX Mid Tower	Black	\N	Tempered Glass	57.5	2
NZXT H700i Ninja	\N	ATX Mid Tower	Blue / Yellow	\N	Tempered Glass	58.6	2
be quiet! Dark Base Pro 900 Rev. 2	\N	ATX Full Tower	Silver / Black	\N	Tempered Glass	\N	7
In Win A1 Plus	\N	Mini ITX Tower	Black	650	Tempered Glass	21.8	0
Xigmatek Nemesis M	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	26.7	2
SSUPD Meshlicious	\N	Mini ITX Tower	Black	\N	Tempered Glass	14.7	0
Azza Celesta 340	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.2	2
CiT RAIDER RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.8	2
Jonsbo VR3	\N	Mini ITX Tower	Black	\N	Mesh	19.9	0
In Win DUBILI	\N	ATX Full Tower	Gray / Orange	\N	Tempered Glass	72.4	2
RAIJINTEK METIS EVO TGS	81.23	Mini ITX Desktop	White	\N	Tempered Glass	22.3	2
RAIJINTEK Ponos Ultra TG4	88.99	ATX Mid Tower	White	\N	Tempered Glass	46.3	2
DIYPC DIY-S08	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	33.2	2
GameMax N80	116.99	ATX Mid Tower	Black	\N	Tempered Glass	56	1
Aerocool Graphite	\N	ATX Mid Tower	\N	\N	Tempered Glass	43	2
Chieftec APEX Q	\N	ATX Mid Tower	Black	\N	\N	52.9	2
Cooler Master MasterFrame 600	291.97	ATX Mid Tower	Silver	\N	Tempered Glass	61.2	2
Jonsbo MOD5	\N	ATX Mid Tower	Black	\N	Tempered Glass	97.2	1
KOLINK Unity Arena ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.2	2
FSP Group CUT593P	\N	ATX Full Tower	Black	\N	Tempered Glass	62.6	3
Montech KING 95 ULTRA	\N	ATX Mid Tower	Silver / Black	\N	Tempered Glass	63	5
Jonsbo D40	\N	ATX Mid Tower	White	\N	Tempered Glass	31.6	3
KOLINK Nimbus	\N	ATX Mid Tower	Black	\N	Tempered Glass	34.2	2
Phanteks Evolv Shift 2	\N	Mini ITX Tower	Black	\N	Tempered Glass	22.8	1
MSI MAG VAMPIRIC 010X	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.9	2
Cougar Conquer	\N	ATX Mid Tower	Black / Orange	\N	Tempered Glass	101.3	3
MSI MAG FORGE 111R	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.5	2
Cooler Master Elite 310	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	39.1	6
Corsair Obsidian Series 700D	\N	ATX Full Tower	Black	\N	\N	84.6	6
NZXT Source 210 Elite	\N	ATX Mid Tower	Black	\N	\N	42.4	8
Cooler Master Elite 431 Plus	\N	ATX Mid Tower	Black	\N	Acrylic	40.4	5
Cooler Master Elite 342	\N	MicroATX Mini Tower	Black	400	\N	27.9	5
Corsair Obsidian Series 350D	\N	MicroATX Mid Tower	Black	\N	\N	41.4	2
Corsair Graphite Series 230T	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	\N	4
Zalman ZM-T3	\N	MicroATX Mini Tower	Black	\N	\N	\N	2
Deepcool KENDOMEN	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	3
Cooler Master Cosmos II	\N	ATX Full Tower	Black / Silver	\N	Tinted Tempered Glass	160.8	13
DAN Cases A4 SFX	\N	Mini ITX Desktop	Black	\N	\N	\N	0
NZXT H500	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	41.3	3
darkFlash Phantom	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
NOX Hummer TG RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Cooler Master MasterCase H500P Mesh	\N	ATX Mid Tower	Black	\N	Tempered Glass	71.4	2
SHARKOON TG5	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Aerocool Scar	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Deepcool CL500	\N	ATX Mid Tower	Black / Silver	\N	Tempered Glass	55.5	2
BitFenix NOVA MESH SE TG	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	36.1	2
Antec DP503	\N	ATX Mid Tower	Black	\N	Tempered Glass	52.3	2
Deepcool CC560 Limited	\N	ATX Mid Tower	White	\N	Tempered Glass	41.7	2
Vetroo AL700	\N	ATX Mid Tower	Black	\N	Tempered Glass	48.1	1
GALAX REV-06 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.5	2
1STPLAYER T3	\N	MicroATX Mid Tower	White	\N	Tempered Glass	32.4	2
Ocypus Iota C70 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	48.6	2
KOLINK Big Chungus Hench	\N	ATX Mid Tower	Black	\N	Tempered Glass	77.3	1
Silverstone SETA A2	197.99	ATX Mid Tower	White	\N	Tempered Glass	68.7	11
Silverstone Sugo 16	100.1	Mini ITX Tower	White	\N	\N	13	1
Geometric Future Model 5 Fanless	119.9	ATX Mid Tower	White	\N	Tempered Glass	51.1	2
Thermaltake View 300 MX	228.75	ATX Mid Tower	Black	\N	Tempered Glass	58.8	2
darkFlash DLM 22	\N	MicroATX Mid Tower	White	\N	Tempered Glass	\N	2
Silverstone GD10B	171.65	HTPC	Black	\N	\N	27.4	2
GameMax Starlight RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.3	2
KOLINK Citadel	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	32.7	2
Cougar DarkBlader X5 RGB	333.94	ATX Mid Tower	Black	\N	Tempered Glass	50	2
Cougar Gemini S	119.94	ATX Mid Tower	Gray / Black	\N	Tempered Glass	\N	2
RAIJINTEK PAEAN C7	\N	ATX Mid Tower	White	\N	Tempered Glass	45.5	2
be quiet! Pure Base 500	\N	ATX Mid Tower	Gray	\N	\N	46	2
Thermaltake Core P6	\N	ATX Mid Tower	Blue / Black	\N	Tempered Glass	76.4	4
SHARKOON Rebel C50	\N	ATX Mid Tower	Black	\N	Mesh	52.4	3
Thermaltake V150 Tempered Glass ARGB Breeze	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	2
LC-Power Gaming 806W Crosswind_X	\N	ATX Mid Tower	White	\N	Tempered Glass	45.8	1
In Win 301	\N	MicroATX Mini Tower	White / Blue	\N	Tempered Glass	28.1	1
Fractal Design Define 7	\N	ATX Mid Tower	Gray	\N	\N	62.4	6
KOLINK Quantum	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.5	2
Cooler Master CMP 520L	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.5	2
Cooler Master CM 690 II	\N	ATX Mid Tower	Black	\N	\N	57.4	6
Fractal Design Define R5 Blackout Edition	\N	ATX Mid Tower	Black	\N	Acrylic	54.2	8
Thermaltake Core P5	\N	ATX Mid Tower	Black	\N	Acrylic	115.4	3
Zalman Z9 NEO	\N	ATX Mid Tower	White	\N	Acrylic	\N	4
Deepcool SMARTER	\N	MicroATX Mini Tower	Black	\N	\N	30.8	2
NZXT H440	\N	ATX Mid Tower	White / Purple	\N	Acrylic	53.3	8
Phanteks Enthoo EVOLV SHIFT	\N	Mini ITX Tower	Gray	\N	Tinted Tempered Glass	24	1
Cooler Master MasterBox K500	\N	ATX Mid Tower	Black	\N	Tempered Glass	46.9	2
Lian Li LANCOOL ONE Digital	\N	ATX Mid Tower	Black	\N	Acrylic	46.7	2
Thermaltake V200	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
MSI MPG GUNGNIR 100	\N	ATX Mid Tower	Black	\N	Tempered Glass	60.8	2
GameMax Spectrum	\N	ATX Mid Tower	Black	\N	Tempered Glass	57.1	2
Cooler Master MasterBox TD500 Mesh w/o Controller	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Fractal Design Define 7 Light	\N	ATX Mid Tower	Black	\N	Tempered Glass	62.4	6
Fractal Design Define 7	\N	ATX Mid Tower	Black / White	\N	Tempered Glass	62.4	6
Tecware Forge S	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GameMax Destroyer	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	43.6	2
GameMax Master M905	\N	ATX Full Tower	Black	\N	Tempered Glass	53.8	8
HYTE Metaphor: ReFantazio Y70	\N	ATX Mid Tower	Brown / Gold	\N	Tempered Glass	70.7	2
Chieftec BX-10B-M-OP	94.24	MicroATX Mid Tower	Black	\N	Mesh	28.8	1
Silverstone TJ04B-E	241.07	ATX Mid Tower	Black	\N	\N	51	9
Thermaltake CTE E550	169.95	ATX Mid Tower	White	\N	Tempered Glass	77.4	3
Silverstone KL07B-E	148.08	ATX Mid Tower	Black	\N	\N	52.9	3
Silverstone RVZ03W-ARGB	139.43	Mini ITX Desktop	White	\N	\N	\N	0
Silverstone FARA 312Z	88.86	MicroATX Mini Tower	Black	\N	Tempered Glass	37.2	2
Lian Li LANCOOL 205 Mesh	239.95	ATX Mid Tower	White / Black	\N	Tempered Glass	41.3	2
YEYIAN Hussar Plus	\N	ATX Mid Tower	White	\N	Tempered Glass	33.5	1
GameMax Abyss TR	112.99	ATX Mid Tower	Black	\N	Tempered Glass	57.1	3
Silverstone PS13	\N	ATX Mid Tower	Black	\N	\N	\N	3
Cooler Master Masterbox 520	\N	ATX Mid Tower	White	\N	Tempered Glass	52.5	2
Mars Gaming MCZP	\N	MicroATX Mid Tower	Pink / Black	\N	Tempered Glass	\N	1
Deepcool CYCLOPS	\N	ATX Mid Tower	White	\N	Tempered Glass	51.5	2
Aerocool Zauron V1	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.6	2
Cooler Master 690 III	\N	ATX Mid Tower	Black	\N	Acrylic	58.5	7
Antec DF700 FLUX	\N	ATX Mid Tower	White	\N	Tempered Glass	49.9	3
Thermaltake View 270	\N	ATX Mid Tower	Green / Black	\N	Tempered Glass	47.6	2
Fractal Design Define C TG	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.6	2
Fractal Design Define S2	\N	ATX Mid Tower	Black / White	\N	Tinted Tempered Glass	58.8	3
Phanteks ECLIPSE G500A DRGB (Fanless)	\N	ATX Mid Tower	Black	\N	Tempered Glass	61.8	2
Apevia X-Master	\N	HTPC	Black	500	\N	22	1
Fractal Design Arc Midi	\N	ATX Mid Tower	Black	\N	\N	54.4	8
Cooler Master HAF 912 Plus	\N	ATX Mid Tower	Black	\N	\N	54.9	6
Antec One	\N	ATX Mid Tower	Black	\N	\N	44.2	5
Azza Genesis 9000B	\N	ATX Full Tower	Black	\N	Acrylic	93	5
Cooler Master Storm Scout 2	\N	ATX Mid Tower	Black	\N	Acrylic	61.6	7
Corsair Carbide Series 330R	\N	ATX Mid Tower	Black	\N	\N	49.9	4
NZXT H440	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	53.3	8
Aerocool XPredator X3	\N	ATX Mid Tower	Black / Red	\N	Acrylic	62.5	8
Phanteks Eclipse P400	\N	ATX Mid Tower	Black	\N	Tinted Acrylic	45.9	2
Corsair Carbide Series SPEC-ALPHA	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	\N	3
DIYPC F2	\N	MicroATX Mini Tower	Black / Purple	\N	Acrylic	\N	2
Zalman Z3	\N	ATX Mid Tower	Black	\N	\N	\N	4
be quiet! Dark Base 900	\N	ATX Full Tower	Black / Orange	\N	\N	82	7
Rosewill CULLINAN	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Lian Li PC-O11	\N	ATX Full Tower	Black	\N	Tempered Glass	64.1	4
NZXT H500	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	41.3	3
Fractal Design Define S2 Vision RGB	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	58.8	3
Deepcool Gamer Storm MACUBE 550	\N	ATX Mid Tower	Black	\N	Tempered Glass	65.9	4
Azza PYRAMID 804	\N	ATX Mid Tower	Silver / Black	\N	Tempered Glass	\N	1
Zalman M3 Plus	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	39.1	2
SilentiumPC Signum SG1V EVO TG ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Corsair iCUE 5000X RGB Neon Night	\N	ATX Mid Tower	Black / Purple	\N	Tempered Glass	66.2	2
Golden Field MAGE	\N	ATX Mid Tower	Pink / Black	\N	Tempered Glass	47.6	2
DIYPC S3-BK-ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	36.8	2
Cooler Master Cosmos C700M	\N	ATX Full Tower	Silver / White	\N	Tempered Glass	\N	4
SaharaGaming M808W	\N	MicroATX Mid Tower	White	\N	Tempered Glass	41.9	2
Ocypus Iota C70 ARGB	\N	ATX Mid Tower	White	\N	Tempered Glass	48.6	2
Thermaltake Ceres 350 MX	139.99	ATX Mid Tower	Yellow	\N	Tempered Glass	52.5	1
Apevia Destiny Pro	81.99	ATX Mid Tower	Black	\N	Tempered Glass	42	2
In Win F5	169	ATX Full Tower	White	\N	Tempered Glass	65.1	2
Nanoxia Deep Silence 3	\N	ATX Mid Tower	Black / Silver	\N	\N	\N	5
Cougar FV270	\N	ATX Mid Tower	White	\N	Tempered Glass	72.7	2
Silverstone SETA H1	193.04	ATX Mid Tower	Black	\N	Tempered Glass	55	2
Azza Hive 450	79.98	ATX Mid Tower	Black	\N	Tempered Glass	41.9	2
GameMax Spark Pro	\N	ATX Mid Tower	White	\N	Tempered Glass	33.5	1
NOX LITE030	\N	MicroATX Mid Tower	Black	500	\N	19.6	3
Cooler Master MasterBox Q300P	\N	MicroATX Mini Tower	Black	\N	Acrylic	46.6	1
Phanteks EVOLV SHIFT 2 AIR	\N	Mini ITX Tower	Black	\N	\N	\N	1
Jonsbo Jonsplus i400	\N	ATX Mid Tower	Silver	\N	Tempered Glass	55.7	6
Thermaltake Level 20 GT ARGB	\N	ATX Full Tower	Silver / Black	\N	Tempered Glass	100.9	7
Thermaltake H200 TG Snow RGB	\N	ATX Mid Tower	White	\N	Tempered Glass	39.7	2
SHARKOON Rebel C50 RGB	480.24	ATX Mid Tower	White	\N	Tempered Glass	52.4	3
Thermaltake Ceres 350 MX	139.99	ATX Mid Tower	Black	\N	Tempered Glass	52.5	1
Cougar MG130-G	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	\N	2
Antec P120 Crystal	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
Deepcool Quadstellar Infinity	\N	ATX Mid Tower	Black	\N	Tempered Glass	129.9	3
Aerocool Playa	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.8	2
FSP Group CMT380	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	45.5	2
Thermaltake CTE E660 MX	\N	ATX Mid Tower	Black	\N	Tempered Glass	77.4	3
Cooler Master MB600L	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	2
Aerocool Aero One Eclipse	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
In Win Wavy	\N	Mini ITX Tower	Black	120	\N	6.8	0
Fractal Design Array R2	\N	Mini ITX Desktop	Black	300	\N	17.3	6
NZXT Phantom 410	\N	ATX Mid Tower	Black	\N	Acrylic	58.5	6
Rosewill Line-M	\N	MicroATX Mini Tower	Black	\N	\N	26.9	2
Corsair Carbide Series Air 540	\N	ATX Mid Tower	Black	\N	Acrylic	62.6	2
Asus VENTO 3600 RED	\N	ATX Mid Tower	Red	\N	\N	101.8	3
SHARKOON T9 Value	\N	MicroATX Mid Tower	Black / Blue	\N	Acrylic	\N	0
Phanteks Enthoo EVOLV ITX	\N	Mini ITX Tower	Black	\N	Acrylic	\N	2
Thermaltake Core X1	\N	Mini ITX Tower	Black / Blue	\N	Acrylic	\N	3
Rosewill SRM-01	\N	MicroATX Mini Tower	Black	\N	\N	\N	2
be quiet! Silent Base 600	\N	ATX Mid Tower	Black / Orange	\N	\N	\N	3
Corsair Carbide Series Quiet 400Q	\N	ATX Mid Tower	Black	\N	\N	\N	2
Phanteks Eclipse P400S	\N	ATX Mid Tower	Black	\N	Tinted Acrylic	45.9	2
NOX Hummer ZN	\N	ATX Mid Tower	Black	\N	\N	52.2	2
Thermaltake Versa C22 RGB	\N	ATX Mid Tower	Black	\N	Acrylic	52.2	2
Thermaltake Core P3 Snow Edition	\N	ATX Mid Tower	White	\N	Acrylic	80.1	2
Phanteks Eclipse P400	\N	ATX Mid Tower	Black / Red	\N	Tinted Tempered Glass	45.9	2
Phanteks Eclipse P400S	\N	ATX Mid Tower	Black / Red	\N	Tinted Tempered Glass	45.9	2
SHARKOON VG4-W	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	38.3	3
Corsair Carbide Series SPEC OMEGA	\N	ATX Mid Tower	Red / Black	\N	Tempered Glass	\N	3
Rosewill CULLINAN MX	\N	ATX Mid Tower	Black	\N	Tempered Glass	47.2	4
Cooler Master MasterCase MC500M	\N	ATX Mid Tower	Black	\N	Tempered Glass	75.6	4
Cooler Master Stryker SE	\N	ATX Full Tower	White / Black	\N	Tempered Glass	87.7	2
NZXT H200	\N	Mini ITX Tower	Black	\N	Tempered Glass	27.3	1
RAIJINTEK ARCADIA	\N	ATX Mid Tower	\N	\N	\N	39.1	4
Corsair Carbide Series SPEC-06	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
Silverstone LD01	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	\N	3
Thermaltake Versa J24 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Cooler Master MasterBox MB510L	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	2
be quiet! Silent Base 601	\N	ATX Mid Tower	Black / Orange	\N	Tempered Glass	\N	3
Antec Dark Avenger DA601	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Fractal Design Define S2 Vision Blackout	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	58.8	3
Phanteks Enthoo 719	\N	ATX Full Tower	Gray	\N	Tempered Glass	81.4	4
Phanteks Eclipse P360X	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.3	2
Rosewill Prism M	\N	ATX Mid Tower	Black	\N	Tempered Glass	36.9	2
SHARKOON RGB LIT 100	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
ADATA XPG Battlecruiser	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	55.2	2
ADATA XPG INVADER	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
MUSETEX MK7-GN5	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	37.4	2
Montech X3 Glass	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
GAMDIAS TALOS E2	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Deepcool CK500	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.4	2
SilentiumPC Ventum VT2 EVO TG ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.5	1
Xigmatek Aquarius Plus Queen	\N	ATX Mid Tower	Pink	\N	Tempered Glass	49.6	2
DIYPC Dragon-R-4LED	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	33.2	2
YEYIAN Hollow 2500	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.7	2
SeaSonic ARCH Q5	\N	ATX Mid Tower	Black	650	Tempered Glass	46.4	3
RAIJINTEK OPHION M EVO TGS	69.9	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	3
Chieftec UE-02B	119.1	MicroATX Mini Tower	\N	\N	\N	12.9	1
Thermaltake CTE E600	129.99	ATX Mid Tower	Blue	\N	Tempered Glass	77.4	2
Cooler Master MASTERBOX E501L	\N	ATX Mid Tower	Black / Blue	\N	\N	\N	2
KOLINK Big Chungus Shredded	\N	ATX Mid Tower	Black	\N	Tempered Glass	66.4	1
Geometric Future Model 8	\N	ATX Mid Tower	Black / Orange	\N	Tinted Tempered Glass	57.5	3
Thermaltake CTE E660 MX	184.98	ATX Mid Tower	White	\N	Tempered Glass	77.4	3
Silverstone Lucid LD03	149.81	Mini ITX Tower	\N	\N	Tinted Tempered Glass	25.2	1
Silverstone FARA R1 PRO	94.99	ATX Mid Tower	Black	\N	Tempered Glass	36	1
Mars Gaming MC-LCD	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	33.2	1
Geometric Future Model 5 Fanless	119.9	ATX Mid Tower	Black / Green	\N	Tempered Glass	51.1	2
iTek Dark Cave DS	\N	ATX Mid Tower	White	\N	Tempered Glass	49.6	2
Thermaltake H550 TG ARGB	234.64	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
In Win B1 Mesh	\N	Mini ITX Desktop	Black	200	\N	7.8	0
Cougar DarkBlader-S	\N	ATX Full Tower	Black / Red	\N	Tempered Glass	\N	4
Fractal Design Define R5 Blackout Edition	\N	ATX Mid Tower	Black	\N	\N	54.2	8
SSUPD Meshroom S w/PCIe 4.0 Riser	\N	ATX Mini Tower	Blue	\N	Mesh	14.9	0
SSUPD Meshroom S w/PCIe 4.0 Riser	\N	ATX Mini Tower	Gray	\N	Mesh	14.9	0
Thermaltake Core V71 TG	\N	ATX Full Tower	Black	\N	Tempered Glass	\N	8
Antec NX800	\N	ATX Mid Tower	\N	\N	Tempered Glass	54	3
Fractal Design Define 7	\N	ATX Mid Tower	White	\N	\N	62.4	6
SeaSonic SYNCRO Q704	\N	ATX Mid Tower	Black	\N	Tempered Glass	61.9	2
APNX V1	\N	ATX Mid Tower	Black / White	\N	Tempered Glass	70.4	2
Armoury D60	\N	ATX Mid Tower	White	\N	Tempered Glass	59.3	1
Cooler Master CM 690	\N	ATX Mid Tower	Black	\N	\N	53.8	5
In Win BK623	\N	MicroATX Desktop	Black	300	\N	12.3	1
Rosewill RANGER-M	\N	MicroATX Mini Tower	Black	\N	\N	21.6	2
Rosewill FBM-01	\N	MicroATX Mini Tower	Black	\N	\N	21.6	2
NZXT Switch 810	\N	ATX Full Tower	White / Black	\N	Acrylic	81.3	6
Cooler Master K380	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	5
Silverstone RVZ01B	\N	Mini ITX Desktop	Black	\N	\N	\N	1
Cooler Master K350	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	6
Lian Li PC-O7S	\N	HTPC	Black	\N	Tempered Glass	\N	7
NZXT Manta	\N	Mini ITX Desktop	Black	\N	Acrylic	\N	2
Phanteks Eclipse P400	\N	ATX Mid Tower	White	\N	Tinted Acrylic	45.9	2
iBuypower ARC 647 CASE	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	3
be quiet! Dark Base 900	\N	ATX Full Tower	Black / Silver	\N	\N	82	7
Thermaltake Versa C21	\N	ATX Mid Tower	Black	\N	Acrylic	52.8	3
Thermaltake Versa N24	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Aerocool Aero-500	\N	ATX Mid Tower	Black	\N	Acrylic	45.1	4
Thermaltake Core G21 Tempered Glass Edition	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	46.6	2
Azza Inferno 310	\N	ATX Mid Tower	Black / Red	\N	Acrylic	46.7	2
SHARKOON S25-V	\N	ATX Mid Tower	Blue	\N	Acrylic	43.9	3
Antec P8	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.7	2
Fractal Design Define R6 Blackout	\N	ATX Mid Tower	Black	\N	Tempered Glass	56.7	6
Phanteks Enthoo Pro Tempered Glass	\N	ATX Full Tower	Black / White	\N	Tinted Tempered Glass	69.1	6
EVGA DG-76	\N	ATX Mid Tower	Black	\N	Tempered Glass	48.6	2
Cooler Master MasterCase MC500	\N	ATX Mid Tower	Black	\N	Tempered Glass	65.9	2
Raidmax Alpha Prime	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.8	2
DAN Cases A4-SFXv3	\N	Mini ITX Desktop	Black	\N	\N	\N	0
Deepcool D-Shield V2	\N	ATX Mid Tower	Black	\N	Acrylic	44	2
Zalman K1	\N	ATX Mid Tower	Black	\N	Acrylic	43.3	2
GameMax ONYX	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.1	3
Maingear Vybe Mk. V	\N	ATX Mid Tower	Black	\N	Tempered Glass	38.4	2
Montech Air 900 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	44	2
SHARKOON Elite Shark CA200G	\N	ATX Mid Tower	Black	\N	Tempered Glass	62.8	4
MagniumGear NEO Qube	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
Cooler Master MasterCase H500P ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Apevia Genesis-PK	\N	ATX Mid Tower	Pink / Black	\N	Tempered Glass	\N	3
Jonsbo V9	\N	MicroATX Mini Tower	Silver	\N	Tempered Glass	17.6	1
CiT S8	\N	MicroATX Desktop	Black / Silver	\N	\N	8.6	1
Jonsbo V11	\N	Mini ITX Tower	Black	\N	Mesh	13	0
MSI MPG GUNGNIR 300 MONSTER HUNTER EDITION	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	60.5	2
Thermaltake Divider 300 TG Air Snow	119.99	ATX Mid Tower	White	\N	Tempered Glass	48.2	2
Thermaltake CTE E600	145.94	ATX Mid Tower	White	\N	Tempered Glass	77.4	2
Montech SKY ONE LITE	134.96	ATX Mid Tower	White	\N	Tempered Glass	44.8	2
SHARKOON VS9 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.1	2
Supermicro SuperChassis 721TQ-350B2	361.94	Mini ITX Tower	Black	350	\N	14.1	0
Thermaltake AH T200 Snow	\N	MicroATX Mid Tower	White	\N	Tempered Glass	69.1	2
Thermaltake Divider 300 ARGB Triangular	154.98	ATX Mid Tower	Black	\N	Tempered Glass	48.2	2
Phanteks Enthoo EVOLV SHIFT X	\N	Mini ITX Tower	Gray	\N	Tinted Tempered Glass	\N	2
Cougar DarkBlader X7	\N	ATX Mid Tower	Black	\N	Tempered Glass	50	2
RAIJINTEK PAEAN C7	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.5	2
KOLINK Inspire K8	\N	ATX Mid Tower	Black	\N	Tempered Glass	30.8	2
Phanteks Enthoo EVOLV TG	\N	MicroATX Mini Tower	Silver	\N	Tinted Tempered Glass	41.7	2
Aerocool NightHawk Duo	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Silverstone RVZ03B-ARGB	\N	Mini ITX Desktop	Black	\N	\N	\N	0
Thermaltake View 21 Tempered Glass Edition	\N	ATX Mid Tower	Black	\N	Acrylic	48.2	2
Tempest Shade RGB	\N	ATX Mid Tower	White / Black	\N	Acrylic	\N	2
MSI MPG Sekira 500P	\N	ATX Mid Tower	Black	\N	Tempered Glass	67.1	6
Silverstone GD05B-USB3.0	\N	HTPC	Black	\N	\N	21.4	2
GameMax F15M Mesh	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	4
MSI MPG Quietude 100S	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.8	2
ADATA XPG CRUISER	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.8	4
KOLINK Unity Cascade ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.9	2
Antec Nine Hundred Two	\N	ATX Mid Tower	Black	\N	Acrylic	50.6	6
NZXT Phantom 410	\N	ATX Mid Tower	Red / Black	\N	Acrylic	58.5	6
Cougar Solution	\N	ATX Mid Tower	Black	\N	\N	40.7	6
Cooler Master HAF XM	\N	ATX Mid Tower	Black	\N	\N	76	6
Antec VSK-4000	\N	ATX Mid Tower	Black	\N	\N	33.4	2
NZXT Source 210	\N	ATX Mid Tower	Black	\N	Acrylic	42.4	8
Corsair Graphite Series 760T	\N	ATX Full Tower	Black / White	\N	Acrylic	78.8	6
Deepcool KENDOMEN	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
In Win 805	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Rosewill CHALLENGER S	\N	ATX Mid Tower	Black	\N	\N	\N	3
DIYPC F2	\N	MicroATX Mini Tower	White	\N	Acrylic	\N	2
Deepcool Dukase	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Cooler Master MasterBox Lite 3	\N	MicroATX Mini Tower	Black	\N	\N	26.9	1
Corsair Carbide Series SPEC-04	\N	ATX Mid Tower	Black / Gray	\N	Acrylic	42.8	3
DIYPC Vanguard RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
In Win 301C	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	26	1
NZXT H400i	\N	MicroATX Mini Tower	Black / Red	\N	Tempered Glass	36.9	1
CiT F3	\N	MicroATX Mini Tower	Black / Red	\N	Acrylic	\N	2
Fractal Design Define R6 USB-C Blackout	\N	ATX Mid Tower	Black	\N	Tempered Glass	56.7	6
Thermaltake V100	\N	ATX Mid Tower	Black	\N	\N	36.6	2
Antec Dark Phantom DP501	\N	ATX Mid Tower	Black	\N	Tempered Glass	64	2
Deepcool MACUBE 310	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.2	2
Corsair iCUE 220T RGB	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	37.3	2
Fractal Design Era ITX	\N	Mini ITX Desktop	Gray	\N	\N	16.7	1
Golden Field Z2	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	\N	2
darkFlash DLM 21 Mesh	\N	MicroATX Mini Tower	Pink	\N	Tempered Glass	32.1	2
MSI MPG GUNGNIR 111M	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
SAMA SAMA-Z4	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	39.2	2
MSI MAG VAMPIRIC 011C	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.9	2
Jonsbo T8 PLUS	\N	Mini ITX Desktop	Silver / Black	\N	Tempered Glass	12.5	0
Jonsbo VR3	\N	Mini ITX Tower	White	\N	Mesh	19.9	0
Cooler Master MasterBox Q300L Retro	\N	MicroATX Mini Tower	White / Green	\N	Acrylic	33.6	1
SilentiumPC Gladius M35	\N	ATX Mid Tower	Black	\N	\N	49.4	2
SAMA V Nature	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Ocypus Gamma C50	\N	MicroATX Mini Tower	White	\N	Tempered Glass	34.6	2
Geometric Future Model 2 The ARK	169.9	MicroATX Mini Tower	Black / Gold	\N	Mesh	40.7	1
Thermaltake H700 TG	94.98	ATX Mid Tower	White	\N	Tempered Glass	53.5	2
Azza Regis	399.99	ATX Mid Tower	Black	\N	Tempered Glass	\N	1
Silverstone Lucid LD03-AF	157.51	Mini ITX Tower	Black	\N	Tempered Glass	25.2	1
Cougar MX600 Mini RGB	\N	MicroATX Mini Tower	White	\N	Tempered Glass	47.1	2
Silverstone SG12B-V2	184.53	MicroATX Mini Tower	Black / Blue	\N	\N	\N	3
SHARKOON VS8 RGB	345.69	ATX Mid Tower	White	\N	Tempered Glass	42.1	2
Jonsbo MOD5	\N	ATX Mid Tower	Gray	\N	Tempered Glass	97.2	1
Aerocool Skribble	\N	ATX Mid Tower	Black	\N	Tempered Glass	42	2
SHARKOON VK3 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.5	2
Cougar Airface	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.6	2
Azza Eclipse 440	79.98	ATX Mid Tower	Black	\N	Tempered Glass	45.5	2
CiT S015B LED	\N	MicroATX Desktop	Black	300	\N	11.9	2
Antec NX100	\N	ATX Mid Tower	Black / Yellow	\N	Acrylic	37.7	2
KOLINK Citadel Glass SE ARGB	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	53.4	2
KOLINK Observatory Y ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.1	2
SHARKOON TG7M RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	52.1	2
Acer Predator MI900	\N	Mini ITX Tower	White / Black	\N	Mesh	15.5	0
Lian Li PC-O11ROG	\N	ATX Full Tower	Silver	\N	Tempered Glass	65.3	4
NZXT H400	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	36.9	1
Cougar PANZER EVO RGB	\N	ATX Full Tower	Black	\N	Tempered Glass	\N	2
Streacom DA2	\N	Mini ITX Desktop	Black	\N	\N	\N	3
Silverstone FARA R1	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	1
ADATA XPG STARKER AIR	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	40	2
Jonsbo V8	\N	Mini ITX Desktop	Gray	\N	Mesh	25.3	2
RAIJINTEK PAN Slim	\N	Mini ITX Desktop	Black	\N	\N	38.7	2
Cooler Master HAF X nVidia Edition	\N	ATX Full Tower	Green / Black	\N	Acrylic	76.2	5
Rosewill R379-M	\N	MicroATX Slim	Black / Silver	300	\N	12.9	1
Zalman Z9	\N	ATX Mid Tower	Black	\N	\N	\N	5
Lian Li PC-Q12	\N	Mini ITX Tower	Black	300	\N	6.6	0
Zalman Z11 Plus HF1	\N	ATX Mid Tower	Black	\N	Acrylic	68	5
Silverstone SG05-LITE	\N	Mini ITX Desktop	Black	450	\N	10.7	1
Lian Li PC-Q02	\N	Mini ITX Tower	Black	300	\N	6.8	1
Thermaltake Chaser A31 Thunder Edition	\N	ATX Mid Tower	Black	\N	Acrylic	63.4	5
Rosewill Galaxy-01	\N	ATX Mid Tower	Black	\N	\N	45.9	4
Cooler Master HAF Stacker 915R	\N	Mini ITX Tower	Black	\N	\N	32.4	3
Antec P100	\N	ATX Mid Tower	Black / Silver	\N	\N	\N	7
Enermax ECA3253	\N	ATX Mid Tower	Pink	\N	Acrylic	43.8	5
Fractal Design Define R4 Blackout	\N	ATX Mid Tower	Black	\N	\N	56	8
Zalman Z3 Plus White	\N	ATX Mid Tower	Black / White	\N	Acrylic	38.4	4
Rosewill RISE	\N	ATX Full Tower	Black	\N	Acrylic	55.9	2
SHARKOON T9 Value	\N	MicroATX Mid Tower	Black	\N	Acrylic	\N	0
be quiet! Silent Base 800	\N	ATX Mid Tower	Black / Orange	\N	\N	\N	7
NZXT H440	\N	ATX Mid Tower	Black / Red	\N	Acrylic	53.3	8
Thermaltake Suppressor F1	\N	Mini ITX Desktop	Black	\N	Acrylic	\N	2
Phanteks Enthoo EVOLV ATX TG	\N	ATX Mid Tower	Gray	\N	Tinted Tempered Glass	\N	5
Corsair Crystal Series 460X RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.9	2
Rosewill FBM-X1	\N	MicroATX Mini Tower	Black	\N	Acrylic	22.2	1
Deepcool Frame	\N	MicroATX Mid Tower	Black	\N	\N	\N	3
Thermaltake Versa N27	\N	ATX Mid Tower	White	\N	Acrylic	\N	4
SHARKOON TG5	\N	ATX Mid Tower	Black / White	\N	Acrylic	\N	3
Deepcool Gamer Storm Quadstellar	\N	ATX Desktop	Black	\N	\N	\N	8
Cougar PANZER EVO	\N	ATX Full Tower	Black / Red	\N	Acrylic	\N	2
FSP Group CMT520	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Thermaltake Level 20 GT RGB Plus	\N	ATX Full Tower	Black / Silver	\N	Tempered Glass	100.9	7
Antec P7 Window	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	2
Antec GX202	\N	ATX Mid Tower	Black	\N	Acrylic	40.1	3
GameMax Fortress	\N	ATX Full Tower	Black	\N	Tempered Glass	54.7	2
GameMax Predator	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	49.8	2
DIYPC Jax11	\N	ATX Mid Tower	White	\N	Acrylic	\N	2
RAIJINTEK Eris Evo	\N	ATX Full Tower	Black	\N	Tempered Glass	137.6	5
Apevia CRUSADER-F-BK	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
SilentiumPC Regnum RG4	\N	ATX Mid Tower	Black	\N	\N	46.1	3
SHARKOON REV 100	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.1	3
Apevia Enzo	\N	ATX Mid Tower	White	\N	Tempered Glass	35.7	3
Azza Luminous 110F	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	36.1	2
GAMDIAS TALOS M1B	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cougar MX660 Mesh	\N	ATX Mid Tower	Black	\N	Tempered Glass	50	2
In Win Chopin MAX	\N	Mini ITX Desktop	Black	200	Mesh	4.4	0
Noua Smash S2	\N	ATX Mid Tower	Black	\N	Tempered Glass	32.5	2
Tecware Nexus Evo RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.4	2
NOX Hummer Fusion S	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	36.1	2
KOLINK Inspire K1	\N	ATX Mid Tower	Black	\N	Tempered Glass	25.1	3
1STPLAYER T3-G	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	32.4	2
Jonsbo U4 Mini	\N	MicroATX Desktop	White	\N	Tempered Glass	37.6	1
Geometric Future Model 8	\N	ATX Mid Tower	Black / Blue	\N	Tinted Tempered Glass	57.5	3
Chieftec CS-12B-300	146.86	MicroATX Mini Tower	Black	300	\N	12.3	1
Silverstone SG02B-F-USB3.0	\N	MicroATX Desktop	Black	\N	\N	22.4	2
Thermaltake Level 20 GT ARGB Black Edition	\N	ATX Full Tower	Black	\N	Tempered Glass	100.9	7
Cougar MX440-G RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	46	2
KOLINK OBSERVATORY RGB	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	3
Enermax K8 RGB	\N	ATX Mid Tower	White	\N	Tempered Glass	50.4	2
Jonsbo U4 Pro MESH	\N	ATX Mid Tower	Black	\N	Mesh	34.5	1
HYTE REVOLT 3	249.99	Mini ITX Tower	White	700	Mesh	18.4	1
Fractal Design Define C	\N	ATX Mid Tower	Black	\N	Acrylic	39.3	2
Antec DARK CUBE	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	\N	1
Thermaltake Versa H21	\N	ATX Mid Tower	Black	500	\N	42.8	3
Silverstone ML06B-E	\N	HTPC	Black	\N	\N	\N	0
Silverstone SG13	\N	Mini ITX Tower	White / Black	\N	\N	11.5	1
MSI MPG Sekira 100P	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.9	2
Thermaltake DH102	\N	HTPC	Black / Silver	\N	\N	28.1	3
SHARKOON VS8 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.1	2
KOLINK Observatory Y Mesh	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.1	2
Cooler Master Elite 360	\N	ATX Mini Tower	Black	\N	\N	23.2	1
Cooler Master Storm Scout	\N	ATX Mid Tower	Black	\N	Acrylic	52.6	5
Cooler Master Cosmos	\N	ATX Full Tower	Silver / Black	\N	\N	99.2	6
Xigmatek Elysium	\N	ATX Full Tower	Black	\N	Acrylic	93.9	8
Enermax ECA892BG-1350	\N	ATX Mid Tower	Black	1350	\N	57.5	6
Thermaltake Overseer RX-I	\N	ATX Full Tower	Black	\N	Acrylic	68.1	5
NZXT Phantom 410	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	58.5	6
Fractal Design Define R4	\N	ATX Mid Tower	Black / Gray	\N	Acrylic	56	8
NZXT Phantom 630	\N	ATX Full Tower	Black	\N	Acrylic	92	6
Lian Li PC-TU100	\N	Mini ITX Tower	Black	\N	\N	10.6	0
NZXT Phantom 530	\N	ATX Full Tower	Black	\N	Acrylic	72.7	6
Corsair Carbide Series SPEC-03	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	36.1	3
Deepcool TESSERACT BF	\N	ATX Mid Tower	Black / White	\N	\N	36.4	4
Thermaltake Versa H35	\N	ATX Mid Tower	Black	\N	Acrylic	49.3	3
Fractal Design Define R5	\N	ATX Mid Tower	White	\N	Acrylic	54.2	8
Lian Li PC-Q26	\N	Mini ITX Tower	Black	\N	\N	33.8	10
Thermaltake Core V31	\N	ATX Mid Tower	Black	\N	Acrylic	72	3
Phanteks Enthoo EVOLV ATX	\N	ATX Mid Tower	Gray	\N	Acrylic	\N	5
Cooler Master MasterCase 5	\N	ATX Mid Tower	Black	\N	\N	\N	2
Antec VSP-5000	\N	ATX Mid Tower	Black	\N	\N	\N	4
Phanteks Enthoo Luxe TG	\N	ATX Full Tower	Black	\N	Tinted Tempered Glass	72.4	6
NZXT H200i	\N	Mini ITX Tower	Black / Red	\N	Tempered Glass	27.3	1
Fractal Design Define R6 Blackout	\N	ATX Mid Tower	Black	\N	\N	56.7	6
In Win X-Frame 2.0	\N	ATX Test Bench	White / Blue	\N	\N	102	6
Cooler Master MasterCase MC500Mt	\N	ATX Mid Tower	Black / Red	\N	Acrylic	75.6	4
be quiet! Silent Base 801	\N	ATX Mid Tower	Black	\N	\N	\N	5
Deepcool MATREXX 55 A-RGB 3F	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
In Win BQ656T.AD150TB3	\N	Mini ITX Tower	Black	150	\N	\N	0
Rosewill FBM-X2	\N	MicroATX Mini Tower	Black	\N	\N	25.3	1
In Win D-Frame 2.0	\N	ATX Full Tower	Black / Green	1065	Tempered Glass	\N	4
Deepcool MATREXX 70	\N	ATX Mid Tower	Black	\N	Tempered Glass	54.2	2
GameMax Expedition	\N	MicroATX Mini Tower	Black	\N	Acrylic	29.4	2
In Win 309	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
MagniumGear Neo Air ATX	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	41.4	2
Phanteks Evolv Shift Air	\N	Mini ITX Tower	Black	\N	Mesh	24	1
In Win A1 Plus	\N	Mini ITX Tower	Pink	650	Tempered Glass	21.8	0
MagniumGear Neo Mini V2	\N	Mini ITX Desktop	Black	\N	Tempered Glass	\N	1
Cooler Master MasterBox LITE 5 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.7	2
SilentiumPC Regnum RG6V EVO TG ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Jonsbo Jonsplus i100 Pro	\N	Mini ITX Desktop	Black	\N	\N	25.9	1
GAMDIAS MARS M1	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Montech SKY ONE MINI	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	21.9	1
Montech SKY ONE MINI	\N	MicroATX Mini Tower	White	\N	Tempered Glass	21.9	1
MSI MPG GUNGNIR 110R EVA e-PROJECT	\N	ATX Mid Tower	Black / Purple	\N	Tempered Glass	\N	2
MSI MAG VAMPIRIC 300R PACIFIC BLUE	\N	ATX Mid Tower	Blue	\N	Tempered Glass	54.1	2
ADATA XPG STARKER	\N	ATX Mid Tower	White	\N	Tempered Glass	40	2
CiT Raider RGB	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	37.8	2
FSP Group CMT260	\N	ATX Mid Tower	Black	\N	Tempered Glass	36.1	2
Cooler Master MasterBox MB520	\N	ATX Mid Tower	Black / Red	\N	Acrylic	50.4	2
BGears b-Masstige	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	28.2	2
Jonsbo D300 4PCS	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	45.8	2
YEYIAN Dragoon	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.1	2
YEYIAN Haizen 2500	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	24.7	2
Aerocool Viewport Mini V2	\N	MicroATX Mini Tower	White	\N	Tempered Glass	35	1
SilentiumPC Aquarius X70W	\N	ATX Mid Tower	Black	\N	Acrylic	59.1	2
Ocypus Gamma C72	\N	ATX Mid Tower	White	\N	Tempered Glass	43	2
In Win 904	69.98	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Geometric Future Model 5 Vent Fanless	109.9	ATX Mid Tower	White	\N	Tempered Glass	53.8	2
Geometric Future Model 5 Fanless	109.9	ATX Mid Tower	Black / Yellow	\N	Tempered Glass	51.1	2
Cooler Master Elite 500	\N	ATX Mid Tower	Black	\N	\N	38	2
Silverstone ALTA F1	299.55	ATX Mid Tower	Black	\N	Tempered Glass	56.8	2
Azza Chroma 410	120	ATX Mid Tower	Black	\N	Acrylic	\N	2
Cooler Master MasterBox TD500 Mesh V2 Chun-Li	\N	ATX Mid Tower	White / Blue	\N	Tempered Glass	52.4	2
Silverstone FTZ01	181.99	Mini ITX Desktop	Silver	\N	\N	\N	1
Silverstone SETA A1	\N	ATX Mid Tower	Pink / Silver	\N	Tempered Glass	45.7	2
BitFenix Tracery	\N	ATX Mid Tower	Black	\N	Tempered Glass	52.8	4
Thermaltake Suppressor F31 TG	\N	ATX Mid Tower	Black	\N	Tempered Glass	64	3
KOLINK Unity Solar Mesh ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.3	2
RAIJINTEK Thetis	\N	ATX Mid Tower	Black	\N	\N	27.7	2
Cooler Master MasterCase SL600M Black Edition	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	4
Thermaltake Divider 200 TG Air	\N	MicroATX Mini Tower	White	\N	Tempered Glass	51.6	3
Chieftec BX-10B-OP	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	28.8	1
Cooler Master MasterBox 500	\N	ATX Mid Tower	Black	\N	Tempered Glass	52.4	2
ADATA XPG Battlecruiser II	179.99	ATX Mid Tower	White	\N	Tempered Glass	62.6	5
KOLINK Unity Meshbay ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	41	2
BitFenix Prodigy M	\N	MicroATX Mini Tower	Black	\N	\N	35.9	4
Cougar MX340	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cougar MX350 MESH-X	\N	ATX Mid Tower	Black	\N	\N	39.4	2
Thermaltake Ceres 330 ARGB	\N	ATX Mid Tower	Blue	\N	Tempered Glass	53.9	1
Corsair Carbide Series 678C	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	65.2	6
Thermaltake AH T200	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	69.1	2
Jonsbo MOD-3 Mini	\N	MicroATX Mid Tower	Gray	\N	Tempered Glass	76.4	1
Cooler Master Elite 120 Advanced	\N	Mini ITX Tower	Black / Silver	\N	\N	19.7	3
Anidees AI Crystal Cube	\N	ATX Mid Tower	\N	\N	Tinted Tempered Glass	50.5	3
Cougar MX331 MESH-G	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.5	2
Lian Li Q58 (PCIe 3.0)	\N	Mini ITX Desktop	White	\N	Tempered Glass	14.5	0
Cougar Dust 2	\N	Mini ITX Tower	Black / Gold	\N	Mesh	23.6	0
Jonsbo VR4	\N	ATX Mid Tower	White	\N	Mesh	37.8	2
Cougar Airface Pro RGB	\N	ATX Mid Tower	White	\N	Tempered Glass	55.4	2
Jonsbo D32 PRO MESH	\N	MicroATX Desktop	\N	\N	Mesh	25.7	2
Cooler Master HAF X	\N	ATX Full Tower	Black	1000	Acrylic	75	5
Lian Li PC-Q09	\N	Mini ITX Desktop	Black	110	\N	5.5	0
Foxconn G-007(H)	\N	MicroATX Mid Tower	Black	\N	\N	45.4	4
Raidmax Thunder ATX-315WB	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	36.2	5
NZXT Source 210 Elite	\N	ATX Mid Tower	White / Black	\N	\N	42.4	8
Azza Solano 1000R	\N	ATX Full Tower	Black	\N	Acrylic	56	8
Rosewill BLACKHAWK-ULTRA	\N	ATX Full Tower	Black	\N	\N	100.6	10
NZXT Phantom 410	\N	ATX Mid Tower	Black	\N	Acrylic	58.5	6
CiT Vantage	\N	ATX Mid Tower	Black / Yellow	\N	\N	37.5	5
Antec VSK-3000	\N	MicroATX Mid Tower	Black	\N	\N	\N	2
Cooler Master K280	\N	ATX Mid Tower	Black	\N	\N	\N	6
Cooler Master Cosmos SE	\N	ATX Mid Tower	Black	\N	Acrylic	78.4	8
Corsair Graphite Series 230T Windowed	\N	ATX Mid Tower	Black / Gray	\N	Acrylic	\N	4
Nanoxia NXDS6B	\N	ATX Full Tower	Black	\N	\N	\N	13
Fractal Design Core 1500	\N	MicroATX Mini Tower	Black	\N	\N	32.5	4
Rosewill I5-397	\N	ATX Mini Tower	Black	450	\N	37	6
Rosewill Neutron	\N	Mini ITX Desktop	Black	\N	Acrylic	38.9	3
BitFenix Prodigy M	\N	MicroATX Mini Tower	Black / Orange	\N	Acrylic	35.9	4
Sentey GS-6011	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	3
Silverstone RVZ02B	\N	HTPC	Black	\N	\N	\N	1
be quiet! Silent Base 600	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Aerocool CS-101	\N	MicroATX Slim	Black	\N	\N	\N	1
Rosewill NIGHTHAWK 117	\N	ATX Full Tower	Black	\N	Acrylic	\N	8
ABS R206-ITX	\N	MicroATX Mini Tower	Black	\N	\N	39.1	1
NZXT Manta	\N	Mini ITX Desktop	Black / Red	\N	Acrylic	\N	2
be quiet! Dark Base 900	\N	ATX Full Tower	Black / Orange	\N	Acrylic	82	7
NOX Hummer ZS	\N	ATX Mid Tower	Black	\N	Acrylic	43.6	2
NOX Hummer ZS	\N	ATX Mid Tower	White	\N	Acrylic	43.6	2
Aerocool P7-C1	\N	ATX Mid Tower	Black	\N	Acrylic	60.2	2
Phanteks Eclipse P400	\N	ATX Mid Tower	Black / White	\N	Tinted Tempered Glass	45.9	2
Phanteks Eclipse P400	\N	ATX Mid Tower	White	\N	Tinted Tempered Glass	45.9	2
Antec Sonata II	\N	ATX Mid Tower	Black	450	\N	\N	4
Corsair Carbide Series SPEC-04	\N	ATX Mid Tower	Black / Yellow	\N	Acrylic	42.8	3
Thermaltake Core X5 Riing Edition	\N	ATX Desktop	Green / Black	\N	Acrylic	92.8	4
NZXT H200i	\N	Mini ITX Tower	Black	\N	Tempered Glass	27.3	1
DAN Cases A4 SFX	\N	Mini ITX Desktop	Silver	\N	\N	\N	0
In Win 101C	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
Phanteks Eclipse P300	\N	ATX Mid Tower	\N	\N	Tinted Tempered Glass	36	2
Thermaltake View 71 TG RGB Plus	\N	ATX Full Tower	Black / Silver	\N	Acrylic	\N	4
Fractal Design Meshify S2	\N	ATX Mid Tower	Black	\N	\N	58.3	3
Raidmax NEON RGB	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
BitFenix Nova Mesh	\N	ATX Mid Tower	Black	\N	Acrylic	41.4	2
Deepcool MATREXX 50 ADD-RGB 3F	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.5	2
Cooler Master Silencio S600	\N	ATX Mid Tower	Black	\N	Tempered Glass	47	4
Circle CG830	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	3
Golden Field Z3	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
DIYPC Shadow-H3-ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
GameMax Black Diamond ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
SHARKOON REV 200	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.5	2
Apevia Prodigy	\N	MicroATX Mini Tower	Pink	\N	Tempered Glass	32.5	2
Lian Li Q58 (PCIe 3.0)	\N	Mini ITX Desktop	Black	\N	Tempered Glass	14.5	0
GAMDIAS ATHENA M2 ELITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Antec NX700	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Vetroo M01	\N	MicroATX Mid Tower	White / Black	\N	Tempered Glass	36.6	2
Raidmax X616	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.9	2
OCPC MICRO	\N	MicroATX Mid Tower	Black	\N	\N	12.7	0
Jonsbo D500	\N	ATX Full Tower	Black	\N	Tempered Glass	90.8	10
Cooler Master Silencio S400 Sakura Limited Edition	\N	MicroATX Mini Tower	White / Pink	\N	Tempered Glass	\N	4
Apevia Guardian-M	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.5	2
Apevia Destiny Flow	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GALAX REV-05	\N	ATX Full Tower	Black	\N	Tempered Glass	39.5	2
GameMax Aero Mini Eco	\N	MicroATX Mini Tower	Black / White	\N	Tempered Glass	31.5	2
EVOLVEO Nate 2	\N	ATX Mid Tower	\N	\N	Acrylic	36.6	2
Inter-Tech C-703 Vision	\N	ATX Mid Tower	Black	\N	Tempered Glass	56.4	2
SSUPD Meshroom S V2 w/PCIe 4.0 Riser	\N	MicroATX Mini Tower	Black	\N	Mesh	14.9	2
SSUPD Meshroom S V2 w/PCIe 4.0 Riser	\N	MicroATX Mini Tower	White	\N	Mesh	14.9	2
BitFenix CETO Premium	\N	ATX Mid Tower	White	\N	Tempered Glass	49	3
In Win ModFree Base	179	ATX Full Tower	Black	\N	Tempered Glass	57.2	1
GAMDIAS NESO P1	149.99	ATX Full Tower	\N	\N	Tempered Glass	75.2	5
Silverstone FARA 313	\N	MicroATX Mid Tower	Black	\N	\N	26.7	3
Azza Cast 808	\N	ATX Mid Tower	Black	\N	\N	\N	1
Jonsbo D40	\N	ATX Mid Tower	Silver / Black	\N	Tempered Glass	31.6	3
Azza Octane A	99.99	ATX Mid Tower	Black	\N	Tempered Glass	44.8	2
Silverstone FTZ01-E	200.69	Mini ITX Desktop	Black	\N	\N	\N	0
Tempest Spectra RGB	\N	ATX Mid Tower	White / Black	\N	Acrylic	\N	2
Geometric Future Model 8	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	57.5	3
Cooler Master MasterBox TD500 Mesh V2 Ryu	\N	ATX Mid Tower	White / Red	\N	Tempered Glass	52.4	2
Aerocool CS-107	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	23.7	1
Jonsbo D400	\N	ATX Mid Tower	White	\N	Tempered Glass	59.9	2
Cooler Master Elite 502	\N	ATX Mid Tower	White	\N	Tempered Glass	52.4	2
Cooler Master MasterBox MB500 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.5	2
Zalman R2	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
RAIJINTEK PAN Slim	\N	Mini ITX Desktop	White	\N	\N	38.7	2
Vetroo K1	\N	ATX Mid Tower	Silver	\N	Tempered Glass	37.4	2
GameMax Revolt	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.7	2
Jonsbo U4 Pro	\N	ATX Mid Tower	White	\N	Tempered Glass	34.5	1
Cooler Master Silencio 652S	\N	ATX Mid Tower	Black	\N	\N	\N	9
Supermicro S5	\N	ATX Mid Tower	Black / Red	\N	\N	\N	6
Thermaltake Level 20 HT Snow Edition	\N	ATX Full Tower	\N	\N	Tempered Glass	144.3	4
BitFenix Nova Mesh SE	\N	ATX Mid Tower	White / Purple	\N	Tempered Glass	36.1	2
Aerocool Tor Pro	\N	ATX Full Tower	Black	\N	Tempered Glass	66.8	2
Antec Sonata III	\N	ATX Mid Tower	Black	500	\N	40.2	4
Antec Skeleton	\N	ATX Mini Tower	Silver / Black	\N	\N	51.9	2
Cooler Master Cosmos S	\N	ATX Full Tower	Black / Gray	\N	\N	99.2	4
Silverstone FT03	\N	MicroATX Mini Tower	Black	\N	\N	32.2	3
Cooler Master HAF X	\N	ATX Full Tower	Black	\N	Acrylic	75	5
Xigmatek Elysium	\N	ATX Full Tower	Black / Silver	\N	Acrylic	93.9	8
nMEDIAPC HTPC 8000	\N	HTPC	Brown	\N	\N	49.6	4
NZXT Source 220	\N	ATX Mid Tower	Black	\N	\N	43.4	8
Sentey SS1-2420	\N	MicroATX Slim	Black	250	\N	13.3	1
Lian Li PC-V650	\N	ATX Mini Tower	Silver	\N	\N	38.2	7
NZXT Phantom 630	\N	ATX Full Tower	Gunmetal	\N	Acrylic	92	6
Cooler Master Elite 330U	\N	ATX Mid Tower	Black	350	\N	40.7	5
Cooler Master Elite 344	\N	ATX Mini Tower	Silver	350	\N	28.2	5
Apevia X-Dreamer4	\N	ATX Mid Tower	Pink	\N	Acrylic	43.1	4
Thermaltake Chaser A71	\N	ATX Full Tower	Black	\N	Acrylic	66.3	5
Apevia X-Sniper2	\N	ATX Mid Tower	Black / Green	\N	Acrylic	\N	4
Fractal Design Arc XL	\N	ATX Full Tower	Black	\N	Acrylic	72.8	8
Aerocool Strike-X One	\N	ATX Mid Tower	Black / Red	\N	\N	\N	6
NZXT Phantom	\N	ATX Full Tower	Black / Red	\N	\N	74.3	7
Thermaltake Versa H23	\N	ATX Mid Tower	Black	\N	Acrylic	43.7	3
NZXT H440	\N	ATX Mid Tower	Black / Green	\N	Acrylic	53.3	8
Corsair Graphite Series 780T	\N	ATX Full Tower	Black / Yellow	\N	Acrylic	109.9	6
Fractal Design Core 1300	\N	MicroATX Mini Tower	Black	\N	\N	32.5	2
Corsair Carbide Series 330R Titanium Edition	\N	ATX Mid Tower	Black / Silver	\N	\N	49.9	4
Raidmax Hyperion	\N	MicroATX Mid Tower	Black / Blue	\N	Acrylic	\N	5
Thermaltake Core X9 Snow Edition	\N	ATX Desktop	White	\N	Acrylic	\N	7
NZXT Noctis 450	\N	ATX Mid Tower	White / Blue	\N	Acrylic	\N	6
Aerocool Aero-800	\N	ATX Mid Tower	Black / White	\N	Acrylic	\N	2
NZXT H440	\N	ATX Mid Tower	White / Black	\N	Acrylic	53.3	8
Antec P380	\N	ATX Full Tower	Black	\N	Acrylic	\N	8
Cooler Master MasterCase Maker 5	\N	ATX Mid Tower	Black	\N	Acrylic	\N	5
be quiet! Dark Base 900	\N	ATX Full Tower	Black	\N	Acrylic	82	7
Rosewill B2-SPIRIT	\N	ATX Full Tower	Black	\N	Acrylic	\N	13
Cooler Master MasterCase Pro 3	\N	MicroATX Mini Tower	Black	\N	Acrylic	55.4	2
NZXT H440 Hyper Beast	\N	ATX Mid Tower	Blue	\N	Acrylic	53.3	8
Silverstone RL06	\N	ATX Mid Tower	Black / Red	\N	Acrylic	43.4	3
SHARKOON TG5	\N	ATX Mid Tower	Black / Green	\N	Acrylic	\N	3
LC-Power 991B Lighthouse	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.6	3
Corsair Carbide Series SPEC OMEGA	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	3
Xigmatek Scorpio	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	30.1	2
Thermaltake Versa J23 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Fractal Design Define R6 USB-C	\N	ATX Mid Tower	Black / White	\N	\N	56.7	6
Antec Dark Fleet DF500 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Rosewill CULLINAN MX-Red	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	47.2	4
Silverstone CS280B	\N	Mini ITX Tower	Black / Silver	\N	\N	\N	0
Thermaltake H100 TG	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.7	2
Rosewill SPECTRA X	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	5
Rosewill PRISM S	\N	ATX Mid Tower	Black	\N	Tempered Glass	46.9	3
Antec NX500	\N	ATX Mid Tower	Black	\N	Tempered Glass	47.4	2
MagniumGear Neo Silent	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.4	2
Jonsbo C3 Plus	\N	MicroATX Mini Tower	Silver	\N	Tempered Glass	31.2	4
Maingear Vybe Mk. V	\N	ATX Mid Tower	Red / Black	\N	Tempered Glass	38.4	2
BitFenix Dawn TG	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
MagniumGear NEO Qube	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Fractal Design Define 7	\N	ATX Mid Tower	Black / White	\N	\N	62.4	6
Cougar MX330-G Air	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
FSP Group CMT230	\N	ATX Mid Tower	Black	\N	Acrylic	36.9	2
SAMA Sama-3D	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cooler Master MasterCase H500P Mesh ARGB	\N	ATX Mid Tower	Gray	\N	Tempered Glass	71.4	2
RAIJINTEK PONOS MS	\N	ATX Mid Tower	Black	\N	Tempered Glass	45	3
Jonsbo U4	\N	ATX Mid Tower	Black	\N	Tempered Glass	29.8	2
Apevia Predator	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.7	3
Fractal Design Define 7 Compact	\N	ATX Mid Tower	White	\N	\N	42.5	2
SilentiumPC Signum SG1	\N	ATX Mid Tower	Black	\N	\N	\N	2
Jonsbo T8	\N	Mini ITX Desktop	Black	\N	Tempered Glass	8.4	1
Tempest Aura ARGB	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
GAMDIAS ARGUS E3	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GAMDIAS ATHENA E1 ELITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
darkFlash DLC29	\N	ATX Mid Tower	Black	\N	\N	38.6	2
MUSETEX Y4	\N	ATX Mid Tower	Black	\N	Tempered Glass	32.9	2
Antec NX292	\N	ATX Mid Tower	White	\N	Tempered Glass	37.6	2
CiT Dark Star	\N	ATX Mid Tower	Black	\N	Acrylic	41.3	2
DIYPC ARGB-Q01	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	40	2
RAIJINTEK OPHION 7L	\N	Mini ITX Desktop	Black	\N	Mesh	7.1	0
Vetroo M05	\N	MicroATX Mid Tower	Pink	\N	Tempered Glass	36.3	2
GameMax Brufen C3	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	42.2	2
GameMax Dragon Knight	\N	ATX Mid Tower	Black	\N	Acrylic	59.1	8
GameMax G563	\N	ATX Mid Tower	Black	\N	Acrylic	37.8	2
YEYIAN Phoenix	\N	ATX Mid Tower	Black	\N	Tempered Glass	47.3	2
Xigmatek Cubi	\N	ATX Mid Tower	Black	\N	Tempered Glass	62.8	2
SHARKOON Rebel C70G RGB	\N	ATX Mid Tower	Brown / White	\N	Tempered Glass	54.5	3
Armoury C802	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.4	2
RAIJINTEK OPHION M EVO ALS	69.9	MicroATX Mid Tower	Black	\N	\N	\N	3
Geometric Future Model 2 The ARK	99.9	MicroATX Mini Tower	Gray / Black	\N	Tempered Glass	40.7	1
iStarUSA S-917	211.96	Mini ITX Tower	Black	\N	\N	28.2	0
BitFenix Prodigy M 2022 ARGB	\N	MicroATX Mini Tower	Black / White	\N	Tempered Glass	\N	2
Silverstone FARA R1 PRO	108.86	ATX Mid Tower	White	\N	Tempered Glass	36	1
Silverstone FARA 514X	\N	ATX Mid Tower	White	\N	Tempered Glass	49.7	2
KOLINK Unity Solar Mesh ARGB	\N	ATX Mid Tower	White	\N	Tempered Glass	42.3	2
Antec CX600M RGB	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	46.8	1
Cougar Spike	\N	MicroATX Mini Tower	Black	\N	\N	28.2	2
Phanteks Enthoo EVOLV SHIFT X	\N	Mini ITX Tower	Black	\N	Tinted Tempered Glass	\N	2
Cooler Master MasterBox K500 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	46.9	2
Silverstone SETA Q1	\N	ATX Mid Tower	Black	\N	\N	56.2	2
Silverstone GD06B	\N	HTPC	Black	\N	\N	22.4	4
RAIJINTEK OPHION	\N	Mini ITX Desktop	Black	\N	Acrylic	\N	1
Cougar DarkBlader X5	177.76	ATX Mid Tower	White	\N	Tempered Glass	50	2
Zalman R2	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cougar MX430 Mesh RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.6	2
Jonsbo U5	\N	ATX Mid Tower	Silver	\N	Tempered Glass	40.3	2
Cougar Airface RGB	\N	ATX Mid Tower	White	\N	Tempered Glass	43.6	2
RAIJINTEK PAEAN MINI	\N	Mini ITX Tower	Black	\N	Tempered Glass	26	1
KOLINK Tranquility	\N	ATX Mid Tower	Black	\N	\N	40.6	2
Thermaltake A500	\N	ATX Mid Tower	Silver / Black	\N	Tempered Glass	67.4	6
Aerocool Playa Slim	\N	MicroATX Mini Tower	Black	\N	\N	\N	1
Zalman X3	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	\N	2
Jonsbo MOD-3	\N	ATX Mid Tower	Gray	\N	Tempered Glass	93.1	1
BitFenix Prodigy M 2022	\N	MicroATX Mini Tower	Black / White	\N	Tempered Glass	\N	2
Cougar MG140 Air RGB	\N	MicroATX Mini Tower	White / Black	\N	Tempered Glass	35.3	2
Cougar Dust 2	\N	Mini ITX Tower	Black / Gray	\N	Mesh	23.6	0
LC-Power Gaming 808B Skylla_X	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.7	2
Zalman P30 AIR	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	44.6	2
Apevia X-Cruiser	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	41.2	5
Logisys CS888CL	\N	ATX Mid Tower	Clear	\N	\N	43.3	6
NZXT Phantom	\N	ATX Full Tower	Pink / Black	\N	\N	74.3	7
In Win BK623.BN300TBL	\N	MicroATX Mini Tower	Black	300	\N	12.3	1
Thermaltake Commander MS-I ID	\N	ATX Mid Tower	Black	\N	Acrylic	41.1	5
Thermaltake Commander MS/I Snow Edition	\N	ATX Mid Tower	White / Black	\N	Acrylic	41.9	5
NZXT Switch 810	\N	ATX Full Tower	Black	\N	Acrylic	81.3	6
Cooler Master CM 690 II	\N	ATX Mid Tower	Black	\N	\N	57.4	6
Cooler Master Storm Scout 2	\N	ATX Mid Tower	White	\N	Acrylic	61.6	7
Xion XON-720P	\N	MicroATX Slim	White	300	\N	10.4	1
Topower TP-1687BS-400	\N	MicroATX Desktop	Black / Silver	400	\N	15.4	1
BitFenix Phenom M	\N	MicroATX Mini Tower	Black	\N	\N	30.6	5
Apevia X-Hermes	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	44.7	4
Corsair Graphite Series 230T	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	\N	4
Fractal Design Arc Midi R2	\N	ATX Mid Tower	Black	\N	\N	55.6	8
Antec Eleven Hundred V2	\N	ATX Mid Tower	Black	\N	Acrylic	67.6	6
Phanteks Enthoo Luxe	\N	ATX Full Tower	White / Black	\N	Acrylic	72.4	6
Lian Li PC-A79	\N	ATX Full Tower	Silver	\N	\N	\N	6
Thermaltake Core V51	\N	ATX Mid Tower	Black	\N	Acrylic	71.2	5
Nanoxia Deep Silence 5	\N	ATX Full Tower	Black	\N	\N	\N	11
Lian Li PC-T80	\N	ATX Test Bench	Black	\N	\N	\N	6
CiT Vanquish	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	5
Rosewill Stryker M	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Phanteks Enthoo Primo	\N	ATX Full Tower	Black / White	\N	Acrylic	\N	6
Phanteks Enthoo Pro M	\N	ATX Mid Tower	Green	\N	Acrylic	56.4	2
Aerocool Aero-800	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Zalman R1	\N	ATX Mid Tower	Black	\N	Acrylic	\N	4
Xion Xon-350	\N	ATX Mid Tower	Black	\N	\N	23.7	2
Antec P182	\N	ATX Mid Tower	Black	\N	\N	55.7	6
NOX Hummer MC	\N	ATX Mid Tower	White / Blue	\N	Acrylic	43.6	2
Corsair Carbide Series SPEC-ALPHA	\N	ATX Mid Tower	Black / Yellow	\N	Acrylic	\N	3
Lian Li PC-Q20	\N	Mini ITX Tower	Black	\N	\N	7.2	0
Silverstone PM01	\N	ATX Mid Tower	Black	\N	Acrylic	70.3	4
Apevia X-Mirage	\N	ATX Mid Tower	Pink	\N	Acrylic	41.8	2
GameMax FALCON WHITE RGB	\N	ATX Mid Tower	White / Black	\N	Acrylic	\N	2
SHARKOON VG4-W	\N	ATX Mid Tower	Black / Red	\N	Acrylic	38.3	3
Aerocool V3X Advance	\N	ATX Mid Tower	Black	\N	\N	30.4	3
Phanteks Enthoo EVOLV ITX TG	\N	Mini ITX Desktop	Black / Red	\N	Tinted Tempered Glass	34.1	2
Lian Li PC-O8X	\N	ATX Mid Tower	Gold	\N	Tempered Glass	\N	6
In Win BM639.AD160TBL	\N	Mini ITX Tower	Black	\N	\N	6.8	1
NZXT H700i	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	58.6	2
SHARKOON S25-S	\N	ATX Mid Tower	Black	\N	Acrylic	43.9	3
Aerocool P7-C0	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
EVGA DG-77	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Streacom BC1 Mini	\N	Mini ITX Test Bench	Silver	\N	\N	\N	0
NZXT H500i	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	41.3	3
Rosewill METEOR XR	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Thermaltake Versa J21	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
be quiet! Dark Base 700	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	7
Antec VSK10 Window	\N	MicroATX Mid Tower	Black	\N	Acrylic	\N	2
Fractal Design Vector RS Blackout	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	64.1	6
In Win EFS052	\N	ATX Mini Tower	Black	\N	\N	25.4	0
KOLINK INSPIRE K2 RGB	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	28.2	2
AvP Arion RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	34.6	2
Deepcool MATREXX 55 V3 ADD-RGB WH	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
NOX Hummer TGF	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
darkFlash DLM 21 Mesh	\N	MicroATX Mini Tower	White	\N	Tempered Glass	32.1	2
Apevia Predator	\N	ATX Mid Tower	Pink	\N	Tempered Glass	35.7	3
SilentiumPC Signum SG7V EVO TG ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Aerocool Atomic V2	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	36.2	2
MS Cyclops V	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Tempest Spectra RGB	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Aerocool Mecha	\N	ATX Mid Tower	Black	\N	Tempered Glass	33.5	2
Jonsbo MOD5	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	97.2	1
Silverstone CS330B	\N	MicroATX Mini Tower	Black	\N	\N	30.2	4
SAMA Sama-S88-BK	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	37.7	2
GameMax Contac Turbo COC	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	43	2
GameMax Contac Turbo COC	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	43	2
Vetroo AL600	\N	ATX Mid Tower	White	\N	Tempered Glass	41.7	3
Antec DF800 FLUX	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	3
In Win Explorer	\N	Mini ITX Desktop	White	\N	Tempered Glass	34.3	1
Thermaltake Versa T26 TG ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.6	2
MSI MAG SHIELD 110R	\N	ATX Mid Tower	Black	\N	Tempered Glass	36.5	2
ADATA XPG STARKER	\N	ATX Mid Tower	Black	\N	Tempered Glass	40	2
Ocelot OGEC01	\N	ATX Mid Tower	Black	\N	Tempered Glass	31.7	2
Jonsbo V11	\N	Mini ITX Tower	Silver	\N	Mesh	13	0
OCPC MINI	\N	Mini ITX Test Bench	Black	\N	\N	7.2	0
Thermaltake Core P5 V2	\N	ATX Mid Tower	Black	\N	Tempered Glass	115.4	6
MagniumGear NEO AIR (2023)	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	41.4	2
Noua Diamond C112	\N	ATX Mid Tower	White	\N	Tempered Glass	39.8	2
Cooler Master HAF XB EVO	\N	ATX Desktop	Black	\N	Acrylic	61.7	2
GALAX REV-01	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.9	2
Vetroo M03	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	36.1	2
Aerocool Dryft Mini V1	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	47	1
GameMax Aero	\N	ATX Mid Tower	Black / White	\N	Tempered Glass	40.7	2
GameMax Aero Mini	\N	MicroATX Mini Tower	Black / White	\N	Tempered Glass	31.5	2
GameMax Edge	\N	ATX Mid Tower	Black	\N	Tempered Glass	34.2	2
GameMax Infinity Mini	\N	MicroATX Mini Tower	White	\N	Tempered Glass	36.7	1
GameMax Silent Max	\N	ATX Mid Tower	Black	\N	\N	98.5	8
DIYPC ARGB-Q1.V2	\N	MicroATX Mini Tower	White	\N	Tempered Glass	\N	1
APNX C1-R	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.6	3
Ocypus Gamma C70 ARGB	\N	ATX Mid Tower	White	\N	Tempered Glass	40.3	2
Cooler Master Elite 302 Lite	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	34.1	1
Jonsbo C5	\N	ATX Mid Tower	Black	\N	Tempered Glass	34.5	4
Silverstone SETA A1	144.47	ATX Mid Tower	Silver / Black	\N	Tempered Glass	45.7	2
Geometric Future Model 5 Vent	159.9	ATX Mid Tower	White	\N	Tempered Glass	53.8	2
MagniumGear Neo G	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.4	2
Antec AX27 RGB ELITE	\N	ATX Mid Tower	\N	\N	Tempered Glass	32.2	2
Thermaltake View 300 MX Snow TG ARGB	144.98	ATX Mid Tower	White	\N	Tempered Glass	58.8	2
Thermaltake S250 TG ARGB	\N	ATX Mid Tower	White	\N	Tempered Glass	49.4	2
Antec P5	\N	MicroATX Mini Tower	Black	\N	\N	\N	2
Cougar DarkBlader X5	177.76	ATX Mid Tower	Black	\N	Tempered Glass	50	2
Deepcool CYCLOPS	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.5	2
KOLINK Inspire K6	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	32.7	2
SHARKOON Rebel C80M RGB	\N	ATX Mid Tower	Black	\N	Mesh	55.7	3
Silverstone RV05B	116.35	ATX Mid Tower	Black	\N	\N	63.8	2
In Win 301C	\N	MicroATX Mini Tower	White	\N	Tempered Glass	26	1
Cooler Master MasterCase MC500P	\N	ATX Mid Tower	Black	\N	Tempered Glass	65.9	4
Thermaltake Versa J22	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GameMax Vengeance	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.9	2
BitFenix FLOW	\N	ATX Mid Tower	White	\N	Tempered Glass	42.3	2
Aerocool CS-109-S	\N	ATX Mid Tower	Black	\N	\N	23.7	2
Cooler Master MasterBox 5T	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	2
Antec VSK10	295.77	MicroATX Mid Tower	Black	\N	\N	\N	2
Silverstone SETA A1	139.46	ATX Mid Tower	Black	\N	Tempered Glass	45.7	2
Thermaltake Divider 500 TG ARGB Air Snow	159.99	ATX Mid Tower	White	\N	Tempered Glass	56.8	2
Jonsbo D41 STD Screen	\N	ATX Mid Tower	White	\N	Tempered Glass	35.4	2
NZXT Phantom 820	\N	ATX Full Tower	Gunmetal	\N	Acrylic	92.8	6
NZXT H700i	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	58.6	2
Cooler Master MB600L ODD	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	2
NZXT H700	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	58.6	2
be quiet! Silent Base 601	\N	ATX Mid Tower	Black / Orange	\N	\N	\N	3
Jonsbo TR03-G	\N	ATX Mid Tower	Black	\N	Tempered Glass	95.3	3
Cooler Master Elite 300 TG	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	35.8	2
Enermax K8 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.4	2
Antec LanBoy Air	\N	ATX Mid Tower	Black / Yellow	\N	\N	58.5	6
Corsair Graphite Series 600T	\N	ATX Mid Tower	Black	\N	\N	79.3	6
Antec Twelve Hundred	\N	ATX Full Tower	Black	750	Acrylic	63.5	9
Cooler Master Centurion 5	\N	ATX Mid Tower	Black / Silver	\N	\N	42	4
Cooler Master CM690 II Basic	\N	ATX Mid Tower	Black	\N	\N	57.4	6
Thermaltake SopranoRS 101	\N	ATX Mid Tower	Black	\N	Acrylic	43.7	5
Thermaltake Element V	\N	ATX Full Tower	Black	\N	Acrylic	62.4	6
Cooler Master HAF 932 AMD Limited Edition	\N	ATX Full Tower	Black / Red	\N	Acrylic	76.5	5
Apevia X-Master	\N	HTPC	Black / Blue	500	\N	22	1
NZXT H2	\N	ATX Mid Tower	Black	\N	\N	51.8	8
Raidmax Cyclone	\N	ATX Mid Tower	Black / Red	450	\N	34.1	5
Fractal Design Define R3	\N	ATX Mid Tower	White	\N	\N	47.5	8
Azza Orion 202 EVO	\N	ATX Mid Tower	Black / Red	\N	Acrylic	43.5	4
Antec P280	\N	ATX Mid Tower	Black / Gray	\N	\N	68	6
Sentey SS1-2421	\N	MicroATX Slim	Black	250	\N	13.3	1
Silverstone PS07B	\N	MicroATX Mini Tower	Black	\N	\N	31.4	5
Cooler Master CM 690 II Advanced NVIDIA Edition	\N	ATX Mid Tower	Black	\N	Acrylic	55.7	4
Zalman ZM-Z9 U3	\N	ATX Mid Tower	Black	\N	Acrylic	48.3	5
In Win Z583T.CQ350TB3L	\N	MicroATX Mini Tower	Black / Silver	350	\N	24.2	1
Azza Genesis 9000W	\N	ATX Full Tower	White / Black	\N	Acrylic	93	5
Ultra XBlaster V2	\N	ATX Mid Tower	Black	450	\N	36	6
Thermaltake Armor Revo Gene Snow Edition	\N	ATX Mid Tower	White	\N	Acrylic	69.9	5
Cooler Master Storm Scout 2 Advanced	\N	ATX Mid Tower	Black	\N	Acrylic	61.6	7
Cooler Master N600	\N	ATX Mid Tower	Black	\N	\N	48.5	7
Rosewill Galaxy-02	\N	ATX Mid Tower	Black	\N	\N	26.4	4
BitFenix Prodigy M	\N	MicroATX Mini Tower	White	\N	\N	35.9	4
Antec 1100 Illusion	\N	ATX Full Tower	Black	\N	Acrylic	67.6	6
Corsair Carbide Series Air 540	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	62.6	2
Raidmax Vampire	\N	ATX Full Tower	White / Blue	\N	Acrylic	80.5	7
Fractal Design Define R4 Blackout	\N	ATX Mid Tower	Black	\N	Acrylic	56	8
Cooler Master 690 III	\N	ATX Mid Tower	Black / Green	\N	\N	58.5	7
Lian Li PC-A51	\N	ATX Mini Tower	Silver	\N	\N	\N	5
Phanteks Enthoo Primo	\N	ATX Full Tower	White	\N	Acrylic	\N	6
Zalman ZM-T4	\N	MicroATX Mini Tower	Black	\N	\N	\N	2
BitFenix Neos	\N	ATX Mid Tower	Black	\N	\N	37	3
Rosewill RISE Glow	\N	ATX Full Tower	Black	\N	Acrylic	55.9	5
Aerocool Mechatron-Black Steel Edition	\N	ATX Mid Tower	Black	\N	Acrylic	60.3	4
Aerocool XPredator X1	\N	ATX Mid Tower	Black	\N	\N	43.2	6
In Win IW-BQ656T.AD120TB3	\N	Mini ITX Tower	Black	120	\N	3.3	0
Phanteks Enthoo Primo	\N	ATX Full Tower	Black / Red	\N	Acrylic	\N	6
Lian Li PC-O6S	\N	HTPC	Black	\N	Tempered Glass	\N	6
In Win 703	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	4
be quiet! Silent Base 600	\N	ATX Mid Tower	Black	\N	\N	\N	3
DIYPC D480	\N	ATX Mid Tower	White	\N	Acrylic	\N	2
Phanteks Eclipse P400S	\N	ATX Mid Tower	Black	\N	\N	45.9	2
DIYPC Gamemax	\N	ATX Full Tower	Black	\N	Acrylic	61.7	4
Silverstone PM01	\N	ATX Mid Tower	Black / Red	\N	Acrylic	70.3	4
Deepcool Dukase	\N	ATX Mid Tower	White	\N	Acrylic	\N	3
EVGA DG-86	\N	ATX Full Tower	Gray	\N	Acrylic	\N	8
DAN Cases A4 SFX	\N	Mini ITX Desktop	Black	\N	\N	\N	0
Rosewill GUNGNIR X	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	2
Aerocool Aero-300	\N	ATX Mid Tower	Black	\N	Acrylic	37.8	2
Aerocool Aero-500	\N	ATX Mid Tower	White / Black	\N	Acrylic	45.1	4
Phanteks Enthoo EVOLV SHIFT	\N	Mini ITX Tower	Black	\N	Tinted Tempered Glass	24	1
Phanteks Enthoo Pro M TG	\N	ATX Mid Tower	Black / White	\N	Tinted Tempered Glass	56.4	2
be quiet! Dark Base 900	\N	ATX Full Tower	White	\N	Acrylic	82	7
BitFenix Enso	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Lian Li PC-V3000	\N	ATX Full Tower	Black	\N	Tinted Tempered Glass	\N	9
Cooler Master MB600L	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	2
Fractal Design Define R6	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	56.7	6
In Win 305	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
DIYPC Vision II	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	46.9	3
Streacom BC1 Mini	\N	Mini ITX Test Bench	Black	\N	\N	\N	0
Streacom BC1	\N	ATX Test Bench	Silver	\N	\N	\N	2
Antec P6	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	38.1	2
Lian Li PC-Q39GWX	\N	Mini ITX Desktop	Black	\N	Tempered Glass	\N	2
GamerChief HYVE	\N	ATX Full Tower	Black	\N	Acrylic	\N	4
Cooler Master MasterBox MB500 TUF Edition	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.5	2
NZXT H700	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	58.6	2
NZXT H400	\N	MicroATX Mini Tower	Black / Red	\N	Tempered Glass	36.9	1
SAMA ARK	\N	ATX Full Tower	Black / Blue	\N	Tempered Glass	\N	4
Corsair Carbide Series 275R	\N	ATX Mid Tower	Black / Red	\N	Acrylic	44.2	2
Fractal Design Define S2 Blackout	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	58.8	3
Cooler Master MasterCase SL600M	\N	ATX Mid Tower	Silver / Black	\N	Tempered Glass	\N	4
Enermax SABERAY RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	60.3	2
NZXT H700 Nuka-Cola	\N	ATX Mid Tower	Red / Black	\N	Tempered Glass	58.6	2
Tecware Nexus M	\N	MicroATX Mid Tower	White	\N	Tempered Glass	\N	2
NZXT H500 Overwatch	\N	ATX Mid Tower	Black / Orange	\N	Tempered Glass	41.3	3
Rosewill PRISM S	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	46.9	3
BitFenix Nova Mesh TG	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.4	2
GameMax Centauri	\N	MicroATX Mid Tower	Black / Red	\N	Acrylic	34.7	2
NZXT H510i Phantom Gaming	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	41.3	2
Antec Striker	\N	Mini ITX Tower	White	\N	Tempered Glass	39.6	0
Montech Air 900 MESH	\N	ATX Mid Tower	White	\N	Tempered Glass	44	2
Aerocool Sentinel	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	1
FSP Group CST 110	\N	MicroATX Mini Tower	Black	\N	\N	15.4	3
darkFlash DLM 22	\N	MicroATX Mid Tower	Pink	\N	Tempered Glass	\N	2
Enermax MarbleShell M MS20 ARGB	\N	MicroATX Mini Tower	White / Black	\N	Tempered Glass	\N	2
SilentiumPC Armis AR1	\N	ATX Mid Tower	Black	\N	\N	29.2	2
NZXT CRFT 08 H510 Valhalla	\N	ATX Mid Tower	Black / Gray	\N	Tempered Glass	41.3	2
GAMDIAS ARGUS E2 ELITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GAMDIAS ATHENA M2 LITE	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	2
GAMDIAS MARS M2	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	2
Jonsbo D30	\N	MicroATX Mini Tower	Silver / Black	\N	Tempered Glass	26.6	1
Vetroo AL600	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.7	3
darkFlash DLH21	\N	Mini ITX Tower	Black	\N	\N	17.2	1
In Win B1 Pure	\N	Mini ITX Desktop	White / Brown	200	\N	7.8	0
Thermaltake Divider 500 TG ARGB	164.98	ATX Mid Tower	Black	\N	Tempered Glass	56.8	2
Azza Crimson 211	\N	ATX Mid Tower	Black	\N	Acrylic	40.4	3
Corsair Carbide Series SPEC-02	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Inter-Tech C-702 DIORAMA	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.1	2
Cougar MX410	\N	ATX Mid Tower	Black	\N	Acrylic	36.3	2
Vetroo AL-MESH-7C	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.9	2
DIYPC ARGB-Q8-BK	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	28.4	2
Antec NX320	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.5	2
CiT Blaze	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	31.4	2
Apevia Destiny Pro	\N	ATX Mid Tower	Pink / Black	\N	Tempered Glass	42	2
Corsair iCUE 5000D RGB AIRFLOW iCUE Lighting Node PRO	\N	ATX Mid Tower	Black	\N	Tempered Glass	66.2	2
LC-Power Gaming 900B - Lumaxx Gloom	\N	ATX Mid Tower	Black	\N	Tempered Glass	57	2
Chieftec STALLION II	\N	ATX Mid Tower	Black	\N	Tempered Glass	62.5	2
Jonsbo MOD-3 Mini	\N	MicroATX Mid Tower	White	\N	Tempered Glass	76.4	1
Antec NX360 Elite	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.5	1
GALAX REV-06 RGB	\N	ATX Mid Tower	White	\N	Tempered Glass	39.5	2
GALAX REV-06 ARGB	\N	ATX Mid Tower	White	\N	Tempered Glass	39.5	2
GameMax M60	\N	MicroATX Mid Tower	White	\N	Mesh	29.4	2
Jonsbo BO 100	\N	Mini ITX Desktop	Black	\N	Tempered Glass	15.7	1
KOLINK Outline	\N	ATX Mid Tower	Black	\N	Tempered Glass	38.3	2
Thermaltake CTE E660 MX	\N	ATX Mid Tower	Green / Black	\N	Tempered Glass	77.4	3
GameMax Spark Mini	\N	Mini ITX Desktop	Black	\N	Tempered Glass	15.1	1
SAMA V Nature	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
MSI PRO FORGE M050A	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	32.8	2
Geometric Future Model 5 Vent Fanless	109.9	ATX Mid Tower	Black / Yellow	\N	Tempered Glass	53.8	2
Silverstone ALTA F1	290.88	ATX Mid Tower	Silver / Black	\N	Tempered Glass	56.8	2
SHARKOON MS-Z1000	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	26.2	1
Silverstone PM02-G	156.41	ATX Mid Tower	\N	\N	Tempered Glass	49.3	3
Antec NSK4100	\N	ATX Mid Tower	Black	\N	\N	35.6	6
Fractal Design Define R6	\N	ATX Mid Tower	Silver	\N	\N	56.7	6
Antec P110 Luce	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	6
LC-Power Gaming 807W Stormwatch_X	\N	ATX Mid Tower	White	\N	Tempered Glass	54.2	1
KOLINK Levante V2 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.6	3
Thermaltake Core P90	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	135.9	3
Azza Overdrive	\N	ATX Full Tower	Black	\N	Tempered Glass	\N	2
Thermaltake Divider 300 TG Air	124.98	ATX Mid Tower	Black	\N	Tempered Glass	48.2	2
Aerocool Graphite v3 ARGB	\N	ATX Mid Tower	\N	\N	Tempered Glass	43	2
Cooler Master Elite 330	\N	ATX Mid Tower	Black / Silver	\N	\N	38.2	5
Fractal Design Define XL R2	\N	ATX Full Tower	Gray	\N	\N	72.1	8
Corsair Graphite Series 230T	\N	ATX Mid Tower	Black / Red	\N	\N	\N	4
Thermaltake Versa N26	\N	ATX Mid Tower	Black	\N	Acrylic	44.7	3
Montech Fighter 500	\N	ATX Mid Tower	White	\N	Tempered Glass	38.6	2
Cougar Purity RGB	\N	MicroATX Mini Tower	White	\N	Tempered Glass	28.2	2
BitFenix Saber	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Thermaltake A700 TG	\N	ATX Full Tower	Silver	\N	Tempered Glass	102	4
Antec NX800	\N	ATX Mid Tower	White	\N	Tempered Glass	54	3
Thermaltake Divider 200 TG	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	51.6	3
MSI MAG PYLON	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.1	2
Azza Iris 330	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.5	2
RAIJINTEK Ponos Ultra TG4	\N	ATX Mid Tower	Black	\N	Tempered Glass	46.3	2
Cooler Master Sileo 500	\N	ATX Mid Tower	Black	500	\N	41.3	4
Cooler Master Storm Sniper	\N	ATX Mid Tower	Black	\N	\N	79.2	5
Lian Li PC-V351	\N	MicroATX Desktop	Black	\N	\N	27.1	2
Apevia X-Alien	\N	ATX Full Tower	Black	500	\N	50.9	5
Apevia X-FIT-200	\N	Mini ITX Tower	Black	250	\N	6.4	1
Broadway Com Corp 939PL	\N	ATX Mid Tower	Black	550	\N	34.4	4
Raidmax Blackstorm ATX-615WU	\N	ATX Mid Tower	Black / Blue	\N	\N	47.7	4
NZXT Source 210	\N	ATX Mid Tower	White / Black	\N	\N	42.4	8
Apex SK-386	\N	ATX Mid Tower	Black	300	\N	29.2	5
Lian Li PC-TU200	\N	Mini ITX Tower	Black	\N	\N	21.6	4
NZXT Phantom	\N	ATX Full Tower	Black / Green	\N	\N	74.3	7
Apevia ATXB2KL	\N	ATX Mid Tower	Beige / Gray	420	\N	40.2	4
Silverstone SG08B	\N	Mini ITX Desktop	Black	600	\N	14.8	1
NZXT Switch 810	\N	ATX Full Tower	Black	\N	Acrylic	81.3	6
Cooler Master Elite 311	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	40.8	5
Xigmatek Midgard II	\N	ATX Mid Tower	Black	\N	\N	45.4	6
Cooler Master HAF 922	\N	ATX Mid Tower	Black	\N	\N	71.5	5
Thermaltake V3 Black AMD Edition	\N	ATX Mid Tower	Black / Red	\N	Acrylic	38.5	4
Cougar Challenger	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	71.6	7
Silverstone GD04B-USB3.0	\N	HTPC	Black	\N	\N	21.3	2
NZXT Phantom 630	\N	ATX Full Tower	White	\N	Acrylic	92	6
Ultra Rogue M925	\N	ATX Full Tower	Black	\N	\N	61.9	8
Nanoxia Deep Silence 1	\N	ATX Mid Tower	Black	\N	\N	57	7
Zalman MS800 Plus	\N	ATX Mid Tower	Black	\N	Acrylic	\N	1
CFI Pharaoh Evo	\N	ATX Full Tower	Black	\N	Acrylic	109.4	10
Thermaltake Chaser A31 Snow White	\N	ATX Mid Tower	White	\N	Acrylic	52.7	6
Apevia X-Cruiser3	\N	ATX Mid Tower	Pink	\N	Acrylic	44.7	4
Apevia X-Sniper2	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	4
NZXT H230	\N	ATX Mid Tower	Black	\N	\N	43.7	6
Cubitek MagicCube-AIO	\N	ATX Mid Tower	Black	\N	\N	\N	5
Rosewill Legacy U3-B	\N	MicroATX Mini Tower	Black	\N	Acrylic	20.1	2
Raidmax Viper GX	\N	ATX Mid Tower	Black / Green	\N	\N	65.3	7
Raidmax Cobra Z	\N	ATX Mid Tower	Black / Red	\N	\N	59.5	3
Thermaltake Versa H21	\N	ATX Mid Tower	Black	\N	Acrylic	42.8	3
Thermaltake Urban T81	\N	ATX Full Tower	Black	\N	Acrylic	82.8	8
Lian Li PC-V1000L	\N	ATX Full Tower	Black	\N	\N	73.6	0
Thermaltake Commander G41	\N	ATX Mid Tower	Black	\N	Acrylic	57	6
Phanteks Enthoo EVOLV	\N	MicroATX Mini Tower	Black	\N	Acrylic	41.7	3
Cooler Master Silencio 652	\N	ATX Mid Tower	Black	\N	\N	\N	9
Xion XON 310	\N	MicroATX Mid Tower	Black	\N	\N	\N	1
Aerocool XPredator	\N	ATX Full Tower	White	\N	Acrylic	\N	6
Thermaltake Suppressor F51	\N	ATX Mid Tower	Black	\N	Acrylic	69.7	6
Lian Li PC-O5S	\N	HTPC	Black	\N	Tempered Glass	\N	5
Corsair Carbide Series SPEC-01	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	38.3	4
Thermaltake Core X2	\N	MicroATX Mini Tower	Black	\N	Acrylic	\N	4
be quiet! Silent Base 800	\N	ATX Mid Tower	Black	\N	Acrylic	\N	7
Phanteks Enthoo EVOLV ATX	\N	ATX Mid Tower	Silver	\N	Acrylic	\N	5
NZXT Manta	\N	Mini ITX Desktop	White / Black	\N	Acrylic	\N	2
DIYPC Zondda	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	\N	4
Raidmax Ninja II	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	\N	3
Phanteks Eclipse P400S	\N	ATX Mid Tower	White	\N	\N	45.9	2
BitFenix Nova	\N	ATX Mid Tower	White	\N	Acrylic	\N	4
Thermaltake Core X31	\N	ATX Mid Tower	Black	\N	Acrylic	\N	6
NOX Coolbay CX	\N	MicroATX Desktop	Black	\N	Acrylic	\N	3
NZXT H440 EnVyUs	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	53.3	8
be quiet! Dark Base 900	\N	ATX Full Tower	Black / Silver	\N	Acrylic	82	7
Azza Taurus 5000B	\N	ATX Full Tower	Black	\N	Acrylic	\N	8
DIYPC Silence	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Deepcool SMARTER	\N	MicroATX Mini Tower	Black / Blue	\N	\N	30.8	2
Lian Li PC-Q20	\N	Mini ITX Tower	White	\N	\N	7.2	0
Cooler Master MasterBox Lite 3	\N	MicroATX Mini Tower	Black	\N	Acrylic	26.9	1
NZXT H440	\N	ATX Mid Tower	Black / Green	\N	Acrylic	53.3	8
SHARKOON VG4-W	\N	ATX Mid Tower	Black / Green	\N	Acrylic	38.3	3
In Win 303 ROG RGB Edition	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	\N	2
Lian Li PC-D600	\N	ATX Full Tower	Black	\N	Acrylic	\N	6
Enermax OSTROG Lite	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
In Win 303 MSI Dragon	\N	ATX Mid Tower	White / Silver	\N	Tempered Glass	\N	2
Lian Li ALPHA 550X	\N	ATX Mid Tower	Black	\N	Tempered Glass	56.5	4
In Win A1	\N	Mini ITX Tower	Black	600	Tempered Glass	20.4	0
In Win A1	\N	Mini ITX Tower	White	600	Tempered Glass	20.4	0
Raidmax Zeta B04	\N	ATX Mid Tower	Black	\N	Tempered Glass	48.3	2
CiT F3	\N	MicroATX Mini Tower	Black / Purple	\N	Acrylic	\N	2
Corsair SPEC-OMEGA RGB Newegg Edition	\N	ATX Mid Tower	Black / Multicolor	\N	Tempered Glass	\N	3
SHARKOON VG5	\N	ATX Mid Tower	Black / Red	\N	Acrylic	38.3	3
Xigmatek Hawthorn	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	36.1	2
be quiet! Silent Base 801	\N	ATX Mid Tower	Black / Orange	\N	Tempered Glass	\N	5
Antec Dark Fleet DF500	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Tecware Nexus	\N	ATX Mid Tower	Black / White	\N	Tempered Glass	\N	2
SAMA Proxima-RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cooler Master MasterBox CM694 TG	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	6
Azza Apollo 430	\N	ATX Mid Tower	White	\N	Tempered Glass	41.3	4
BitFenix Nova Mesh TG 4ARGB	\N	ATX Mid Tower	White	\N	Tempered Glass	41.4	2
Thermaltake S500	\N	ATX Mid Tower	Black	\N	Tempered Glass	67.8	2
AvP Galaxy III	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	39.4	6
Montech Flyer Black	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cougar MG120	\N	MicroATX Mini Tower	Black	\N	\N	\N	2
Rosewill Tyrfing V2	\N	ATX Mid Tower	Black	\N	Acrylic	44.6	3
DIYPC Solo-T2-BK Black USB 3.0	\N	ATX Mid Tower	Black / Blue	\N	\N	39.1	3
Cougar Blazer	\N	ATX Mid Tower	Black / Orange	\N	Tempered Glass	\N	3
Aerocool Aero One Mini Eclipse	\N	MicroATX Mini Tower	White / Black	\N	Tempered Glass	\N	2
darkFlash DLX22	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
SilentiumPC Armis AR7	\N	ATX Mid Tower	Black	\N	Tempered Glass	63.9	3
SilentiumPC Signum SG1X EVO TG ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Montech X2 Mesh	\N	ATX Mid Tower	White	\N	Tempered Glass	32.3	2
Apevia Prodigy	\N	MicroATX Mini Tower	White	\N	Tempered Glass	32.5	2
Aerocool Trinity Mini V1	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	28.1	2
Vetroo A03	\N	ATX Mid Tower	Pink / Black	\N	Tempered Glass	\N	2
Vetroo M01	\N	MicroATX Mid Tower	Pink / Black	\N	Tempered Glass	36.6	2
DIYPC IDX6	\N	ATX Mid Tower	Black	\N	Tempered Glass	52.9	2
NZXT H510i Rivals	\N	ATX Mid Tower	Yellow / Black	\N	Tempered Glass	41.3	2
Cougar MX430 Air RGB	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	37.6	2
GameMax Contac Turbo COC	\N	ATX Mid Tower	Black / Gray	\N	Tempered Glass	43	2
GameMax Contac Turbo COC	\N	ATX Mid Tower	Pink / White	\N	Tempered Glass	43	2
darkFlash DLC29	\N	ATX Mid Tower	White	\N	\N	38.6	2
Antec DP505	\N	ATX Mid Tower	White	\N	Tempered Glass	51.9	2
Apevia Genesis Pro	\N	ATX Mid Tower	Pink	\N	Tempered Glass	35.7	3
Deepcool MACUBE 310P	\N	ATX Mid Tower	White	\N	Tempered Glass	45.2	2
Golden Field MAGE	\N	ATX Mid Tower	Green / Black	\N	Tempered Glass	47.6	2
Phanteks Evolv X	\N	ATX Mid Tower	White	\N	Tempered Glass	64.9	4
Cougar MX410-T	\N	ATX Mid Tower	Black	\N	Tempered Glass	36.3	2
Aerocool Delta	\N	ATX Mid Tower	Black	\N	Acrylic	30.3	2
Antec P7 NEO	\N	ATX Mid Tower	Black	\N	\N	46.3	2
CiT Raider AIR	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.3	2
Corsair iCUE 5000D RGB AIRFLOW iCUE Lighting Node PRO	\N	ATX Mid Tower	White	\N	Tempered Glass	66.2	2
Enermax StarryKnight SK30 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Xigmatek Overtake	\N	ATX Full Tower	Black	\N	Tempered Glass	67.8	2
ADATA XPG VALOR MESH ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.8	2
Jonsbo BO 100	\N	Mini ITX Desktop	Silver	\N	Tempered Glass	15.7	1
DIYPC G3-ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.3	2
GameMax Infinity Mini	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	36.7	1
GameMax Titan Silent	\N	ATX Full Tower	Black	\N	\N	53.8	8
MSI MAG FORGE 100M Lite	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.1	2
Mars Gaming MC9	\N	ATX Mid Tower	Black	\N	Tempered Glass	55.7	2
Jonsbo Jonsplus Z20	\N	MicroATX Desktop	Orange / White	\N	Tempered Glass	25.3	1
YEYIAN Haizen 2500	\N	MicroATX Mid Tower	White	\N	Tempered Glass	24.7	2
YEYIAN Vortex 1200	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	27.5	2
MSI MAG PANO M100L PZ	\N	MicroATX Mid Tower	White	\N	Tempered Glass	41.9	1
DIYPC ARGB-Q3 V2	\N	MicroATX Mini Tower	Pink	\N	Tempered Glass	38.6	2
Aerocool Zauron V2	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.6	2
GameMax Spark Mini	\N	Mini ITX Desktop	White	\N	Tempered Glass	15.1	1
Cooler Master Elite 600	\N	ATX Mid Tower	White	\N	Tempered Glass	52	2
RAIJINTEK STYX	89.99	MicroATX Mini Tower	Silver	\N	\N	\N	3
Silverstone FARA 513	\N	ATX Mid Tower	Black	\N	\N	44.6	2
Geometric Future M4 King Arthur	\N	ATX Mid Tower	White	\N	Tempered Glass	37.9	2
SHARKOON REV300	\N	ATX Full Tower	White	\N	Tempered Glass	65.6	4
Antec AX26 RGB ELITE	\N	ATX Mid Tower	\N	\N	Tempered Glass	32.2	2
Thermaltake S500 Tempered Glass Snow Edition	\N	ATX Mid Tower	White	\N	Tempered Glass	67.8	2
Antec AX67 ARGB	\N	ATX Mid Tower	\N	\N	Tempered Glass	36.4	2
Asus A23 PLUS	129	MicroATX Mid Tower	White	\N	Tempered Glass	47.4	2
RAIJINTEK Silenos Pro	207.78	ATX Mid Tower	Black	\N	Tempered Glass	39.8	2
Cooler Master HAF 932	\N	ATX Full Tower	Black	\N	Acrylic	76.7	5
In Win 303C	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.6	2
Fractal Design Define 7 Light	\N	ATX Mid Tower	Gray	\N	Tempered Glass	62.4	6
KOLINK Inspire K10 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	32.1	1
KOLINK Observatory Z	\N	ATX Mid Tower	Black	\N	Tempered Glass	56.4	2
Silverstone CS383	379.99	ATX Full Tower	Black	\N	\N	77	1
Thermaltake Core X71	\N	ATX Full Tower	Black	\N	Acrylic	\N	3
Thermaltake Versa C23 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
In Win 101C	\N	ATX Mid Tower	Blue	\N	Tempered Glass	\N	2
SHARKOON VS7	\N	ATX Mid Tower	Black	\N	\N	47	2
BitFenix Prodigy M 2022	\N	MicroATX Mini Tower	White / Black	\N	Tempered Glass	\N	2
Antec Dark Phantom DP31	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	31.9	2
Antec Dark Fleet DF-85	\N	ATX Full Tower	Black	\N	Acrylic	64.1	9
Antec ISK-100	\N	Mini ITX Tower	Black / Silver	80	\N	4.4	0
Antec P183	\N	ATX Mid Tower	Gray / Black	\N	\N	53.8	6
Antec Six Hundred	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	50.6	6
Antec Three Hundred Illusion	\N	ATX Mid Tower	Black	\N	\N	43.5	6
Cooler Master Elite 360	\N	ATX Mini Tower	Black	350	\N	23.2	1
Thermaltake Xaser VI	\N	ATX Full Tower	Silver / Black	\N	\N	98.9	7
Thermaltake ArmorPlus	\N	ATX Full Tower	Black	\N	Acrylic	90.8	7
Antec Twelve Hundred V3	\N	ATX Full Tower	Black	\N	Acrylic	63.5	9
Lian Li PC-9F	\N	ATX Mid Tower	Black	\N	\N	49.4	6
Lian Li PC-V354	\N	MicroATX Mini Tower	Silver	\N	\N	32.9	7
Apevia X-Dreamer3	\N	ATX Mid Tower	Pink	\N	Acrylic	37.1	6
Aerocool AeroEngine Plus	\N	ATX Mid Tower	Black	\N	\N	38	5
In Win Dragon Rider	\N	ATX Full Tower	Black	\N	\N	76.6	6
In Win IW-BP655.300TBL	\N	Mini ITX Desktop	Black	300	\N	8.1	0
Raidmax Smilodon ATX-612WB	\N	ATX Mid Tower	Black	\N	Acrylic	47.5	4
Rosewill Thor	\N	ATX Full Tower	Black	\N	\N	74.8	6
Sunbeam AC-9B-HUVB	\N	ATX Mid Tower	Clear	\N	\N	49.5	4
Antec P193 V3	\N	ATX Full Tower	Black	\N	\N	65.5	6
NZXT Phantom	\N	ATX Full Tower	Black / Orange	\N	\N	74.3	7
Azza Fusion 3000	\N	ATX Full Tower	Black	\N	\N	100.9	2
Rosewill R5	\N	ATX Mid Tower	Black	\N	\N	55.4	6
BitFenix Prodigy	\N	Mini ITX Tower	White	\N	\N	36	5
Xigmatek GIGAS	\N	MicroATX Desktop	Silver	\N	\N	35.2	6
NZXT Phantom 820	\N	ATX Full Tower	White	\N	Acrylic	92.8	6
Silverstone PS08B	\N	MicroATX Mid Tower	Black	\N	\N	23.7	4
Zalman Z5	\N	ATX Mid Tower	Black	\N	\N	45.8	3
Thermaltake Soprano	\N	ATX Mid Tower	Black	\N	\N	51.1	5
Silverstone SG02B-F-USB3.0	\N	MicroATX Desktop	White	\N	\N	22.4	2
In Win K1 BASIC	\N	MicroATX Mini Tower	Black	120	\N	4.7	0
Xion XON-710P	\N	MicroATX Slim	Black	300	\N	9.5	1
Thermaltake VP300A5W2N	\N	ATX Mid Tower	Blue	\N	Acrylic	52.7	6
NZXT H230	\N	ATX Mid Tower	White	\N	\N	43.7	6
Cooler Master N500	\N	ATX Mid Tower	Black	\N	\N	44.1	4
NZXT Phantom 630	\N	ATX Full Tower	Black	\N	Acrylic	92	6
Aerocool Strike-X Air	\N	ATX Test Bench	Black / Red	\N	\N	\N	3
Cooltek Antiphon	\N	ATX Mid Tower	Black	\N	\N	\N	4
Aerocool DS Cube	\N	MicroATX Mini Tower	Black	\N	Acrylic	41.5	2
Antec P183 V3 + 850	\N	ATX Mid Tower	Black	850	\N	53.2	6
Silverstone RV01B-W-USB3.0	\N	ATX Full Tower	Black	\N	Acrylic	113.1	6
LC-Power PRO-923B	\N	ATX Mid Tower	Black	\N	\N	\N	4
nMEDIAPC HTPC 1800B	\N	HTPC	Black	\N	\N	5.8	0
Thermaltake Versa H22	\N	ATX Mid Tower	Black	\N	Acrylic	42.8	0
Fractal Design Core 3300	\N	ATX Mid Tower	Black	\N	\N	54.3	3
Fractal Design Core 3500	\N	ATX Mid Tower	Black	\N	\N	56	4
Parvum Systems S2.0	\N	MicroATX Mini Tower	White / Purple	\N	Acrylic	\N	2
Apex TX-388	\N	MicroATX Mid Tower	Black	300	\N	25.8	4
Nanoxia Deep Silence 3	\N	ATX Mid Tower	Black	\N	\N	\N	5
SHARKOON T9 Value	\N	MicroATX Mid Tower	Black / Green	\N	Acrylic	\N	0
Corsair Graphite Series 380T	\N	Mini ITX Tower	Black / White	\N	\N	41	2
BitFenix Pandora	\N	MicroATX Mid Tower	Black	\N	\N	31.2	2
DIYPC Gamemax	\N	ATX Full Tower	White	\N	Acrylic	61.7	4
Raidmax Vortex	\N	ATX Mid Tower	Black	\N	Acrylic	42.4	3
BitFenix Aegis Core	\N	MicroATX Mid Tower	White	\N	Acrylic	46.2	4
Raidmax Horus	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Silverstone PS11B	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Apevia X-QPack3	\N	MicroATX Mini Tower	White	\N	Acrylic	\N	2
VIVO CASE-V01	\N	ATX Mid Tower	Black / Blue	\N	\N	\N	3
NZXT H440	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	53.3	8
DIYPC Ranger-R8	\N	ATX Mid Tower	Black / Green	\N	Acrylic	41.6	4
Phanteks Eclipse P400S	\N	ATX Mid Tower	White	\N	Tinted Acrylic	45.9	2
SHARKOON BW9000	\N	ATX Mid Tower	Black	\N	Acrylic	\N	5
Zodiac Aries A-100	\N	MicroATX Mid Tower	Black	\N	\N	\N	1
Antec NSK3100	\N	MicroATX Mini Tower	Black	\N	\N	\N	2
Zalman T2 Plus	\N	MicroATX Mini Tower	Black	\N	Acrylic	\N	2
Cooler Master Silencio 452	\N	ATX Mid Tower	Black	\N	\N	\N	6
VIVO CASE-V06	\N	MicroATX Mid Tower	Black	\N	Acrylic	\N	2
Silverstone PM01	\N	ATX Mid Tower	White / Blue	\N	Acrylic	70.3	4
Anidees Crystal	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Jonsbo UMX4 Zone	\N	ATX Mid Tower	Silver	\N	\N	38	2
DIYPC DIY-G5	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	43.2	2
Cooler Master MasterCase 5	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Thermaltake Core P5 TG	\N	ATX Mid Tower	Black / Silver	\N	Tinted Tempered Glass	115.4	3
Thermaltake Core P3	\N	ATX Mid Tower	Red	\N	Acrylic	80.1	2
Lian Li PC-O10	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.9	4
Phanteks Eclipse P400S	\N	ATX Mid Tower	Gray	\N	Tinted Tempered Glass	45.9	2
DAN Cases A4 SFX	\N	Mini ITX Desktop	Silver	\N	\N	\N	0
Silverstone RL06	\N	ATX Mid Tower	White / Black	\N	Acrylic	43.4	3
Azza Photios 250	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Thermaltake View 31 TG	\N	ATX Mid Tower	Black	\N	Acrylic	63.5	3
Corsair Carbide Series SPEC-ALPHA	\N	ATX Mid Tower	White / Blue	\N	Acrylic	\N	3
SHARKOON DG7000-G	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	\N	3
mean:it 5PM	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	51.5	3
Cooltek JB C2	\N	MicroATX Mini Tower	Silver	\N	\N	12.1	1
BitFenix Nova TG	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	40.8	3
BitFenix Nova TG	\N	ATX Mid Tower	White	\N	Tempered Glass	40.8	3
EVGA DG-84	\N	ATX Full Tower	Black	\N	\N	119.1	2
Rosewill SCM-01	\N	MicroATX Mini Tower	Black	\N	\N	\N	3
Thermaltake Versa N27	\N	ATX Mid Tower	Black	\N	Acrylic	\N	4
Thermaltake View 22	\N	ATX Mid Tower	Black	\N	Acrylic	51.1	2
Azza Thor 320	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.3	2
Cooler Master MasterBox E300L	\N	MicroATX Mini Tower	Black / Silver	\N	\N	\N	2
SHARKOON VG5	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	38.3	3
Lian Li LANCOOL ONE	\N	ATX Mid Tower	Black	\N	Tempered Glass	46.7	2
Thermaltake Level 20 GT	\N	ATX Full Tower	Black / Silver	\N	Tempered Glass	100.9	7
Cooler Master MasterBox MB510L	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
be quiet! Silent Base 601	\N	ATX Mid Tower	Black / Silver	\N	\N	\N	3
darkFlash T20	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Deepcool MATREXX 55 ADD-RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Tecware Nexus	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
Deepcool MATREXX 55 ADD-RGB WH	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
In Win D-Frame 2.0	\N	ATX Full Tower	White / Blue	1065	Tempered Glass	\N	4
Rosewill FBM-06	\N	MicroATX Mini Tower	Black	\N	\N	23.7	2
NZXT H500 Vault Boy	\N	ATX Mid Tower	Blue / Yellow	\N	Tempered Glass	41.3	3
Lian Li LANCOOL ONE Digital	\N	ATX Mid Tower	White / Silver	\N	Tempered Glass	46.7	2
SaharaGaming P75	\N	ATX Full Tower	\N	\N	Tempered Glass	\N	2
Cougar Gemini T	\N	ATX Mid Tower	Black	\N	Tempered Glass	64	2
ABKONCORE Cronos 350M	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	\N	2
GameMax Draco	\N	ATX Mid Tower	Black	\N	Tempered Glass	45	3
GameMax Ghost	\N	ATX Mid Tower	Black	\N	\N	38.1	1
GameMax Kamikaze PRO	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	39.6	2
GameMax Polaris	\N	ATX Mid Tower	Black	\N	Tempered Glass	44	3
Aerocool Bolt	\N	ATX Mid Tower	\N	\N	Tempered Glass	35.3	2
Silverstone SST-PS15B	\N	MicroATX Mid Tower	Black	\N	\N	25.7	1
Rosewill Zircon T	\N	ATX Mid Tower	Black	\N	Acrylic	44.6	3
Antec P82 Flow	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
SilentiumPC Regnum RG4T	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	46.8	3
Rosewill Prism T	\N	ATX Mid Tower	Black	\N	Tempered Glass	58.2	2
Cougar MX410 Mesh	\N	ATX Mid Tower	Black / Black	\N	\N	36.3	2
Cooler Master MasterCase H100 ARGB	\N	Mini ITX Desktop	Black	\N	\N	\N	1
Cooler Master CMP 501	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Segotep Argus	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
darkFlash DLX22	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
SHARKOON M25 Silent PCGH Edition	\N	ATX Mid Tower	Black	\N	\N	\N	3
Apevia Matrix	\N	ATX Mid Tower	White	\N	Tempered Glass	37.8	3
Cougar Gemini T Pro	\N	ATX Mid Tower	Black	\N	Tempered Glass	64	2
SilentiumPC Signum SG7V TG	\N	ATX Mid Tower	Black	\N	\N	\N	3
HYTE REVOLT 3 EU	\N	Mini ITX Tower	Black	700	Mesh	18.4	1
GAMDIAS MARS E1	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GAMDIAS TALOS M1	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
MOROVOL TW7-S2-WT	\N	MicroATX Mid Tower	White / Black	\N	Tempered Glass	27.1	2
Vetroo M01	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	36.6	2
Vetroo MESH6	\N	ATX Mid Tower	Black	\N	Tempered Glass	51	2
Deepcool MACUBE 310P	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.2	2
MSI Creator 400M	\N	ATX Mid Tower	Black	\N	Tempered Glass	65.4	2
Azza Thor 320DH	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.3	2
Aerocool Falcon V1	\N	ATX Mid Tower	Black	\N	Acrylic	33.6	1
NZXT H510 Siege	\N	ATX Mid Tower	Red / Black	\N	Tempered Glass	41.3	2
MSI MEG PROSPECT 700RL	\N	ATX Mid Tower	Black	\N	Tempered Glass	80.7	2
Cougar DarkBlader X7	\N	ATX Mid Tower	Black / Green	\N	Tempered Glass	50	2
RAIJINTEK OPHION ELITE TITAN	\N	Mini ITX Tower	Black	\N	Mesh	24.9	3
CiT Blade ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	38.9	2
GameMax Typhoon COC	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.7	2
Noua Mesh M9	\N	ATX Mid Tower	Black	\N	Mesh	38.6	2
GameMax Commando TG	\N	MicroATX Mid Tower	\N	\N	Tempered Glass	31.9	2
Thermaltake Versa T27 TG ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.7	2
Jonsbo TB01	\N	ATX Test Bench	Black	\N	\N	50.5	4
GameMax Master M905	\N	ATX Full Tower	Black	\N	Acrylic	53.8	8
DIYPC ARGB-Q01	\N	MicroATX Mini Tower	White	\N	Tempered Glass	40	2
Azza Mesa	\N	ATX Desktop	Silver / Black	\N	Tempered Glass	130.2	2
KOLINK Inspire X2	\N	ATX Mid Tower	Black	\N	Tempered Glass	30.1	2
KOLINK Observatory Lite Mesh ARGB	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	33.4	2
Aerocool Menace Saturn FRGB	145	ATX Mid Tower	Black	\N	Tempered Glass	36.7	2
Antec Draco 10	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	40	2
DIYPC Rainbow-Flash-S1	\N	ATX Mid Tower	Pink	\N	Tempered Glass	39.2	2
Cougar Uniface	\N	ATX Mid Tower	White	\N	Tempered Glass	53.9	2
SHARKOON Skiller SGC1 Window	\N	ATX Mid Tower	Blue	\N	Acrylic	47.5	2
Axiom Nova C013	\N	ATX Mid Tower	Black	\N	Tempered Glass	38.5	1
Asus Prime AP202	\N	MicroATX Mid Tower	White	\N	Tempered Glass	47.9	2
In Win EFS712	109.99	MicroATX Mini Tower	Black	\N	\N	25.5	3
BitFenix Tracery	\N	ATX Mid Tower	White	\N	Tempered Glass	52.8	4
Mars Gaming MC-LCD	\N	MicroATX Mini Tower	White	\N	Tempered Glass	33.2	1
GameMax Destroyer Mesh	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	43.6	2
CiT Home RGB	\N	MicroATX Mid Tower	Black	\N	\N	\N	3
Thermaltake SD101	\N	Mini ITX Tower	Black	180	Acrylic	8.2	1
Geometric Future Model 2 The ARK	\N	MicroATX Mini Tower	White	\N	Mesh	40.7	1
GameMax Silent Hill	\N	MicroATX Mini Tower	Black	\N	\N	25	2
Xigmatek Octans	\N	Mini ITX Desktop	Black	\N	\N	\N	2
RIOTORO CR400	\N	ATX Mid Tower	Black	\N	Acrylic	43	2
Geometric Future Model 8	151.88	ATX Mid Tower	Black / White	\N	Tinted Tempered Glass	57.5	3
MagniumGear NEO	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.8	2
KOLINK Unity Adapt ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.3	2
Streacom DA6 XL	\N	Mini ITX Test Bench	Silver	\N	\N	21.5	4
Antec ISK 310-150	\N	Mini ITX Desktop	Black / Silver	150	\N	6.9	0
Foxconn TS-689 (H+A)+ISO-450	\N	ATX Mid Tower	Black / Silver	350	\N	36.4	2
Silverstone SG04B-F	155.51	MicroATX Mini Tower	Black	\N	\N	24.7	2
Silverstone PS13	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Antec NX1000	\N	ATX Mid Tower	Black	\N	Tempered Glass	57.6	2
Noua Smash S1	\N	ATX Mid Tower	Black	\N	Tempered Glass	32.5	2
Jonsbo D32 STD MESH	\N	MicroATX Desktop	\N	\N	Tempered Glass	25.7	1
Thermaltake View 27	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Thermaltake View 27	\N	ATX Mid Tower	White / Black	\N	Acrylic	\N	2
Cougar Gemini S	\N	ATX Mid Tower	Silver / Black	\N	Tempered Glass	\N	2
Deco Gear DGPCS01	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
darkFlash DLH21	\N	Mini ITX Tower	White	\N	\N	17.2	1
Antec NX420	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.6	2
Cooler Master MasterBox MB400L	\N	MicroATX Mini Tower	Black	\N	\N	35.4	2
BitFenix Garen	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.3	2
Jonsbo U4 Pro MESH	\N	ATX Mid Tower	White	\N	Mesh	34.5	1
Antec ISK 300-150	\N	Mini ITX Desktop	Black	150	\N	6.9	0
Cooler Master Elite 310	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	39.1	6
Cooler Master Elite 370	\N	ATX Mid Tower	Black	\N	\N	38.7	5
Thermaltake Element G	\N	ATX Mid Tower	Black	850	\N	57.5	7
Thermaltake Dokker	\N	ATX Mid Tower	Black	\N	Acrylic	45.5	5
NZXT Gamma Classic	\N	ATX Mid Tower	Black	\N	\N	43.1	7
Lian Li PC-K62	\N	ATX Mid Tower	Black	\N	Acrylic	52.9	4
Antec One Hundred	\N	ATX Mid Tower	Black	\N	\N	45.2	6
Cooler Master ATCS 840	\N	ATX Full Tower	Black	\N	\N	88.5	6
Lian Li PC-T60	\N	ATX Test Bench	Black	\N	\N	45.6	3
Lian Li PC-C36B	\N	HTPC	Black	300	\N	15.3	2
Lian Li PC-C34F	\N	HTPC	Black	\N	\N	30.7	4
Lian Li PC-V354	\N	MicroATX Mini Tower	Black	\N	\N	32.9	7
Apevia X-Discovery	\N	ATX Mid Tower	Black	\N	Acrylic	41.2	4
NZXT Guardian 921 RB	\N	ATX Mid Tower	Black	\N	Acrylic	\N	4
Broadway Com Corp 1244MA	\N	ATX Mini Tower	Black	500	\N	20.8	2
Apex MJ-16	\N	MicroATX Mini Tower	Black	250	\N	16.9	3
Athenatech A100SC.200	\N	MicroATX Desktop	Black / Silver	200	\N	18.4	2
Athenatech A6605BS.450	\N	ATX Mini Tower	Black / Silver	450	\N	33.3	2
In Win BL647.300TBL	\N	MicroATX Slim	Black	300	\N	11.6	2
In Win BK623	\N	MicroATX Desktop	Black	300	\N	12.3	1
Raidmax Iceberg	\N	ATX Mid Tower	Black	\N	Acrylic	55.2	4
Silverstone FT02B	\N	ATX Mid Tower	Black	\N	Acrylic	64.8	5
Silverstone TJ07-BW	\N	ATX Full Tower	Black	\N	Acrylic	69.2	6
Silverstone LC13B-E	\N	HTPC	Black	\N	\N	32.4	4
Silverstone SG05BB-450	\N	Mini ITX Desktop	Black	450	\N	10.7	1
Dynapower EN-7255	\N	MicroATX Mid Tower	White	\N	\N	38.7	2
NZXT H2	\N	ATX Mid Tower	White	\N	\N	51.8	8
Corsair Graphite Series 600T Mesh	\N	ATX Mid Tower	Black	\N	Acrylic	79.3	6
nMEDIAPC HTPC 6000B	\N	HTPC	Black	\N	\N	29.9	5
Sentey DS1-4246	\N	ATX Mid Tower	Black	600	\N	36	4
BitFenix Shinobi	\N	ATX Mid Tower	Black	\N	\N	45.8	7
Antec Solo II	\N	ATX Mid Tower	Black	\N	\N	42.2	3
Antec P180	\N	ATX Mid Tower	White / Black	\N	\N	56	6
NZXT Tempest 210	\N	ATX Mid Tower	Black	\N	\N	43.6	8
Xigmatek Asgard Pro	\N	ATX Mid Tower	Black	\N	\N	41.5	7
BitFenix Shinobi XL Window	\N	ATX Full Tower	White	\N	Acrylic	77.6	7
Fractal Design Define R4	\N	ATX Mid Tower	White	\N	Acrylic	56	8
MSI Ravager	\N	ATX Mid Tower	Black	\N	\N	40.3	6
Silverstone SG05B-USB3.0	\N	Mini ITX Desktop	Black	300	\N	10.7	1
Silverstone FT03-MINI	\N	Mini ITX Tower	Black	\N	\N	17.5	1
Lian Li PC-Q03	\N	Mini ITX Tower	Black	\N	\N	10.2	1
In Win GR One	\N	ATX Full Tower	White / Black	\N	Acrylic	81	8
Lian Li PC-A76	\N	ATX Full Tower	Black	\N	\N	75.5	12
Rosewill ARMOR-EVO	\N	ATX Mid Tower	Black	\N	\N	58.3	7
Thermaltake Chaser A31	\N	ATX Mid Tower	Black	\N	Acrylic	52.7	6
Silverstone SG05-LITE	\N	Mini ITX Desktop	White	\N	\N	10.7	1
Thermaltake Urban S71	\N	ATX Full Tower	Black	\N	Acrylic	66.3	5
Silverstone SG10B	\N	MicroATX Mini Tower	Black	\N	\N	\N	2
In Win C583T.CQ350TB3L	\N	ATX Mid Tower	Black	350	\N	35	3
In Win GT1	\N	ATX Mid Tower	Black	\N	Acrylic	48.8	6
Silverstone LC16BM-USB3.0	\N	HTPC	Black	\N	\N	\N	6
Xion XON-720P	\N	MicroATX Slim	Red / Black	300	\N	10.4	1
Apevia X-Dreamer4	\N	ATX Mid Tower	Black	\N	Acrylic	43.1	4
Thermaltake Chaser A31 Thunder Edition	\N	ATX Mid Tower	White	\N	Acrylic	63.4	5
Rosewill PATRIOT	\N	ATX Mid Tower	Black	\N	Acrylic	51.7	6
Xigmatek Aeos	\N	MicroATX Mid Tower	Black	\N	\N	\N	2
DIYPC V3Plus	\N	Mini ITX Tower	Red	\N	\N	10.5	1
Cubitek HPTX ICE	\N	ATX Full Tower	Black	\N	\N	\N	8
Thermaltake Urban S71	\N	ATX Full Tower	Black	\N	\N	66.3	5
Logisys CS369BK	\N	ATX Mid Tower	Black	480	\N	\N	4
Rosewill Legacy U3-S	\N	MicroATX Mini Tower	Silver	\N	\N	20.1	2
Rosewill Legacy V3 Plus-B	\N	Mini ITX Tower	Black	\N	\N	10	1
Corsair Graphite Series 730T	\N	ATX Full Tower	Black	\N	Acrylic	78.7	6
Lian Li PC-A51	\N	ATX Mini Tower	Black	\N	\N	\N	5
Cougar MX300	\N	ATX Mid Tower	Black	\N	Acrylic	42.9	3
BitFenix Neos	\N	ATX Mid Tower	Black / Blue	\N	\N	37	3
Thermaltake Commander G42	\N	ATX Mid Tower	Black	\N	Acrylic	58.2	6
Xigmatek Nebula	\N	Mini ITX Tower	Black	\N	\N	22.3	2
Deepcool STEAM CASTLE	\N	MicroATX Mid Tower	Black	\N	Acrylic	47.1	3
SHARKOON T9 Value	\N	MicroATX Mid Tower	Black / White	\N	Acrylic	\N	0
BitFenix Comrade	\N	ATX Mid Tower	Black	\N	Acrylic	37	3
Silverstone RV05B-W	\N	ATX Mid Tower	Black	\N	Acrylic	63.8	2
Thermaltake Versa H25	\N	ATX Mid Tower	Black	\N	Acrylic	42.6	3
Nanoxia Deep Silence 5	\N	ATX Full Tower	Black / Gray	\N	\N	\N	11
DIYPC Ranger-R4	\N	ATX Mid Tower	Black / Red	\N	Acrylic	41.6	4
Xigmatek Spirit M	\N	MicroATX Mini Tower	Black	\N	Acrylic	\N	2
Lian Li PC-Q33	\N	Mini ITX Tower	Black	\N	Acrylic	18.1	2
DIYPC Cuboid	\N	MicroATX Mini Tower	Black / Green	\N	Acrylic	\N	3
Cooler Master N300	\N	ATX Mid Tower	Black	\N	Acrylic	39.5	7
Thermaltake Suppressor F51	\N	ATX Mid Tower	Black	\N	\N	69.7	6
Corsair Carbide Series 330R	\N	ATX Mid Tower	Black	\N	\N	49.9	4
Lian Li PC-O8X	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	6
Aerocool Aero-1000	\N	ATX Mid Tower	Black	\N	Acrylic	\N	5
Aerocool Aero-1000	\N	ATX Mid Tower	White	\N	Acrylic	\N	5
In Win 805	\N	ATX Mid Tower	Black / Gold	\N	Tempered Glass	\N	2
Phanteks Enthoo EVOLV ITX	\N	Mini ITX Tower	Black / White	\N	Acrylic	\N	2
Corsair Carbide Series SPEC-03	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	36.1	3
DIYPC Alnitak	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	4
RAIJINTEK STYX	\N	MicroATX Mini Tower	Green	\N	Acrylic	\N	3
Corsair Carbide Series SPEC-M2	\N	MicroATX Mid Tower	Black	\N	Acrylic	\N	2
CiT Spectre	\N	ATX Mid Tower	Black	\N	Acrylic	\N	4
Rosewill FBM-05	\N	MicroATX Mini Tower	Black	\N	\N	\N	2
Phanteks Eclipse P400	\N	ATX Mid Tower	Gray	\N	Tinted Acrylic	45.9	2
BitFenix Nova	\N	ATX Mid Tower	Black	\N	Acrylic	\N	4
Deepcool Dukase	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
DIYPC J180	\N	ATX Mid Tower	White	\N	Acrylic	\N	2
Zalman R1	\N	ATX Mid Tower	White / Gold	\N	Acrylic	\N	4
Antec Super Lanboy	\N	ATX Mid Tower	Silver	\N	Acrylic	\N	4
DIYPC J180	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Cougar MX200	\N	ATX Mid Tower	Black	\N	\N	\N	6
MS-Tech X3 Crow	\N	ATX Full Tower	Black / Red	\N	Acrylic	59.5	4
NOX Coolbay SX	\N	ATX Mid Tower	Black / Blue	\N	\N	37.9	4
Silverstone RL05	\N	ATX Mid Tower	Black / Red	\N	Acrylic	43.9	2
Phanteks Enthoo Luxe TG	\N	ATX Full Tower	Gray	\N	Tinted Tempered Glass	72.4	6
NZXT Noctis 450	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	6
Lian Li PC-Q37	\N	Mini ITX Tower	Black	\N	Tempered Glass	28.3	2
Cooler Master MasterCase Pro 6	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	70.1	5
Silverstone PM01	\N	ATX Mid Tower	White	\N	Acrylic	70.3	4
Phanteks Enthoo Elite	\N	ATX Full Tower	Gray	\N	Tinted Tempered Glass	124.5	6
DIYPC MA01	\N	MicroATX Mini Tower	Black / Red	\N	\N	20.5	1
Anidees AI Crystal Cube Lite	\N	ATX Desktop	Black	\N	Tempered Glass	50.5	3
DIYPC DIY-BG01	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
NZXT S340 Elite	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	41.6	2
Azza Titan 240	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Anidees AI Crystal Cube	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	50.5	3
Azza Storm 6000B	\N	ATX Full Tower	Black	\N	Tempered Glass	63.6	4
Cooler Master Elite 342	\N	MicroATX Mini Tower	Black	\N	\N	27.9	5
Cooler Master Elite 343	\N	MicroATX Mini Tower	Black	420	\N	29.1	5
EVGA DG-85	\N	ATX Full Tower	Black	\N	Acrylic	119.1	2
Thermaltake Versa N27	\N	ATX Mid Tower	Black	\N	Acrylic	\N	4
Antec Cube	\N	Mini ITX Tower	Black / Green	\N	Acrylic	42	1
Cooler Master MB600L	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	\N	2
EVGA DG-77	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
SAMA Maxcool-W-15	\N	MicroATX Mid Tower	Black / Red	\N	Acrylic	\N	3
GamerChief HYVE	\N	ATX Full Tower	White / Black	\N	Acrylic	\N	4
NZXT H200	\N	Mini ITX Tower	Black / Red	\N	Tempered Glass	27.3	1
RAIJINTEK PAEAN	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Cooler Master MasterBox MB511	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Phanteks Enthoo Pro M TG	\N	ATX Mid Tower	Green / Black	\N	Tinted Tempered Glass	56.4	2
RAIJINTEK COEUS ELITE TC	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	50.5	0
Zalman Z9 NEO Plus	\N	ATX Mid Tower	White / Black	\N	Acrylic	\N	2
Xigmatek Frontliner	\N	ATX Mid Tower	Black	\N	Acrylic	45.1	2
Thermaltake Versa J25	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Fractal Design Define S2	\N	ATX Mid Tower	Silver	\N	Tinted Tempered Glass	58.8	3
Fractal Design Define S2	\N	ATX Mid Tower	White	\N	Tempered Glass	58.8	3
In Win 915	\N	ATX Full Tower	Silver	\N	Tempered Glass	\N	4
Aerocool Quartz RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	38.3	2
DIYPC Rainbow-Flash-R1	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cougar GEMINI X	\N	ATX Full Tower	Black	\N	Tempered Glass	\N	4
Deepcool MATREXX 70	\N	ATX Mid Tower	Black	\N	Tempered Glass	54.2	2
Cougar MX330-X-STE500	\N	ATX Mid Tower	Black	500	\N	39.4	2
Raidmax Magnus	\N	ATX Mid Tower	Black	\N	Tempered Glass	85.7	2
Rosewill PRISM S LITE	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	46.9	3
GameMax Aurora	\N	ATX Mid Tower	Black	\N	Tempered Glass	50	2
GameMax Cobalt	\N	ATX Mid Tower	Black	\N	Tempered Glass	52.3	2
GameMax Crusader	\N	ATX Mid Tower	Black	\N	Tempered Glass	34.8	3
GameMax Expedition	\N	MicroATX Mini Tower	Red	\N	Acrylic	29.4	2
Aerocool Quartz REVO	\N	ATX Mid Tower	Black	\N	Tempered Glass	38.3	2
DIYPC DIY-A1-W	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
Antec Dark Phantom DP501	\N	ATX Mid Tower	White	\N	Tempered Glass	64	2
Deepcool Gamer Storm MACUBE 550	\N	ATX Mid Tower	White	\N	Tempered Glass	65.9	4
Maingear Vybe Mk. V	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	38.4	2
Montech Air 900 ARGB	\N	ATX Mid Tower	White	\N	Tempered Glass	44	2
Rosewill Zircon M	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.2	2
NZXT H510 Alliance	\N	ATX Mid Tower	Blue	\N	Tempered Glass	41.3	2
In Win 925	\N	ATX Full Tower	Black	\N	Tempered Glass	\N	4
Fractal Design Era ITX	\N	Mini ITX Desktop	Gold / Black	\N	Tinted Tempered Glass	16.7	1
KOLINK BALANCE ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Thermaltake Core P3 TG Curved	\N	ATX Mid Tower	Black	\N	Tempered Glass	80.1	2
SilentiumPC Regnum RG4T RGB	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	46.8	3
Cougar DarkBlader-G	\N	ATX Full Tower	Black / Silver	\N	Tempered Glass	\N	4
Cooler Master MasterBox E500 (w/o ODD)	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Silverstone FARA R1	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	1
Silverstone FARA R1	\N	ATX Mid Tower	White	\N	\N	\N	1
darkFlash V22	\N	ATX Mid Tower	Pink	\N	Tempered Glass	41.7	1
Cougar MX331 MESH-X	\N	ATX Mid Tower	Black	\N	\N	43.5	2
Deco Gear DGPCS20X	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	53.3	2
Phanteks EVOLV SHIFT 2 AIR	\N	Mini ITX Tower	Gray / Black	\N	\N	\N	1
SilentiumPC Armis AR6Q EVO ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	46	2
Thermaltake Versa T25	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.9	2
SilentiumPC Signum SG1Q EVO TG ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Apevia Genesis-WH	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	3
Corsair iCUE 5000X RGB Triptych	\N	ATX Mid Tower	Black / Green	\N	Tempered Glass	66.2	2
Tempest Vision RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	0
Thermaltake Commander G33	\N	ATX Mid Tower	Black	\N	Tempered Glass	46.9	2
Antec Dark Phantom DP502 Flux	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	49.5	3
GAMDIAS ATHENA M1	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.5	2
GAMDIAS TALOS M1 ELITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Montech AIR 1000 SILENT	\N	ATX Mid Tower	White	\N	\N	\N	2
SilentiumPC Ventum VT4V TG	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
SilentiumPC Ventum VT4 TG	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
ADATA XPG DEFENDER PRO	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	47.7	2
Cooler Master CMP 510	\N	ATX Mid Tower	Black	\N	Tempered Glass	42	2
Thermaltake AH T200	\N	MicroATX Mid Tower	Turquoise / Black	\N	Tempered Glass	69.1	2
Thermaltake The Tower 100	\N	Mini ITX Tower	Gold	\N	Tempered Glass	32.7	2
Thermaltake Divider 500 TG ARGB Air	164.98	ATX Mid Tower	Black	\N	Tempered Glass	56.8	2
ADATA XPG CRUISER	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.8	4
Jonsbo VR4	\N	ATX Mid Tower	Black	\N	Mesh	37.8	2
Jonsbo U4 Plus	\N	ATX Mid Tower	Silver	\N	Tempered Glass	31.7	1
SAMA AM07GG	\N	MicroATX Mid Tower	White	\N	Tempered Glass	38.7	2
UNYKAch UK3002	\N	MicroATX Desktop	Black	\N	\N	21.2	0
Thermaltake H590 TG ARGB	\N	ATX Mid Tower	White	\N	Tempered Glass	49.1	2
Antec AX51 Elite	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.2	2
Antec AX51	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.2	2
Cooler Master MasterBox MB520	\N	ATX Mid Tower	Black	\N	Acrylic	50.4	2
Cooler Master MasterBox MB520	\N	ATX Mid Tower	Black / White	\N	Acrylic	50.4	2
Tecware Nexus Evo RGB	\N	ATX Mid Tower	White	\N	Tempered Glass	35.4	2
Vetroo M03	\N	MicroATX Mini Tower	White	\N	Tempered Glass	36.1	2
Vetroo M03	\N	MicroATX Mini Tower	Green	\N	Tempered Glass	36.1	2
RAIJINTEK OPHION 7L	\N	Mini ITX Desktop	White	\N	Mesh	7.1	0
FSP Group CMT380 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.5	2
BGears b-Draco5907-RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.2	3
Thermaltake H700 TG	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.5	2
SilentiumPC Regnum RG1W	\N	ATX Mid Tower	Black	\N	Acrylic	39.4	2
DIYPC IDX3-ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.9	2
GameMax Kreator	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.7	2
YEYIAN Kalt 1101	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	26.3	2
DIYPC ARGB-Q3 V2	\N	MicroATX Mini Tower	Green	\N	Tempered Glass	38.6	2
SHARKOON Skiller SGC1 Window	\N	ATX Mid Tower	Green	\N	Acrylic	47.5	2
FSP Group CMT120	\N	ATX Mid Tower	Black	\N	Acrylic	34.5	2
Ocypus Gamma C72	\N	ATX Mid Tower	Black	\N	Tempered Glass	43	2
Cougar MX330-G Pro	\N	ATX Mid Tower	White	\N	Tempered Glass	49.1	2
Rosewill REDBONE U3	\N	ATX Mid Tower	Black / Red	\N	\N	37.4	6
Chieftec BT-04B-U3-250VS (230V)	262	Mini ITX Tower	Black	250	\N	10.5	1
RAIJINTEK Metis Plus	\N	Mini ITX Tower	Blue	\N	Acrylic	13.4	2
In Win Alice	\N	ATX Mid Tower	Gray / Black	\N	\N	\N	1
SHARKOON MS-Y1000	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	26.2	1
Zalman M1	\N	Mini ITX Tower	Black	\N	\N	\N	3
Azza Apollo 430	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.3	4
RAIJINTEK METIS EVO TGS	\N	Mini ITX Desktop	Black	\N	Tempered Glass	22.3	2
Thermaltake Divider 300 TG Snow	\N	ATX Mid Tower	White	\N	Tempered Glass	48.2	2
Chieftec UK-02W-OP	\N	ATX Mid Tower	White	\N	\N	29.6	2
GameMax Brufen C3	\N	ATX Mid Tower	Black / White	\N	Tempered Glass	42.2	2
GameMax Vega	97.99	ATX Mid Tower	Gray / Black	\N	Tempered Glass	53.2	3
BitFenix Saber Mesh	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.3	2
Silverstone CS01-HS	180.49	Mini ITX Tower	Black	\N	\N	\N	0
BitFenix Shogun	\N	ATX Mid Tower	Black	\N	Acrylic	74.2	6
In Win EM048	351.24	MicroATX Mini Tower	Black	\N	\N	\N	1
SHARKOON S25-V	\N	ATX Mid Tower	Black	\N	\N	43.9	3
In Win 303C	\N	ATX Mid Tower	White	\N	Tempered Glass	51.6	2
be quiet! Silent Base 801	\N	ATX Mid Tower	Black / Orange	\N	\N	\N	5
Cougar Gemini M	\N	MicroATX Mini Tower	Silver	\N	Tempered Glass	35.7	2
Jonsbo UMX1 Plus	\N	Mini ITX Desktop	Black	\N	\N	16.6	1
Jonsbo V4	\N	MicroATX Mini Tower	\N	\N	\N	19.2	2
Thermaltake H590 TG ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.1	2
KOLINK INSPIRE K3 ARGB	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	28.2	2
KOLINK Observatory Z Mesh	\N	ATX Mid Tower	Black	\N	Tempered Glass	56.4	2
KOLINK Refine	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.6	2
Zalman P30 AIR	\N	MicroATX Mini Tower	White	\N	Tempered Glass	44.6	2
Antec ISK 300-65	\N	Mini ITX Desktop	Black	65	\N	6.9	0
Antec LanBoy Air	\N	ATX Mid Tower	Black	\N	\N	58.5	6
Antec Three Hundred	\N	ATX Mid Tower	Black	430	\N	43.5	6
Cooler Master Cosmos Pure	\N	ATX Full Tower	Black	\N	\N	99.2	6
Cooler Master Elite 335	\N	ATX Mid Tower	Black	\N	\N	36.9	6
Cooler Master Elite 341	\N	MicroATX Mid Tower	Black	\N	\N	26.8	2
Cooler Master Centurion 534	\N	ATX Mid Tower	Black	\N	\N	42	4
Cooler Master USP 100	\N	ATX Mid Tower	Black / Red	550	\N	52.5	6
Antec Fusion Remote	\N	HTPC	Black	\N	\N	25.6	2
Thermaltake Level 10	\N	ATX Full Tower	Black	\N	\N	129.6	6
Thermaltake ARMOR A90	\N	ATX Mid Tower	Black / Silver	850	Acrylic	54.3	6
Rosewill R101-P	\N	MicroATX Mid Tower	Black	450	\N	25.3	4
Cooler Master Centurion 590	\N	ATX Mid Tower	Black	\N	\N	46.9	0
Lian Li PC-Q07	\N	Mini ITX Tower	Black	\N	\N	11.2	1
Lian Li PC-Q08	\N	Mini ITX Tower	Black	\N	\N	21.2	6
Lian Li PC-7FN	\N	ATX Mid Tower	Black	\N	\N	47.9	4
Lian Li PC-A05N	\N	ATX Mini Tower	Silver	\N	\N	39.1	3
Lian Li PC-T7	\N	Mini ITX Test Bench	Silver	\N	\N	18.6	1
Lian Li PC-V2120	\N	ATX Full Tower	Silver	\N	\N	93.5	10
Apevia X-Plorer2	\N	ATX Mid Tower	Black / Pink	\N	Acrylic	39.2	5
Apevia X-QPack2	\N	MicroATX Desktop	Black / Green	500	Acrylic	24.2	2
HEC 7106BB	\N	ATX Desktop	Black	\N	\N	28.7	2
HEC ITX200A	\N	HTPC	Black	200	\N	5.8	1
NZXT Tempest EVO	\N	ATX Mid Tower	Black	\N	Acrylic	61.8	8
Apex DM-317-A	\N	MicroATX Slim	Black / Silver	275	\N	12.9	1
Apex PC-375	\N	ATX Mid Tower	Black	300	\N	33.2	4
Apex TM366BK	\N	MicroATX Mid Tower	Black	300	\N	25	1
Apex Vortex 3620	\N	ATX Mid Tower	Black	\N	\N	33.2	5
Diablotek CPA-6170	\N	ATX Mid Tower	Black	\N	\N	38.4	5
Foxconn DH-045(H+A)+MT-300	\N	MicroATX Slim	Black	300	\N	13	1
Foxconn TLM-436(H+A)+ISO-400-4SS	\N	MicroATX Mini Tower	Black / Silver	300	\N	25.7	4
Foxconn TS-001(H+A)+ISO-400-4SS	\N	ATX Mid Tower	Black / Silver	300	\N	36.4	2
In Win BP655.200BL	\N	Mini ITX Desktop	Black	200	\N	8.1	0
In Win BQ656.AD80TBL	\N	Mini ITX Tower	Black	80	\N	3.3	0
In Win Maelstrom	\N	ATX Full Tower	Black	\N	\N	74.1	6
In Win Matrix	\N	MicroATX Mini Tower	White	300	\N	17.8	1
Raidmax Icecube	\N	MicroATX Desktop	Black	\N	\N	33.1	4
XClio Godspeed One Advanced	\N	ATX Mid Tower	Black	\N	Acrylic	44.3	5
Xigmatek Asgard II	\N	ATX Mid Tower	Black	\N	\N	35.5	5
Zalman Z7	\N	ATX Mid Tower	Black	\N	\N	48.4	5
Lian Li LanCool PC-K57	\N	ATX Mid Tower	Black	\N	\N	47.1	3
NZXT Phantom	\N	ATX Full Tower	White / Black	\N	\N	74.3	7
Apevia X-Trooper-Jr	\N	ATX Mid Tower	Black	\N	Acrylic	29.8	3
Raidmax ATX-298WY	\N	ATX Mid Tower	Black / Yellow	\N	Acrylic	42.9	4
Sentey CS2-1333	\N	ATX Mid Tower	Black	\N	\N	25.9	2
Diablotek ELITE	\N	ATX Mid Tower	Black	450	\N	27.9	2
Sentey GS-6400R - ARVINA	\N	ATX Full Tower	Red / Black	\N	\N	60.7	5
Apevia X-Dreamer	\N	ATX Mid Tower	Blue	420	Acrylic	36	5
Silverstone RV03B-W	\N	ATX Full Tower	Black / Silver	\N	Acrylic	69.4	4
Rosewill REDBONE	\N	ATX Mid Tower	Black / Red	\N	\N	37.4	6
Sigma ZEN-WAR	\N	ATX Mid Tower	Blue / Silver	\N	Acrylic	74.1	3
Sentey GS-6000R	\N	ATX Mid Tower	Black	\N	\N	42.5	4
Cooler Master Elite 371	\N	ATX Mid Tower	Black / Silver	400	\N	38.7	5
In Win IW-BQ656T.AD80TBL	\N	HTPC	Black	80	\N	3.3	0
Thermaltake Commander MS-I Epic Edition	\N	ATX Mid Tower	Black / Red	\N	Acrylic	41.9	5
Thermaltake Level 10 GTS	\N	ATX Mid Tower	Black	\N	\N	54.9	5
BitFenix Shinobi XL	\N	ATX Full Tower	Black	\N	\N	77.2	7
Fractal Design Define R4	\N	ATX Mid Tower	White	\N	\N	56	8
Diablotek PREDATOR	\N	ATX Mid Tower	Black	\N	\N	39.7	5
Diablotek CITADEL	\N	ATX Mid Tower	Black	\N	\N	31.6	5
MSI TC	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Lian Li PC-A55	\N	ATX Mid Tower	Silver	\N	\N	31.8	2
Gigabyte GZ-G2SGB	\N	ATX Mid Tower	Black	\N	\N	33.8	6
BitFenix Ghost	\N	ATX Mid Tower	Black	\N	\N	55.8	4
BitFenix Prodigy	\N	Mini ITX Tower	Red	\N	\N	36	5
Ultra Rogue M950	\N	ATX Full Tower	Black	\N	\N	61.9	8
Thermaltake Level 10 GT Battle Edition	\N	ATX Full Tower	Green / Black	\N	\N	96.7	5
Thermaltake Urban S21	\N	ATX Mid Tower	Black	\N	Acrylic	40.1	5
Cougar Archon	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	\N	3
Rosewill THRONE	\N	ATX Full Tower	Black	\N	\N	74.8	10
Cooler Master Elite 430	\N	ATX Mid Tower	Black	\N	Acrylic	39.5	5
Xion XON-720P	\N	MicroATX Slim	Black	300	\N	10.4	1
Apevia X-Dreamer4	\N	ATX Mid Tower	Black / Green	\N	Acrylic	43.1	4
Raidmax ATX-605BT	\N	ATX Full Tower	Black	\N	Acrylic	75.6	6
Thermaltake Versa G2	\N	ATX Mid Tower	Black	\N	Acrylic	40.1	5
Thermaltake New Soprano Snow Edition	\N	ATX Mid Tower	White	\N	\N	51.2	5
BitFenix Prodigy	\N	Mini ITX Tower	Blue	\N	Acrylic	36	5
In Win H-Frame Mini	\N	Mini ITX Tower	Black / Red	180	\N	\N	0
Thermaltake Versa II	\N	ATX Mid Tower	Black	\N	\N	\N	5
Antec GX500	\N	ATX Mid Tower	Black	\N	\N	44.4	4
Aerocool GT-S	\N	ATX Full Tower	Black / Red	\N	Acrylic	\N	7
Cooler Master HAF Stacker 915F	\N	Mini ITX Tower	Black	\N	\N	32.4	3
Nanoxia NXDS6B	\N	ATX Full Tower	White	\N	\N	\N	13
Cooler Master Elite 241	\N	ATX Mini Tower	Black	400	\N	\N	2
Cooler Master Storm Scout 2	\N	ATX Mid Tower	Gunmetal	\N	Acrylic	61.6	7
Azza XT-1	\N	ATX Full Tower	Black / Red	\N	Acrylic	59.8	6
BitFenix Comrade	\N	ATX Mid Tower	Black / White	\N	\N	37	3
Rosewill Legacy V4-B	\N	MicroATX Mini Tower	Silver	\N	\N	18.3	3
Rosewill THRONE-G-Window	\N	ATX Full Tower	Black / Red	\N	Acrylic	74.8	10
Supermicro CSE-732G-500B	\N	ATX Mid Tower	Black / Blue	500	Acrylic	64.7	3
Supermicro CSE-732G-903B	\N	ATX Mid Tower	Black / Blue	900	Acrylic	64.7	3
Xigmatek Aquila	\N	MicroATX Mini Tower	Black	\N	Acrylic	\N	2
Corsair Carbide Series SPEC-03	\N	ATX Mid Tower	Black / White	\N	Acrylic	36.1	3
Gigabyte GZ-G3 PLUS	\N	ATX Mid Tower	Black / Red	\N	\N	33.6	6
Cooler Master HAF 912 Advanced	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	6
Cooler Master K350	\N	ATX Mid Tower	Black	\N	Acrylic	\N	6
Deepcool STEAM CASTLE	\N	MicroATX Mid Tower	Yellow	\N	Acrylic	47.1	3
Lian Li PC-A61	\N	ATX Mid Tower	Silver	\N	\N	57.4	6
Lian Li PC-Q01	\N	Mini ITX Tower	Black	\N	\N	13.2	2
Lian Li PC-V2130	\N	ATX Full Tower	Silver	\N	\N	94.4	8
Azza SIRIUS	\N	ATX Mid Tower	Black	\N	Acrylic	38.3	3
DIYPC M88	\N	MicroATX Mini Tower	Black	\N	\N	21.1	3
In Win BK644.BH300TB3	\N	MicroATX Mini Tower	Black / Silver	300	\N	12.3	0
In Win BP655.FH300TB3	\N	Mini ITX Tower	Black / Blue	300	\N	8.1	2
Silverstone FT05	\N	ATX Mid Tower	Black / Silver	\N	\N	45.3	2
Thermaltake Versa H34	\N	ATX Mid Tower	Black	\N	Acrylic	49.3	3
Phanteks Enthoo EVOLV	\N	MicroATX Mini Tower	White	\N	Acrylic	41.7	3
Fractal Design Define R5	\N	ATX Mid Tower	Silver	\N	Acrylic	54.2	8
BitFenix Prodigy M	\N	MicroATX Mini Tower	Black / Green	\N	Acrylic	35.9	4
Aerocool Strike-X Xtreme	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	6
Cooler Master N400	\N	ATX Mid Tower	Black	\N	Acrylic	40.2	7
NZXT H440	\N	ATX Mid Tower	Red	\N	Acrylic	53.3	8
Enermax ECA5030A	\N	ATX Full Tower	Black / Blue	\N	\N	\N	5
Phanteks Enthoo Primo	\N	ATX Full Tower	Black / Orange	\N	Acrylic	\N	6
Raidmax Scorpio V	\N	ATX Mid Tower	Black	\N	Acrylic	54.6	8
Phanteks Enthoo EVOLV ITX	\N	Mini ITX Tower	Black	\N	\N	\N	2
Azza Nova 8000	\N	ATX Full Tower	White	\N	Acrylic	\N	6
DIYPC Cuboid	\N	MicroATX Mini Tower	Black / Red	\N	Acrylic	\N	3
Logisys CS6801BK	\N	MicroATX Mini Tower	Black	350	\N	12	1
Deepcool Tristellar	\N	Mini ITX Desktop	Black	\N	\N	\N	2
Xigmatek Mach II	\N	ATX Mid Tower	Black	\N	\N	\N	3
Rosewill STAR PREDATOR	\N	ATX Mid Tower	Black	\N	\N	\N	6
Raidmax ATX-404WU	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	3
Sentey Ss1-2429	\N	MicroATX Mid Tower	Black	\N	\N	\N	0
Sentey GS-6009	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	3
Antec P70	\N	ATX Mid Tower	Black	\N	\N	\N	4
Phanteks Enthoo Pro M	\N	ATX Mid Tower	Black	\N	Acrylic	56.4	2
DIYPC Skyline-07	\N	ATX Full Tower	Black / Blue	\N	\N	69.2	3
DIYPC Skyline-07	\N	ATX Full Tower	Black / Green	\N	\N	69.2	3
Cougar Solution 2	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Silverstone ML08	\N	HTPC	Black	\N	\N	\N	0
be quiet! Silent Base 600	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	\N	3
CiT Spectre	\N	ATX Mid Tower	White	\N	Acrylic	\N	4
Lian Li PC-Q21	\N	Mini ITX Tower	Black	\N	\N	\N	2
SHARKOON T28	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	6
BitFenix Nova	\N	ATX Mid Tower	White	\N	\N	\N	4
Thermaltake Core X31	\N	ATX Mid Tower	Black	\N	Acrylic	\N	6
Antec VSK3-500	\N	MicroATX Mini Tower	Black	500	\N	\N	2
DIYPC P48	\N	ATX Mid Tower	White	\N	\N	\N	3
In Win Chopin	\N	HTPC	Silver	150	\N	\N	0
Silverstone FT01B-USB3.0	\N	ATX Mid Tower	Black	\N	\N	\N	7
Thermaltake Core P3 SE	\N	ATX Mid Tower	Black	\N	Acrylic	80.1	2
Thermaltake Core P5	\N	ATX Mid Tower	Green	\N	Acrylic	115.4	3
Aerocool VS-1	\N	ATX Mid Tower	Black	\N	\N	30.7	2
In Win 509	\N	ATX Full Tower	Black	\N	Tempered Glass	71.6	5
In Win 805 Infinity	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
NOX Coolbay TX	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	57.3	8
Aerocool P7-C1	\N	ATX Mid Tower	White	\N	Acrylic	60.2	2
SHARKOON DG7000	\N	ATX Mid Tower	Black / Green	\N	Acrylic	46.4	3
Cougar MX310	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	49.6	3
Thermaltake Versa C22 RGB Snow Edition	\N	ATX Mid Tower	White	\N	Acrylic	52.2	2
RIOTORO CR1280 PRISM RGB	\N	ATX Full Tower	Black	\N	Acrylic	70.6	4
Thermaltake Core P5 TG Snow Edition	\N	ATX Mid Tower	White / Black	\N	Tinted Tempered Glass	115.4	3
Cooler Master MasterCase Maker 5t	\N	ATX Mid Tower	Black	\N	Tempered Glass	75.6	2
Phanteks Eclipse P400	\N	ATX Mid Tower	Gray	\N	Tinted Tempered Glass	45.9	2
Raidmax Sigma	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Raidmax Sigma	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
Azza Onyx 260	\N	ATX Mid Tower	White / Black	\N	Acrylic	\N	3
SHARKOON DG7000-G	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	\N	3
NZXT S340 Elite Hyper Beast	\N	ATX Mid Tower	Multicolor	\N	Tempered Glass	41.6	2
mean:it 4PM	\N	ATX Desktop	Black / Red	\N	Tempered Glass	48	3
mean:it 4PM	\N	ATX Desktop	Black	\N	Tempered Glass	48	3
Cooltek TG-01 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.6	2
Deepcool D-Shield	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Deepcool EARLKASE RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Azza Storm 6000W	\N	ATX Full Tower	White	\N	Tempered Glass	63.6	4
Apex 21N	\N	ATX Mid Tower	Black	\N	Acrylic	44.4	2
Phanteks Enthoo EVOLV ITX TG	\N	Mini ITX Desktop	White	\N	Tinted Tempered Glass	34.1	2
Lian Li PC-O8X	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	6
Xigmatek Prosper	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.3	2
Antec P280	\N	ATX Mid Tower	Black	\N	Acrylic	68	6
DIYPC Illusion II	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	\N	3
Lian Li PC-A41	\N	MicroATX Mini Tower	Black	\N	\N	\N	5
Raidmax Vortex	\N	ATX Mid Tower	Black	\N	Acrylic	42.4	3
Phanteks Mini XL	\N	MicroATX Desktop	Black	\N	Acrylic	\N	6
DIYPC TG8	\N	ATX Mid Tower	Green / Black	\N	Tempered Glass	\N	2
Lian Li ALPHA 550W	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	56.5	4
Gigabyte AC300W	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Aerocool QS-240	\N	MicroATX Mid Tower	Black	\N	Acrylic	\N	2
SAMA Maxcool-W-15	\N	MicroATX Mid Tower	White / Red	\N	Acrylic	\N	3
In Win X-Frame 2.0	\N	ATX Test Bench	Black / Green	\N	\N	102	6
EVGA DG-75	\N	ATX Mid Tower	Black	\N	Tempered Glass	47.3	2
DIYPC Model X	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
CiT F3	\N	MicroATX Mini Tower	Black / Blue	\N	Acrylic	\N	2
KOLINK ROCKET	\N	Mini ITX Desktop	Black	\N	\N	\N	0
Cooler Master MasterBox E500L	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	2
Thermaltake Versa J24	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
be quiet! Silent Base 801	\N	ATX Mid Tower	Black / Silver	\N	Tempered Glass	\N	5
Silverstone RVZ03	\N	Mini ITX Desktop	White	\N	\N	\N	0
Fractal Design Define R6 USB-C	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	56.7	6
Fractal Design Define R6 USB-C	\N	ATX Mid Tower	Silver	\N	Tempered Glass	56.7	6
Fractal Design Define R6 USB-C	\N	ATX Mid Tower	White / Black	\N	\N	56.7	6
Rosewill MAGNETAR	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	2
Rosewill PRISM T500	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Antec P110 Silent	\N	ATX Mid Tower	Black	\N	\N	\N	6
Silverstone RL07	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	\N	3
Cooler Master MasterBox CM694 Steel	\N	ATX Mid Tower	Black	\N	\N	\N	6
Raidmax Magnus	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	85.7	2
iTek LUNAR 19R2	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.9	3
GameMax Shadow	\N	ATX Mid Tower	Black	\N	Tempered Glass	38.8	1
GameMax Titan RGB	\N	ATX Mid Tower	Black	\N	Acrylic	54.6	2
Aerocool Quartz Blue	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	38.3	2
Jonsbo C3 Plus	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	31.2	4
Montech Flyer White	\N	MicroATX Mid Tower	White	\N	Tempered Glass	\N	2
BitFenix Nova Mesh TG	\N	ATX Mid Tower	White	\N	Tempered Glass	41.4	2
SHARKOON RGB LIT 200	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Tecware Vega L	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	1
Silverstone PS14-E	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.1	2
darkFlash DLM 21 Mesh	\N	MicroATX Mini Tower	Green	\N	Tempered Glass	32.1	2
Antec Striker Phantom Gaming Edition	\N	Mini ITX Desktop	White / Black	\N	Tempered Glass	\N	0
Enermax MarbleShell MS30	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Apevia Predator	\N	ATX Mid Tower	White	\N	Tempered Glass	35.7	3
Cougar MX331-T	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.5	2
Jonsbo A4 Ver1.1	\N	ATX Mini Tower	Silver	\N	Tempered Glass	15.7	1
darkFlash DLS 480	\N	ATX Mid Tower	White	\N	Tempered Glass	53.7	2
Deepcool CL500 4F	\N	ATX Mid Tower	Black / Gray	\N	Tempered Glass	55.5	2
Casecom RSM-91	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
SilentiumPC Armis AR6X TG RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	46	2
SilentiumPC Armis AR5X RGB	\N	ATX Full Tower	Black	\N	Tempered Glass	45.8	2
SilentiumPC Armis AR7X RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	63.9	3
SilentiumPC Signum SG1M TG	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
DIYPC AVVU-W-ARGB	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	3
Azza Cast 808W	\N	ATX Mid Tower	White / Black	\N	\N	\N	1
Corsair iCUE 5000X RGB Planetary	\N	ATX Mid Tower	Black / Orange	\N	Tempered Glass	66.2	2
Tempest Phantom	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
BitFenix Enso Mesh 4ARGB	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
HYTE REVOLT 3 EU	\N	Mini ITX Tower	White	700	Mesh	18.4	1
GAMDIAS APOLLO E2	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GAMDIAS APOLLO M2 ELITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GAMDIAS ARGUS E1	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
MOROVOL TW7-S2-PK	\N	MicroATX Mid Tower	Pink / Black	\N	Tempered Glass	27.1	2
Vetroo K2	\N	Mini ITX Desktop	Black	\N	Tempered Glass	\N	0
Azza Blaze 231	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.4	3
Azza Raven 420DF1	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.8	6
Azza Zircon 7000B	\N	ATX Full Tower	Black	\N	Tempered Glass	61.8	5
Thermaltake Suppressor F51	\N	ATX Mid Tower	Black	\N	Tempered Glass	69.7	6
Aerocool Falcon V1	\N	ATX Mid Tower	Black	\N	Tempered Glass	33.6	1
Aerocool Falcon V2	\N	ATX Mid Tower	Black	\N	Acrylic	33.6	1
Lazer3D LZX-8 Tek	\N	Mini ITX Desktop	Black / Gray	\N	\N	8.6	0
Cougar MG120-G RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	34.9	2
Cougar MX670 RGB	\N	ATX Mid Tower	\N	\N	Tempered Glass	50.3	2
SSUPD Meshroom S	\N	ATX Mini Tower	Black	\N	Mesh	14.9	0
Aerocool Raider Mini	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	23.8	2
Jonsbo RM2	\N	ATX Mid Tower	Black	\N	\N	21.5	1
Jonsbo UMX6	\N	ATX Full Tower	Silver	\N	\N	54.1	2
Ocelot OC-Purple Katana	\N	MicroATX Mini Tower	Purple / Black	\N	Tempered Glass	30	2
Ocelot OC-HANAMI 1	\N	MicroATX Mini Tower	White / Pink	\N	Tempered Glass	30	2
Horizon Exo	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	33.6	2
Cooler Master CMP 320L	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	38.6	2
Jonsbo U5S	\N	ATX Mid Tower	Silver	\N	Tempered Glass	40.3	2
Enermax StarryKnight SK30 V2	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.7	2
MagniumGear Neo Air 2	\N	ATX Mid Tower	White / Brown	\N	Tempered Glass	41.9	2
Silverstone FARA V1M PRO	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	36	2
SHARKOON MS-Y1000	\N	MicroATX Mid Tower	White	\N	Tempered Glass	26.2	1
KOLINK KLA-002	\N	ATX Mid Tower	Black	\N	\N	25.1	3
KOLINK Stronghold Overseer	\N	ATX Mid Tower	Black	\N	Tempered Glass	41	2
BGears b-Voguish Plus	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.8	2
GameMax Destroyer	\N	MicroATX Mini Tower	White	\N	Tempered Glass	43.6	2
GameMax Draco XD	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.7	2
YEYIAN Blade 2100	\N	ATX Mid Tower	Black	\N	Tempered Glass	36.6	2
YEYIAN Abyss 2500	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	40.7	2
SeaSonic ARCH Q5	\N	ATX Mid Tower	Black	750	Tempered Glass	46.4	3
Enermax ENERPAZO EP237 RGB	\N	ATX Mid Tower	White	\N	Tempered Glass	40	2
MSI MAG PANO M100L PZ	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	41.9	1
GameMax F46	\N	ATX Mid Tower	White	\N	Tempered Glass	40.6	2
Aerocool Viewport Mini V1	\N	MicroATX Mini Tower	White	\N	Tempered Glass	35	1
1STPLAYER T3-G	\N	MicroATX Mid Tower	White	\N	Tempered Glass	32.4	2
APNX C1-R	\N	ATX Mid Tower	White	\N	Tempered Glass	53.6	3
BitFenix TRITON	\N	ATX Mid Tower	White	\N	Tempered Glass	45.1	2
Xigmatek ZEUS 5PCS CY120	\N	ATX Full Tower	Black	\N	Tempered Glass	98.8	2
Zalman Z10 DS	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.9	2
Thermaltake Commander C34 TG Snow ARGB	74.96	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	3
In Win F3	\N	MicroATX Mini Tower	White	\N	Tempered Glass	35.5	2
Thermaltake V150	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	2
In Win DUBILI DIY	\N	ATX Full Tower	Gold / Black	\N	Tempered Glass	72.4	2
BitFenix Colossus Micro	230	MicroATX Mid Tower	Black	\N	\N	30.6	4
KOLINK Unity Nexus ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.3	2
In Win F3	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	35.5	2
Antec NSK1480	\N	MicroATX Desktop	Black / Silver	350	\N	17.8	2
XFX Type-01 Series Bravo Edition	\N	ATX Mid Tower	Black	\N	Acrylic	68	3
Cougar MG110	\N	MicroATX Mini Tower	Black	\N	Acrylic	30.8	2
Geometric Future Model 6	\N	ATX Mid Tower	Black / Yellow	\N	Tinted Tempered Glass	43.5	4
SHARKOON MS-Z1000	\N	MicroATX Mid Tower	White	\N	Tempered Glass	26.2	1
RAIJINTEK Ponos Ultra MS4	\N	ATX Mid Tower	White	\N	Tempered Glass	46.3	2
Thermaltake Level 10 GTS Snow Edition	\N	ATX Mid Tower	White / Black	\N	\N	54.9	5
BitFenix Aegis Core	\N	MicroATX Mid Tower	Black	\N	Acrylic	46.2	4
Silverstone SG12B	\N	MicroATX Mini Tower	Black	\N	\N	\N	3
Phanteks Enthoo EVOLV TG	\N	MicroATX Mini Tower	Gray	\N	Tinted Tempered Glass	41.7	2
BitFenix Enso	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
be quiet! Silent Base 801	\N	ATX Mid Tower	Black / Silver	\N	\N	\N	5
Thermaltake Commander C34 TG ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
RAIJINTEK METIS EVO ALS	\N	Mini ITX Desktop	Silver	\N	\N	22.3	2
Cooler Master MasterBox MB600L V2 w/ODD	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.7	2
Jonsbo U5	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.3	2
Thermaltake AH T200	\N	MicroATX Mid Tower	Pink / Black	\N	Tempered Glass	69.1	2
Inter-Tech SC-4100	\N	Mini ITX Desktop	Black	\N	\N	10.6	0
Jonsbo D500	\N	ATX Full Tower	Silver / Black	\N	Tempered Glass	90.8	10
Rosewill Blackbone	\N	ATX Mid Tower	Black	\N	\N	35.1	5
Antec Dark Fleet DF-10	\N	ATX Mid Tower	Black	\N	Acrylic	47.7	6
Antec Dark Fleet DF-30	\N	ATX Mid Tower	Black	\N	Acrylic	46.6	6
Antec Dark Fleet DF-35	\N	ATX Mid Tower	Black	\N	Acrylic	46.6	2
Antec Mini P180	\N	MicroATX Mini Tower	White	\N	\N	39.7	5
Antec Minuet	\N	MicroATX Slim	Black / White	350	\N	13.3	1
Antec P193	\N	ATX Mid Tower	Black	\N	\N	62.2	6
Antec Sonata Proto	\N	ATX Mid Tower	Black	\N	\N	40.2	4
Antec VSK-2000	\N	ATX Mid Tower	Black	\N	\N	42.1	6
Antec VSK2450	\N	ATX Mid Tower	Black	450	\N	42.1	6
Cooler Master Centurion 5	\N	ATX Mid Tower	Black / Blue	\N	\N	42	4
Cooler Master Centurion 5 II	\N	ATX Mid Tower	Black	\N	Acrylic	43.2	5
Cooler Master Centurion 534	\N	ATX Mid Tower	Black	460	\N	42	4
Cooler Master Centurion 541	\N	MicroATX Mini Tower	Black / Silver	\N	\N	29.4	2
Cooler Master CM690 II Advanced	\N	ATX Mid Tower	Black	\N	\N	56.3	6
Cooler Master Storm Scout	\N	ATX Mid Tower	Black	700	Acrylic	52.6	5
Thermaltake LANBOX Lite	\N	MicroATX Mini Tower	Black	\N	\N	29.6	2
Thermaltake Spedo Advance Package	\N	ATX Full Tower	Black / Silver	\N	Acrylic	75.4	6
Thermaltake V9 Black Edition	\N	ATX Mid Tower	Black	\N	\N	46.6	5
Thermaltake WingRS 201	\N	ATX Mid Tower	Black	\N	\N	37.9	4
Thermaltake Element V NVIDIA Edition	\N	ATX Full Tower	Black	\N	Acrylic	62.4	6
Thermaltake V6 BlacX Edition	\N	ATX Mid Tower	Black	\N	Acrylic	49.8	3
Thermaltake V9 BlacX	\N	ATX Mid Tower	Black	\N	Acrylic	50.6	5
Thermaltake V9 BlacX Edition	\N	ATX Mid Tower	Black	\N	Acrylic	50.6	5
Rosewill DESTROYER	\N	ATX Mid Tower	Black	\N	\N	37.4	3
Antec Sonata IV	\N	ATX Mid Tower	Black	620	\N	43.1	4
Cooler Master ATCS 840	\N	ATX Full Tower	Silver	\N	\N	88.5	6
Thermaltake WingMA	\N	MicroATX Mid Tower	Black / Silver	\N	\N	28	4
Lian Li PC-Q06	\N	Mini ITX Test Bench	Black	\N	\N	10.7	1
Lian Li PC-60FN	\N	ATX Mid Tower	Black	\N	\N	47.9	4
Lian Li PC-7B PLUS II	\N	ATX Mid Tower	Black	\N	\N	46.2	3
Lian Li PC-A04	\N	MicroATX Mini Tower	Black	\N	\N	\N	7
Lian Li PC-X1000	\N	ATX Mid Tower	Black	\N	\N	67.2	6
Aerocool M40	\N	MicroATX Mini Tower	Black	\N	\N	25.9	2
Apevia X-Plorer	\N	ATX Mid Tower	Black	\N	Acrylic	40.3	4
Apevia X-Master	\N	HTPC	Black / Silver	500	\N	22	1
Apevia X-Master	\N	HTPC	Black / Red	500	\N	22	1
Apevia X-QPack	\N	MicroATX Desktop	Black / Silver	420	Acrylic	22.7	2
Apevia X-QPack	\N	MicroATX Desktop	Black / Blue	420	Acrylic	22.7	2
Apevia X-QPack2	\N	MicroATX Desktop	Black	500	\N	24.2	2
Antec Nine Hundred Two V3	\N	ATX Mid Tower	Black	\N	Acrylic	50.6	6
NZXT Alpha	\N	ATX Mid Tower	Black / Gray	\N	Acrylic	43.6	5
NZXT Duet	\N	HTPC	Black / Silver	\N	\N	30.3	1
NZXT Hush	\N	ATX Mid Tower	Black	\N	\N	41.4	5
NZXT Vulcan	\N	MicroATX Mid Tower	Black	\N	Acrylic	30.3	2
Apex TU150	\N	ATX Mid Tower	Black	400	\N	38.3	3
Apex TX-381	\N	MicroATX Mid Tower	Black	300	\N	30	4
Athena Power CA-1015CR47	\N	MicroATX Slim	Black / Red	470	\N	18.1	1
Athena Power CA-601B80	\N	ATX Full Tower	Black	800	\N	50.6	4
Athenatech A1019HG.150	\N	Mini ITX Desktop	Gray / Black	150	\N	5.2	1
Athenatech A3712BB.450	\N	ATX Mid Tower	Black	450	\N	23.2	2
Foxconn TLA+436(H+A)+ISO-400-4SS	\N	ATX Mid Tower	Black / Silver	300	\N	33.2	4
Gigabyte Sumo 4192	\N	ATX Full Tower	Black	\N	\N	54.2	5
In Win Diva	\N	Mini ITX Tower	Black / Pink	160	\N	9.3	0
In Win Dragon Slayer	\N	MicroATX Mini Tower	Black	\N	\N	35.6	0
In Win Z589T.CQ350TBL	\N	MicroATX Mini Tower	Black	350	\N	24.2	1
Raidmax Tornado	\N	ATX Mid Tower	Black	\N	\N	42.1	5
Raidmax Smilodon ATX-612WB	\N	ATX Mid Tower	Black / White	500	Acrylic	47.5	4
Rosewill RS-MI-01	\N	Mini ITX Tower	Black	250	\N	9.4	1
Silverstone FT03	\N	MicroATX Mini Tower	Silver	\N	\N	32.2	3
Silverstone SG02-BF	\N	MicroATX Desktop	Black / Silver	\N	\N	22.4	2
Silverstone SG07-B	\N	Mini ITX Desktop	Black / Gray	600	\N	14.6	1
Silverstone TJ08-B	\N	MicroATX Mid Tower	Black	\N	\N	28	2
Xigmatek Asgard II	\N	ATX Mid Tower	Black / Orange	\N	\N	35.5	5
Zalman MS1000-HS1	\N	ATX Mid Tower	Black	\N	\N	55.7	3
Athenatech A3701BB	\N	HTPC	Black	\N	\N	23.2	1
Silverstone GD05B	\N	HTPC	Black	\N	\N	21.3	2
Silverstone LC17-B	\N	HTPC	Silver	\N	\N	30.9	6
Cooler Master CM 690 II Nvidia Edition	\N	ATX Mid Tower	Black	\N	Acrylic	55.7	6
Cooler Master Elite 371	\N	ATX Mid Tower	Black / White	\N	\N	38.7	5
Foxconn RM233+FSP150-50GLT	\N	Mini ITX Tower	Black / Silver	150	\N	9.4	1
Rosewill GEAR X3	\N	ATX Mid Tower	Black	\N	\N	44.6	6
Apevia X-Trooper-Jr	\N	ATX Mid Tower	Black	\N	Acrylic	29.8	3
Apevia X-Trooper-Jr	\N	ATX Mid Tower	Black	450	Acrylic	29.8	3
In Win BL672	\N	MicroATX Desktop	Black / Silver	\N	\N	11.6	2
Lian Li PC-C60	\N	HTPC	Black	\N	\N	33.1	6
Lian Li PC-X2000F	\N	ATX Full Tower	Black	\N	\N	73.5	7
Logisys CS305BK	\N	ATX Mid Tower	Black	480	\N	31.8	5
nMEDIAPC HTPC 5000S	\N	HTPC	Black	\N	\N	24.4	4
Fractal Design Core 3000	\N	ATX Mid Tower	Black	\N	\N	41.1	6
Fractal Design Define XL	\N	ATX Full Tower	Black / Gray	\N	\N	72.6	10
Sentey DS1-4237	\N	ATX Mid Tower	Black	\N	\N	38.8	4
Raidmax ATX-615WUP	\N	ATX Mid Tower	Black / Blue	500	\N	47.7	4
BitFenix Colossus Venom Edition	\N	ATX Full Tower	Black	\N	\N	79	7
Cooler Master Elite 335 Upgraded	\N	ATX Mid Tower	Black	\N	\N	40.5	5
Fractal Design Define XL	\N	ATX Full Tower	Black / Gray	\N	\N	72.6	10
Fractal Design Define R3	\N	ATX Mid Tower	Black / Silver	\N	\N	47.5	8
Thermaltake Level 10 GT LCS	\N	ATX Full Tower	Black	\N	Acrylic	96.7	5
NZXT Tempest 410 Elite	\N	ATX Mid Tower	Black	\N	Acrylic	51.1	8
NZXT Hades	\N	ATX Mid Tower	Black	\N	\N	42.7	4
Apevia X-Telstar	\N	ATX Full Tower	Black	\N	Acrylic	52.7	5
Diablotek DIAMOND	\N	ATX Mid Tower	Black	400	\N	27.9	2
Azza Spartan CSAZ-102E	\N	ATX Mid Tower	Black	\N	Acrylic	52.1	4
Enermax Fulmo Basic	\N	ATX Mid Tower	Black	\N	\N	57.5	6
Sentey CS1-1398	\N	ATX Mid Tower	Black	250	\N	27.8	2
Cooler Master Elite 311	\N	ATX Mid Tower	Black / Red	\N	Acrylic	40.8	5
Lian Li PC-100	\N	ATX Mid Tower	Black	\N	\N	52.4	6
Raidmax Super Hurricane	\N	ATX Mid Tower	Black	\N	Acrylic	36.7	4
Raidmax Seiran	\N	ATX Mid Tower	Black	\N	\N	45.3	6
Logisys Area 51	\N	ATX Mid Tower	Silver	480	Acrylic	65.3	5
Raidmax Viper	\N	ATX Mid Tower	White / Red	\N	Acrylic	42.6	4
Cooler Master Elite 361	\N	ATX Mid Tower	Black	\N	\N	25.1	4
Lian Li PC-Q12	\N	Mini ITX Tower	Silver	300	\N	6.6	0
NZXT Switch 810	\N	ATX Full Tower	Black	\N	Acrylic	81.3	6
Zalman GS-1000	\N	ATX Full Tower	Black	\N	\N	94.7	6
Cooler Master Elite 361	\N	ATX Mid Tower	Black	\N	\N	25.1	4
BitFenix Colossus Window	\N	ATX Full Tower	Black	\N	Acrylic	79	7
Silverstone FT02B-USB3.0	\N	ATX Mid Tower	Silver	\N	Acrylic	64.8	5
Zalman MS1000-HS2	\N	ATX Mid Tower	Black	\N	\N	55.7	6
In Win C589T.CQ450TBL	\N	ATX Mid Tower	Black	450	\N	35	3
Topower TP-1687BS-300	\N	MicroATX Desktop	Black / Silver	300	\N	15.4	1
Silverstone FT03	\N	MicroATX Mini Tower	Silver / Black	\N	\N	32.2	3
DIYPC DIY-6811	\N	MicroATX Mid Tower	Black	\N	\N	23	2
Apevia X-Jupiter-Jr G-Type	\N	ATX Mid Tower	Black	\N	Acrylic	42.3	3
Cooler Master Elite 311	\N	ATX Mid Tower	Black / Blue	420	\N	40.8	5
Silverstone TJ04B-EW	\N	ATX Mid Tower	Black	\N	Acrylic	51	9
Lian Li PC-A75	\N	ATX Full Tower	Black	\N	\N	75.5	12
Gigabyte GZ-ZLM10RS	\N	ATX Mid Tower	Black / Red	\N	\N	36.2	8
Silverstone SG09B	\N	MicroATX Mini Tower	Black	\N	\N	22.8	2
Chieftec BL-01B-OP	\N	ATX Mid Tower	Black	\N	\N	\N	3
Fractal Design Core 3000 USB 3.0	\N	ATX Mid Tower	Black	\N	\N	71.4	6
Silverstone SG05BB-450-USB3	\N	Mini ITX Desktop	White	300	\N	10.7	1
CFI Bastet	\N	ATX Mid Tower	Black	\N	Acrylic	48	2
Lian Li PC-CK101	\N	Mini ITX Tower	Black	300	\N	24.4	1
Lian Li PC-CK101	\N	Mini ITX Tower	Black	300	\N	24.4	1
Nanoxia Deep Silence 2 White	\N	ATX Mid Tower	Black	\N	\N	57	7
Thermaltake Urban S31	\N	ATX Mid Tower	Black	\N	\N	53.3	6
Xigmatek CCC-AD38BT-U03	\N	ATX Mid Tower	Black	\N	\N	43.6	8
Enermax ECA3253	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	43.8	5
Gigabyte GZ-X7	\N	ATX Mid Tower	Black	\N	\N	36.6	6
Gigabyte GZ-ZA1	\N	ATX Mid Tower	Black	\N	\N	30.9	5
Cooler Master Elite 120 Advanced	\N	Mini ITX Tower	White	\N	\N	19.7	3
Silverstone RL04W	\N	ATX Mid Tower	White	\N	Acrylic	\N	5
Zalman MS800	\N	ATX Mid Tower	Black	\N	\N	59.6	3
Zalman ZM-T1	\N	MicroATX Mini Tower	Black	\N	\N	24.7	2
Apex TX-606-U3	\N	MicroATX Mid Tower	Black	300	\N	27.9	5
DIYPC Alpha-DB6	\N	ATX Test Bench	White	\N	\N	21.8	0
Thermaltake V2 Plus	\N	ATX Mid Tower	Black	450	\N	52.7	6
Raidmax ATX-502WBG	\N	ATX Mid Tower	Black	\N	Acrylic	59.5	3
Rosewill FB-04	\N	ATX Mid Tower	Black	\N	\N	26.5	4
Sentey CS1-1398 PLUS	\N	ATX Mid Tower	Black	\N	\N	30.3	5
Sentey GS-6010 Plus	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	36.9	5
Sentey GS-6020 Plus	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	40.2	4
Thermaltake Versa G1	\N	ATX Mid Tower	Black	\N	Acrylic	40.1	5
Apevia X-Cruiser3	\N	ATX Mid Tower	Blue / Silver	\N	Acrylic	44.7	4
Apevia X-Cruiser3	\N	ATX Mid Tower	Black / Green	\N	Acrylic	44.7	4
Lian Li PC-A75	\N	ATX Full Tower	Black	\N	Acrylic	75.5	12
Apevia X-Sniper2	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	4
Apevia X-Sniper2	\N	ATX Mid Tower	White / Blue	\N	Acrylic	\N	4
Corsair Carbide Series 330R	\N	ATX Mid Tower	Black	\N	\N	49.9	4
Silverstone RV04B-W	\N	ATX Full Tower	Black	\N	Acrylic	\N	7
NZXT Phantom 630	\N	ATX Full Tower	Gunmetal	\N	Acrylic	92	6
Cougar MG100	\N	MicroATX Mini Tower	Black	\N	\N	\N	2
In Win D-FRAME	\N	ATX Desktop	Red	\N	Acrylic	97.5	3
Aerocool Strike-X GT	\N	ATX Mid Tower	Black / Red	\N	\N	42.9	6
Aerocool XPredator X3	\N	ATX Mid Tower	Black / Red	\N	Acrylic	62.5	8
BitFenix Phenom M	\N	MicroATX Mini Tower	White	\N	\N	30.6	5
Apevia X-Hermes	\N	ATX Mid Tower	Black / Green	\N	Acrylic	44.7	4
BitFenix Shadow	\N	ATX Mid Tower	Black	\N	\N	\N	7
Cooler Master N600 Windowed	\N	ATX Mid Tower	Black	\N	Acrylic	\N	7
Corsair Graphite Series 230T	\N	ATX Mid Tower	Black / Gray	\N	Acrylic	\N	4
Cooler Master Silencio 650	\N	ATX Mid Tower	Black	\N	\N	\N	7
Aerocool XPredator Devil	\N	ATX Full Tower	Black / Red	\N	Acrylic	\N	6
Cougar MX500	\N	ATX Mid Tower	Black	\N	\N	\N	7
Enermax ECA3310A	\N	ATX Mid Tower	Black	\N	Acrylic	58.6	7
Rosewill BLACKHAWK	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	55.1	6
Rosewill LINE-M-A	\N	MicroATX Mini Tower	Black	\N	\N	26.9	0
Silverstone TJ08B-EW	\N	MicroATX Mid Tower	Black	\N	Acrylic	30.2	4
Antec ISK600	\N	Mini ITX Tower	Black / Blue	\N	\N	18.7	3
BitFenix Comrade	\N	ATX Mid Tower	White	\N	\N	37	3
Silverstone GD04B-USB3.0	\N	HTPC	Silver	\N	\N	21.3	2
Thermaltake Armor Series	\N	ATX Full Tower	Black	\N	Acrylic	65	6
EVGA Hadron Hydro	\N	Mini ITX Tower	Black	500	Acrylic	18.4	2
Antec VSK-4350E-N	\N	ATX Mid Tower	Black	350	\N	33.4	5
DIYPC HTPC-MiniCube	\N	Mini ITX Tower	Gold	\N	\N	9.8	1
In Win BP655.FH200B	\N	Mini ITX Desktop	Black	200	\N	8.1	1
Raidmax Cobra Z	\N	ATX Mid Tower	Black / Blue	\N	\N	59.5	3
Thermaltake Urban S1	\N	MicroATX Mini Tower	Black	\N	\N	32.9	5
Thermaltake Urban SD1	\N	MicroATX Mini Tower	Black	\N	\N	30.4	2
Fractal Design Core 3500	\N	ATX Mid Tower	Black	\N	Acrylic	56	4
Aerocool XPredator X3	\N	ATX Mid Tower	Black / White	\N	Acrylic	62.5	8
DIYPC Skyline-07	\N	ATX Full Tower	Black	\N	\N	69.2	3
Aerocool DS 200	\N	ATX Mid Tower	Black / Orange	\N	\N	\N	5
BitFenix Pandora	\N	MicroATX Mid Tower	Silver	\N	Acrylic	31.2	2
Lian Li PC-A61	\N	ATX Mid Tower	Black	\N	\N	57.4	6
Lian Li PC-Q35A	\N	Mini ITX Tower	Silver	\N	\N	18.1	5
In Win BK644.BH300TB	\N	MicroATX Mini Tower	Black	300	\N	12.3	1
Rosewill STEALTH	\N	ATX Mid Tower	Black	\N	Acrylic	52	8
Aerocool GT-A	\N	ATX Mid Tower	White	\N	Acrylic	\N	3
Zalman H1	\N	ATX Full Tower	Black	\N	Acrylic	74.3	7
Silverstone FT05	\N	ATX Mid Tower	Silver	\N	\N	45.3	2
be quiet! Silent Base 800	\N	ATX Mid Tower	Black / Silver	\N	\N	\N	7
Ultra Defender II	\N	ATX Mid Tower	Black	\N	Acrylic	\N	4
Aerocool Strike-X Xtreme	\N	ATX Mid Tower	Black / White	\N	Acrylic	\N	6
Aerocool Strike-X Advance	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	0
Cooler Master N300	\N	ATX Mid Tower	Black	\N	\N	39.5	7
Cooler Master K281	\N	ATX Mid Tower	Black / Red	\N	\N	\N	7
Cooler Master K350	\N	ATX Mid Tower	Black / Red	500	Acrylic	\N	6
DIYPC FM18	\N	ATX Mid Tower	Black	\N	Acrylic	33.8	2
Cooler Master Elite 334U	\N	ATX Mid Tower	Black / Silver	\N	\N	\N	5
NZXT Phantom 240	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	6
Phanteks Enthoo EVOLV	\N	MicroATX Mini Tower	Silver	\N	Acrylic	41.7	3
DIYPC Zondda	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	\N	4
BitFenix Aegis Core	\N	MicroATX Mid Tower	Blue	\N	Acrylic	46.2	4
BitFenix Aegis	\N	MicroATX Mid Tower	Black	\N	Acrylic	46.2	4
Raidmax HYBODUS	\N	MicroATX Mini Tower	Black / Red	\N	\N	\N	2
Sentey GS-6008	\N	ATX Mid Tower	Black	\N	\N	\N	2
Cooltek UMX1	\N	Mini ITX Tower	Black	\N	\N	\N	2
Azza Nova 8000	\N	ATX Full Tower	Black / Orange	\N	Acrylic	\N	6
Rosewill R521-M	\N	MicroATX Mini Tower	Black	400	\N	\N	5
Apevia X-QPack3	\N	MicroATX Mini Tower	Black / Blue	\N	Acrylic	\N	2
Apevia X-QPack3	\N	MicroATX Mini Tower	Black	\N	\N	\N	2
Apevia X-QPack3	\N	MicroATX Mini Tower	Pink	\N	Acrylic	\N	2
Element Gaming Hyperion	\N	MicroATX Mid Tower	Black / Blue	\N	Acrylic	\N	5
Cooler Master N400	\N	ATX Mid Tower	Black	\N	Acrylic	40.2	7
Raidmax Element	\N	Mini ITX Desktop	Black / Gray	\N	\N	\N	2
Raidmax Element	\N	Mini ITX Desktop	Black / Blue	450	\N	\N	2
VIVO CASE-V02	\N	ATX Mid Tower	Black / Blue	\N	\N	\N	3
VIVO CASE-V03	\N	ATX Mid Tower	Black / Red	\N	\N	\N	4
In Win 707	\N	ATX Full Tower	Black / Red	\N	Acrylic	\N	8
be quiet! Silent Base 600	\N	ATX Mid Tower	Black / Silver	\N	\N	\N	3
Zalman ZM-T1 PLUS	\N	MicroATX Mini Tower	Black	\N	\N	\N	2
Thermaltake Suppressor F31	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
RAIJINTEK STYX	\N	MicroATX Mini Tower	Silver	\N	Acrylic	\N	3
SHARKOON BD28	\N	ATX Mid Tower	Black / Green	\N	Acrylic	\N	3
SHARKOON BD28	\N	ATX Mid Tower	Black / Blue	\N	\N	\N	3
Raidmax Viper II	\N	ATX Mid Tower	Black / Green	\N	Acrylic	\N	3
Raidmax Viper II	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	3
SHARKOON T28	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	6
SHARKOON T28	\N	ATX Mid Tower	Black / Green	\N	Acrylic	\N	6
VIVO Titan	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Apevia X-QPack3	\N	MicroATX Mini Tower	Black / Orange	\N	Acrylic	\N	2
DIYPC Zondda	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	4
DIYPC D480	\N	ATX Mid Tower	Black	\N	\N	\N	2
Rosewill GUNGNIR	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	3
Antec GX500	\N	ATX Mid Tower	Black	\N	Acrylic	44.4	4
DIYPC M89	\N	MicroATX Mini Tower	Black / Red	\N	\N	20.9	2
DIYPC Ranger-R5	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	4
DIYPC DIY-M6	\N	MicroATX Mid Tower	White / Blue	\N	Acrylic	\N	2
Apevia X-EnerQ	\N	MicroATX Mid Tower	Black / Green	\N	Acrylic	\N	2
Apevia X-Qber	\N	MicroATX Desktop	Black / Red	\N	Acrylic	\N	2
Anidees AI7	\N	ATX Desktop	Black	\N	Acrylic	\N	4
Thermaltake Suppressor F31	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Silverstone RVZ01-E	\N	HTPC	Black	\N	\N	\N	0
Xigmatek Eris	\N	Mini ITX Desktop	Black	\N	\N	\N	1
Logisys CS380BK	\N	ATX Mid Tower	Black	480	Acrylic	\N	3
SHARKOON T3-W	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	38.3	6
NOX Hummer ZX	\N	ATX Mid Tower	White / Black	\N	Acrylic	48.8	2
NOX Coolbay SX	\N	ATX Mid Tower	Black / Red	\N	\N	37.9	4
NOX Coolbay VX	\N	ATX Mid Tower	Black / Red	\N	Acrylic	34.3	7
SHARKOON DG7000	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	46.4	3
SHARKOON DG7000	\N	ATX Mid Tower	Black / Red	\N	Acrylic	46.4	3
Lian Li PC-Q20	\N	Mini ITX Tower	Silver	\N	\N	7.2	0
Thermaltake Core P3	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	80.1	2
RAIJINTEK Metis Plus	\N	Mini ITX Tower	Black	\N	Acrylic	13.4	2
RAIJINTEK Metis Plus	\N	Mini ITX Tower	Red	\N	Acrylic	13.4	2
NZXT H440	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	53.3	8
Silverstone RL06	\N	ATX Mid Tower	White / Black	\N	Acrylic	43.4	3
Thermaltake View 27	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Azza Onyx 260	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Silverstone KL07	\N	ATX Mid Tower	Black	\N	\N	52.9	3
Lian Li Odyssey	\N	Mini ITX Desktop	Black	\N	\N	\N	2
Lian Li Odyssey	\N	Mini ITX Desktop	White	\N	\N	\N	2
Apevia X-Mirage	\N	ATX Mid Tower	Black / Red	\N	Acrylic	41.8	2
Apevia X-Mirage	\N	ATX Mid Tower	White	\N	Acrylic	41.8	2
Aerocool Aero-300 FAW	\N	ATX Mid Tower	Black	\N	Acrylic	36.3	2
SHARKOON VG4-W	\N	ATX Mid Tower	Black	\N	Acrylic	38.3	3
VIVO CASE-V06	\N	MicroATX Mid Tower	White / Black	\N	Acrylic	\N	2
Anidees AI Crystal Cube	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.5	3
mean:it 5PM	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	51.5	3
Enermax Ostrog ADV	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	54.7	6
Enermax Ostrog ADV	\N	ATX Mid Tower	Black / Red	\N	Acrylic	54.7	6
Cooltek JB C2	\N	MicroATX Mini Tower	Black	\N	\N	12.1	1
DIYPC Illusion I	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	\N	2
DIYPC Skyline-06	\N	ATX Full Tower	Black / Green	\N	Acrylic	\N	3
Silverstone RL06	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	43.4	3
In Win BL631.300TBL	\N	MicroATX Slim	Black	300	\N	11.6	2
Silverstone TJ08B-E	\N	MicroATX Mini Tower	Silver	\N	\N	30.2	4
Raidmax Monster II	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
NZXT H400i	\N	MicroATX Mini Tower	Black / Blue	\N	Tempered Glass	36.9	1
NZXT H200i	\N	Mini ITX Tower	Black / Blue	\N	Tempered Glass	27.3	1
SHARKOON AM5	\N	ATX Mid Tower	Blue / Black	\N	Acrylic	\N	3
RIOTORO CR500	\N	ATX Mid Tower	Black	\N	Tempered Glass	41	4
Lian Li ALPHA 330X	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Lian Li ALPHA 330W	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
Rosewill Orbit-Z1	\N	ATX Mid Tower	Black	\N	Acrylic	41.6	2
Fractal Design Define R6	\N	ATX Mid Tower	White / Black	\N	\N	56.7	6
Fractal Design Define R6	\N	ATX Mid Tower	Silver	\N	Tempered Glass	56.7	6
In Win X-Frame 2.0	\N	ATX Test Bench	Black / Red	\N	\N	102	6
In Win Tou 2.0	\N	ATX Full Tower	\N	1065	Tempered Glass	\N	5
EVGA DG-73	\N	ATX Mid Tower	Black	\N	Acrylic	45.9	2
EVGA DG-75	\N	ATX Mid Tower	White	\N	\N	47.3	2
Nanoxia Rexgear 1	\N	MicroATX Desktop	Black	\N	Acrylic	\N	3
Nanoxia Deep Silence 4	\N	MicroATX Mini Tower	Black / Gray	\N	\N	\N	6
Raidmax X08	\N	ATX Mid Tower	Black / Silver	\N	Tempered Glass	\N	3
NZXT H400	\N	MicroATX Mini Tower	Black / Blue	\N	Tempered Glass	36.9	1
Raidmax Alpha Prime	\N	ATX Mid Tower	White	\N	Tempered Glass	44.8	2
Lian Li PC-Q50	\N	Mini ITX Desktop	Silver	\N	\N	\N	2
Thermaltake View 32 TG	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Cooler Master MasterBox MB511	\N	ATX Mid Tower	Black / White	\N	Acrylic	\N	2
RAIJINTEK PAEAN M	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	40.9	1
RAIJINTEK ASTERION CLASSIC	\N	ATX Full Tower	Black	\N	Tempered Glass	56	3
RAIJINTEK ASTERION PLUS	\N	ATX Full Tower	Black	\N	Acrylic	59.3	3
Lian Li PC-O11AIR RGB	\N	ATX Full Tower	Black	\N	Tempered Glass	60.2	3
DAN Cases A4-SFXv3	\N	Mini ITX Desktop	Silver	\N	\N	\N	0
SHARKOON VG5	\N	ATX Mid Tower	Black	\N	Acrylic	38.3	3
Cooler Master MasterBox E500L	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	2
HG Computers Osmi	\N	Mini ITX Tower	Black	\N	\N	\N	1
MagniumGear NEO	\N	ATX Mid Tower	Silver	\N	Tempered Glass	37.8	2
MagniumGear NEO G MINI	\N	Mini ITX Tower	Black	\N	Tempered Glass	\N	1
MagniumGear NEO MINI	\N	Mini ITX Tower	Silver	\N	Tempered Glass	\N	1
GAMDIAS Talos P1	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
BitFenix Enso Mesh	\N	ATX Mid Tower	Black	\N	Tempered Glass	46.4	2
FSP Group CMT330	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	2
Azza Chroma 410	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
DIYPC Trio-GT-RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cougar Puritas	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cooler Master MasterBox K500 Phantom Gaming Edition	\N	ATX Mid Tower	Black	\N	Tempered Glass	46.9	2
Thermaltake Commander C31 TG ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Cooler Master MasterCase H500P Mesh Phantom Gaming Edition	\N	ATX Mid Tower	Black / Red	\N	Acrylic	71.4	2
Thermaltake Versa J24 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Thermaltake Commander C31 TG Snow ARGB	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	3
Cougar MX330-STE500	\N	ATX Mid Tower	Black	500	Acrylic	39.4	2
GameMax ABYSS	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Raidmax Alpha	\N	ATX Mid Tower	Black	\N	Acrylic	44.2	2
Raidmax Alpha	\N	ATX Mid Tower	White	\N	Acrylic	44.2	2
Rosewill PRISM S LITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	46.9	3
Deepcool Gamer Storm NEW ARK 90SE	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Anidees AI Crystal Cube MAR 3	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	50.5	3
GameMax Crusader Mirage	\N	ATX Mid Tower	Black	\N	Tempered Glass	34.8	3
GameMax Expedition	\N	MicroATX Mini Tower	White	\N	Acrylic	29.4	2
GameMax Explorer	\N	MicroATX Mini Tower	Black	\N	Tinted Acrylic	33.7	2
GameMax Gravity	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.6	2
GameMax Knight	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.3	3
GameMax Moonstone RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	66.9	1
GameMax GMX-PRECISION	\N	ATX Full Tower	Black	\N	Tempered Glass	82.9	10
GameMax Sapphire RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	52.3	2
GameMax Solar	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.1	1
GameMax View	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.7	2
DIYPC DIY-D3-RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	46.1	2
Deepcool Gamer Storm Quadstellar Electro Limited Edition	\N	ATX Desktop	Silver / Orange	\N	\N	\N	8
Rosewill Cullinan V-Silent	\N	ATX Mid Tower	Black	\N	\N	51.8	2
NZXT H510 Horde	\N	ATX Mid Tower	Red	\N	Tempered Glass	41.3	2
RAIJINTEK METIS EVO TGS	\N	Mini ITX Desktop	Red	\N	Tempered Glass	22.3	2
Rosewill FBM-X2	\N	MicroATX Mini Tower	Black	400	\N	25.3	1
Apevia CRUSADER-F-WH	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
KOLINK BIG CHUNGUS	\N	ATX Mid Tower	Black	\N	Tempered Glass	146.1	2
DIYPC Solo-T2-R Black USB 3.0	\N	ATX Mid Tower	Black / Red	\N	\N	39.1	3
GameMax RockStar G515	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Golden Field MUT1	\N	ATX Mid Tower	Black	\N	\N	47.5	2
DIYPC Vanguard-V6-RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Raidmax Monster II SE	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
SilentiumPC Regnum RG4	\N	ATX Mid Tower	White / Black	\N	\N	46.1	3
DIYPC S2-RGB	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	44.9	2
GAMDIAS APOLLO M1	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Enermax MarbleShell MS30	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
GameMax Shine G517	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Silverstone FARA R1	\N	ATX Mid Tower	Black	\N	\N	\N	1
Azza Pyramid 804V	\N	ATX Mid Tower	Silver / Black	\N	Tempered Glass	\N	1
Aerocool Flo Saturn FRGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	48.8	2
BitFenix Nova Mesh SE	\N	ATX Mid Tower	White	\N	\N	36.1	2
darkFlash DLS 480	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.7	2
Apevia Matrix	\N	ATX Mid Tower	Pink	\N	Tempered Glass	37.8	3
Apevia Enzo	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.7	3
Apevia Enzo	\N	ATX Mid Tower	Pink	\N	Tempered Glass	35.7	3
SilentiumPC Armis AR6	\N	ATX Mid Tower	Black	\N	Tempered Glass	46	2
SilentiumPC Armis AR6X EVO ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	46	2
SilentiumPC Armis AR7 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	63.9	3
DIYPC Vanguard-V8-RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Aerocool Trinity Mini V3	\N	MicroATX Mini Tower	White	\N	Tempered Glass	28.1	2
BitFenix Prodigy M 2022 ARGB	\N	MicroATX Mini Tower	White / Black	\N	Tempered Glass	\N	2
GAMDIAS ARGUS M3	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GAMDIAS ATHENA E1	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GAMDIAS TALOS M1 LITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GAMDIAS TALOS M1A	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GAMDIAS TALOS P1A	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
BitFenix BitFenix Neos Window BFC-NEO-100-WWWKB-RP White / Blue Steel / Plastic ATX Mid Tower Computer Case	\N	ATX Mid Tower	White / Blue	\N	Acrylic	37	3
BitFenix BitFenix Neos Window Side Panel Computer Case, Black/Red, BFC-NEO-100-KKWSR-RP, ATX/Micro ATX/Mini-ITX Form Factor, Compatible with ATX PSU	\N	ATX Mid Tower	Black / Red	\N	Acrylic	37	3
SilentiumPC Ventum VT4V EVO TG ARGB	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
Raidmax P805	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Vetroo A03	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cooler Master CMP 510	\N	ATX Mid Tower	Black	\N	Tempered Glass	42	2
Rosewill SPECTRA C101	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	37	2
Thermaltake Divider 550 TG Ultra	204.98	ATX Mid Tower	Black	\N	Tempered Glass	56.8	2
Azza Inferno 310DF	\N	ATX Mid Tower	Black	\N	Tempered Glass	46.7	2
CiT Master	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.6	2
SSUPD Meshroom S	\N	ATX Mini Tower	Yellow	\N	Mesh	14.9	0
Rosewill SPECTRA C201	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.6	2
Vetroo AL-MESH-7C	\N	ATX Mid Tower	White	\N	Tempered Glass	40.9	2
DIYPC ARGB-Q8-W	\N	MicroATX Mid Tower	Silver / Black	\N	Tempered Glass	28.4	2
CiT Dark Star ARGB	\N	ATX Mid Tower	Black	\N	Acrylic	41.3	2
Jonsbo V8	\N	Mini ITX Desktop	Black	\N	Mesh	25.3	2
OCPC MICRO	\N	MicroATX Mid Tower	White	\N	\N	12.7	0
MagniumGear NEO AIR (2023)	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.4	2
Noua Diamond C9	\N	ATX Mid Tower	Red / Black	\N	Tempered Glass	41	2
Noua Iron V7	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.5	2
Noua Iron V6	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.9	2
Noua Noob X5	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.8	2
Noua Smash S10	\N	ATX Mid Tower	White	\N	Tempered Glass	35.7	2
Noua Oryx M4	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.5	2
Noua Orizon M3	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.1	2
Deepcool CC560 FS	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.7	2
Apevia Guardian-M	\N	ATX Mid Tower	Pink	\N	Tempered Glass	39.5	2
Jonsbo Jonsplus i400	\N	ATX Mid Tower	Silver	\N	\N	55.7	6
Jonsbo Jonsplus i400	\N	ATX Mid Tower	Black	\N	Tempered Glass	55.7	6
GALAX REV-01	\N	ATX Mid Tower	White	\N	Tempered Glass	41.9	2
GALAX REV-03	\N	MicroATX Mini Tower	White	\N	Mesh	21.9	1
Xigmatek Overtake	\N	ATX Full Tower	Black	\N	Tempered Glass	67.8	2
SHARKOON Rebel C60 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	52	3
Mars Gaming MCM	\N	MicroATX Mini Tower	White	\N	Tempered Glass	20.5	2
Enermax MarbleShell MS21 RGB	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	33.8	2
KOLINK INSPIRE K20	\N	ATX Mid Tower	Black	\N	Tempered Glass	30.6	2
KOLINK INSPIRE K5 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	37	2
KOLINK Inspire X3	\N	ATX Mid Tower	Black	\N	Tempered Glass	30.1	2
DIYPC DIY-A5	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	28.4	2
DIYPC IDX7-ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.8	4
Silverstone FARA R1 PRO V2	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.1	2
Rosewill SRM-01B	\N	MicroATX Mini Tower	Black	450	\N	\N	2
Jonsbo Jonsplus Z20	\N	MicroATX Desktop	Pink / Black	\N	Tempered Glass	25.3	1
YEYIAN Blade 2101	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.8	2
YEYIAN Stahl 900	\N	ATX Mid Tower	Black	\N	\N	27.6	2
YEYIAN Shadow 2200	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.9	2
Cooler Master MasterBox 520 Mesh Blackout Edition	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.4	2
Thermaltake V100	\N	ATX Mid Tower	Black	450	Acrylic	36.6	2
CherryTree Borg Cube w/Lights	\N	ATX Desktop	Black	\N	Tempered Glass	55.3	0
SSUPD Meshroom S V2	\N	MicroATX Mini Tower	Gray	\N	Mesh	14.9	2
Aerocool GT	\N	ATX Mid Tower	Black	\N	Mesh	34.4	3
SHARKOON Skiller SGC1	\N	ATX Mid Tower	Black	\N	\N	47.5	2
Aerocool Hexform	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	28	2
Cooler Master CMP 500	\N	ATX Mid Tower	Black	\N	Acrylic	46.5	2
Cooler Master Elite 600	\N	ATX Mid Tower	Black	\N	Tempered Glass	52	2
Cougar OmnyX	\N	ATX Mid Tower	Black	\N	Tempered Glass	73.3	2
RAIJINTEK Thetis	\N	ATX Mid Tower	Silver	\N	Acrylic	27.7	2
NZXT Source 210	\N	ATX Mid Tower	Black	\N	\N	42.4	8
Thermaltake Divider 200 TG Snow	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	51.6	3
Thermaltake Divider 300 ARGB Snow Triangular	\N	ATX Mid Tower	White	\N	Tempered Glass	48.2	2
Silverstone FARA R1 Rainbow	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	1
Thermaltake Divider 500 TG ARGB Snow	174.96	ATX Mid Tower	White	\N	Tempered Glass	56.8	2
CiT S003B	\N	MicroATX Desktop	Black / Silver	300	\N	12.1	2
Chieftec Chieftronic M2	\N	MicroATX Mid Tower	\N	\N	Tempered Glass	37.5	2
Azza CUBE MINI 805	\N	Mini ITX Tower	Silver / Black	\N	Tempered Glass	17.6	0
SHARKOON Rebel C60 RGB	\N	ATX Mid Tower	White	\N	Tempered Glass	52	3
SHARKOON Rebel C80G RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	55.7	3
Silverstone SG03B-F	\N	MicroATX Mini Tower	Black	\N	\N	22.2	0
BitFenix Aegis	\N	MicroATX Mid Tower	Red	\N	Acrylic	46.2	4
Cooler Master MasterBox E500L	\N	ATX Mid Tower	Black / Silver	\N	\N	\N	2
Jonsbo TR03-A	\N	ATX Mid Tower	Black	\N	Tempered Glass	95.3	3
Jonsbo TR03-G	\N	ATX Mid Tower	Silver	\N	Tempered Glass	95.3	3
GAMDIAS ARGUS M2	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
In Win Explorer	\N	Mini ITX Desktop	Yellow / Red	\N	Tempered Glass	34.3	1
In Win A5	\N	ATX Mid Tower	White	\N	Tempered Glass	34.9	2
Chieftec BT-06B-250VS (230v)	\N	Mini ITX Tower	\N	250	\N	10.5	1
Jonsbo UMX6	\N	ATX Full Tower	Black	\N	\N	54.1	2
Chieftec SCORPION 3	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	43.3	2
GameMax Vega	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	53.2	3
RAIJINTEK PAN Slim	\N	Mini ITX Desktop	Silver	\N	\N	38.7	2
YEYIAN Phoenix	\N	ATX Mid Tower	Black	\N	Mesh	47.3	2
Jonsbo D32 STD MESH	\N	MicroATX Desktop	\N	\N	Tempered Glass	25.7	1
Antec NSK1380	\N	MicroATX Mini Tower	Silver / Black	350	\N	18	3
Antec NSK4482B	\N	ATX Mid Tower	Black	380	\N	34.9	3
Antec Two Hundred V2	\N	ATX Mid Tower	Black	\N	\N	42.1	0
Cooler Master Elite 310	\N	ATX Mid Tower	Black / Red	\N	Acrylic	39.1	6
Cooler Master Elite 330	\N	ATX Mid Tower	Black / Silver	350	\N	38.2	5
Cooler Master Gladiator 600	\N	ATX Mid Tower	Black / Gray	\N	\N	41.8	5
Cooler Master HAF 932	\N	ATX Full Tower	Black	\N	Acrylic	76.7	5
Cooler Master Storm Sniper	\N	ATX Mid Tower	Black	\N	Acrylic	79.2	5
Gigabyte GZ-KXA	\N	ATX Mid Tower	Black	\N	\N	32.8	5
Thermaltake LANBOX Lite	\N	MicroATX Mini Tower	Black	\N	Acrylic	29.6	2
Thermaltake Armor+ MX	\N	ATX Mid Tower	Black	\N	Acrylic	62.8	4
Thermaltake Element G	\N	ATX Mid Tower	Black	\N	\N	57.5	7
Thermaltake Element Q	\N	Mini ITX Desktop	Black	200	\N	9.4	1
Thermaltake ARMOR A90	\N	ATX Mid Tower	Black	\N	Acrylic	54.3	6
Thermaltake ARMOR A60	\N	ATX Mid Tower	Black	\N	Acrylic	50.4	5
Thermaltake ARMOR A60 AMD Edition	\N	ATX Mid Tower	Black / Red	\N	Acrylic	50.4	5
Rosewill Cruiser	\N	ATX Mid Tower	Black	\N	Acrylic	47.7	4
Rosewill R101-P	\N	MicroATX Mid Tower	Black	\N	\N	25.3	4
Rosewill R363-M	\N	MicroATX Mid Tower	Black	400	\N	25.8	2
NZXT Lexa S	\N	ATX Mid Tower	Black	\N	Acrylic	49.6	7
HEC 63RABB	\N	ATX Mid Tower	Black	\N	\N	35.2	4
Antec Solo	\N	ATX Mid Tower	Black / White	\N	\N	41.4	4
Cooler Master Elite 334 nVidia	\N	ATX Mid Tower	Black	\N	Acrylic	38.2	6
Thermaltake Armor A30	\N	ATX Mini Tower	Black	\N	Acrylic	35.5	2
Lian Li PC-Q06	\N	Mini ITX Test Bench	Red	\N	\N	10.7	1
Lian Li PC-Q09F	\N	Mini ITX Desktop	Silver	150	\N	6.3	0
Lian Li PC-Q09F	\N	Mini ITX Desktop	Black	150	\N	6.3	0
Lian Li PC-Q09F	\N	Mini ITX Desktop	Red	150	\N	6.3	0
Lian Li PC-Q09	\N	Mini ITX Desktop	Red	80	\N	5.5	0
Lian Li PC-Q09	\N	Mini ITX Desktop	White	110	\N	5.5	0
Lian Li PC-Q11	\N	Mini ITX Tower	Red	\N	\N	16.8	2
Lian Li PC-60FNWX	\N	ATX Mid Tower	Black	\N	Acrylic	48	4
Lian Li PC-7FNWX	\N	ATX Mid Tower	Black	\N	Acrylic	47.9	4
Lian Li PC-A06FB	\N	ATX Mid Tower	Black	\N	\N	34	3
Lian Li PC-B70	\N	ATX Full Tower	Black	\N	\N	76.9	10
Lian Li PC-C39	\N	HTPC	Black	\N	\N	16.6	2
Lian Li PC-C37B	\N	HTPC	Black	\N	\N	15.3	2
Lian Li PC-T1	\N	Mini ITX Test Bench	Black	\N	\N	21.1	1
Lian Li PC-T7	\N	Mini ITX Test Bench	Black	\N	\N	18.6	1
Lian Li PC-V1200Bplus II	\N	ATX Mid Tower	Black	\N	\N	64.2	6
Lian Li PC-V2120	\N	ATX Full Tower	Black	\N	\N	93.5	10
Lian Li PC-V2120	\N	ATX Full Tower	Black	\N	\N	93.5	10
Lian Li PC-V352	\N	MicroATX Desktop	Black	\N	\N	30.4	3
Aerocool AeroRacer Pro-Red	\N	ATX Mid Tower	Black / Red	\N	\N	34.8	4
Aerocool Vx-e	\N	ATX Mid Tower	Black	\N	\N	47.7	0
Apevia X-Gear	\N	ATX Mid Tower	Green / Blue	420	Acrylic	40.1	4
Apevia X-Cruiser2	\N	ATX Mid Tower	Blue / Silver	\N	Acrylic	40.1	5
Apevia X-Jupiter G-Type	\N	ATX Full Tower	Black	\N	\N	66.3	6
Apevia X-Plorer2	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	39.2	5
Apevia X-QBOII	\N	MicroATX Mini Tower	Black	500	Acrylic	28.4	2
Apevia X-QPack	\N	MicroATX Desktop	Black / Silver	420	\N	22.7	2
Apevia X-QPack	\N	MicroATX Desktop	Black	420	\N	22.7	2
Apevia X-QPack2	\N	MicroATX Desktop	Black / Silver	500	\N	24.2	2
Apevia X-QPack2	\N	MicroATX Desktop	Black / Pink	500	Acrylic	24.2	2
Apevia X-Telstar-Jr G-Type	\N	ATX Mid Tower	Silver	\N	Acrylic	42.3	3
Apevia X-Telstar-Jr S-Type	\N	ATX Mid Tower	Silver	\N	\N	42.3	3
Apevia X-Telstar-Jr S-Type	\N	ATX Mid Tower	Black / Red	\N	\N	42.3	3
Antec P183 V3	\N	ATX Mid Tower	Black	\N	\N	53.8	6
NZXT M59 - 001BK	\N	ATX Mid Tower	Black	\N	Acrylic	43.1	7
NZXT Guardian 921 RB	\N	ATX Mid Tower	Black	\N	Acrylic	\N	4
HEC 6T18BBHP485D	\N	MicroATX Mini Tower	Black	485	\N	21.6	1
NZXT Apollo	\N	ATX Mid Tower	Black	\N	Acrylic	61.8	4
NZXT Beta Evo	\N	ATX Mid Tower	Black	\N	\N	48.9	5
NZXT Lexa Blackline	\N	ATX Mid Tower	Black	\N	Acrylic	65.4	5
Apex DM-318	\N	HTPC	Black	275	\N	12.8	1
Apex TM-302-3	\N	MicroATX Mid Tower	Black / Silver	300	\N	25.7	1
Apex TX-373	\N	MicroATX Mid Tower	Black	300	\N	26.7	4
Apex TX-519-35	\N	MicroATX Mid Tower	Black	350	\N	26.7	4
Apex Vortex 3620mini	\N	MicroATX Mid Tower	Black	\N	\N	25	2
Athena Power CA-1015CR40	\N	MicroATX Slim	Black / Red	400	\N	18.1	1
Athena Power CA-1015IS30	\N	MicroATX Slim	Black / Silver	300	\N	18.1	1
Athena Power CA-1015IS47	\N	MicroATX Slim	Black / Silver	470	\N	18.1	1
Athena Power CA-601B95	\N	ATX Full Tower	Black	950	\N	50.6	4
Athena Power CA-601YW80	\N	ATX Full Tower	Yellow	800	Acrylic	50.6	4
Athenatech A1089BB.150	\N	Mini ITX Tower	Black	150	\N	9.9	1
Athenatech A1089BW.150	\N	Mini ITX Tower	Black / White	150	\N	9.9	1
Enermax ECA2020	\N	MicroATX Mid Tower	Black	350	\N	29.3	4
Enermax ECA3170	\N	ATX Mid Tower	Black	\N	\N	33.9	6
Foxconn TLA+566(H+A)+ISO-400-4SS	\N	ATX Mid Tower	Black / Silver	300	\N	33.2	4
Foxconn TLM-566(H+A)+ISO-400-4SS	\N	MicroATX Mid Tower	Black / Silver	300	\N	25.7	4
Foxconn TW-689 (H+A)+ISO-450	\N	MicroATX Mini Tower	Black / Silver	350	\N	25.1	2
Gigabyte GZ-AA2CB-SNS	\N	ATX Mid Tower	White / Black	\N	\N	44.1	3
Gigabyte Setto 1020	\N	ATX Mid Tower	Black	\N	\N	36.1	6
Gigabyte Sumo 5115	\N	ATX Full Tower	Black	\N	\N	60.5	5
Gigabyte GZ-P5HA3W	\N	ATX Mid Tower	Black	\N	\N	26.5	5
Gigabyte GZ-X6BPD-500	\N	ATX Mid Tower	Black	\N	\N	36.1	3
In Win BK644.BN300TBL	\N	MicroATX Mini Tower	Black	300	\N	12.3	1
In Win C583T.CQ350TBL	\N	ATX Mid Tower	Black / Silver	350	\N	35	3
In Win EM033.T350BL	\N	ATX Mini Tower	Black	\N	\N	25.3	2
In Win IW-Z589T.CQ350TBL	\N	MicroATX Mini Tower	Black	350	\N	24.2	1
In Win IW-Z638T.CQ350TBL	\N	MicroATX Mini Tower	Black	350	\N	24.2	1
Raidmax Tornado	\N	ATX Mid Tower	Black / Red	\N	Acrylic	42.1	5
Raidmax Tornado	\N	ATX Mid Tower	Black / Red	450	Acrylic	42.1	5
Raidmax Smilodon ATX-612WB	\N	ATX Mid Tower	Black / White	\N	Acrylic	47.5	4
Raidmax Aztec	\N	ATX Mid Tower	Black / Yellow	\N	Acrylic	47.5	4
Raidmax Quantum ATX-798WB	\N	ATX Mid Tower	Black	\N	Acrylic	58.6	6
Raidmax Sagitta ATX-928WB	\N	ATX Mid Tower	Black	\N	Acrylic	44.6	3
Raidmax Skyline ATX-948WB	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	47.1	4
Silverstone KL02-B	\N	ATX Mid Tower	Black	\N	\N	41.7	4
Silverstone KL03-B	\N	ATX Full Tower	Silver	\N	\N	68.2	4
Silverstone SG05-B	\N	Mini ITX Desktop	Black	300	\N	10.7	1
Silverstone SG06-B	\N	Mini ITX Desktop	Black	300	\N	11.1	1
Sunbeam ACUF-HUVB	\N	ATX Mid Tower	Clear	\N	\N	33.3	2
XClio WTBK ADVANCED	\N	ATX Full Tower	Black	\N	\N	75.7	6
Xigmatek Asgard II	\N	ATX Mid Tower	Black / Silver	\N	\N	35.5	5
Xion AXP600-001BK	\N	ATX Mid Tower	Black	\N	\N	40	4
Athenatech A100SC.270	\N	HTPC	Gray / Silver	270	\N	18.5	2
Foxconn DH-153C(H+A)+MT-300-4SS	\N	HTPC	Black	300	\N	13	1
Silverstone LC20-B	\N	HTPC	Black	\N	\N	31.3	6
Zalman HD160	\N	HTPC	Silver / Black	\N	\N	29.4	4
Lian Li PC-K63	\N	ATX Mid Tower	Black	\N	Acrylic	60.1	6
In Win BK644	\N	MicroATX Mini Tower	Black	300	\N	12.3	1
Broadway Com Corp 937PK	\N	MicroATX Mid Tower	Black / Gray	420	\N	25.5	4
NZXT Zero 2	\N	ATX Full Tower	Black	\N	\N	59.7	6
Cooler Master HAF 922	\N	ATX Mid Tower	Black	\N	Acrylic	71.5	5
Dynapower EN-4102	\N	MicroATX Mid Tower	Silver / Black	\N	\N	38.8	4
Gigabyte Triton 180	\N	ATX Mid Tower	Black	\N	\N	41.9	3
In Win BP671.200BL	\N	Mini ITX Tower	Black	200	\N	8.1	1
In Win IW-Z589T.D400TBL	\N	MicroATX Mini Tower	Black	400	\N	\N	1
Lian Li PC-K59	\N	ATX Mid Tower	Black	\N	Acrylic	60.1	6
Raidmax Atlas	\N	ATX Mid Tower	Black	500	Acrylic	44.7	4
Raidmax ATX-298WBP	\N	ATX Mid Tower	Black	500	Acrylic	42.9	4
Raidmax Typhoon	\N	ATX Mid Tower	Black	450	Acrylic	36.2	5
Raidmax Aztec	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	47.5	4
Rosewill Future	\N	ATX Mid Tower	Black	\N	\N	39.7	6
Apevia X-Trooper	\N	ATX Mid Tower	Black	\N	Acrylic	44.8	6
Logisys Area 51	\N	ATX Mid Tower	Black	480	Acrylic	65.3	5
Lian Li PC-A05FNB	\N	ATX Mid Tower	Black	\N	\N	40.4	3
Lian Li PC-A70F USB3.0	\N	ATX Mid Tower	Black	\N	\N	76.3	10
Lian Li PC-U6B	\N	MicroATX Mid Tower	Black	\N	\N	44.6	3
Lian Li PC-X900	\N	ATX Mid Tower	Black	\N	Acrylic	53.3	7
Logisys CS206BK	\N	ATX Mid Tower	Black	480	\N	28.8	5
Logisys CS308BK	\N	ATX Mid Tower	Black / Silver	480	Acrylic	31.8	5
Logisys CS308RD	\N	ATX Mid Tower	Black / Red	480	Acrylic	31.8	5
Raidmax Tornado	\N	ATX Mid Tower	Black	450	\N	42.1	5
Silverstone TJ11B-W	\N	ATX Full Tower	Black	\N	Acrylic	94.5	6
nMEDIAPC HTPC 1080P	\N	HTPC	Black	\N	\N	17.7	3
nMEDIAPC HTPC 2000B	\N	HTPC	Black	\N	\N	29.9	6
Linkworld 313-06-C2228	\N	ATX Mid Tower	Black / Silver	\N	\N	35.2	5
Sentey BX1-4243 v2.1	\N	ATX Mid Tower	Black	\N	\N	40.2	4
Sentey CS2-1332	\N	ATX Mid Tower	Black	\N	\N	25.9	2
Linkworld 43716-128FU+P04	\N	MicroATX Mini Tower	Black / Silver	430	\N	23.2	1
Sentey CS2-1331	\N	ATX Mid Tower	Black	\N	\N	25.9	2
Diablotek LEGEND	\N	ATX Mid Tower	Black	\N	\N	\N	2
Sigma ORCA-B	\N	ATX Mid Tower	Black / Silver	\N	\N	38.9	4
Sentey PS1-3213	\N	ATX Mid Tower	Black	\N	\N	29.8	2
Sigma UNICORN-ST	\N	ATX Mid Tower	Black / Gray	\N	\N	47.7	4
Sentey BX1-4234 v2.1	\N	ATX Mid Tower	Black	\N	\N	40.2	4
Sigma Venom-WB	\N	ATX Mid Tower	Black	\N	Acrylic	42.2	5
Sentey Arvina Extreme Division	\N	ATX Full Tower	Black	\N	\N	60.7	5
Cougar Evolution	\N	ATX Mid Tower	Black	\N	Acrylic	59.8	4
Azza Toledo 301	\N	ATX Mid Tower	Black	\N	\N	57.1	4
Rosewill Challenger-U3	\N	ATX Mid Tower	Black	\N	\N	38.4	5
Azza Solano 1000	\N	ATX Full Tower	Black	\N	Acrylic	56	8
Sentey BX1-4284 v2.1	\N	ATX Mid Tower	Black	\N	\N	40.2	4
BitFenix Merc Alpha	\N	ATX Mid Tower	Black	\N	\N	40.5	6
BitFenix Shinobi Window	\N	ATX Mid Tower	Black	\N	Acrylic	46.2	7
Fractal Design Define R3	\N	ATX Mid Tower	Black / Gray	\N	\N	47.5	8
Cooler Master Silencio 450	\N	ATX Mid Tower	Black	\N	\N	43	5
Lian Li PC-90	\N	ATX Full Tower	Black	\N	\N	57.5	7
Lian Li PC-TU200	\N	Mini ITX Tower	Silver	\N	\N	21.6	4
NZXT Apollo	\N	ATX Mid Tower	Orange / Black	\N	Acrylic	61.8	4
NZXT Apollo	\N	ATX Mid Tower	Silver / Black	\N	Acrylic	61.8	4
Apevia X-Jupiter G-Type	\N	ATX Full Tower	Blue	\N	\N	66.3	6
Apevia X-Jupiter G-Type	\N	ATX Full Tower	Gray	\N	\N	66.3	6
Apevia X-Dreamer2	\N	ATX Mid Tower	Silver	420	Acrylic	40	5
Diablotek FLY	\N	ATX Mid Tower	Gray / Black	\N	\N	37.1	3
Cougar 6XR9	\N	ATX Mid Tower	Black / White	\N	\N	51.4	4
Linkworld CA-IP-W-WOP	\N	ATX Mid Tower	Silver	\N	\N	\N	3
Xion XON-570	\N	ATX Mid Tower	Black	\N	\N	31.7	5
Silverstone Fortress Series FT02S	\N	ATX Full Tower	Silver	\N	\N	64.8	5
Azza Helios 910	\N	ATX Mid Tower	Black	\N	\N	47	4
Azza Hurrican 2000	\N	ATX Full Tower	Black	\N	Acrylic	82	6
In Win PE663T2.D450TBL	\N	ATX Mid Tower	Black	450	\N	39.4	5
Sentey GS-6500	\N	ATX Full Tower	Black	\N	\N	61	5
Sentey BX1-4237 V2.2	\N	ATX Mid Tower	Black	\N	\N	40.2	4
Thermaltake VN10006W2N-B	\N	ATX Full Tower	White / Black	\N	Acrylic	96.7	5
Sigma ATLANTIS	\N	ATX Mid Tower	Black	\N	\N	74.1	4
Sigma ATLANTIS	\N	ATX Mid Tower	Silver	\N	\N	74.1	4
Rosewill RANGER	\N	ATX Mid Tower	Black	\N	Acrylic	44.6	4
Sentey GS-6500R	\N	ATX Full Tower	Black / Red	\N	\N	61	5
Raidmax ATX-298WR	\N	ATX Mid Tower	Black / Red	\N	Acrylic	42.9	4
Azza Fusion 4000	\N	ATX Full Tower	Black	\N	\N	122.9	8
In Win MANA134	\N	ATX Mid Tower	Black	\N	\N	39.9	6
Cooler Master Elite 311	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	40.8	5
Cooler Master Elite 311	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	40.8	5
Antec One Hundred USM	\N	ATX Mid Tower	Black	\N	\N	45.3	6
In Win MANA136	\N	ATX Mid Tower	Black	\N	\N	40.5	6
In Win BUC 101	\N	ATX Mid Tower	Black	\N	\N	50.3	5
Enermax Fulmo GT	\N	ATX Full Tower	Black	\N	\N	101.4	10
Logisys CS2008XBK	\N	ATX Mid Tower	Black	\N	\N	38.6	5
Logisys CS1202BK	\N	ATX Mid Tower	Black	\N	\N	38.6	5
nMEDIAPC HTPC 7000B	\N	HTPC	Black	\N	\N	18.3	3
In Win MANA137	\N	ATX Mid Tower	Black	\N	\N	40.3	6
Lian Li PC-Q09FN	\N	HTPC	Black	300	\N	7.5	1
Lian Li PC-Q18	\N	HTPC	Black	\N	\N	20.9	6
BitFenix Shinobi Window XL	\N	ATX Full Tower	Black	\N	Acrylic	77.6	7
DIYPC Alpha-GT3	\N	ATX Test Bench	Black	\N	\N	35.6	0
Thermaltake Armor Revo Snow Edition	\N	ATX Full Tower	White / Black	\N	Acrylic	82	6
Silverstone KL04B	\N	ATX Mid Tower	Black	\N	\N	52.1	9
Silverstone TJ07B-W-USB3.0	\N	ATX Full Tower	Black	\N	Acrylic	69.2	6
Raidmax Sting Ray ATX-249B	\N	ATX Mid Tower	Black	\N	\N	43.4	3
Rosewill RPS-01	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	45.7	6
Azza Armour 203	\N	ATX Mid Tower	Black	\N	Acrylic	43.5	6
Gigabyte GZ-M3BPD-700	\N	MicroATX Mid Tower	Black	\N	\N	25.3	2
Cougar Challenger	\N	ATX Mid Tower	Black	\N	Acrylic	71.6	7
Silverstone PS07B	\N	MicroATX Mini Tower	White	\N	\N	31.4	5
Silverstone RV02B-EW-USB3.0	\N	ATX Full Tower	Black	\N	Acrylic	69.6	5
MSI Stealth	\N	ATX Mid Tower	Black	\N	\N	40.3	4
Zalman GS1000-T	\N	ATX Full Tower	Black / Silver	\N	\N	94.7	6
Cougar Volant	\N	ATX Mid Tower	Black	\N	\N	40.6	6
In Win C583T.CQ450TBL	\N	ATX Mid Tower	Black / Silver	450	\N	35	3
Silverstone FT02B-USB3.0	\N	ATX Mid Tower	Black	\N	\N	64.8	5
Silverstone LC13B-E-USB3.0	\N	HTPC	Black	\N	\N	32.3	4
Silverstone SG06B-USB3.0	\N	Mini ITX Desktop	Black	300	\N	11.1	1
Sentey GS-6050 II Halcon	\N	ATX Mid Tower	Black	\N	Acrylic	42.5	4
Silverstone RL01B-USB 3.0	\N	ATX Mid Tower	Gray / Black	\N	Acrylic	40.9	5
Silverstone SG06BB-450-USB3.0	\N	Mini ITX Desktop	Black	450	\N	11.1	1
Sentey GS-6000 II Optimus	\N	ATX Mid Tower	Black	\N	Acrylic	42.5	4
Sentey CS3-3340 TAC2.0	\N	ATX Mid Tower	Black	\N	\N	36.9	5
Xion XON-980	\N	ATX Mid Tower	Black	\N	\N	60.4	7
Topower TP-6208BB-450	\N	ATX Mid Tower	Black / Silver	450	\N	33.4	6
Silverstone FT03-MINI	\N	Mini ITX Tower	Silver	\N	\N	17.5	1
Lian Li PC-V355	\N	MicroATX Mini Tower	Silver	\N	\N	28.5	3
Lian Li PC-V355	\N	MicroATX Mini Tower	Black	\N	\N	28.5	3
Xion XON-910PCB	\N	MicroATX Mid Tower	White / Red	450	\N	18.6	1
Diablotek CYCLOPS	\N	ATX Mid Tower	Black	\N	\N	41.4	5
Raidmax ATX-809B	\N	ATX Mid Tower	Black	\N	\N	55.5	5
Raidmax ATX-823BR	\N	ATX Mid Tower	Black	\N	\N	58.2	5
Thermaltake Commander MS-II	\N	ATX Mid Tower	Black	\N	Acrylic	39.7	5
Xigmatek GIGAS	\N	MicroATX Desktop	Black	\N	\N	35.2	6
Lian Li PC-V750	\N	ATX Full Tower	Black	\N	Acrylic	99.4	9
Lian Li PC-V750	\N	ATX Full Tower	Silver	\N	\N	99.4	9
Silverstone SG07B-USB3.0	\N	Mini ITX Desktop	Black / Gray	600	\N	14.6	1
DIYPC DIY-5823	\N	ATX Mid Tower	Black / Silver	\N	\N	28.3	6
Silverstone FT02B-USB3.0	\N	ATX Mid Tower	Black	\N	Acrylic	64.8	5
DIYPC DIY-5823	\N	ATX Mid Tower	Black	\N	\N	28.3	6
In Win IW-BQ656T.AD80TBLR	\N	Mini ITX Desktop	Black	80	\N	3.3	0
DIYPC Adventurer-9601R	\N	ATX Full Tower	Black	\N	Acrylic	49.7	7
Gigabyte GZ-P5HB5C	\N	ATX Mid Tower	Black	\N	\N	\N	4
Apevia X-Jupiter-Jr G-Type	\N	ATX Mid Tower	Blue	\N	Acrylic	42.3	3
Rosewill FBM-02	\N	MicroATX Mini Tower	Black / Gray	\N	\N	21.6	2
Silverstone FT02B-USB3.0	\N	ATX Mid Tower	White / Silver	\N	\N	64.8	5
BitFenix Prodigy	\N	Mini ITX Tower	Orange	\N	\N	36	5
BitFenix Raider Window	\N	ATX Mid Tower	Black	\N	Acrylic	\N	6
Rosewill Line	\N	ATX Mid Tower	Black	\N	\N	35.5	8
Zalman Z5 Plus	\N	ATX Mid Tower	Black	\N	Acrylic	45.8	3
Xion XON-560	\N	MicroATX Mini Tower	White	\N	\N	28.3	3
Xion XON-560	\N	MicroATX Mini Tower	Black	\N	\N	28.3	3
Silverstone RV02B-W-USB3.0	\N	ATX Full Tower	Black	\N	Acrylic	68.3	3
CFI Prime 101	\N	ATX Mid Tower	Black	\N	\N	27.5	2
CFI CFI-A7007	\N	ATX Full Tower	Black	\N	Acrylic	69.1	6
Lian Li PC-7H	\N	ATX Mid Tower	Silver	\N	\N	55.5	4
Ultra Etorque X10	\N	ATX Full Tower	Black	\N	\N	107.3	8
Thermaltake Armor Revo Gene	\N	ATX Mid Tower	Black	\N	Acrylic	69.9	5
Thermaltake Level 10 Limited Edition	\N	ATX Full Tower	Silver	\N	\N	129.6	6
Thermaltake Level 10 GTS	\N	ATX Mid Tower	Black	\N	Acrylic	54.9	5
Thermaltake Level 10 GTS Snow Edition	\N	ATX Mid Tower	White	\N	Acrylic	54.9	5
Thermaltake Versa I	\N	ATX Mid Tower	Black	\N	\N	42.2	5
Silverstone SG01B-F-USB3.0	\N	MicroATX Desktop	Silver	\N	\N	21.7	2
Enermax ECA3280A	\N	ATX Mid Tower	Black / Red	\N	Acrylic	58.2	8
Lian Li PC-C37B USB3.0	\N	HTPC	Black	\N	\N	15.3	2
Lian Li PC-Q30	\N	Mini ITX Tower	Black	\N	\N	23.4	0
Lian Li PC-TU100	\N	Mini ITX Tower	Silver	\N	\N	10.6	0
Gigabyte GZ-X5	\N	ATX Mid Tower	Black	\N	\N	36.1	5
Gigabyte GZ-ZA2	\N	ATX Mid Tower	Black	\N	\N	30.9	5
Gigabyte Luxo X10	\N	ATX Mid Tower	Black	\N	\N	34	4
Cougar Solution C400SL	\N	ATX Mid Tower	Black	400	\N	\N	6
Rosewill THRONE	\N	ATX Full Tower	White	\N	\N	74.8	10
Azza Silentium 920B	\N	ATX Mid Tower	Black	\N	\N	\N	5
Cooler Master RC-912-KKN4	\N	ATX Mid Tower	Black	\N	\N	54.9	6
In Win BL040.300TB3LF	\N	HTPC	Black	\N	\N	11.6	2
In Win BL672.300TB3LF	\N	HTPC	Black	\N	\N	11.6	2
In Win C653T.CQ350TB3L	\N	ATX Mid Tower	Black	\N	\N	35	3
In Win EM013.CQ350TS3L	\N	MicroATX Mini Tower	Black	350	\N	25.3	2
In Win G7	\N	ATX Mid Tower	Black	\N	\N	43.6	4
In Win GT1	\N	ATX Mid Tower	White	\N	Acrylic	48.8	6
In Win H-Frame	\N	ATX Mid Tower	Blue / Silver	\N	\N	62.8	3
In Win PE689T2.CQ450TBL	\N	ATX Mid Tower	Black	\N	\N	39.4	0
Silverstone SG06BB-LITE	\N	Mini ITX Desktop	Black	\N	Acrylic	\N	1
Xion XON-566TB	\N	ATX Mid Tower	Black	\N	Acrylic	\N	4
Zalman Z12 Plus	\N	ATX Mid Tower	Black	\N	Acrylic	47.7	5
Zalman ZM-T2	\N	MicroATX Mini Tower	Black	\N	\N	24.7	2
Apevia X-Cruiser	\N	ATX Mid Tower	Blue	\N	Acrylic	41.2	5
Apevia X-Dreamer4	\N	ATX Mid Tower	Silver	\N	Acrylic	43.1	4
Apex DS-539	\N	HTPC	Black	275	\N	14.3	2
DIYPC HTPC-KT28B	\N	HTPC	Black	\N	\N	18.8	2
DIYPC MiniQ1	\N	MicroATX Mini Tower	White	\N	\N	24.7	2
DIYPC MiniQ7	\N	ATX Mini Tower	White	\N	\N	24.8	2
DIYPC Skyline	\N	ATX Mid Tower	Black	\N	\N	28.3	6
Raidmax Vampire	\N	ATX Full Tower	Black	\N	Acrylic	80.5	7
Raidmax Atlas	\N	ATX Mid Tower	Blue / Black	\N	Acrylic	44.7	4
Raidmax ATX-298WBP	\N	ATX Mid Tower	Black / Blue	\N	\N	42.9	4
Raidmax ATX-502WBG	\N	ATX Mid Tower	White / Black	\N	Acrylic	59.5	3
Rosewill FBM-01	\N	MicroATX Mini Tower	White	\N	\N	21.6	2
Sentey GS-6020	\N	ATX Mid Tower	Black	\N	\N	40.2	4
HEC EnterpriseH585	\N	MicroATX Mid Tower	Black	\N	\N	\N	2
HEC Vigilance	\N	MicroATX Mini Tower	Black	\N	\N	27.5	2
Apevia X-Cruiser3	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	44.7	4
Apevia X-Cruiser3	\N	ATX Mid Tower	Black / Red	\N	Acrylic	44.7	4
Logisys CS368BB	\N	ATX Mid Tower	Black / Blue	480	\N	34	6
Rosewill Galaxy-03	\N	ATX Mid Tower	Black	\N	\N	29.9	4
Silverstone FT04	\N	ATX Full Tower	Black	\N	Acrylic	\N	7
Silverstone FT04	\N	ATX Full Tower	Silver	\N	Acrylic	\N	7
BitFenix Ronin	\N	ATX Mid Tower	Black	\N	Acrylic	\N	6
Enermax ECA3212	\N	ATX Mid Tower	Black / Blue	\N	\N	\N	5
Xigmatek Recon	\N	ATX Mid Tower	Black	\N	\N	\N	4
In Win D-FRAME	\N	ATX Desktop	Orange	\N	Acrylic	97.5	3
Gigabyte Sumo Alpha	\N	ATX Mid Tower	Black	\N	Acrylic	53.1	4
Apevia X-Hermes	\N	ATX Mid Tower	Black / Red	\N	Acrylic	44.7	4
DIYPC FM08	\N	ATX Mid Tower	Black / Blue	\N	\N	33.8	2
Gigabyte Luxo M30	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	63.8	8
Gigabyte Luxo M30 White	\N	ATX Mid Tower	White / Black	\N	Acrylic	63.8	8
In Win H-Frame Mini	\N	Mini ITX Tower	Black / Green	180	Acrylic	\N	0
Raidmax ATX-502WBG	\N	ATX Mid Tower	Black / Silver	\N	\N	59.5	3
Rosewill R536	\N	ATX Mid Tower	Black	500	\N	35.6	5
Rosewill THRONE-G-Window	\N	ATX Full Tower	Gunmetal	\N	Acrylic	74.8	10
Rosewill FBM-01	\N	MicroATX Mini Tower	Black	450	\N	21.6	2
Enermax ECA3310B	\N	ATX Mid Tower	Red	\N	Acrylic	58.6	7
Cubitek ATX ICE	\N	ATX Mid Tower	Black	\N	\N	\N	7
Aerocool DS Cube	\N	MicroATX Mini Tower	Black / Red	\N	\N	41.5	2
Aerocool DS Cube	\N	MicroATX Mini Tower	Black / Orange	\N	Acrylic	41.5	2
SHARKOON MA-M1000	\N	MicroATX Mid Tower	Black / Blue	\N	\N	\N	2
Thermaltake ARMOR A30i	\N	MicroATX Mini Tower	Black	\N	Acrylic	35.5	3
Streacom ST-F1CS-EVO	\N	HTPC	Silver	\N	\N	\N	0
Cooler Master HAF 912	\N	ATX Mid Tower	Black	\N	\N	54.9	6
Antec Nineteen Hundred	\N	ATX Full Tower	Black / Green	\N	Acrylic	\N	12
Antec Nineteen Hundred	\N	ATX Full Tower	Black / Red	\N	Acrylic	\N	12
DIYPC Solar-M1	\N	ATX Mid Tower	Black / Green	\N	Acrylic	38	5
In Win 904	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Rosewill Legacy U2-S	\N	Mini ITX Tower	Silver	\N	Acrylic	15.4	2
Thermaltake Chaser A21	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	41.3	6
Xigmatek Assassin	\N	ATX Mid Tower	Black / Gray	\N	Acrylic	52.5	8
In Win 901	\N	Mini ITX Tower	Black / Silver	\N	Tempered Glass	\N	2
DIYPC Solar-M1	\N	ATX Mid Tower	Black / Red	\N	Acrylic	38	5
HEC 63R3BR	\N	ATX Mid Tower	Black / Red	\N	\N	35.2	4
Lian Li PC-V358	\N	MicroATX Mid Tower	Black	\N	\N	36.6	6
Rosewill Legacy U3-B	\N	MicroATX Mini Tower	Black	\N	\N	20.1	2
Rosewill Legacy V6-S	\N	Mini ITX Tower	Black / Silver	\N	\N	12.5	4
Silverstone PS09B	\N	MicroATX Mid Tower	Black	\N	\N	24.6	4
Supermicro CSE-732G-000B	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	64.7	3
Thermaltake Element Q	\N	Mini ITX Desktop	Black / Red	220	\N	9.4	1
Xigmatek Aquila	\N	MicroATX Mini Tower	Black / White	\N	Acrylic	\N	2
Cooler Master 690 III	\N	ATX Mid Tower	Black	\N	\N	58.5	7
Azza Sirius 206	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	38.3	3
DIYPC HTPC-MiniCube	\N	Mini ITX Tower	Silver	\N	\N	9.8	1
nMEDIAPC HTPC 2800B	\N	HTPC	Black	\N	\N	25	4
Silverstone PS10B	\N	ATX Mid Tower	Black	\N	\N	54.8	0
Thermaltake Urban R31	\N	ATX Mid Tower	Black	\N	Acrylic	51.2	6
Cooler Master K280 USB3.0	\N	ATX Mid Tower	Black	\N	\N	\N	6
SHARKOON Mask	\N	ATX Mid Tower	Black	\N	\N	\N	3
Parvum Systems S2.0	\N	MicroATX Mini Tower	Black / White	\N	Acrylic	\N	2
Parvum Systems S2.0	\N	MicroATX Mini Tower	Green / White	\N	Acrylic	\N	2
Parvum Systems S2.0	\N	MicroATX Mini Tower	White / Red	\N	Acrylic	\N	2
BitFenix Outlaw	\N	ATX Mid Tower	Black	\N	\N	37.3	4
BitFenix Outlaw USB3.0	\N	ATX Mid Tower	Black	\N	\N	37.6	4
BitFenix Neos	\N	ATX Mid Tower	Black / Gold	\N	Acrylic	37	3
BitFenix Neos	\N	ATX Mid Tower	Black / Silver	\N	\N	37	3
BitFenix Neos	\N	ATX Mid Tower	Black / Red	\N	\N	37	3
BitFenix Neos	\N	ATX Mid Tower	White / Red	\N	\N	37	3
BitFenix Neos	\N	ATX Mid Tower	White	\N	\N	37	3
BitFenix Phenom M Nvidia Edition	\N	MicroATX Mini Tower	Black / Green	\N	\N	30.6	5
Azza GT1	\N	ATX Full Tower	Black	\N	Acrylic	90.4	7
DIYPC FM08	\N	ATX Mid Tower	Black / Blue	\N	\N	33.8	2
HEC Voyager	\N	ATX Mid Tower	Black	\N	\N	29.5	1
Aerocool DS Cube	\N	MicroATX Mini Tower	Black / Blue	\N	\N	41.5	2
Aerocool DS Cube	\N	MicroATX Mini Tower	Black / Green	\N	\N	41.5	2
Aerocool Strike-X GT	\N	ATX Mid Tower	Black	\N	\N	42.9	6
CiT MTX-005B	\N	Mini ITX Tower	Black	300	\N	\N	1
Aerocool DS 200	\N	ATX Mid Tower	Black / Red	\N	\N	\N	5
Aerocool DS 200	\N	ATX Mid Tower	Black / Blue	\N	\N	\N	5
Aerocool DS 200	\N	ATX Mid Tower	Black / Green	\N	\N	\N	5
NZXT Source 220	\N	ATX Mid Tower	Black	\N	Acrylic	43.4	8
Lian Li PC-Q36W	\N	Mini ITX Tower	Black	\N	\N	25.4	2
Lian Li PC-V359W	\N	MicroATX Mid Tower	Silver	\N	\N	36.6	3
Lian Li PC-V359W	\N	MicroATX Mid Tower	Gold	\N	\N	36.6	3
Deepcool PANGU SW	\N	ATX Mid Tower	Black	\N	Acrylic	40.8	6
Deepcool STEAM CASTLE	\N	MicroATX Mid Tower	Red	\N	Acrylic	47.1	3
Corsair Graphite Series 380T	\N	Mini ITX Tower	Black / Yellow	\N	\N	41	2
Antec GX500 ILLUSION	\N	ATX Mid Tower	Black	\N	Acrylic	44.4	4
Lian Li PC-Q33	\N	Mini ITX Tower	Black	\N	\N	18.1	2
In Win GR One	\N	ATX Full Tower	White	\N	Acrylic	81	8
In Win GR One	\N	ATX Full Tower	Black / Red	\N	Acrylic	81	8
Antec ASK4000E-U3	\N	ATX Mid Tower	Black	\N	\N	33.4	5
BitFenix Pandora Core	\N	MicroATX Mid Tower	Black	\N	Acrylic	31.2	2
BitFenix Pandora Core	\N	MicroATX Mid Tower	Silver	\N	Acrylic	31.2	2
Lian Li PC-B16	\N	ATX Mid Tower	Black	\N	\N	57.4	6
Lian Li PC-10N	\N	ATX Mid Tower	Silver	\N	\N	\N	6
Lian Li PC-V1000L	\N	ATX Full Tower	Black	\N	Acrylic	73.6	0
Lian Li PC-V2130	\N	ATX Full Tower	Black	\N	\N	94.4	8
Lian Li PC-V2130	\N	ATX Full Tower	Black	\N	Acrylic	94.4	8
Lian Li PC-V359W	\N	MicroATX Mid Tower	Black	\N	\N	36.6	3
BitFenix Comrade	\N	ATX Mid Tower	White	\N	Acrylic	37	3
DIYPC Mirage-D1	\N	ATX Mid Tower	Black / Yellow	\N	Acrylic	37.2	4
In Win G7	\N	ATX Mid Tower	Gray	\N	\N	43.6	4
DIYPC MA01	\N	MicroATX Mini Tower	Black / Green	\N	\N	20.5	1
DIYPC Shadow-H01	\N	ATX Mid Tower	White	\N	Acrylic	47.8	4
Rosewill I3-397	\N	MicroATX Mini Tower	Black	400	\N	27.9	4
Thermaltake Versa H24	\N	ATX Mid Tower	Black	\N	Acrylic	42.6	3
BitFenix Prodigy M	\N	MicroATX Mini Tower	Black	\N	Acrylic	35.9	4
BitFenix Prodigy M	\N	MicroATX Mini Tower	Black / Red	\N	Acrylic	35.9	4
BitFenix Prodigy M	\N	MicroATX Mini Tower	Black / Red	\N	Acrylic	35.9	4
Aerocool Strike-X Xtreme	\N	ATX Mid Tower	Red	\N	Acrylic	\N	6
Aerocool Strike-X Advance	\N	ATX Mid Tower	White / Blue	\N	Acrylic	\N	0
DIYPC Solar-M1	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	38	5
DIYPC Solo-T1	\N	ATX Mid Tower	Black / Blue	\N	\N	38.9	3
DIYPC Solo-T1	\N	ATX Mid Tower	Black / Red	\N	\N	38.9	3
Thermaltake Core V41	\N	ATX Mid Tower	Black	\N	Acrylic	59.4	6
Raidmax Viper GX	\N	ATX Mid Tower	Black / Red	\N	Acrylic	65.3	7
Streacom F1CWS Evo	\N	HTPC	Black	\N	\N	\N	1
Deepcool STEAM CASTLE	\N	MicroATX Mid Tower	Black	\N	\N	47.1	3
Lian Li PC-T80	\N	ATX Test Bench	Silver	\N	\N	\N	6
RAIJINTEK Metis	\N	Mini ITX Tower	Black	\N	Acrylic	13.4	1
RAIJINTEK Metis	\N	Mini ITX Tower	Red	\N	Acrylic	13.4	1
RAIJINTEK Metis	\N	Mini ITX Tower	Red	\N	\N	13.4	1
Silverstone KL05B	\N	ATX Mid Tower	Black	\N	Acrylic	\N	6
Cooltek UMX1	\N	Mini ITX Tower	Silver	\N	\N	\N	2
BitFenix Aegis	\N	MicroATX Mid Tower	White	\N	Acrylic	46.2	4
Azza CSAZ-105	\N	Mini ITX Desktop	Black	\N	\N	\N	1
Antec P50	\N	MicroATX Mini Tower	Black	\N	\N	\N	3
Phanteks Enthoo Primo	\N	ATX Full Tower	Black / Green	\N	Acrylic	\N	6
Cooltek CoolCube	\N	HTPC	Black	\N	\N	\N	1
Silverstone MM01	\N	ATX Full Tower	Black	\N	\N	\N	7
Apevia X-QPack3	\N	MicroATX Mini Tower	Black / Green	\N	Acrylic	\N	2
Apevia X-QPack3	\N	MicroATX Mini Tower	Black / Red	\N	Acrylic	\N	2
Aerocool DS 200	\N	ATX Mid Tower	Black	\N	Acrylic	\N	5
Aerocool XPredator Cube	\N	MicroATX Mid Tower	Black / Red	\N	Acrylic	\N	3
Azza Cosmas 208S	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Sentey Ss1-2429	\N	MicroATX Mid Tower	Black / Green	\N	\N	\N	0
Sentey Ss1-2429	\N	MicroATX Mid Tower	Black / Red	\N	\N	\N	0
Cooltek W2	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Cooltek W2	\N	ATX Mid Tower	Silver	\N	Acrylic	\N	3
Cooler Master N400	\N	ATX Mid Tower	Black	\N	\N	40.2	7
Raidmax Element	\N	Mini ITX Desktop	Black / Green	450	\N	\N	2
Xigmatek Aquila	\N	MicroATX Mini Tower	Black / Green	\N	Acrylic	\N	2
Silverstone CS01	\N	Mini ITX Tower	Black	\N	\N	\N	2
CHENBRO SR30169	\N	Mini ITX Tower	Black / Silver	\N	\N	\N	4
be quiet! Silent Base 800	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	\N	7
be quiet! Silent Base 800	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	\N	7
Aerocool Aero-500 - C	\N	ATX Mid Tower	Black	\N	Acrylic	45.1	4
Deepcool Tristellar	\N	Mini ITX Desktop	White / Blue	\N	Acrylic	\N	2
Deepcool Tristellar	\N	Mini ITX Desktop	Black / Silver	\N	Acrylic	\N	2
In Win 805	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	\N	2
Chieftec DX-02B	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	6
Phanteks Enthoo EVOLV ITX	\N	Mini ITX Tower	Black / Red	\N	Acrylic	\N	2
NZXT H440	\N	ATX Mid Tower	Black	\N	\N	53.3	8
be quiet! Silent Base 600	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	\N	3
DIYPC Ranger-R8	\N	ATX Mid Tower	Black / Yellow	\N	Acrylic	41.6	4
DIYPC DIY-N8	\N	MicroATX Mini Tower	Black / Blue	\N	Acrylic	\N	2
Thermaltake Core V51 Riing Edition	\N	ATX Mid Tower	Black / Green	\N	Acrylic	71.2	5
SHARKOON CA-M	\N	MicroATX Mini Tower	Black	\N	\N	\N	2
Rosewill VIPER Z	\N	ATX Mid Tower	Black	\N	Acrylic	\N	7
Lian Li PC-Q10	\N	Mini ITX Desktop	Black	\N	Acrylic	\N	2
Aerocool GT-RS	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Raidmax Viper II	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	3
VIVO CASE-V03B	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	4
Apevia X-Pioneer	\N	ATX Mid Tower	Black / Green	\N	Acrylic	\N	4
Apevia X-Pioneer	\N	ATX Mid Tower	Black / Pink	\N	Acrylic	\N	4
Apevia X-Pioneer	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	4
DIYPC Silence	\N	ATX Mid Tower	Black	\N	\N	\N	2
Phanteks Eclipse P400S	\N	ATX Mid Tower	Gray	\N	\N	45.9	2
SHARKOON BW9000	\N	ATX Mid Tower	White	\N	Acrylic	\N	5
Silverstone CS01-HS	\N	Mini ITX Tower	Silver	\N	\N	\N	0
Lian Li PC-TU300	\N	ATX Mid Tower	Black	\N	\N	\N	2
Antec VSK4-500	\N	ATX Mid Tower	Black	500	\N	\N	5
DIYPC DIY-E68	\N	ATX Mid Tower	Black	\N	\N	\N	3
Apevia X-EnerQ	\N	MicroATX Mid Tower	Black / Red	\N	Acrylic	\N	2
LEPA LPC309(U3)	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
RIOTORO CR1080	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Apevia X-Qber	\N	MicroATX Desktop	Black / Green	\N	Acrylic	\N	2
Apevia X-Qber	\N	MicroATX Desktop	Pink	\N	Acrylic	\N	2
Apevia X-Qber	\N	MicroATX Desktop	White	\N	Acrylic	\N	2
Anidees AI8	\N	ATX Full Tower	Black	\N	Acrylic	\N	4
Nanoxia CoolForce 2	\N	ATX Full Tower	Black	\N	Acrylic	\N	4
Zalman T5	\N	MicroATX Mini Tower	Black	\N	\N	\N	2
Silverstone FT01B-USB3.0	\N	ATX Mid Tower	Black	\N	Acrylic	\N	7
Silverstone PM01	\N	ATX Mid Tower	Black / Red	\N	Acrylic	70.3	4
Raidmax Narwhal	\N	ATX Full Tower	Black	\N	Acrylic	\N	6
VIVO CASE-V07	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
SHARKOON T3-W	\N	ATX Mid Tower	Black / Green	\N	Acrylic	38.3	6
BitFenix Aurora	\N	ATX Mid Tower	Black	\N	Tempered Glass	54.8	4
In Win 509 ROG	\N	ATX Full Tower	Black / Red	\N	Tempered Glass	71.6	5
Rosewill WolfStone	\N	ATX Mid Tower	Black	\N	Acrylic	\N	8
X2 Nextyde	\N	ATX Mid Tower	Black	\N	Acrylic	34.2	2
NOX Hummer TX	\N	ATX Mid Tower	Black	\N	Acrylic	45.9	8
NOX Coolbay SX	\N	ATX Mid Tower	Black / Red	\N	Acrylic	37.9	4
NOX Coolbay ZX	\N	ATX Mid Tower	Black / Green	\N	Acrylic	48.7	3
Thermaltake Urban S31 Window	\N	ATX Mid Tower	White	\N	Acrylic	53.6	6
Deepcool LANDKING V2	\N	ATX Mid Tower	Gray	\N	Acrylic	57.5	5
RAIJINTEK Metis	\N	Mini ITX Tower	Green	\N	\N	13.4	1
Raidmax Viper GX II	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	65.6	3
Lian Li PC-Q20	\N	Mini ITX Tower	Pink	\N	\N	7.2	0
Silverstone RL05	\N	ATX Mid Tower	White / Red	\N	Acrylic	43.9	2
Cooler Master CM 590 III	\N	ATX Mid Tower	White	\N	Acrylic	45.1	4
Raidmax Ninja II	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	\N	3
Silverstone RL06	\N	ATX Mid Tower	Black / Red	\N	Acrylic	43.4	3
DIYPC DIY-J21	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
DIYPC DIY-J21	\N	ATX Mid Tower	White	\N	Acrylic	\N	3
BitFenix Portal	\N	Mini ITX Tower	Black	\N	Acrylic	\N	2
BitFenix Portal	\N	Mini ITX Tower	White	\N	Acrylic	\N	2
Cooler Master MasterCase Pro 6	\N	ATX Mid Tower	Black / Red	\N	Acrylic	70.1	5
Anidees AI Crystal Lite	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.5	3
Lian Li Odyssey	\N	Mini ITX Desktop	Silver	\N	\N	\N	2
Apevia X-Mirage	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	41.8	2
Apevia X-Mirage	\N	ATX Mid Tower	Black / Green	\N	Acrylic	41.8	2
SHARKOON DG7000-G	\N	ATX Mid Tower	Black / Green	\N	Tempered Glass	\N	3
RIOTORO CR480	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	3
Rosewill BRADLEY M	\N	ATX Mid Tower	Black	\N	Acrylic	36.6	3
Anidees AI Crystal Cube	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	50.5	3
Azza Solaris 402S	\N	ATX Mid Tower	Black	\N	Acrylic	\N	6
mean:it 5PM	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	51.5	3
mean:it 5PM	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	51.5	3
Rosewill HIMARS	\N	ATX Mid Tower	Black	\N	Acrylic	52.3	0
Enermax Ostrog ADV	\N	ATX Mid Tower	Black / Green	\N	Acrylic	54.7	6
Aerocool Aero-500	\N	ATX Mid Tower	Black	\N	\N	45.1	4
Cooler Master 690 III	\N	ATX Mid Tower	White / Black	\N	Acrylic	58.5	7
DIYPC Skyline-06	\N	ATX Full Tower	Black / Red	\N	Acrylic	\N	3
DIYPC Skyline-06	\N	ATX Full Tower	Black / Blue	\N	Acrylic	\N	3
Lian Li PC-T60	\N	ATX Test Bench	Silver	\N	\N	45.6	3
Silverstone RL06	\N	ATX Mid Tower	White / Black	\N	Acrylic	43.4	3
Lian Li PC-O8X	\N	ATX Mid Tower	Green	\N	Tempered Glass	\N	6
Lian Li PC-O8X	\N	ATX Mid Tower	Blue	\N	Tempered Glass	\N	6
Apevia X-Harmony	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	39.3	2
Apevia X-Harmony	\N	ATX Mid Tower	Black / Green	\N	Acrylic	39.3	2
In Win 901	\N	Mini ITX Tower	Black / Gold	\N	Tempered Glass	\N	2
Lian Li PC-M25	\N	MicroATX Mini Tower	Black	\N	\N	\N	8
In Win G7	\N	ATX Mid Tower	Gray	\N	\N	43.6	4
Thermaltake Urban S21	\N	ATX Mid Tower	Black	\N	\N	40.1	5
XFX Type-01 Series Bravo Edition	\N	ATX Mid Tower	Black	\N	Acrylic	68	3
Xigmatek Shockwave	\N	ATX Mid Tower	Black	\N	\N	\N	4
SHARKOON AM5	\N	ATX Mid Tower	Red / Black	\N	\N	\N	3
SHARKOON AM5	\N	ATX Mid Tower	Silver / Black	\N	\N	\N	3
SHARKOON AM5	\N	ATX Mid Tower	Red / Black	\N	Acrylic	\N	3
SHARKOON AM5	\N	ATX Mid Tower	Silver / Black	\N	Acrylic	\N	3
Cooltek G3	\N	HTPC	Black / Silver	\N	\N	23.3	2
Cooltek UMX3	\N	MicroATX Mini Tower	Black	\N	Acrylic	24.6	1
DIYPC TG8	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
DIYPC TG8	\N	ATX Mid Tower	Red / Black	\N	Tempered Glass	\N	2
Cougar MG110	\N	MicroATX Mini Tower	Black	\N	\N	30.8	2
Enermax GraceMESH	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	\N	2
CRYORIG TAKU	\N	Mini ITX Desktop	Silver	\N	\N	\N	1
DIYPC Vision II	\N	ATX Mid Tower	Black / Green	\N	Tempered Glass	46.9	3
Deepcool TESSERACT BF	\N	ATX Mid Tower	White / Black	\N	Acrylic	36.4	4
Streacom BC1 Mini	\N	Mini ITX Test Bench	Red	\N	\N	\N	0
Streacom BC1	\N	ATX Test Bench	Red	\N	\N	\N	2
Nanoxia Rexgear 1	\N	MicroATX Desktop	White / Black	\N	Acrylic	\N	3
Nanoxia Rexgear 1	\N	MicroATX Desktop	Red	\N	Acrylic	\N	3
In Win D-FRAME MINI	\N	Mini ITX Tower	Green	\N	Tempered Glass	46.3	3
Cooler Master MasterCase MC600P	\N	ATX Mid Tower	Black	\N	Tempered Glass	70.1	4
Thermaltake View 37	\N	ATX Mid Tower	Black	\N	Acrylic	73.7	3
Aerocool DS 230	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
NZXT H700 PUBG	\N	ATX Mid Tower	Red / Blue	\N	Tempered Glass	58.6	2
NZXT H200	\N	Mini ITX Tower	Black / Blue	\N	Tempered Glass	27.3	1
Lian Li PC-Q38	\N	Mini ITX Tower	Black / Silver	\N	Acrylic	\N	1
Cooler Master MasterBox MB511	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	2
RAIJINTEK COEUS EVO	\N	ATX Full Tower	Black	\N	Acrylic	56.8	4
CiT F3	\N	MicroATX Mini Tower	Black / Green	\N	Acrylic	\N	2
CiT F3	\N	MicroATX Mini Tower	White / Black	\N	Acrylic	\N	2
In Win 101 PRGB1	\N	ATX Mid Tower	White / Blue	\N	Tempered Glass	48.3	2
In Win 301C PRGB2	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	26	1
In Win 301C	\N	MicroATX Mini Tower	White	\N	Tempered Glass	26	1
SHARKOON VG5	\N	ATX Mid Tower	Black / Green	\N	Acrylic	38.3	3
Cooler Master MasterBox E500L	\N	ATX Mid Tower	Black	\N	\N	\N	2
Rosewill CULLINAN PX	\N	ATX Mid Tower	Black / Green	\N	Tempered Glass	\N	2
HG Computers Osmi	\N	Mini ITX Tower	White	\N	\N	\N	1
Fractal Design Define R6 USB-C	\N	ATX Mid Tower	Silver	\N	\N	56.7	6
Cougar Pioneer-X	\N	ATX Mid Tower	Black	\N	\N	\N	6
BitFenix Enso Mesh	\N	ATX Mid Tower	White	\N	Tempered Glass	46.4	2
Zalman X7	\N	ATX Full Tower	Black	\N	Acrylic	\N	6
Enermax EQUILENCE	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Enermax EQUILENCE	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Azza Obsidian 270	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	3
DIYPC Trio-VX-RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cougar Puritas RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
AvP Mamba	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Thermaltake Commander C36 TG ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Silverstone RL07	\N	ATX Mid Tower	White / Blue	\N	Tempered Glass	\N	3
Antec GX330	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Silverstone RL08BW-RGB	\N	MicroATX Mini Tower	Black / White	\N	Tempered Glass	\N	3
HEC HX200	\N	MicroATX Mini Tower	Black	\N	\N	\N	2
HEC HX300	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
BitFenix Nova Mesh TG	\N	ATX Mid Tower	\N	\N	Tempered Glass	41.4	2
BitFenix Nova Mesh	\N	ATX Mid Tower	\N	\N	Acrylic	41.4	2
GameMax Demolition	\N	ATX Mid Tower	Black	\N	Tempered Glass	36.2	2
GameMax Eclipse	\N	ATX Mid Tower	Black	\N	Tempered Glass	48	2
GameMax Expedition	\N	MicroATX Mini Tower	Blue	\N	Acrylic	29.4	2
GameMax Fortress Air	\N	ATX Full Tower	Black	\N	Tempered Glass	54.7	2
GameMax Hush	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.8	3
GameMax Muted	\N	ATX Mid Tower	Black	\N	Acrylic	58.3	2
GameMax Vega	\N	ATX Mid Tower	White	\N	Tempered Glass	53.2	3
GameMax Whisper	\N	MicroATX Mini Tower	Black	\N	Acrylic	36.7	2
GameMax Zircon RGB	\N	ATX Mid Tower	Black	\N	Acrylic	53.4	3
Aerocool Aero-500G RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.1	4
Enermax SABERAY RGB	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	60.3	2
Antec GX202	\N	ATX Mid Tower	White	\N	Acrylic	40.1	3
Deepcool Earlkase RGB V2	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.9	2
KOLINK Levante	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.2	3
MagniumGear Neo Mini V2	\N	Mini ITX Desktop	Silver	\N	Tempered Glass	\N	1
RAIJINTEK METIS EVO ALS	\N	Mini ITX Desktop	Blue	\N	\N	22.3	2
Rosewill SRM-01B	\N	MicroATX Mini Tower	Black	\N	\N	\N	2
Cooler Master MasterBox MB320L ARGB	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	38.8	2
Rosewill Cullinan V	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.8	2
In Win 905-SILADD	\N	ATX Mid Tower	Silver / Black	\N	Tinted Tempered Glass	\N	1
Silverstone SG13 V2	\N	Mini ITX Tower	White / Black	\N	\N	11.5	1
Circle CC830	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	3
DIYPC Skyline-06-RGB	\N	ATX Full Tower	Black	\N	Acrylic	\N	3
Lazer3D LZ7 XTD	\N	Mini ITX Desktop	Black	\N	Tempered Glass	\N	0
Cougar MX410 Mesh	\N	ATX Mid Tower	Black / Black	\N	Tempered Glass	36.3	2
Silverstone PS14-E	\N	ATX Mid Tower	Black	\N	\N	43.1	2
Azza ARC 241	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
DIYPC S2-RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.9	2
Zalman X3	\N	ATX Mid Tower	White	\N	Tinted Tempered Glass	\N	2
RAIJINTEK PONOS TG	\N	ATX Mid Tower	Black	\N	Tempered Glass	45	3
Enermax LIBLLUSSION LL30	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
EG ST-ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	56.9	5
Cougar Blazer Essence	\N	ATX Mid Tower	Black / Orange	\N	Tempered Glass	\N	2
darkFlash V22	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.7	1
darkFlash DLM 22	\N	MicroATX Mid Tower	Green	\N	Tempered Glass	\N	2
Cougar MX331 MESH	\N	ATX Mid Tower	Black	\N	Acrylic	43.5	2
Enermax MarbleShell M MS20 ARGB	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	\N	2
Cooler Master CM690 II Advanced	\N	ATX Mid Tower	White	\N	\N	56.3	6
SilentiumPC Armis AR5	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.8	2
SilentiumPC Armis AR5 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.8	2
SilentiumPC Armis AR7X EVO ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	63.9	3
SilentiumPC Astrum AT6V EVO	\N	ATX Mid Tower	Black	\N	Tempered Glass	46	2
SilentiumPC Astrum AT6V	\N	ATX Mid Tower	Black	\N	Tempered Glass	46	2
Azza Luminous 110	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	36.1	2
SilentiumPC Signum SG1M	\N	ATX Mid Tower	Black	\N	\N	\N	2
DIYPC AVVU-BK-ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Raidmax EVOL H07	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
Tempest Spook RGB	\N	ATX Mid Tower	White / Black	\N	Acrylic	\N	2
Tempest Aura ARGB	\N	ATX Mid Tower	White / Black	\N	Acrylic	\N	2
Tempest Vapor RGB	\N	ATX Mid Tower	White / Black	\N	Acrylic	\N	2
Tempest Vapor RGB	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
BitFenix Enso Mesh 4ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Aerocool Trinity Mini V3	\N	MicroATX Mini Tower	Pink	\N	Tempered Glass	28.1	2
SHARKOON VS7 Window	\N	ATX Mid Tower	Black	\N	Acrylic	47	2
DIYPC Rainbow-Flash-F4	\N	ATX Mid Tower	White	\N	Tempered Glass	33.2	2
Cooler Master Elite 500	\N	ATX Mid Tower	Black	\N	Tempered Glass	38	2
GAMDIAS APOLLO M1 ELITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GAMDIAS APOLLO M2	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GAMDIAS ARGUS E2	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GAMDIAS ARGUS E4	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GAMDIAS ARGUS E5	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GAMDIAS ATHENA M1 ELITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
GAMDIAS ATHENA M2	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Azza Opus 809	\N	ATX Mid Tower	Silver / Black	\N	Tinted Tempered Glass	\N	1
Raidmax P805 ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Thermaltake Core P5 TG Ti	\N	ATX Mid Tower	Black	\N	Tempered Glass	115.4	6
Geometric Future Model 6	\N	ATX Mid Tower	Black / Green	\N	Tinted Tempered Glass	43.5	4
DIYPC IDX6	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	52.9	2
MUSETEX T2	\N	Mini ITX Desktop	Black	\N	Tempered Glass	16.6	2
MSI MAG BUNKER	\N	ATX Mid Tower	Black	\N	Tempered Glass	45.1	2
Azza Iris 330S	\N	ATX Mid Tower	Black	\N	Tempered Glass	38.8	2
Azza Raven 420	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.8	6
Azza Thor 320DF	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.3	2
Azza Crimson 211G	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.4	3
Azza Golem 221G	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.4	3
Cougar Turret Mesh	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.9	2
Cougar Turret RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.9	2
SSUPD Meshroom S	\N	ATX Mini Tower	Blue	\N	Mesh	14.9	0
SSUPD Meshroom S	\N	ATX Mini Tower	Gray	\N	Mesh	14.9	0
Jonsbo UMX1 Plus	\N	Mini ITX Desktop	Silver / Black	\N	Tempered Glass	16.6	1
Jonsbo V10	\N	Mini ITX Desktop	Black	\N	Tempered Glass	18.2	0
Raidmax I328	\N	ATX Mid Tower	Black	\N	Tempered Glass	34.8	2
CiT S012B	\N	MicroATX Desktop	Black	300	\N	12.2	2
Chieftec Chieftronic G1	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.2	2
Jonsbo U4 Plus	\N	ATX Mid Tower	Black	\N	Tempered Glass	31.7	1
RAIJINTEK PAEAN PREMIUM	\N	ATX Mid Tower	Silver	\N	Tempered Glass	90.6	2
darkFlash BLADE-X	\N	ATX Mid Tower	Black	\N	\N	82.6	2
OCPC MINI	\N	Mini ITX Test Bench	Black / Red	\N	\N	7.2	0
Noua Demon T8	\N	ATX Mid Tower	Black	\N	Tempered Glass	36.1	2
Noua Diamond C101	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.7	2
Noua Fobia L8	\N	MicroATX Mid Tower	White	\N	Tempered Glass	32.7	2
Noua Fobia L7	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	32.7	2
Noua Fobia L5	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	37.2	2
Noua Ego Z5	\N	ATX Full Tower	Black	\N	Tempered Glass	104.6	2
Noua Icaris M5	\N	ATX Mid Tower	Black	\N	Tempered Glass	55.1	2
Noua Noob X13	\N	ATX Mid Tower	White	\N	Tempered Glass	34	2
Noua Ne-o F18	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.8	2
Noua Utopia F15	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.1	2
Noua Utopia F12	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.4	3
Apevia Guardian-M	\N	ATX Mid Tower	White	\N	Tempered Glass	39.5	2
Cooler Master MasterBox MB520	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	50.4	2
Thermaltake Versa H26	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
GALAX REV-02	\N	ATX Mid Tower	White	\N	Tempered Glass	43	2
Vetroo M03	\N	MicroATX Mini Tower	Pink	\N	Tempered Glass	36.1	2
GameMax Spark	\N	MicroATX Mid Tower	Gray	\N	Tempered Glass	26.5	1
KOLINK BASTION RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.1	2
KOLINK BASTION RGB	\N	ATX Mid Tower	White	\N	Tempered Glass	39.1	2
KOLINK Ethereal	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.6	2
Enermax MAKASHI MKII ARGB	\N	ATX Full Tower	Black	\N	Tempered Glass	\N	2
In Win AIRFORCE	\N	ATX Full Tower	White / Multicolor	\N	Tempered Glass	76.6	2
DIYPC G1-ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	43.3	2
DIYPC Gamemax-III-ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	36.3	2
DIYPC IDX2-ARGB	\N	ATX Mid Tower	Gray / Black	\N	Tempered Glass	46.9	4
DIYPC S2-RGB	\N	ATX Mid Tower	Pink / Black	\N	Tempered Glass	44.9	2
DIYPC S3-LED	\N	ATX Mid Tower	White	\N	Acrylic	36.8	2
DIYPC Zetta-ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	37.5	3
GameMax AutoBot II	\N	ATX Mid Tower	White / Orange	\N	Tempered Glass	106.4	1
Rosewill CULLINAN PX RGB-ST	\N	ATX Mid Tower	\N	\N	Tempered Glass	\N	2
Phanteks Enthoo EVOLV SHIFT	\N	Mini ITX Tower	Gray / Black	\N	Mesh	24	1
YEYIAN Abyss 2500	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.7	2
YEYIAN Hollow 2500	\N	ATX Mid Tower	White / Camo	\N	Tempered Glass	37.7	2
BitFenix Saber Mesh	\N	ATX Mid Tower	White	\N	Tempered Glass	42.3	2
Sentey Stealth II	\N	ATX Mid Tower	Black	\N	Acrylic	30.6	2
Thermaltake V100	\N	ATX Mid Tower	Black	\N	Acrylic	36.6	2
SAMA M2	\N	ATX Mid Tower	\N	\N	Tempered Glass	39.2	2
CherryTree Borg Cube	\N	ATX Desktop	Black	\N	\N	55.3	0
CherryTree Borg Cube	\N	ATX Desktop	Black	\N	Tempered Glass	55.3	0
DARKROCK A8-X	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.5	2
SSUPD Meshroom S V2	\N	MicroATX Mini Tower	Blue	\N	Mesh	14.9	2
SSUPD Meshroom S V2 w/PCIe 4.0 Riser	\N	MicroATX Mini Tower	Blue	\N	Mesh	14.9	2
SSUPD Meshroom S V2 w/PCIe 4.0 Riser	\N	MicroATX Mini Tower	Green	\N	Mesh	14.9	2
SSUPD Meshroom S V2 w/PCIe 4.0 Riser	\N	MicroATX Mini Tower	Gray	\N	Mesh	14.9	2
SSUPD Meshroom S V2 w/PCIe 4.0 Riser	\N	MicroATX Mini Tower	Blue / Yellow	\N	Mesh	14.9	2
Aerocool GT Advance	\N	ATX Mid Tower	Black	\N	Mesh	34.4	3
Aerocool GT Advance	\N	ATX Mid Tower	White	\N	Mesh	34.4	3
GameMax F36	\N	MicroATX Mini Tower	White	\N	Tempered Glass	35.1	2
DIYPC DIY-S08	\N	ATX Mid Tower	Pink / Black	\N	Tempered Glass	33.2	2
GameMax F45	\N	ATX Mid Tower	White / Yellow	\N	Tempered Glass	40.6	2
SHARKOON Skiller SGC1 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	47.3	3
APNX C1-R	\N	ATX Mid Tower	Blue	\N	Tempered Glass	53.6	3
PC Cooler IE200	\N	ATX Mid Tower	White	\N	Tempered Glass	48.1	2
LC-Power Gaming 8001B Pro-Storm	\N	ATX Mid Tower	White	\N	Tempered Glass	53.6	2
Jonsbo U4 Pro	\N	ATX Mid Tower	Black	\N	Tempered Glass	34.5	1
Cooler Master Elite 302 Lite	\N	MicroATX Mini Tower	White / Black	\N	Tempered Glass	34.1	1
Cooler Master Elite 502 Lite	\N	ATX Mid Tower	Black	\N	Tempered Glass	52.4	2
Cooler Master Elite 502 Lite	\N	ATX Mid Tower	White	\N	Tempered Glass	52.4	2
Xigmatek ZEUS	\N	ATX Full Tower	Black	\N	Tempered Glass	98.8	2
Cougar OmnyX	\N	ATX Mid Tower	White	\N	Tempered Glass	73.3	2
In Win 216	\N	ATX Mid Tower	White	\N	Tempered Glass	47.1	2
Silverstone CS01	148.72	Mini ITX Tower	Silver	\N	\N	\N	2
In Win MANA136 WHITE	\N	ATX Mid Tower	White / Black	300	Acrylic	40.5	0
RAIJINTEK STYX	\N	MicroATX Mini Tower	Red	\N	Acrylic	\N	3
Noua Demon T7	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	33.7	2
LC-Power Gaming 900W - Lumaxx Light	\N	ATX Mid Tower	White	\N	Tempered Glass	57	2
Silverstone GD04B	\N	HTPC	Black	\N	\N	21.3	2
RAIJINTEK STYX	\N	MicroATX Mini Tower	Blue	\N	Acrylic	\N	3
RAIJINTEK Thetis	\N	ATX Mid Tower	Silver	\N	\N	27.7	2
RAIJINTEK Thetis	\N	ATX Mid Tower	Black	\N	Acrylic	27.7	2
In Win 307	\N	ATX Mid Tower	White	\N	Tinted Tempered Glass	\N	2
Jonsbo TR03-A	\N	ATX Mid Tower	Silver	\N	Tempered Glass	95.3	3
Cougar MX660-T RGB	240.25	ATX Mid Tower	Black	\N	Tempered Glass	50	2
RAIJINTEK OPHION ELITE WHITE	\N	Mini ITX Tower	White	\N	Mesh	24.9	3
Chieftec Chieftronic M1	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	37.3	0
In Win AIRFORCE	\N	ATX Full Tower	Black	\N	Tempered Glass	76.6	2
GameMax F36	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	35.1	2
Antec NSK3480	\N	MicroATX Mid Tower	Black / Silver	380	\N	24.3	1
Antec NSK 6582B	\N	ATX Mid Tower	Black	430	\N	45.8	5
Antec LanBoy Air	\N	ATX Mid Tower	Black	\N	\N	58.5	6
Antec NSK4482	\N	ATX Mid Tower	Black / Silver	380	\N	34.9	3
Antec Six Hundred	\N	ATX Mid Tower	Black	\N	Acrylic	50.6	6
Antec Sonata Elite	\N	ATX Mid Tower	Black	\N	\N	43.2	4
Apevia X-Dreamer	\N	ATX Mid Tower	White / Blue	\N	\N	36	5
Cooler Master Centurion 5	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	42	4
Cooler Master Elite 310	\N	ATX Mid Tower	Black / Blue	420	\N	39.1	6
Cooler Master Elite 310	\N	ATX Mid Tower	Black / Orange	460	Acrylic	39.1	6
Cooler Master Centurion 5 II	\N	ATX Mid Tower	Black / White	\N	Acrylic	43.2	5
Cooler Master Centurion 541	\N	MicroATX Mini Tower	Black / Silver	400	\N	29.4	2
Gigabyte GZ-AABC61-CNB	\N	ATX Mid Tower	Black	\N	\N	47.4	4
Gigabyte GZ-KF01B	\N	ATX Mid Tower	Black	\N	\N	26.5	5
Gigabyte GZ-X7BMDX-400	\N	ATX Mid Tower	Black	\N	\N	36.4	6
Gigabyte Luxo X142	\N	ATX Mid Tower	Black	\N	\N	38.5	4
Gigabyte GZ-PH2A3	\N	ATX Mid Tower	Black	\N	\N	26.5	5
Antec M FusionRemote	\N	HTPC	Black / Silver	350	\N	17.8	1
Thermaltake Element T	\N	ATX Mid Tower	Black	\N	\N	52.9	6
Thermaltake V5 Black Edition	\N	ATX Mid Tower	Black	\N	Acrylic	56.3	3
Thermaltake V3 Black Edition	\N	ATX Mid Tower	Black	430	Acrylic	38.5	4
Rosewill ARMOR	\N	ATX Mid Tower	Black	\N	\N	41.1	5
Rosewill FB-01	\N	ATX Mid Tower	Black	\N	\N	\N	7
Rosewill FB-02	\N	ATX Mid Tower	Black	\N	\N	30.2	7
Rosewill R102-P	\N	MicroATX Mid Tower	Black	\N	\N	25.3	4
Rosewill R103A	\N	ATX Mid Tower	Black	350	\N	35.8	4
Rosewill R218-P	\N	ATX Mid Tower	Black	\N	\N	34.9	4
Rosewill R218-P	\N	ATX Mid Tower	Black	450	\N	34.9	4
Rosewill R519	\N	ATX Mid Tower	Black	500	\N	35.6	5
Rosewill Smart One	\N	ATX Mid Tower	Black	\N	\N	44.1	5
Rosewill TU-155 II 500	\N	ATX Mid Tower	Black	500	Acrylic	42.4	3
Rosewill Wind Knight	\N	ATX Mid Tower	Black	\N	\N	46.6	5
HEC Blitz	\N	ATX Mid Tower	Black	\N	\N	38.4	3
HEC 6C11BBX585	\N	ATX Mid Tower	Black	585	\N	38.4	3
HEC 6C28BB8S	\N	ATX Mid Tower	Black	\N	\N	34.8	5
HEC 6C28BBOH48D	\N	ATX Mid Tower	Black	485	\N	38.4	5
Lian Li PC-K58	\N	ATX Mid Tower	Black	\N	\N	52.9	4
Lian Li PC-K58	\N	ATX Mid Tower	Black	\N	Acrylic	52.9	4
Lian Li PC-K62R1	\N	ATX Mid Tower	Black	\N	Acrylic	50.7	4
Antec Two Hundred S	\N	ATX Mid Tower	Black	\N	\N	42.1	6
Lian Li K60B	\N	ATX Mid Tower	Black	\N	\N	52.9	4
Lian Li PC-Q06	\N	Mini ITX Test Bench	Silver	\N	\N	10.7	1
Lian Li PC-Q07R	\N	Mini ITX Tower	Red	\N	\N	11.2	1
Lian Li PC-Q08	\N	Mini ITX Tower	Silver	\N	\N	21.2	6
Lian Li PC-Q08	\N	Mini ITX Tower	Red	\N	\N	21.2	6
Lian Li PC-Q09	\N	Mini ITX Desktop	Silver	80	\N	5.5	0
Lian Li PC-Q09F	\N	Mini ITX Desktop	White	150	\N	6.3	0
Lian Li PC-Q11	\N	Mini ITX Tower	Silver	\N	\N	16.8	2
Lian Li PC-Q11	\N	Mini ITX Tower	Black	\N	\N	16.8	2
Lian Li PC-Q11	\N	Mini ITX Tower	Silver	\N	\N	16.8	2
Lian Li PC-8N	\N	ATX Mid Tower	Black	\N	Acrylic	80	3
Lian Li PC-8NWX	\N	ATX Mid Tower	Black	\N	Acrylic	48	3
Lian Li PC-K56	\N	ATX Mid Tower	Black	\N	\N	47.1	4
Lian Li PC-K56W	\N	ATX Mid Tower	Black	\N	Acrylic	47.1	4
Lian Li PC-A04	\N	MicroATX Mini Tower	Silver	\N	\N	\N	7
Lian Li PC-A70F	\N	ATX Full Tower	Black	\N	\N	75.5	10
Lian Li PC-X900	\N	ATX Mid Tower	Red	\N	Acrylic	53.3	7
Lian Li PC-X500FX	\N	ATX Mid Tower	Black	\N	Acrylic	58.9	6
Lian Li PC-B10	\N	ATX Mid Tower	Black	\N	\N	47.5	4
Lian Li PC-P80	\N	ATX Full Tower	Black	\N	\N	88.7	6
Lian Li PC-A71F	\N	ATX Full Tower	Black	\N	\N	79.3	10
Lian Li PC-A77F	\N	ATX Full Tower	Black	\N	\N	76.9	9
Lian Li PC-B25F	\N	ATX Mid Tower	Black	\N	\N	50.5	6
Lian Li PC-B25FWB	\N	ATX Mid Tower	Black	\N	Acrylic	50.8	6
Lian Li PC-P50	\N	ATX Mid Tower	Black	\N	\N	50.8	3
Lian Li PC-P50	\N	ATX Mid Tower	Black / White	\N	Acrylic	50.8	3
Lian Li PC-C50	\N	HTPC	Silver	\N	\N	24.2	3
Lian Li PC-C50	\N	HTPC	Black	\N	\N	24.2	3
Lian Li PC-P50WB	\N	ATX Mid Tower	Black	\N	Acrylic	50.6	3
Lian Li PC-C32B	\N	HTPC	Black	\N	\N	37.4	4
Lian Li PC-C33B	\N	HTPC	Black	\N	\N	32.5	4
Lian Li PC-T1	\N	Mini ITX Test Bench	Red	\N	\N	21.1	1
Lian Li PC-V1020	\N	ATX Mid Tower	Silver	\N	\N	55.5	7
Lian Li PC-V1020	\N	ATX Mid Tower	Black	\N	\N	55.5	7
Lian Li PC-V1020	\N	ATX Mid Tower	Red	\N	\N	55.5	7
Lian Li PC-V351	\N	MicroATX Desktop	Silver	\N	\N	27.1	2
Lian Li PC-V352	\N	MicroATX Desktop	Silver	\N	\N	30.4	3
Lian Li PC-V352	\N	MicroATX Desktop	Red	\N	\N	30.4	3
Lian Li PC-V354	\N	MicroATX Mini Tower	Red	\N	\N	32.9	7
Aerocool Qx-2000	\N	MicroATX Mini Tower	Black	\N	\N	28	2
Apevia X-Infinity	\N	ATX Mid Tower	Black / Gray	420	Acrylic	42.7	5
Apevia X-Dreamer2	\N	ATX Mid Tower	Black	420	Acrylic	40	5
Apevia X-Gear	\N	ATX Mid Tower	Silver	420	Acrylic	40.1	4
Apevia X-Gear	\N	ATX Mid Tower	Black / Blue	420	Acrylic	40.1	4
Apevia X-Gear	\N	ATX Mid Tower	Blue	420	Acrylic	40.1	4
Apevia X-Plorer	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	40.3	4
Apevia MX-Pider	\N	ATX Full Tower	Black	500	\N	50.9	4
Apevia MX-Pleasure	\N	ATX Full Tower	Black	500	Acrylic	52.7	7
Apevia MX-Pleasure	\N	ATX Full Tower	Black	500	\N	52.7	7
Apevia X-Cruiser Silver	\N	ATX Mid Tower	Silver	\N	Acrylic	40.1	5
Apevia X-Cruiser2	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	40.1	5
Apevia X-Cruiser2	\N	ATX Mid Tower	Green / Silver	\N	Acrylic	40.1	5
Apevia X-Cruiser2	\N	ATX Mid Tower	Pink / Silver	\N	Acrylic	40.1	5
Apevia X-Cruiser2	\N	ATX Mid Tower	Red / Silver	\N	Acrylic	40.1	5
Apevia X-Dreamer3	\N	ATX Mid Tower	Black	450	\N	37.1	6
Apevia X-Dreamer3	\N	ATX Mid Tower	Silver	\N	Acrylic	37.1	6
Apevia X-Dreamer3	\N	ATX Mid Tower	Black	\N	Acrylic	37.1	6
Apevia X-Dreamer3	\N	ATX Mid Tower	Black	\N	Acrylic	37.1	6
Apevia X-Dreamer3	\N	ATX Mid Tower	Black	\N	Acrylic	37.1	6
Apevia X-Dreamer3	\N	ATX Mid Tower	Black	\N	Acrylic	37.1	6
Apevia X-Telstar	\N	ATX Full Tower	Silver	\N	Acrylic	52.7	5
Apevia X-Jupiter-Jr G-Type	\N	ATX Mid Tower	Black	\N	Acrylic	42.3	3
Apevia X-Jupiter-Jr G-Type	\N	ATX Mid Tower	Black	\N	Acrylic	42.3	3
Apevia X-Jupiter G-Type	\N	ATX Full Tower	Black	\N	Acrylic	64.5	6
Apevia X-Jupiter G-Type	\N	ATX Full Tower	Blue	\N	Acrylic	64.5	6
Apevia X-Master	\N	HTPC	Black / Green	500	\N	22	1
Apevia X-Plorer2	\N	ATX Mid Tower	Black	450	\N	39.2	5
Apevia X-Plorer2	\N	ATX Mid Tower	Black	\N	Acrylic	39.2	5
Apevia X-Plorer2	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	39.2	5
Apevia X-Plorer2	\N	ATX Mid Tower	Black / Green	\N	Acrylic	39.2	5
Apevia X-Plorer2	\N	ATX Mid Tower	Black / Red	\N	Acrylic	39.2	5
Apevia X-QBOII	\N	MicroATX Mini Tower	Black / Silver	500	Acrylic	28.4	2
Apevia X-QBOII	\N	MicroATX Mini Tower	Black / Blue	500	Acrylic	28.4	2
Apevia X-QBOII	\N	MicroATX Mini Tower	Black / Green	500	Acrylic	28.4	2
Apevia X-QBOII	\N	MicroATX Mini Tower	Black / Silver	500	\N	28.4	2
Apevia X-QBOII	\N	MicroATX Mini Tower	Black	500	\N	28.4	2
Apevia X-QBOII	\N	MicroATX Mini Tower	Black / Red	500	Acrylic	28.4	2
Apevia X-QPack	\N	MicroATX Desktop	Black	420	Acrylic	22.7	2
Apevia X-QPack2	\N	MicroATX Desktop	Black / Silver	500	Acrylic	24.2	2
Apevia X-QPack2	\N	MicroATX Desktop	Black	500	Acrylic	24.2	2
Apevia X-QPack2	\N	MicroATX Desktop	Black / Blue	500	Acrylic	24.2	2
Apevia X-QPack2	\N	MicroATX Desktop	Black / Orange	500	Acrylic	24.2	2
Apevia X-QPack2	\N	MicroATX Desktop	Black / Green	500	Acrylic	24.2	2
Apevia X-QPack2	\N	MicroATX Desktop	Black / Red	500	Acrylic	24.2	2
Apevia X-Sniper G-Type	\N	ATX Mid Tower	Black	\N	Acrylic	44.4	3
Apevia X-Sniper G-Type	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	44.4	3
Apevia X-Sniper G-Type	\N	ATX Mid Tower	Black	\N	Acrylic	44.4	3
Apevia X-Sniper G-Type	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	44.4	3
Apevia X-Telstar-Jr G-Type	\N	ATX Mid Tower	Black	\N	Acrylic	42.3	3
Apevia X-Telstar-Jr G-Type	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	42.3	3
Apevia X-Telstar-Jr G-Type	\N	ATX Mid Tower	Black / Red	\N	Acrylic	42.3	3
Apevia X-Telstar-Jr S-Type	\N	ATX Mid Tower	Black	\N	\N	42.3	3
Apevia X-Telstar-Jr S-Type	\N	ATX Mid Tower	Black / Blue	\N	\N	42.3	3
Apevia X-Telstar-Jr S-Type	\N	ATX Mid Tower	Black / Green	\N	\N	42.3	3
NZXT Whisper	\N	ATX Full Tower	Black	\N	\N	61.8	9
NZXT Hush	\N	ATX Mid Tower	Silver	\N	\N	41.4	5
HEC 6T10BB	\N	MicroATX Mini Tower	Black	\N	\N	24	1
HEC 6K28BB8F	\N	MicroATX Mini Tower	Black	\N	\N	29.1	2
Apex TX-381-C	\N	MicroATX Mid Tower	Black	\N	\N	30	4
Apex PC-373-C	\N	ATX Mid Tower	Black	\N	\N	33.2	5
HEC 6C28BS	\N	ATX Mid Tower	Black / Silver	\N	\N	38.4	4
HEC 6C60BS	\N	ATX Mid Tower	Black / Silver	\N	\N	38.4	4
HEC 6K28BBX585	\N	MicroATX Mini Tower	Black	585	\N	29.1	2
HEC 6K28BS	\N	MicroATX Mini Tower	Black / Silver	\N	\N	29.1	2
HEC 6K60BS	\N	MicroATX Mini Tower	Black / Silver	\N	\N	29.1	1
HEC 6T18BB	\N	MicroATX Mini Tower	Black	\N	\N	21.6	1
HEC 6XR8	\N	ATX Mid Tower	Black	\N	\N	41.4	4
HEC 7106WW	\N	ATX Desktop	White	\N	\N	28.7	2
HEC 7K09BBA30FNRX	\N	HTPC	Black	300	\N	12.8	1
HEC 7KJ9BBA30FNRX	\N	HTPC	Black	300	\N	12.8	1
HEC ITX200B	\N	HTPC	Black / Silver	200	\N	5.8	1
HEC 7KJ9	\N	HTPC	Black	270	\N	12.8	1
HEC 6C28BB8SOH58	\N	ATX Mid Tower	Black	585	\N	\N	5
HEC 6C28BBX585	\N	ATX Mid Tower	Black	585	\N	\N	5
HEC 6C28BSX585	\N	ATX Mid Tower	Black / Silver	585	\N	38.4	4
HEC 6K11BBOH48D	\N	MicroATX Mini Tower	Black	485	\N	29.1	1
HEC 6K11BBX585	\N	MicroATX Mini Tower	Black	585	\N	29.1	1
HEC 6K28BBOH48D	\N	MicroATX Mini Tower	Black	485	\N	29.1	2
HEC 6K28BSOH48D	\N	MicroATX Mini Tower	Black / Silver	485	\N	29.1	2
HEC 6K28BSX585	\N	MicroATX Mini Tower	Black / Silver	585	\N	29.1	2
HEC 6K60BSX585	\N	MicroATX Mini Tower	Black / Silver	585	\N	29.1	1
HEC 6T10BBHP485D	\N	MicroATX Mini Tower	Black	485	\N	24	1
HEC 6T10BBHP585D	\N	MicroATX Mini Tower	Black	585	\N	24	1
Broadway Com Corp 1243MA	\N	ATX Mini Tower	Black	500	\N	20.8	2
Broadway Com Corp 943PK	\N	MicroATX Mid Tower	Black	500	\N	25.5	4
Broadway Com Corp FX	\N	ATX Mid Tower	Black / Red	\N	Acrylic	34.8	5
Broadway Com Corp R-800	\N	ATX Full Tower	Black	\N	\N	60.2	5
Broadway Com Corp R-810	\N	ATX Full Tower	Black	\N	\N	60.2	5
Broadway Com Corp Runner	\N	ATX Mid Tower	Black	\N	Acrylic	38.1	6
NZXT Apollo	\N	ATX Mid Tower	Blue / Black	\N	Acrylic	61.8	4
NZXT Lexa Blackline	\N	ATX Mid Tower	Black	\N	Acrylic	65.4	5
NZXT Tempest EVO	\N	ATX Mid Tower	White / Black	\N	Acrylic	61.8	8
Apex MI-100	\N	Mini ITX Tower	Black / Silver	250	\N	8.5	1
Apex MI-100	\N	Mini ITX Tower	Black	250	\N	8.5	1
Apex PC-302-C	\N	ATX Mid Tower	Black / Silver	\N	\N	33.2	4
Apex PC-389-C	\N	ATX Mid Tower	Black	\N	\N	33.2	4
Apex TM-524	\N	MicroATX Mid Tower	Black	\N	\N	25	3
Apex TX-518	\N	MicroATX Mid Tower	Black	300	\N	30	4
Raidmax ATX-802BP	\N	ATX Mid Tower	Black	450	\N	42.1	4
Athena Power CA-601B60	\N	ATX Full Tower	Black	600	\N	50.6	4
Athena Power CA-1015CR25	\N	MicroATX Slim	Black / Red	250	\N	18.1	1
Athena Power CA-1015CR30	\N	MicroATX Slim	Black / Red	300	\N	18.1	1
Athena Power CA-1015IS25	\N	MicroATX Slim	Black / Silver	250	\N	18.1	1
Athena Power CA-1015IS40	\N	MicroATX Slim	Black / Silver	400	\N	18.1	1
Athena Power CA-601Y60	\N	ATX Full Tower	Yellow	600	\N	50.6	4
Athena Power CA-601Y80	\N	ATX Full Tower	Yellow	800	\N	50.6	4
Athena Power CA-601Y95	\N	ATX Full Tower	Yellow	950	\N	50.6	4
Athena Power CA-601YW60	\N	ATX Full Tower	Yellow	600	Acrylic	50.6	4
Athena Power CA-601YW95	\N	ATX Full Tower	Yellow	950	Acrylic	50.6	4
Athenatech A100BB.350	\N	MicroATX Desktop	Black / Silver	350	\N	18.4	2
Athenatech A1089BR.150	\N	Mini ITX Tower	Black / Red	150	\N	9.9	1
Athenatech A1089HG.150	\N	Mini ITX Tower	Black	150	\N	9.9	1
Athenatech A301BS.400	\N	MicroATX Mini Tower	Black / Silver	400	\N	27.8	1
Athenatech A301BS.450	\N	MicroATX Mini Tower	Black / Silver	450	\N	27.8	1
Athenatech A3603BB.400	\N	MicroATX Mini Tower	Black	400	\N	26.9	4
Athenatech A412WW.400	\N	ATX Mid Tower	White	400	\N	35	5
Athenatech A4224BB.400	\N	ATX Mid Tower	Black	400	\N	35	4
Athenatech A43K5BL.400	\N	ATX Mid Tower	Black / Blue	400	\N	33.9	4
Athenatech A5730BB.450	\N	ATX Mid Tower	Black	450	\N	41	5
Athenatech A601BS.450	\N	ATX Mid Tower	Black	430	\N	26.2	3
Athenatech A602BS450	\N	ATX Mid Tower	Black / Silver	450	\N	26.2	3
Athenatech A605BL.450	\N	ATX Mid Tower	Black / Blue	430	\N	26.2	3
Athenatech A605BR.450	\N	ATX Mid Tower	Black / Red	430	\N	35.2	3
Dynapower C05.N17.M158	\N	ATX Mini Tower	Silver / Black	430	\N	23.1	1
Dynapower C05.N63.M158	\N	ATX Mini Tower	Black	430	\N	23.1	1
Dynapower CS-HM41602.1266	\N	ATX Mid Tower	Black / Red	450	\N	42.7	4
Dynapower CS-NH3A-C760	\N	ATX Mid Tower	White	430	\N	\N	4
Dynapower Prestige	\N	ATX Mid Tower	Black / White	430	\N	40.5	5
Enermax ECA3180	\N	ATX Mid Tower	Black	\N	\N	42.2	5
Enermax ECA3180	\N	ATX Mid Tower	Black / Red	\N	\N	42.2	5
Enermax ECA3192	\N	ATX Mid Tower	Black	\N	\N	41.5	5
Enermax ECA3220	\N	ATX Mid Tower	Black	\N	\N	49.9	4
Foxconn KS136-ISO450	\N	MicroATX Mini Tower	Black	350	\N	24	4
Foxconn KS188-ISO450	\N	MicroATX Mini Tower	Black / Silver	350	\N	24	4
Foxconn RS-233(H)+DSL-150-4SS	\N	Mini ITX Tower	Black / Silver	150	\N	8.4	1
Foxconn RS-233+FSP150-50GLT-4SS	\N	Mini ITX Tower	Black / Silver	150	\N	8.4	1
Foxconn TLA+566(H+A)+ISO-400-4SS	\N	ATX Mid Tower	Black / Silver	350	\N	33.2	4
Foxconn TLM-720+ISO-400	\N	MicroATX Mini Tower	Black	\N	\N	25.7	4
Foxconn TLM-776(H+A)-ISO-400-4SS	\N	MicroATX Mini Tower	Black / Silver	300	\N	25.7	4
Foxconn TLM-C01+ISO-400	\N	MicroATX Mini Tower	Black / Silver	\N	\N	25.7	4
Foxconn TLM-C03+ISO-400	\N	MicroATX Mini Tower	Black / Silver	\N	\N	25.7	4
Foxconn TSAA725-ISO450	\N	ATX Mid Tower	Black / Silver	350	\N	29.7	4
Foxconn TW-001(H+A)+ISO-400-4SS	\N	MicroATX Mini Tower	Black / Silver	300	\N	25.1	1
Gigabyte Sumo 4112	\N	ATX Full Tower	Black	\N	\N	53.1	5
Gigabyte GZ-AA2CB-SNS	\N	ATX Mid Tower	Black	\N	\N	44.1	3
Gigabyte GZ-AA2CB-SNS	\N	ATX Mid Tower	Gray / Black	\N	\N	44.1	3
Gigabyte Setto 1000	\N	ATX Mid Tower	Black	\N	\N	36.1	6
Gigabyte GZ-KF03B	\N	ATX Mid Tower	Black	\N	\N	26.5	5
Gigabyte GZ-X2BPD-500	\N	ATX Mid Tower	Black	\N	\N	36	3
Gigabyte GZ-X5BPD-500	\N	ATX Mid Tower	Black	\N	\N	36.1	3
Gigabyte Luxo M1000	\N	ATX Mid Tower	Black	\N	\N	37.1	4
Gigabyte GZ-PH1A3	\N	ATX Mid Tower	Black / Gray	\N	\N	26.5	5
In Win Android	\N	ATX Mid Tower	Black / Silver	\N	\N	51.6	3
In Win B2	\N	ATX Mid Tower	Black	\N	\N	53.8	5
In Win BK623.BN300BL	\N	MicroATX Desktop	Black	300	\N	12.3	1
In Win BL641.300TBL	\N	MicroATX Slim	Black	300	\N	11.6	2
In Win BM650.AD160TBL	\N	Mini ITX Tower	Black	160	\N	6.8	0
In Win C589T.CQ350TBL	\N	ATX Mid Tower	Black	350	\N	35	3
In Win C638T.CQ350TBL	\N	ATX Mid Tower	Black	350	\N	35	3
In Win EA013.T350SL	\N	ATX Mid Tower	Black / Silver	\N	\N	34.9	2
In Win EM006.T350SL+	\N	MicroATX Mini Tower	Black / Silver	350	\N	48	2
In Win EM013.T350SL	\N	MicroATX Mini Tower	Black / White	\N	\N	25.3	2
In Win EM023.T350SL	\N	MicroATX Mini Tower	Black	\N	\N	25.3	2
In Win Griffin	\N	ATX Mid Tower	Black	\N	\N	37.1	5
In Win IW-BP655.200BL	\N	Mini ITX Tower	Black	200	\N	8.1	0
In Win IW-BQ656	\N	Mini ITX Tower	Black	80	\N	3.3	0
In Win IW-C589T.CQ350TBL	\N	ATX Mid Tower	Black	350	\N	35	3
In Win IW-F430.RL	\N	ATX Mid Tower	Red / White	\N	\N	43.8	3
In Win IW-V605T2.CQ350TBL	\N	MicroATX Mini Tower	Black	350	\N	22.9	1
In Win IW-Z583T.CQ350TBL	\N	MicroATX Mini Tower	Black / Gray	350	\N	24.2	1
In Win Ironclad	\N	ATX Full Tower	Black / White	\N	\N	70.5	6
In Win S605T2.CQ350TBL	\N	ATX Mid Tower	Black	350	\N	35.8	2
In Win Track	\N	ATX Mid Tower	Black / Silver	\N	\N	45.7	3
In Win V564T2.CQ350TBL	\N	MicroATX Mini Tower	Black / Silver	350	\N	22.9	1
In Win V605T2.CQ350TBL	\N	MicroATX Mini Tower	Black	350	\N	22.9	1
In Win V627T2.CQ350TBL	\N	MicroATX Mini Tower	Black	350	\N	22.9	1
In Win Z583T.CQ350TBL	\N	MicroATX Mini Tower	Black / Silver	350	\N	24.2	1
In Win Z638T.CQ350TBL	\N	MicroATX Mini Tower	Black	350	\N	24.2	1
Raidmax Iceberg	\N	ATX Mid Tower	Silver	\N	Acrylic	55.2	4
Raidmax Tornado	\N	ATX Mid Tower	Black / Green	\N	Acrylic	42.1	5
Raidmax Tornado	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	42.1	5
Raidmax Tornado	\N	ATX Mid Tower	Black / Yellow	\N	Acrylic	42.1	5
Raidmax Hurricane	\N	ATX Mid Tower	Black	\N	Acrylic	36.2	5
Raidmax Atlas ATX-295WB	\N	ATX Mid Tower	Black	\N	Acrylic	42.9	4
Raidmax Atlas ATX-298WB	\N	ATX Mid Tower	Black	\N	Acrylic	42.9	4
Raidmax Typhoon	\N	ATX Mid Tower	Black	\N	Acrylic	36.2	5
Raidmax Smilodon ATX-612WB	\N	ATX Mid Tower	Black	500	Acrylic	47.5	4
Raidmax Blackstorm ATX-615WW	\N	ATX Mid Tower	White / Blue	\N	\N	47.7	1
Raidmax Enzo ATX-617WR	\N	ATX Mid Tower	Black / Red	\N	Acrylic	47.7	4
Raidmax Aztec	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	47.5	4
Raidmax Fusion ATX-806WB	\N	ATX Mid Tower	Gray / Black	\N	Acrylic	41	5
Raidmax Helios ATX-819WB	\N	ATX Mid Tower	Black	\N	Acrylic	51	4
Raidmax Aura ATX-927WB	\N	ATX Mid Tower	Black	\N	Acrylic	40	3
Raidmax Aura ATX-927WB	\N	ATX Mid Tower	Green	\N	Acrylic	40	3
Raidmax Aura ATX-927WB	\N	ATX Mid Tower	Blue	\N	Acrylic	40	3
Raidmax Skyline ATX-948WB	\N	ATX Mid Tower	Black	\N	Acrylic	47.1	4
Raidmax Eclipse ATX-989WBBL	\N	ATX Mid Tower	Black	\N	Acrylic	42.1	3
Rosewill RC-CIX-01	\N	Mini ITX Tower	Black	150	\N	8.6	1
Rosewill RC-CIX-01	\N	Mini ITX Tower	Black / Red	150	\N	8.6	1
Silverstone FT01-B	\N	ATX Mid Tower	Black	\N	\N	51.7	7
Silverstone FT01-B	\N	ATX Mid Tower	Black	\N	Acrylic	51.7	7
Silverstone FT02B	\N	ATX Mid Tower	Black	\N	\N	64.8	5
Silverstone GD01B-MXR	\N	HTPC	Black	\N	\N	31.3	6
Silverstone KL02-B	\N	ATX Mid Tower	Black	\N	Acrylic	41.7	4
Silverstone KL03-B	\N	ATX Full Tower	Black	\N	\N	68.2	4
Silverstone PS05-B	\N	ATX Mid Tower	Black	\N	\N	43	4
Silverstone RV01-BW	\N	ATX Full Tower	Black	\N	Acrylic	113.1	6
Silverstone RV02B-EW	\N	ATX Full Tower	Black	\N	Acrylic	68.3	5
Silverstone RV02B-EW	\N	ATX Full Tower	Black	\N	Acrylic	68.3	5
Silverstone RV02B-EW	\N	ATX Full Tower	White	\N	Acrylic	68.3	5
Silverstone SG01-BF	\N	MicroATX Desktop	Black	\N	\N	21.8	2
Silverstone SG04B-F	\N	MicroATX Mini Tower	Black	\N	\N	24.7	2
Silverstone SG07-B	\N	Mini ITX Desktop	Black / Gray	600	Acrylic	14.6	1
Silverstone TJ09-B	\N	ATX Full Tower	Black	\N	\N	66.6	6
Silverstone TJ09-BW	\N	ATX Full Tower	Black	\N	Acrylic	66.7	6
Silverstone TJ10-B	\N	ATX Full Tower	Black	\N	\N	69.8	6
Sunbeam AC9B-T	\N	ATX Mid Tower	Clear	\N	\N	49.5	4
Sunbeam ACMI-P-HUVB	\N	Mini ITX Tower	Clear	150	Acrylic	10.3	1
Sunbeam ACMI-P-T	\N	Mini ITX Tower	Clear	150	Acrylic	\N	1
Sunbeam ACUF-T	\N	ATX Mid Tower	Clear	\N	\N	33.8	2
Sunbeam IC-AUT	\N	ATX Mid Tower	Black	\N	\N	\N	3
Sunbeam IC-FS	\N	ATX Mid Tower	Black	\N	Acrylic	38.6	3
Sunbeam IC-TR-US-BA-WOPSU	\N	ATX Full Tower	Black / Silver	\N	Acrylic	47.8	6
Sunbeam IC-VM	\N	ATX Mid Tower	Black	\N	\N	31	5
XClio A380BK	\N	ATX Full Tower	Black	\N	Acrylic	60.2	7
XClio A380COLOR	\N	ATX Full Tower	Black	\N	Acrylic	60.2	6
XClio A380COLOR-PLUS	\N	ATX Full Tower	Black	\N	Acrylic	65.4	6
XClio A380PLUS	\N	ATX Full Tower	Black	\N	Acrylic	65.4	7
XClio Blackhawk	\N	ATX Full Tower	Black	\N	\N	59.7	8
XClio Color I	\N	ATX Mid Tower	Black	\N	\N	41.6	5
XClio Coolbox Advanced	\N	ATX Mid Tower	Black	\N	\N	34	5
XClio Godspeed 737	\N	ATX Mid Tower	Black	\N	\N	39.8	5
XClio Godspeed 747	\N	ATX Mid Tower	Black	\N	\N	39.8	5
XClio Godspeed Two Advanced	\N	ATX Mid Tower	Black	\N	Acrylic	44.3	5
XClio Nighthawk	\N	ATX Mid Tower	Black	\N	Acrylic	37.6	4
XClio Nighthawk Color	\N	ATX Mid Tower	Black	\N	Acrylic	39.8	4
XClio WTBK	\N	ATX Full Tower	Black	\N	\N	69.8	6
XClio XCLIO 2000	\N	ATX Full Tower	Black	\N	\N	93.3	12
Xigmatek Utgard Window	\N	ATX Mid Tower	Black	\N	Acrylic	51.7	4
Xigmatek Utgard Mesh	\N	ATX Mid Tower	Black	\N	\N	51.7	4
Xion AXP-ARM001-BL	\N	ATX Mid Tower	Black	\N	Acrylic	38.3	5
Xion AXP100-001BK	\N	ATX Mid Tower	Black	\N	Acrylic	37.2	5
Xion AXP120-001BK	\N	ATX Mid Tower	Black	\N	Acrylic	40.3	5
Xion AXP300-001BK	\N	ATX Mid Tower	Black	\N	\N	43.7	5
Xion XON-CBX01	\N	ATX Mid Tower	Black	\N	Acrylic	38.3	5
Xion XON-EC001	\N	ATX Mid Tower	Black	\N	\N	43.7	5
Xion XON-EC001	\N	ATX Mid Tower	Black / Red	\N	\N	43.7	5
Zalman LQ1000	\N	ATX Mid Tower	Black	\N	\N	47.4	4
Athenatech A100BB.270	\N	HTPC	Black / Silver	270	\N	18.5	2
Athenatech A100SC.350	\N	HTPC	Gray / Silver	350	\N	18.5	2
Athenatech A3708BS.450	\N	HTPC	Black	450	\N	\N	3
Silverstone GD01B-MXR	\N	HTPC	Black	\N	\N	31.3	6
Silverstone LC10B-E	\N	HTPC	Black	\N	\N	30.9	7
Silverstone LC17-B	\N	HTPC	Black	\N	\N	30.9	6
Silverstone LC20-B	\N	HTPC	Black	\N	\N	31.3	6
Silverstone ML02B-MXR	\N	HTPC	Black / Silver	120	\N	12.4	1
XClio XCLIO 777Color	\N	ATX Full Tower	Black	\N	\N	93.2	8
Xion AXP970-001BK	\N	ATX Mid Tower	Black	\N	Acrylic	40	3
Zalman HD160XT-S	\N	HTPC	Silver / Gray	\N	\N	32.2	5
Zalman HD503	\N	HTPC	Black	\N	\N	34.5	3
In Win BQ669.AD80TBL	\N	Mini ITX Tower	Black	80	\N	3.3	0
Silverstone SG06BB-450	\N	Mini ITX Desktop	Black	450	\N	11	1
Xion XON-160PCB	\N	ATX Mid Tower	Black / Silver	500	\N	\N	5
Apevia ATX998KL	\N	ATX Mid Tower	Gray	420	\N	39.6	4
Lian Li PC-K59	\N	ATX Mid Tower	Black	\N	\N	60.1	6
In Win Fanqua	\N	ATX Mid Tower	Black	\N	\N	49.1	3
HEC 6C11BB	\N	ATX Mid Tower	Black	\N	\N	34.8	3
Broadway Com Corp 101PA	\N	ATX Mid Tower	Black	500	\N	32.8	6
Apex Vortex 3610	\N	ATX Mid Tower	Black	\N	\N	36.7	5
Apevia ATX998KL	\N	ATX Mid Tower	Gray	250	\N	39.6	4
Apex SK-393-C	\N	ATX Mid Tower	Black	\N	\N	31	5
Enermax Spinerex	\N	ATX Full Tower	Black	\N	\N	68.5	8
Gigabyte GZ-X8BPDX-400	\N	ATX Mid Tower	Black / Silver	\N	\N	36.1	6
Gigabyte GZ-KX9	\N	ATX Mid Tower	Black / Silver	\N	\N	32.8	5
HEC 63R3BB	\N	ATX Mid Tower	Black	\N	\N	35.2	4
In Win BUC	\N	ATX Mid Tower	Black	\N	\N	51.4	5
In Win C583T.D400TBL	\N	ATX Mid Tower	Black / Silver	400	\N	35	3
In Win EA035.CQ350SL	\N	ATX Mid Tower	Black / Silver	350	\N	34.9	2
In Win EM035.CQ350SL	\N	MicroATX Mini Tower	Black	350	\N	25.3	1
In Win Z583T.D400TBL	\N	MicroATX Mini Tower	Black / Silver	400	\N	24.2	1
Lian Li PC-K57W	\N	ATX Mid Tower	Black	\N	Acrylic	49.9	3
Raidmax Reiter	\N	ATX Mid Tower	Black	\N	\N	49.5	4
Silverstone RV03B-W	\N	ATX Full Tower	Black / White	\N	Acrylic	69.4	4
Sunbeam IC-QB-SVBK	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	38.6	3
Xigmatek Pantheon	\N	ATX Mid Tower	Black	\N	Acrylic	\N	4
Xigmatek Utgard	\N	ATX Mid Tower	Black	\N	\N	51.7	4
Apevia X-Trooper	\N	ATX Mid Tower	Black	\N	Acrylic	44.8	6
Apevia X-Trooper	\N	ATX Mid Tower	Black	\N	Acrylic	44.8	6
Fractal Design Define R3	\N	ATX Mid Tower	Black	\N	\N	47.5	8
Fractal Design Define R3	\N	ATX Mid Tower	White	\N	\N	47.5	8
Apevia X-Trooper-Jr	\N	ATX Mid Tower	Black	\N	Acrylic	29.8	3
Apevia X-Trooper-Jr	\N	ATX Mid Tower	Black	\N	\N	29.8	3
Apevia X-Trooper-Jr	\N	ATX Mid Tower	Black	450	\N	29.8	3
NZXT Beta	\N	ATX Mid Tower	Black	\N	\N	42.8	5
Apevia X-Trooper	\N	ATX Mid Tower	Black	450	\N	44.8	6
Cooler Master Elite 310	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	39.1	6
Broadway Com Corp A3728	\N	ATX Mid Tower	Black	\N	\N	34.7	4
Broadway Com Corp A3728	\N	ATX Mid Tower	Black	\N	\N	34.7	4
Broadway Com Corp A5938	\N	ATX Mid Tower	Black	\N	\N	40.4	5
Broadway Com Corp A5938	\N	ATX Mid Tower	Black	\N	\N	40.4	5
HEC 6T10LOH400	\N	MicroATX Mini Tower	Black	400	\N	24	2
HEC 98R9BB	\N	ATX Full Tower	Black	\N	\N	78.6	5
In Win BM639.AD160TBL	\N	Mini ITX Tower	Black	160	\N	6.8	1
In Win EM020.T350SL	\N	MicroATX Mini Tower	Black / Silver	\N	\N	25.3	2
Lian Li PC-A05FNA	\N	ATX Mid Tower	Silver	\N	\N	40.4	3
Lian Li PC-A71F USB3.0	\N	ATX Mid Tower	Black	\N	\N	79.5	10
Lian Li PC-C60	\N	HTPC	Silver	\N	\N	33.1	6
Lian Li PC-P80NB	\N	ATX Full Tower	Black	\N	\N	84.4	10
Lian Li PC-V600F	\N	MicroATX Mini Tower	Silver	\N	\N	34.5	5
Lian Li PC-V600F	\N	MicroATX Mini Tower	Black	\N	\N	34.5	5
Lian Li PC-V600F	\N	MicroATX Mini Tower	Red	\N	\N	34.5	5
Lian Li PC-V600F	\N	MicroATX Mini Tower	Black	\N	Acrylic	34.5	5
Lian Li PC-Z60B	\N	ATX Mid Tower	Black	\N	\N	47.5	6
Lian Li PC-Z70B	\N	ATX Full Tower	Black	\N	\N	77.7	9
Logisys CS1200BK	\N	ATX Mid Tower	Black	\N	\N	47.9	5
Logisys CS2006BK	\N	ATX Mid Tower	Black	480	\N	38.5	5
Logisys CS301BK	\N	ATX Mid Tower	Black	480	\N	34.5	5
Raidmax ATX-298WW	\N	ATX Mid Tower	Black / White	\N	Acrylic	42.9	4
Sunbeam IC-EVO	\N	ATX Mid Tower	Black	\N	Acrylic	38.5	5
TUNIQ IC-TQ3-US	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Thermaltake Soprano DX	\N	ATX Mid Tower	Black	\N	\N	49.8	5
XClio Blue I	\N	ATX Mid Tower	Black	\N	\N	41.6	5
Xion XON-180	\N	ATX Mid Tower	Black	\N	\N	29.5	4
Zalman GS1200	\N	ATX Full Tower	Black	\N	\N	93.7	6
nMEDIAPC HTPC 1000B	\N	HTPC	Black	\N	\N	24.4	4
nMEDIAPC HTPC 3000B	\N	HTPC	Black	\N	\N	28.9	6
nMEDIAPC HTPC 6000B	\N	HTPC	Silver / Black	\N	\N	29.9	5
Fractal Design Define R3	\N	ATX Mid Tower	Black / Silver	\N	\N	47.5	8
Fractal Design Define XL	\N	ATX Full Tower	Black	\N	\N	72.6	10
Raidmax ATX-615WUP	\N	ATX Mid Tower	White / Blue	500	\N	47.7	4
Fractal Design Define R3	\N	ATX Mid Tower	Black / Gray	\N	\N	47.5	8
Raidmax ATX-948WBP	\N	ATX Mid Tower	Black	450	Acrylic	47.1	4
Sentey PS2-3268	\N	ATX Mid Tower	Black / Silver	\N	\N	38.8	4
Raidmax ATX-948WSP	\N	ATX Mid Tower	Black / Silver	450	Acrylic	47.1	4
Sentey DS1-4234	\N	ATX Mid Tower	Black	\N	\N	38.8	4
Raidmax ATX-305WBP	\N	ATX Mid Tower	Black	450	\N	49.5	4
Diablotek CPA-3570	\N	ATX Mid Tower	Black	\N	\N	38.4	4
Sentey CS1-1396	\N	ATX Mid Tower	Black	\N	\N	27.8	5
Sentey BX2-4260 v2.3	\N	ATX Mid Tower	Black	\N	Acrylic	39.1	5
nMEDIAPC HTPC 2000B	\N	HTPC	Silver / Black	\N	\N	29.9	6
Sentey BX1-4246 v2.1	\N	ATX Mid Tower	Black	\N	\N	40.2	4
Linkworld 43706-228FU+P04	\N	MicroATX Mid Tower	Black	430	\N	23.2	2
Linkworld 431-06 C.2222	\N	ATX Mid Tower	Black	500	\N	31.2	5
Linkworld 313-11(3131-11)	\N	ATX Mid Tower	Black / Silver	500	\N	63.2	6
Sentey GS-6400 - ARVINA	\N	ATX Full Tower	Black	\N	\N	60.7	5
Sentey BX1-4283 v2.3	\N	ATX Mid Tower	Black	\N	Acrylic	40.2	4
Sentey BX1-4284 v2.3	\N	ATX Mid Tower	Black	\N	Acrylic	40.2	4
Sigma PHANTOM-WB	\N	ATX Mid Tower	Black	\N	Acrylic	47.7	4
Sigma BLITZ-WB	\N	ATX Mid Tower	Black	\N	Acrylic	46.6	4
Sentey BX2-4291 v2.3	\N	ATX Mid Tower	Black	\N	Acrylic	39.1	5
Sigma Pluto-WB	\N	ATX Mid Tower	Black	\N	Acrylic	41.5	5
Sentey BX1-4237 v2.1	\N	ATX Mid Tower	Black	\N	\N	40.2	4
Sentey CS1-1399	\N	ATX Mid Tower	Black	250	\N	27.8	2
Sentey PS2-3270	\N	ATX Mid Tower	Black / Silver	250	\N	38.8	4
Sentey PS2-3271	\N	ATX Mid Tower	Black	250	\N	38.8	4
Linkworld Q319-C8888-P4	\N	ATX Mid Tower	Silver	500	\N	42.4	6
Sentey PS2-3272	\N	ATX Mid Tower	Black	250	\N	38.8	4
Apevia X-Dreamer	\N	ATX Mid Tower	Black	420	\N	36	5
BitFenix Colossus	\N	ATX Full Tower	Black	\N	\N	79	7
BitFenix Colossus Window	\N	ATX Full Tower	Black	\N	Acrylic	79	7
BitFenix Merc Beta	\N	ATX Mid Tower	Black	\N	\N	40.5	6
BitFenix Outlaw	\N	ATX Mid Tower	Black	\N	\N	37.3	4
BitFenix Survivor Core	\N	ATX Mid Tower	Black	\N	\N	45.8	6
BitFenix Survivor	\N	ATX Mid Tower	Black	\N	\N	45.8	6
Cooler Master Elite 330 Upgraded	\N	ATX Mid Tower	Black / Silver	\N	\N	40.5	5
nMEDIAPC HTPC 5000S	\N	HTPC	Silver / Black	\N	\N	24.4	4
Silverstone PS06B-W	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	57.2	4
In Win BM639.AD160TSL	\N	Mini ITX Tower	Black / Silver	160	\N	6.8	1
Lian Li PC-K9B	\N	ATX Mid Tower	Black	\N	\N	49.9	6
Lian Li PC-8NW USB3.0	\N	ATX Mid Tower	Black	\N	Acrylic	46.2	3
Lian Li PC-K9WX	\N	ATX Mid Tower	Black	\N	Acrylic	49.9	6
Lian Li PC-60FN USB3.0	\N	ATX Mid Tower	Black	\N	\N	48	4
Lian Li PC-V353	\N	HTPC	Black	\N	\N	32.7	2
Lian Li PC-V353	\N	HTPC	Silver	\N	\N	32.7	2
Lian Li PC-7FN USB 3.0	\N	ATX Mid Tower	Black	\N	\N	\N	4
NZXT Tempest 410	\N	ATX Mid Tower	Black	\N	\N	51.1	8
Apevia X-Telstar-Jr G-Type	\N	ATX Mid Tower	Black / Green	\N	Acrylic	42.3	3
Apevia X-Jupiter G-Type	\N	ATX Full Tower	Silver	\N	Acrylic	64.5	6
Apevia X-Telstar	\N	ATX Full Tower	Black / Blue	\N	Acrylic	52.7	5
Apevia X-Dreamer	\N	ATX Mid Tower	Black	420	Acrylic	36	5
Apevia X-Dreamer2	\N	ATX Mid Tower	Blue	420	Acrylic	40	5
Apevia X-Dreamer	\N	ATX Mid Tower	Silver	420	Acrylic	36	5
Apevia X-Dreamer2	\N	ATX Mid Tower	Green	420	Acrylic	40	5
Apevia X-Jupiter G-Type	\N	ATX Full Tower	Gray	\N	Acrylic	64.5	6
Apevia X-Dreamer	\N	ATX Mid Tower	Silver	420	\N	36	5
Apevia X-Jupiter G-Type	\N	ATX Full Tower	Silver	\N	\N	66.3	6
Linkworld 431-06 C.2828	\N	ATX Mid Tower	Silver	500	\N	31.2	5
Gigabyte GZ-F5HEB	\N	ATX Mid Tower	Black	\N	\N	28.7	5
HEC 6BRBBB	\N	ATX Mid Tower	Black	\N	\N	38.3	4
Gigabyte GZ-X2SPD-500	\N	ATX Mid Tower	White	\N	\N	36.5	3
Linkworld 6280-01	\N	HTPC	Black / Silver	400	\N	21.1	1
Gigabyte GZ-F2HEB	\N	ATX Mid Tower	Black	\N	\N	28.7	5
Linkworld 3210-04-C2628	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	36.8	5
HEC 6K11BB	\N	MicroATX Mini Tower	Black	\N	\N	26.4	1
Linkworld 43715-128FU+P04	\N	MicroATX Mini Tower	Black	430	\N	23.2	1
XClio Touch 320	\N	ATX Mid Tower	Black	\N	\N	56.5	8
Xion XON-403	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	33.4	5
nMEDIAPC HTPC 1000B	\N	HTPC	Silver / Black	\N	\N	24.4	4
XClio Touch 767	\N	ATX Full Tower	Black	\N	\N	56.5	6
XClio Touch 787	\N	ATX Full Tower	Black	\N	\N	56.5	6
Silverstone Fortress Series FT02S	\N	ATX Full Tower	Silver	\N	Acrylic	64.8	5
Azza Triton 401	\N	ATX Mid Tower	Black	\N	\N	47.6	4
Azza Hurrican 2000R	\N	ATX Full Tower	Black	\N	Acrylic	82	6
Enermax Fulmo Advance	\N	ATX Mid Tower	Black	\N	\N	57.5	6
Foxconn RM233+DSI250P	\N	Mini ITX Tower	Black / Silver	250	\N	9.1	1
Foxconn RM338+FSP150-50GL	\N	Mini ITX Tower	Black / Silver	150	\N	9.1	1
In Win IW-V508T2X.L+	\N	MicroATX Mini Tower	White	\N	\N	22.9	1
Apevia X-Telstar	\N	ATX Full Tower	Black / Red	\N	Acrylic	52.7	5
Apevia X-Telstar	\N	ATX Full Tower	Black / Green	\N	Acrylic	52.7	5
Lian Li PC-C37U	\N	HTPC	Black	300	\N	18.4	2
In Win Dragon Rider	\N	ATX Full Tower	White / Black	\N	\N	76.6	6
Sentey GS-6000	\N	ATX Mid Tower	Black	\N	\N	42.5	4
Sentey BX2-4260 v2.1	\N	ATX Mid Tower	Black	\N	\N	39.1	5
Sentey GS-6070 Abaddom	\N	ATX Mid Tower	Black	\N	\N	42.5	4
Sentey CS1-1397	\N	ATX Mid Tower	Black	\N	\N	27.8	2
Sentey BX1-4285 v2.1	\N	ATX Mid Tower	Black	\N	\N	40.2	4
Rosewill RZLS142A-P YE	\N	ATX Mid Tower	Black / Yellow	\N	\N	35.7	4
Sentey GS-6050 Halcon	\N	ATX Mid Tower	Black	\N	\N	42.5	4
Sigma ATLANTIS	\N	ATX Mid Tower	Blue	\N	\N	74.1	4
Sentey GS-6600 Wolf	\N	ATX Full Tower	Black	\N	\N	60.7	5
Sigma ZEN-WAR	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	74.1	3
Sigma ZEN-WAR	\N	ATX Mid Tower	Green	\N	Acrylic	74.1	3
Logisys CS309Bk	\N	ATX Mid Tower	Black	480	Acrylic	31.8	1
Sentey GS-6500B	\N	ATX Full Tower	Black / Blue	\N	\N	61	5
Sentey GS-6400W - ARVINA	\N	ATX Full Tower	White / Black	\N	\N	60.7	5
BitFenix Raider	\N	ATX Mid Tower	Black	\N	\N	\N	6
Cooler Master Elite 370	\N	ATX Mid Tower	Black	400	\N	38.7	5
Cooler Master Elite 370	\N	ATX Mid Tower	Black	400	\N	38.7	5
Lian Li PC-6	\N	ATX Mid Tower	Black	\N	\N	\N	3
Lian Li PC-C32B USB3.0	\N	HTPC	Black	\N	\N	37.4	4
Lian Li PC-B10 USB3.0	\N	ATX Mid Tower	Black	\N	\N	46.4	4
Lian Li PC-K65	\N	ATX Mid Tower	Black	\N	\N	50.1	6
Lian Li PC-K56 N	\N	ATX Mid Tower	Black	\N	\N	50.1	3
Raidmax Super Hurricane	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	36.7	4
Raidmax Super Hurricane	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	36.7	4
Cougar Solution RSB400	\N	ATX Mid Tower	Black	400	\N	40.7	6
Raidmax ATX-321WB	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	42.6	4
In Win IW-BW138.CQ450TBL	\N	ATX Mid Tower	Black	\N	\N	34.9	4
Raidmax Seiran	\N	ATX Mid Tower	White / Black	\N	\N	45.3	6
Xion XON-990	\N	ATX Mid Tower	Black	\N	\N	53	5
Raidmax Viper	\N	ATX Mid Tower	Red / Black	\N	Acrylic	42.6	4
Raidmax Seiran	\N	ATX Mid Tower	Red / Black	\N	\N	45.3	6
HEC 6T10LOH585	\N	MicroATX Mini Tower	Black	585	\N	24	2
Antec One Illusion	\N	ATX Mid Tower	Black	\N	\N	44.2	5
Lian Li PC-Q15	\N	HTPC	Silver	300	\N	14.6	1
Lian Li PC-Q09FN	\N	HTPC	Silver	300	\N	7.5	1
Lian Li PC-V700	\N	ATX Mid Tower	Black	\N	Acrylic	41.7	6
Lian Li PC-Q15	\N	HTPC	Black	300	\N	14.6	1
Lian Li PC-V700	\N	ATX Mid Tower	Black	\N	\N	41.7	6
Lian Li PC-Q18	\N	HTPC	Silver	\N	\N	20.9	6
Lian Li PC-Q25A	\N	Mini ITX Tower	Silver	\N	\N	20.2	7
NZXT Phantom 410	\N	ATX Mid Tower	White / Black	\N	Acrylic	58.5	6
NZXT Phantom 410	\N	ATX Mid Tower	Black / White	\N	Acrylic	58.5	6
BitFenix Colossus Window	\N	ATX Full Tower	White	\N	Acrylic	79	7
BitFenix Shinobi Window	\N	ATX Mid Tower	White	\N	Acrylic	46.2	7
BitFenix Merc Beta	\N	ATX Mid Tower	Black	\N	\N	40.5	6
BitFenix Colossus Venom Window	\N	ATX Full Tower	Black	\N	Acrylic	79.4	7
Fractal Design Define R4	\N	ATX Mid Tower	Black / Gray	\N	\N	56	8
XClio 320	\N	ATX Mid Tower	Black	\N	\N	43.7	8
DIYPC SW-713	\N	ATX Mid Tower	Black	\N	\N	41.2	2
DIYPC SW-9001	\N	ATX Mid Tower	Black	\N	\N	41.2	2
Lian Li PC-Q02	\N	Mini ITX Tower	Silver	300	\N	6.8	1
BitFenix Colossus	\N	ATX Full Tower	White	\N	\N	79	7
Thermaltake ARMOR REVO	\N	ATX Full Tower	Black	\N	Acrylic	82	6
HEC 6T16BB	\N	ATX Mini Tower	Black	\N	\N	24	2
Zalman GS1000 SE	\N	ATX Full Tower	Black	\N	\N	94.7	6
Rosewill RPS-01	\N	ATX Mid Tower	Black / Silver	500	Acrylic	45.7	6
Gigabyte GZ-ZIF138R	\N	ATX Mid Tower	Black	\N	\N	33.3	4
Antec LanBoy Air	\N	ATX Mid Tower	Black	\N	\N	58.5	6
Cougar Evolution	\N	ATX Mid Tower	White	\N	Acrylic	59.8	4
In Win K1 STANDARD	\N	Mini ITX Desktop	Black	120	\N	4.7	0
Gigabyte GZ-AXBS11-CNB	\N	ATX Mid Tower	Black	\N	\N	42.9	6
Silverstone LC10B-E-USB3.0	\N	HTPC	Black	\N	\N	31.1	7
Sentey GS-6070 II Abaddom	\N	ATX Mid Tower	Black	\N	Acrylic	42.5	4
Sentey CS1-1420 TAC2.0	\N	ATX Mid Tower	Black	\N	\N	30.3	5
In Win Z670T.CQ350TBL	\N	MicroATX Mini Tower	Black	350	\N	24.2	2
Gigabyte GZ-ZIF338R	\N	ATX Mid Tower	Black	\N	\N	33.3	4
Topower TP-4107BB-400	\N	ATX Mid Tower	Black	400	\N	30.6	5
Athena Power CA-GSB01DA	\N	ATX Mid Tower	Black	\N	Acrylic	41.1	4
Raidmax ATX-605BW	\N	ATX Mid Tower	Black / White	\N	\N	75.6	6
Lian Li PC-Q16	\N	Mini ITX Tower	Silver	300	\N	9.2	1
Lian Li PC-A55	\N	ATX Mid Tower	Black	\N	\N	31.8	2
Topower TP-1687BB-300	\N	MicroATX Desktop	Black / White	300	\N	15.4	1
Lian Li PC-Q03	\N	Mini ITX Tower	Silver	\N	\N	10.2	1
Lian Li PC-Q16	\N	Mini ITX Tower	Black	300	\N	9.2	1
Apex PCV-588	\N	ATX Mid Tower	Black	\N	Acrylic	39.9	6
In Win BL641S.300TBL	\N	MicroATX Slim	Black	300	\N	11.6	2
Silverstone RL01B-USB 3.0	\N	ATX Mid Tower	Black	\N	\N	40.9	5
Sentey GS-6700 SPIDER	\N	ATX Full Tower	Black	\N	\N	60.7	5
Cougar Solution AF-2	\N	ATX Mid Tower	Black / Green	\N	\N	40.7	6
Sentey GS-6410 ARVINA PLUS	\N	ATX Full Tower	Black	\N	Acrylic	60.7	5
Sentey GS-6510 BURTON PLUS	\N	ATX Full Tower	Black	\N	Acrylic	60.7	5
Lian Li PC-K56N USB 3.0	\N	ATX Mid Tower	Black	\N	\N	50.1	3
Lian Li PC-V750	\N	ATX Full Tower	Black	\N	\N	99.4	9
Silverstone LC20B-M-USB3.0	\N	HTPC	Black	\N	\N	31.2	6
In Win GR One	\N	ATX Full Tower	Gray / Black	\N	Acrylic	81	8
Lian Li PC-B12	\N	ATX Mid Tower	Black	\N	\N	49.3	3
Lian Li PC-X2000FNB	\N	ATX Full Tower	Black	\N	\N	75.4	9
In Win GR One	\N	ATX Full Tower	Gray / Black	\N	Acrylic	81	8
Topower TP-4106BB	\N	ATX Mid Tower	Black	\N	\N	\N	5
DIYPC Adventurer-9601R	\N	ATX Full Tower	Black	\N	Acrylic	49.7	7
Apevia X-Jupiter-Jr G-Type	\N	ATX Mid Tower	Blue	\N	Acrylic	42.3	3
Apevia X-Jupiter-Jr G-Type	\N	ATX Mid Tower	Black	\N	Acrylic	42.3	3
Apevia X-Jupiter-Jr G-Type	\N	ATX Mid Tower	Silver	\N	Acrylic	42.3	3
Apevia X-Jupiter-Jr G-Type	\N	ATX Mid Tower	Silver	\N	Acrylic	42.3	3
Silverstone SG01B-F-USB3.0	\N	MicroATX Desktop	Black	\N	\N	21.7	2
Enermax ECA3175	\N	ATX Mid Tower	Black	\N	Acrylic	33.9	6
Cooler Master Storm Scout 2 Advanced	\N	ATX Mid Tower	Gray / Black	\N	Acrylic	61.6	7
Lian Li PC-7H	\N	ATX Mid Tower	Black	\N	\N	55.5	4
Gigabyte GZ-ZLM10BS	\N	ATX Mid Tower	Black	\N	\N	36.2	8
BitFenix Shinobi XL	\N	ATX Full Tower	White	\N	\N	77.2	7
BitFenix Merc Alpha	\N	ATX Mid Tower	Black	\N	\N	40.5	6
DIYPC SW-711	\N	ATX Mid Tower	Black	\N	\N	41.2	2
Rosewill Line Glow	\N	ATX Mid Tower	Black	\N	\N	35.5	8
Parvum Systems S1.0	\N	MicroATX Mid Tower	Black	\N	Acrylic	\N	2
Parvum Systems S1.0	\N	MicroATX Mid Tower	White	\N	Acrylic	\N	2
Antec P280	\N	ATX Mid Tower	White	\N	\N	68	6
Silverstone TJ10B-USB3.0	\N	ATX Full Tower	Black	\N	\N	69.2	6
Silverstone TJ10B-W	\N	ATX Full Tower	Black	\N	Acrylic	69.2	6
Silverstone TJ10B-W-USB3.0	\N	ATX Full Tower	Black	\N	Acrylic	69.2	6
Silverstone TJ10B-WNV	\N	ATX Full Tower	Black	\N	Acrylic	69.2	6
Silverstone TJ10S	\N	ATX Full Tower	Silver	\N	\N	69.2	6
Silverstone TJ10S-W	\N	ATX Full Tower	Silver	\N	Acrylic	69.2	6
Silverstone TJ10B-WNV-USB3.0	\N	ATX Full Tower	Black	\N	Acrylic	69.2	6
Silverstone RL04B	\N	ATX Mid Tower	Black	\N	\N	54.9	5
Silverstone RL03B-W-USB 3.0	\N	ATX Mid Tower	Black	\N	Acrylic	40.4	7
Silverstone PS05B-USB3.0	\N	ATX Mid Tower	Black	\N	\N	42.6	4
CFI Prime 311	\N	ATX Mid Tower	Black	\N	\N	42.7	4
CFI Prime 223	\N	ATX Mid Tower	Black	\N	\N	32.4	4
CFI Pharaoh	\N	ATX Full Tower	Black	\N	Acrylic	89.6	8
CFI Diablo LT	\N	ATX Mid Tower	Black	\N	Acrylic	48	4
Lian Li PC-7H	\N	ATX Mid Tower	Black	\N	\N	55.5	4
Lian Li PC-9N	\N	ATX Mid Tower	Silver	\N	\N	46.5	3
Lian Li PC-9N	\N	ATX Mid Tower	Black	\N	\N	46.5	3
Lian Li PC-Q07B USB3.0	\N	Mini ITX Tower	Black	\N	\N	11.6	1
Ultra XBlaster Pro	\N	ATX Mid Tower	Black	\N	\N	36	7
Ultra XBlaster V2	\N	ATX Mid Tower	Black	\N	\N	36	6
Ultra Gladiator	\N	ATX Mid Tower	Black	\N	\N	39.5	5
Thermaltake Overseer RX-I Snow Edition	\N	ATX Full Tower	White	\N	Acrylic	68.1	5
Enermax Hoplite ST	\N	ATX Mid Tower	Black	\N	Acrylic	48	6
Enermax Hoplite ST	\N	ATX Mid Tower	White	\N	Acrylic	48	6
Rosewill R5601	\N	ATX Mid Tower	Black	\N	\N	43.2	5
Thermaltake Urban S41	\N	ATX Mid Tower	Black	\N	\N	58.9	5
Thermaltake Urban S31 Window	\N	ATX Mid Tower	Black	\N	Acrylic	53.6	6
Xigmatek CCC-AD38BV-U03	\N	ATX Mid Tower	Black / Orange	\N	\N	43.6	8
Xigmatek CCC-AD38BX-U03	\N	ATX Mid Tower	Black / Silver	\N	\N	43.6	8
Enermax ECA3253	\N	ATX Mid Tower	Black	\N	Acrylic	43.8	5
Enermax ECA3253	\N	ATX Mid Tower	Black / White	\N	Acrylic	43.8	5
Enermax ECA3280A	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	58.2	8
Enermax ECA3290A	\N	ATX Mid Tower	Gunmetal	\N	Acrylic	\N	7
Lian Li PC-Q27	\N	Mini ITX Tower	Silver	\N	\N	14.3	3
Lian Li PC-Q27	\N	Mini ITX Tower	Black	\N	\N	14.3	3
Lian Li PC-Q28	\N	Mini ITX Tower	Silver	\N	\N	23.8	4
Lian Li PC-Q28	\N	Mini ITX Tower	Black	\N	\N	23.8	4
Lian Li PC-K7B USB3.0	\N	ATX Mid Tower	Black	\N	\N	47	5
Lian Li PC-Q30	\N	Mini ITX Tower	Silver	\N	\N	23.4	0
Gigabyte GZ-G1SGS	\N	ATX Mid Tower	Black	\N	\N	33.8	6
Apevia X-DMR4	\N	ATX Mid Tower	Black	\N	Acrylic	43.1	4
Cougar Challenger	\N	ATX Mid Tower	Black / White	\N	Acrylic	71.6	7
In Win BP655.300TB3L	\N	Mini ITX Tower	Black	200	\N	8.1	0
In Win IW-Z611T.CQ350TSL	\N	MicroATX Mini Tower	Black / Silver	350	\N	24.2	1
In Win Z653T.CQ350TB3L	\N	MicroATX Mini Tower	Black	\N	\N	24.2	1
Silverstone GD01B-R-USB3.0	\N	HTPC	Black	\N	\N	\N	6
Silverstone PS08B	\N	MicroATX Mid Tower	White	\N	\N	23.7	4
Silverstone RL02B-W-USB 3.0	\N	ATX Mid Tower	Black	\N	Acrylic	40.4	7
Silverstone SG06BB-LITE	\N	Mini ITX Desktop	Silver	\N	Acrylic	\N	1
Xion XON-710P	\N	MicroATX Slim	Red / Black	300	\N	9.5	1
Xion XON-710P	\N	MicroATX Slim	White	300	\N	9.5	1
Xion XON-791B	\N	ATX Mid Tower	Black	\N	\N	\N	3
Zalman Z12	\N	ATX Mid Tower	Black	\N	\N	47.7	5
Apevia 837344000652	\N	ATX Mid Tower	Silver	350	Acrylic	39.5	4
Apevia ATXB8KLW-SS	\N	ATX Mid Tower	Silver	\N	Acrylic	40.3	4
Apevia MX-Pider	\N	ATX Full Tower	Silver	500	Acrylic	50.9	4
Apevia X-DMR3	\N	ATX Mid Tower	Silver	450	\N	37.1	6
Apevia X-Dreamer4	\N	ATX Mid Tower	Black / Red	\N	Acrylic	43.1	4
Apex DM-532-U3	\N	HTPC	Black	275	\N	13.8	1
Apex MI-110	\N	Mini ITX Tower	Black / Silver	250	Acrylic	9.7	1
DIYPC FM08	\N	ATX Mid Tower	Black	\N	\N	33.8	2
DIYPC FM08	\N	ATX Mid Tower	Black	\N	\N	33.8	2
DIYPC MiniQ1	\N	MicroATX Mini Tower	Black	\N	\N	24.7	2
DIYPC MiniQ7	\N	ATX Mini Tower	Black	\N	\N	24.8	2
DIYPC Skyline	\N	ATX Mid Tower	Black	\N	\N	28.3	6
Raidmax Super Hurricane	\N	ATX Mid Tower	Black	\N	\N	36.7	4
Raidmax Super Hurricane	\N	ATX Mid Tower	Black	450	\N	36.7	4
Raidmax Sting Ray ATX-249B	\N	ATX Mid Tower	White	\N	\N	43.4	3
Raidmax Atlas	\N	ATX Mid Tower	White / Black	\N	Acrylic	44.7	4
Raidmax ATX-502WBG	\N	ATX Mid Tower	Red / Black	\N	Acrylic	59.5	3
Raidmax ATX-502WBG	\N	ATX Mid Tower	Blue / Black	\N	Acrylic	59.5	3
Rosewill FB-03	\N	ATX Mid Tower	Black	\N	\N	26.5	4
Sentey CS1-1399 PLUS	\N	ATX Mid Tower	Black / Red	\N	\N	30.3	5
Sentey CS1-1410	\N	ATX Mid Tower	Black	400	\N	30.3	5
Sentey CS1-1410 PLUS	\N	ATX Mid Tower	Black	\N	\N	30.3	5
Sentey CS1-1420 PLUS	\N	ATX Mid Tower	Black	\N	\N	30.3	5
Sentey GS-6010	\N	ATX Mid Tower	Black	\N	\N	36.9	5
Sentey GS-6060 Plus	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	40.2	4
Topower TP-1687BB-400	\N	MicroATX Desktop	Black	400	\N	15.4	1
Topower TP-6208BB	\N	ATX Mid Tower	Black	\N	Acrylic	\N	5
Xion XON-160P	\N	ATX Mid Tower	Black / Silver	500	\N	56.9	5
Xion XON-301	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	\N	5
HEC Enterprise	\N	ATX Mid Tower	Black	\N	\N	\N	2
HEC Vigilance	\N	MicroATX Mini Tower	Black	400	\N	27.5	2
BitFenix Prodigy	\N	Mini ITX Tower	Green	\N	Acrylic	36	5
Lian Li PC-7H	\N	ATX Mid Tower	Black	\N	Acrylic	55.5	4
Lian Li PC-A76WX	\N	ATX Full Tower	Black	\N	Acrylic	\N	12
Cougar Pioneer	\N	ATX Mid Tower	Black	\N	Acrylic	\N	6
Gigabyte GZ-PD Plus	\N	ATX Mid Tower	Black	\N	\N	30.7	4
Nanoxia DS1WIB	\N	ATX Mid Tower	Black	\N	Acrylic	60	8
Nanoxia NXDS1W	\N	ATX Mid Tower	White	\N	Acrylic	60	8
In Win IW-Z589T.CQ350TB3U2L	\N	ATX Mid Tower	Black	350	\N	\N	1
CHENBRO ES34069-BK-180	\N	Mini ITX Tower	Black	180	\N	9.4	0
Aerocool Syclone2	\N	ATX Mid Tower	Black / Blue	\N	\N	\N	6
Aerocool Strike-X Advance	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	0
BitFenix Phenom	\N	Mini ITX Tower	Black	\N	\N	30.6	6
BitFenix Phenom	\N	Mini ITX Tower	White	\N	\N	30.6	6
DIYPC FM08	\N	ATX Mid Tower	Black / Red	\N	\N	33.8	2
Rosewill THRONE-G-Window	\N	ATX Full Tower	Black	\N	Acrylic	74.8	10
Thermaltake Urban 21 BOM	\N	ATX Mid Tower	Black	\N	Acrylic	40.1	5
Gigabyte Sumo Omega	\N	ATX Mid Tower	Black	\N	\N	61.6	8
Gigabyte GZ-ZSUCWP	\N	ATX Mid Tower	Black	\N	\N	61.6	8
In Win H-Frame Mini	\N	Mini ITX Tower	Blue / Silver	180	\N	\N	0
Rosewill Galaxy-02	\N	ATX Mid Tower	Black	\N	\N	26.4	4
Rosewill Galaxy-01	\N	ATX Mid Tower	Black	\N	\N	45.9	4
Rosewill R536	\N	ATX Mid Tower	Black	500	\N	35.6	5
Xigmatek CCM-38BBW-U01	\N	ATX Mid Tower	Black	\N	Acrylic	67.8	8
Cubitek Mini Cube	\N	Mini ITX Tower	Black	\N	\N	\N	3
Cubitek Mini Cube	\N	Mini ITX Tower	Silver	\N	\N	\N	3
Cubitek Tattoo Beta 2	\N	ATX Mid Tower	Black	\N	\N	\N	5
Cubitek Tattoo Beta 2	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	5
Cubitek Tattoo Pro 2	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	5
Cubitek Tattoo White	\N	ATX Mid Tower	Black / White	\N	Acrylic	\N	5
Aerocool DS Cube	\N	MicroATX Mini Tower	Black	\N	\N	41.5	2
Aerocool DS Cube	\N	MicroATX Mini Tower	White	\N	Acrylic	41.5	2
Aerocool DS Cube	\N	MicroATX Mini Tower	Black / Red	\N	Acrylic	41.5	2
Aerocool DS Cube	\N	MicroATX Mini Tower	Black / Orange	\N	\N	41.5	2
Aerocool DS Cube	\N	MicroATX Mini Tower	Black / White	\N	\N	41.5	2
Aerocool DS Cube	\N	MicroATX Mini Tower	Black / Gold	\N	\N	41.5	2
Aerocool DS Cube	\N	MicroATX Mini Tower	Black / Gold	\N	Acrylic	41.5	2
Nanoxia NXDS4B	\N	MicroATX Mini Tower	White	\N	\N	\N	6
Nanoxia NXDS5B	\N	ATX Full Tower	Black	\N	\N	\N	11
Nanoxia NXDS5B	\N	ATX Full Tower	Black	\N	\N	\N	11
Thermaltake ARMOR A30i Speedy	\N	MicroATX Mini Tower	Black / Red	\N	Acrylic	35.5	3
Streacom ST-F1CB-EVO	\N	HTPC	Black	\N	\N	\N	0
Diablotek CPA-7630	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	31.6	5
Enermax ECA3310A	\N	ATX Mid Tower	White	\N	Acrylic	58.6	7
Rosewill Legacy MX2-B	\N	ATX Mid Tower	Black	\N	\N	37.2	3
Rosewill Legacy MX2-B	\N	ATX Mid Tower	Black	\N	\N	37.2	3
Rosewill Legacy QT01-B	\N	ATX Mid Tower	Black	\N	\N	43.4	4
Rosewill Legacy QT01-S	\N	ATX Mid Tower	Black / Silver	\N	\N	43.4	4
Rosewill Legacy U2-B	\N	Mini ITX Tower	Black	\N	\N	15.4	2
Rosewill Legacy U2-B	\N	Mini ITX Tower	Black	\N	Acrylic	15.4	2
Rosewill Legacy U2-S	\N	Mini ITX Tower	Silver	\N	\N	15.4	2
Rosewill Legacy V6-B	\N	Mini ITX Tower	Black	\N	\N	12.5	4
Silverstone PS07B	\N	MicroATX Mini Tower	Black / Silver	\N	Acrylic	31.4	5
Xigmatek Assassin II	\N	ATX Mid Tower	Black / White	\N	Acrylic	55.1	5
Antec NSK3180	\N	MicroATX Mid Tower	Black	380	\N	26.6	2
Azza XT-1	\N	ATX Full Tower	White / Blue	\N	Acrylic	59.8	6
BitFenix Colossus Mini	\N	Mini ITX Tower	Black / White	\N	\N	57.9	5
CFI Prime 211	\N	ATX Mid Tower	Black / Red	\N	\N	32.4	2
Rosewill Legacy U3-B	\N	MicroATX Mini Tower	Silver	\N	Acrylic	20.1	2
Rosewill Legacy V3 Plus-B	\N	Mini ITX Tower	Silver	\N	\N	10	1
Rosewill Legacy V4-B	\N	MicroATX Mini Tower	Black	\N	\N	18.3	3
Raygo R12-42403	\N	MicroATX Mid Tower	Black / Silver	\N	\N	\N	2
Silverstone SG08B-LITE	\N	Mini ITX Desktop	Black	\N	\N	\N	1
Thermaltake Urban T31 Window	\N	ATX Mid Tower	Black	\N	Acrylic	\N	6
Raidmax ATX-402WB	\N	ATX Mid Tower	Black	\N	Acrylic	42.4	3
Xigmatek Aquila	\N	MicroATX Mini Tower	Black	\N	Acrylic	\N	2
Xigmatek Aquila	\N	MicroATX Mini Tower	Black / White	\N	Acrylic	\N	2
Apex EL-660	\N	ATX Mid Tower	Black	\N	\N	55.4	6
Wesena HTPC-e4-v3-B	\N	HTPC	Black	\N	\N	\N	2
In Win BP671.FH200B	\N	Mini ITX Tower	Black	200	\N	9.1	2
Lian Li PC-10N	\N	ATX Mid Tower	Black	\N	\N	\N	6
Nanoxia Deep Silence 2 White	\N	ATX Mid Tower	White	\N	\N	57	7
Rosewill QN100	\N	ATX Mid Tower	Black	\N	\N	29.7	2
Thermaltake Urban R21	\N	ATX Mid Tower	Black	\N	\N	39.8	5
Cooler Master TC102	\N	ATX Mid Tower	Black	500	\N	\N	2
Parvum Systems S2.0	\N	MicroATX Mini Tower	Black / Blue	\N	Acrylic	\N	2
Parvum Systems S2.0	\N	MicroATX Mini Tower	Black / Green	\N	Acrylic	\N	2
Parvum Systems S2.0	\N	MicroATX Mini Tower	Black / Orange	\N	Acrylic	\N	2
Parvum Systems S2.0	\N	MicroATX Mini Tower	Black / Red	\N	Acrylic	\N	2
Parvum Systems S2.0	\N	MicroATX Mini Tower	White / Black	\N	Acrylic	\N	2
Parvum Systems S2.0	\N	MicroATX Mini Tower	White / Blue	\N	Acrylic	\N	2
Parvum Systems S2.0	\N	MicroATX Mini Tower	Orange / White	\N	Acrylic	\N	2
Parvum Systems S2.0	\N	MicroATX Mini Tower	White / Gold	\N	Acrylic	\N	2
BitFenix Outlaw USB3.0	\N	ATX Mid Tower	Black	\N	\N	37.6	4
BitFenix Outlaw USB3.0	\N	ATX Mid Tower	White / Red	\N	\N	37.6	4
BitFenix Neos Window	\N	ATX Mid Tower	White / Purple	\N	Acrylic	37	3
BitFenix Neos	\N	ATX Mid Tower	White / Blue	\N	\N	37	3
BitFenix Neos	\N	ATX Mid Tower	White / Silver	\N	\N	37	3
BitFenix Phenom M Nvidia Edition	\N	MicroATX Mini Tower	Green / White	\N	\N	30.6	5
Azza Z	\N	Mini ITX Tower	Black	\N	Acrylic	16.7	0
Cooler Master K550	\N	ATX Mid Tower	Black	\N	Acrylic	58.3	7
DIYPC FM08	\N	ATX Mid Tower	Black	\N	\N	33.8	2
DIYPC Gamemax08	\N	ATX Mid Tower	Black / Green	\N	\N	33.8	2
Rosewill Legacy W1-B	\N	Mini ITX Tower	Black	\N	\N	31.1	4
Rosewill Legacy W1-B-Window	\N	Mini ITX Tower	Black	\N	Acrylic	31.1	4
Rosewill Legacy W1-S	\N	Mini ITX Tower	Silver	\N	\N	31.1	4
Rosewill Legacy W1-S-Window	\N	Mini ITX Tower	Silver	\N	Acrylic	31.1	4
Aerocool DS Cube	\N	MicroATX Mini Tower	Black / White	\N	\N	41.5	2
Aerocool DS Cube	\N	MicroATX Mini Tower	Black / Red	\N	\N	41.5	2
Aerocool DS Cube	\N	MicroATX Mini Tower	White	\N	\N	41.5	2
Aerocool DS 200	\N	ATX Mid Tower	Black	\N	\N	\N	5
Aerocool DS 200	\N	ATX Mid Tower	Black / White	\N	\N	\N	5
Lian Li PC-Q36W	\N	Mini ITX Tower	Silver	\N	\N	25.4	2
Lian Li PC-Q36W	\N	Mini ITX Tower	Gold	\N	\N	25.4	2
Lian Li PC-Q36W	\N	Mini ITX Tower	Black / Red	\N	\N	25.4	2
Lian Li PC-V359W	\N	MicroATX Mid Tower	Black / Red	\N	\N	36.6	3
Lian Li PC-V359W	\N	MicroATX Mid Tower	Black	\N	\N	36.6	3
Deepcool STEAM CASTLE	\N	MicroATX Mid Tower	White	\N	Acrylic	47.1	3
Zalman T1U3	\N	MicroATX Mini Tower	Black	\N	\N	24.7	2
Lian Li PC-Q33	\N	Mini ITX Tower	Silver	\N	\N	18.1	2
In Win GR One	\N	ATX Full Tower	Gray	\N	Acrylic	81	8
Athenatech SS-PS08	\N	MicroATX Mid Tower	Black	\N	\N	23.7	4
BitFenix Pandora	\N	MicroATX Mid Tower	Black	\N	Acrylic	31.2	2
BitFenix Pandora Core	\N	MicroATX Mid Tower	Black	\N	\N	31.2	2
BitFenix Pandora	\N	MicroATX Mid Tower	Silver	\N	\N	31.2	2
BitFenix Pandora Core	\N	MicroATX Mid Tower	Silver	\N	\N	31.2	2
Lian Li PC-A61	\N	ATX Mid Tower	Black	\N	Acrylic	57.4	6
Lian Li PC-Q01	\N	Mini ITX Tower	Silver	\N	\N	13.2	2
Lian Li PC-Q19	\N	Mini ITX Tower	Silver	\N	\N	22.4	1
Lian Li PC-Q19	\N	Mini ITX Tower	Black	\N	\N	22.4	1
Lian Li PC-Q35A	\N	Mini ITX Tower	Silver	\N	\N	18.1	5
Lian Li PC-V1000L	\N	ATX Full Tower	Silver	\N	\N	73.6	0
Lian Li PC-V358	\N	MicroATX Mid Tower	Silver	\N	\N	36.6	6
Lian Li PC-Q36W	\N	Mini ITX Tower	Black	\N	\N	25.4	2
Lian Li PC-Q36W	\N	Mini ITX Tower	Silver	\N	\N	25.4	2
DIYPC Mirage-D1	\N	ATX Mid Tower	Black / White	\N	Acrylic	37.2	4
Enermax Thorex	\N	ATX Mid Tower	Black	\N	\N	\N	3
In Win BL641.FH300TB3F	\N	HTPC	Black	300	\N	11.6	2
In Win BL672.FH300TB3F	\N	HTPC	Black / Silver	\N	\N	11.6	2
In Win D-FRAME MINI	\N	Mini ITX Tower	Black / Red	\N	Tempered Glass	46.3	3
In Win EC046.CQ450TB3K	\N	ATX Mid Tower	Black	\N	\N	43.6	4
In Win S-FRAME	\N	ATX Full Tower	Black	\N	Tempered Glass	131.3	4
Aerocool GT-A	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	3
DIYPC Shadow-H01	\N	ATX Mid Tower	Black	\N	Acrylic	47.8	4
Silverstone FT05	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	45.3	2
Silverstone FT05	\N	ATX Mid Tower	Silver	\N	\N	45.3	2
Thermaltake Level 10 Titanium	\N	ATX Full Tower	Black / Silver	\N	\N	129.6	6
Nanoxia Deep Silence 5	\N	ATX Full Tower	White	\N	\N	\N	11
BitFenix Prodigy M	\N	MicroATX Mini Tower	Black / Blue	\N	Acrylic	35.9	4
BitFenix Prodigy M	\N	MicroATX Mini Tower	Black / Blue	\N	\N	35.9	4
BitFenix Prodigy M	\N	MicroATX Mini Tower	Black / Green	\N	\N	35.9	4
BitFenix Prodigy M	\N	MicroATX Mini Tower	Black / Orange	\N	\N	35.9	4
BitFenix Prodigy M	\N	MicroATX Mini Tower	Black / Red	\N	\N	35.9	4
Lian Li PC-Q26	\N	Mini ITX Tower	Silver	\N	\N	33.8	10
Aerocool Strike-X Advance	\N	ATX Mid Tower	Black	\N	Acrylic	\N	0
Cooltek W1	\N	Mini ITX Tower	Black	\N	\N	\N	4
Cooltek W1	\N	Mini ITX Tower	Black	\N	Acrylic	\N	4
Cooltek W1	\N	Mini ITX Tower	Silver	\N	\N	\N	4
Cooltek W1	\N	Mini ITX Tower	Silver	\N	Acrylic	\N	4
Cooler Master Force 500	\N	ATX Mid Tower	Black	500	\N	39.8	7
Cooler Master K280	\N	ATX Mid Tower	Black	500	\N	\N	6
DIYPC FM18	\N	ATX Mid Tower	Black / White	\N	Acrylic	33.8	2
DIYPC HTPC-Cube	\N	Mini ITX Tower	Black	\N	\N	\N	1
DIYPC Ranger-R4	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	41.6	4
DIYPC Solar-M1	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	38	5
Deepcool STEAM CASTLE	\N	MicroATX Mid Tower	Camo	\N	Acrylic	47.1	3
Deepcool STEAM CASTLE	\N	MicroATX Mid Tower	White	\N	\N	47.1	3
Enermax Fulmo ST	\N	ATX Full Tower	Black / Red	\N	Acrylic	\N	8
Gigabyte GZ-X7B-U3NP	\N	ATX Mid Tower	Black / Red	\N	\N	\N	6
Gigabyte GZ-ZGS4B5	\N	ATX Mid Tower	Black	\N	\N	\N	5
Gigabyte GZ-ZGS5B5	\N	ATX Mid Tower	Black	\N	\N	\N	5
Gigabyte GZ-ZHSGWJ	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	8
Gigabyte GZ-ZHSHWW	\N	ATX Mid Tower	Black	\N	\N	\N	8
Gigabyte GZ-ZHSMW8	\N	MicroATX Mini Tower	Black	\N	\N	\N	3
Lian Li PC-K69	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Lian Li PC-Q33	\N	Mini ITX Tower	Silver	\N	Acrylic	18.1	2
NZXT Phantom 240	\N	ATX Mid Tower	Black / Gray	\N	Acrylic	\N	6
Aerocool XPredator Cube	\N	MicroATX Mid Tower	Black / Red	\N	Acrylic	\N	3
Raidmax Atomic	\N	Mini ITX Tower	Black	\N	Acrylic	\N	1
Raidmax Scorpio V	\N	ATX Mid Tower	Pink	\N	Acrylic	54.6	8
RAIJINTEK Metis	\N	Mini ITX Tower	Silver	\N	Acrylic	13.4	1
RAIJINTEK Metis	\N	Mini ITX Tower	Blue	\N	Acrylic	13.4	1
RAIJINTEK Metis	\N	Mini ITX Tower	Gold	\N	Acrylic	13.4	1
RAIJINTEK Metis	\N	Mini ITX Tower	Black	\N	\N	13.4	1
RAIJINTEK Metis	\N	Mini ITX Tower	Blue	\N	\N	13.4	1
RAIJINTEK Metis	\N	Mini ITX Tower	Silver	\N	\N	13.4	1
RAIJINTEK Metis	\N	Mini ITX Tower	Gold	\N	\N	13.4	1
BitFenix Aegis	\N	MicroATX Mid Tower	Blue	\N	Acrylic	46.2	4
BitFenix Aegis Core	\N	MicroATX Mid Tower	Red	\N	Acrylic	46.2	4
BitFenix Aegis	\N	MicroATX Mid Tower	White	\N	Acrylic	46.2	4
BitFenix Aegis	\N	MicroATX Mid Tower	Yellow	\N	Acrylic	46.2	4
BitFenix Aegis Core	\N	MicroATX Mid Tower	Yellow	\N	Acrylic	46.2	4
Silverstone KL05B	\N	ATX Mid Tower	Black	\N	\N	\N	6
Antec ISK600M	\N	MicroATX Mini Tower	Black	\N	\N	\N	3
NOX Coolbay VX	\N	ATX Mid Tower	Black / Blue	\N	\N	34.3	7
Sentey Ss6-2441	\N	MicroATX Mini Tower	White	\N	\N	\N	2
Sentey Ss6-2441	\N	MicroATX Mini Tower	Black / White	\N	\N	\N	2
Azza Nova 8000	\N	ATX Full Tower	Gunmetal	\N	Acrylic	\N	6
Azza ZEN 8100	\N	ATX Full Tower	Black	\N	Acrylic	\N	6
BitFenix Aegis Core	\N	MicroATX Mid Tower	Black	\N	Acrylic	46.2	4
BitFenix Aegis Core	\N	MicroATX Mid Tower	Blue	\N	Acrylic	46.2	4
BitFenix Aegis	\N	MicroATX Mid Tower	Black	\N	Acrylic	46.2	4
BitFenix Aegis	\N	MicroATX Mid Tower	Blue	\N	Acrylic	46.2	4
BitFenix Aegis	\N	MicroATX Mid Tower	Red	\N	Acrylic	46.2	4
BitFenix Aegis	\N	MicroATX Mid Tower	Yellow	\N	Acrylic	46.2	4
BitFenix Aegis Core	\N	MicroATX Mid Tower	Red	\N	Acrylic	46.2	4
DIYPC DIY-BJ05	\N	ATX Mid Tower	Black	\N	\N	\N	3
Azza Draco 207	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	5
Azza Draco 207	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	5
Silverstone PS11B	\N	ATX Mid Tower	Black	\N	\N	\N	3
Raidmax Troy	\N	Mini ITX Desktop	Black / Red	\N	\N	\N	1
Silverstone KL06B	\N	MicroATX Mini Tower	Black	\N	\N	\N	1
Silverstone KL06B	\N	MicroATX Mini Tower	Black	\N	Acrylic	\N	1
Sentey GS-6090	\N	ATX Mid Tower	Black	\N	Acrylic	\N	4
RAIJINTEK Aeneas	\N	MicroATX Mini Tower	Black	\N	Acrylic	\N	4
RAIJINTEK Aeneas	\N	MicroATX Mini Tower	White	\N	Acrylic	\N	4
Lian Li PC-O5	\N	HTPC	Black	\N	Tempered Glass	\N	2
Cooler Master CM690 II Advanced	\N	ATX Mid Tower	Black / White	\N	\N	56.3	6
Sentey SS1-2423	\N	HTPC	Black / Silver	\N	\N	\N	1
Aerocool XPredator Cube	\N	MicroATX Mid Tower	Black / Red	\N	Acrylic	\N	3
BitFenix Neos	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	37	3
BitFenix Neos	\N	ATX Mid Tower	Black	\N	\N	37	3
BitFenix Aegis	\N	MicroATX Mid Tower	Black / White	\N	Acrylic	46.2	4
Cooler Master HAF XM	\N	ATX Mid Tower	Black / Red	\N	Acrylic	76	6
Lian Li PC-O6S	\N	HTPC	Black	\N	Tempered Glass	\N	6
Sentey Ss1-2429	\N	MicroATX Mid Tower	Black / Blue	\N	\N	\N	0
Sentey Ss1-2429	\N	MicroATX Mid Tower	Black / Purple	\N	\N	\N	0
Cooltek W2	\N	ATX Mid Tower	Black	\N	\N	\N	3
Cooltek W2	\N	ATX Mid Tower	Silver	\N	\N	\N	3
DIYPC Adventurer-I8	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	2
DIYPC Adventurer-I8	\N	ATX Mid Tower	Black / Green	\N	Acrylic	\N	2
DIYPC Adventurer-I8	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	2
Aerocool QS-102	\N	HTPC	Black	\N	\N	\N	0
Aerocool QS-102	\N	HTPC	Black	400	\N	\N	0
JMAX JX-FM500B	\N	MicroATX Mini Tower	Black	\N	\N	\N	0
DIYPC Cuboid	\N	MicroATX Mini Tower	Black / Blue	\N	Acrylic	\N	3
Raidmax Element	\N	Mini ITX Desktop	Black / Green	\N	\N	\N	2
Raidmax Element	\N	Mini ITX Desktop	Black / Pink	\N	\N	\N	2
Raidmax Element	\N	Mini ITX Desktop	Black / Pink	\N	\N	\N	2
Raidmax Element	\N	Mini ITX Desktop	Black / Gray	450	\N	\N	2
Antec P50	\N	MicroATX Mini Tower	Black	\N	Acrylic	\N	3
Aerocool Aero-500 - C	\N	ATX Mid Tower	White / Black	\N	Acrylic	45.1	4
Aerocool Aero-800	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	2
Aerocool Aero-800	\N	ATX Mid Tower	Black / Gray	\N	Acrylic	\N	2
Silverstone ML08	\N	HTPC	Black	\N	Acrylic	\N	0
Silverstone ML08	\N	HTPC	Black	\N	Acrylic	\N	0
Logisys CS136BK	\N	ATX Mid Tower	Black / Silver	480	\N	23.7	3
Rosewill WolfStone	\N	ATX Mid Tower	Black	\N	\N	\N	8
Raidmax EXO	\N	ATX Mid Tower	Black / Blue	\N	\N	\N	2
DIYPC Futurus	\N	MicroATX Mid Tower	Black / Blue	\N	Acrylic	\N	2
DIYPC Futurus	\N	MicroATX Mid Tower	White	\N	Acrylic	\N	2
SHARKOON CA-I	\N	Mini ITX Desktop	Black	\N	\N	\N	1
SHARKOON CA-I	\N	Mini ITX Desktop	Silver	\N	\N	\N	1
SHARKOON CA-M	\N	MicroATX Mini Tower	Silver	\N	\N	\N	2
In Win 909	\N	ATX Full Tower	Black	\N	Tempered Glass	\N	4
In Win 909	\N	ATX Full Tower	Silver	\N	Tempered Glass	\N	4
RAIJINTEK STYX	\N	MicroATX Mini Tower	Black	\N	Acrylic	\N	3
RAIJINTEK STYX	\N	MicroATX Mini Tower	Gold	\N	Acrylic	\N	3
RAIJINTEK STYX	\N	MicroATX Mini Tower	Black	\N	\N	\N	3
SHARKOON BD28	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	3
Silverstone RVX01 Window	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	4
Silverstone RVX01	\N	ATX Mid Tower	Black	\N	\N	\N	4
Silverstone RVX01 Window	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	4
Silverstone RVX01 Window	\N	ATX Mid Tower	Black / Green	\N	Acrylic	\N	4
Lian Li PC-Q21	\N	Mini ITX Tower	Silver	\N	\N	\N	2
VIVO Athena	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
RAIJINTEK AGOS	\N	ATX Mid Tower	Black	\N	\N	\N	6
RAIJINTEK AGOS	\N	ATX Mid Tower	White	\N	\N	\N	6
Apevia X-Pioneer	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	4
Apevia X-Pioneer	\N	ATX Mid Tower	White / Blue	\N	Acrylic	\N	4
Apevia X-QPack3	\N	MicroATX Mini Tower	Black	\N	\N	\N	2
NZXT Manta	\N	Mini ITX Desktop	Black	\N	\N	\N	2
Lian Li PC-O7S	\N	HTPC	Black	\N	Tempered Glass	\N	7
Lian Li PC-V33	\N	ATX Mid Tower	Black	\N	\N	\N	4
Lian Li PC-V33	\N	ATX Mid Tower	Black	\N	Acrylic	\N	4
BitFenix Pandora ATX	\N	ATX Mid Tower	Black	\N	Acrylic	\N	4
Sentey BX1-4284 Plus	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	4
DIYPC Zondda	\N	ATX Mid Tower	White	\N	Acrylic	\N	4
Diablotek CPA-8818	\N	ATX Mid Tower	Black	\N	Acrylic	\N	5
DIYPC D480	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
LEPA LPC501	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	6
Phanteks Eclipse P400S	\N	ATX Mid Tower	Gray	\N	Tinted Acrylic	45.9	2
Xigmatek Nebula	\N	Mini ITX Tower	White	\N	\N	22.3	2
Lian Li PC-Q04	\N	Mini ITX Tower	Silver	\N	\N	\N	2
Lian Li PC-Q04	\N	Mini ITX Tower	Black	\N	\N	\N	2
Silverstone LC18	\N	HTPC	Black	\N	\N	30.6	5
DIYPC VT380	\N	ATX Mid Tower	White	\N	Acrylic	\N	3
Silverstone PS12B	\N	MicroATX Mid Tower	Black	\N	\N	\N	4
Apevia X-Qtis	\N	MicroATX Mid Tower	Black / Blue	\N	Acrylic	\N	4
Apevia X-Qtis	\N	MicroATX Mid Tower	White / Blue	\N	Acrylic	\N	4
Antec S10	\N	ATX Full Tower	Black	\N	\N	\N	6
In Win H-Tower	\N	ATX Full Tower	Silver	\N	\N	\N	1
DIYPC DIY-N8	\N	MicroATX Mini Tower	White	\N	Acrylic	\N	2
Lian Li PC-TU300	\N	ATX Mid Tower	Silver	\N	\N	\N	2
Antec GX1000	\N	ATX Mid Tower	Black	\N	\N	\N	6
Antec GX900	\N	ATX Mid Tower	Black / Green	\N	\N	\N	3
Antec P280	\N	ATX Mid Tower	Black	\N	Acrylic	68	6
Antec P380	\N	ATX Full Tower	Black	\N	Acrylic	\N	8
Antec Three Hundred U3	\N	ATX Mid Tower	Black	\N	\N	\N	0
DIYPC D780	\N	ATX Full Tower	Black	\N	Acrylic	\N	8
DIYPC DIY-BJ03	\N	ATX Mid Tower	Black	\N	\N	\N	3
DIYPC F1	\N	MicroATX Mini Tower	White	\N	Acrylic	\N	2
DIYPC G580	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
DIYPC P28	\N	ATX Mid Tower	Black	\N	\N	\N	3
DIYPC P48	\N	ATX Mid Tower	Black	\N	\N	\N	3
DIYPC S280	\N	ATX Mid Tower	Black	\N	Acrylic	\N	4
DIYPC S280	\N	ATX Mid Tower	White	\N	Acrylic	\N	4
DIYPC Skyline-08	\N	ATX Full Tower	White	\N	Acrylic	\N	3
DIYPC Zetta	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
DIYPC Zetta	\N	ATX Mid Tower	White	\N	Acrylic	\N	2
DIYPC DIY-M6	\N	MicroATX Mid Tower	Black / Red	\N	Acrylic	\N	2
Antec X1-T	\N	ATX Mid Tower	Black	\N	Acrylic	\N	8
Apevia X-EnerQ	\N	MicroATX Mid Tower	Black / Blue	\N	Acrylic	\N	2
Apevia X-EnerQ	\N	MicroATX Mid Tower	Black / Pink	\N	Acrylic	\N	2
Apevia X-EnerQ	\N	MicroATX Mid Tower	White / Black	\N	Acrylic	\N	2
Enermax ECA3291A	\N	ATX Mid Tower	Black	\N	Acrylic	\N	7
Apevia X-Qber	\N	MicroATX Desktop	Black / Blue	\N	Acrylic	\N	2
Apevia X-Qber	\N	MicroATX Desktop	Black	\N	\N	\N	2
Anidees AI7	\N	ATX Desktop	Black	\N	\N	\N	4
Anidees AI8	\N	ATX Full Tower	Black	\N	\N	\N	4
Powertek PT-eviltek-case100	\N	ATX Mid Tower	Black	\N	Acrylic	\N	6
VIVO CASE-V00	\N	ATX Mini Tower	Black	\N	\N	\N	2
Silverstone FT01-B	\N	ATX Mid Tower	Silver	\N	\N	51.7	7
Silverstone FT01-B	\N	ATX Mid Tower	Silver	\N	Acrylic	51.7	7
Silverstone FT01B-USB3.0	\N	ATX Mid Tower	Silver	\N	\N	\N	7
Silverstone FT01B-USB3.0	\N	ATX Mid Tower	Silver	\N	Acrylic	\N	7
Raidmax Narwhal	\N	ATX Full Tower	Black / Silver	\N	Acrylic	\N	6
DIYPC Gamestorm	\N	ATX Mid Tower	Black	\N	Acrylic	\N	5
DIYPC Gamestorm	\N	ATX Mid Tower	White	\N	Acrylic	\N	5
Azza Taurus 5000W	\N	ATX Full Tower	White	\N	Acrylic	\N	8
RIOTORO CR280	\N	Mini ITX Desktop	Black / Red	\N	Acrylic	\N	1
Antec P9	\N	ATX Full Tower	Black	\N	Acrylic	97.3	8
Jonsbo UMX4 Zone	\N	ATX Mid Tower	Black	\N	\N	38	2
Jonsbo UMX4 Zone	\N	ATX Mid Tower	Black	\N	Tempered Glass	38	2
Jonsbo UMX4 Zone	\N	ATX Mid Tower	Silver	\N	Tempered Glass	38	2
Aerocool VS-1	\N	ATX Mid Tower	Black	\N	Acrylic	30.7	2
Silverstone RV05B	\N	ATX Mid Tower	White / Black	\N	\N	63.8	2
Silverstone RV05B	\N	ATX Mid Tower	White / Black	\N	Acrylic	63.8	2
SHARKOON T3-W	\N	ATX Mid Tower	Black / Red	\N	Acrylic	38.3	6
BitFenix Aurora	\N	ATX Mid Tower	White	\N	Tempered Glass	54.8	4
DIYPC DIY-G3	\N	ATX Mid Tower	Black / Red	\N	Acrylic	43.8	2
Anidees AI6V2	\N	ATX Mid Tower	Black	\N	\N	\N	7
Aerocool XPredator II	\N	ATX Full Tower	Black / Red	\N	Acrylic	77.2	8
NOX Coolbay SX	\N	ATX Mid Tower	Black / Green	\N	\N	37.9	4
NOX Coolbay ZX	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	48.7	3
NOX Coolbay ZX	\N	ATX Mid Tower	Black / Red	\N	Acrylic	48.7	3
NOX Coolbay VX	\N	ATX Mid Tower	Black / Green	\N	Acrylic	34.3	7
NOX Coolbay VX	\N	ATX Mid Tower	White / Black	\N	Acrylic	34.3	7
Deepcool LANDKING	\N	ATX Mid Tower	Gray	\N	Acrylic	57.5	5
RAIJINTEK Metis	\N	Mini ITX Tower	Green	\N	Acrylic	13.4	1
RAIJINTEK Metis	\N	Mini ITX Tower	White	\N	\N	13.4	1
RAIJINTEK Metis	\N	Mini ITX Tower	White	\N	Acrylic	13.4	1
Raidmax Viper GX II	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	65.6	3
Lian Li PC-O9	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	79.3	6
Lian Li PC-O9	\N	ATX Mid Tower	Black	\N	Tempered Glass	79.3	6
Silverstone RL05	\N	ATX Mid Tower	Black	\N	Acrylic	43.9	2
Silverstone RL05	\N	ATX Mid Tower	Black / White	\N	Acrylic	43.9	2
RAIJINTEK Metis Plus	\N	Mini ITX Tower	Green	\N	Acrylic	13.4	2
RAIJINTEK Metis Plus	\N	Mini ITX Tower	Gold	\N	Acrylic	13.4	2
RAIJINTEK Metis Plus	\N	Mini ITX Tower	Silver	\N	Acrylic	13.4	2
Rosewill GRAM	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
BitFenix Portal	\N	Mini ITX Tower	Black	\N	\N	\N	2
BitFenix Portal	\N	Mini ITX Tower	White	\N	\N	\N	2
Azza Photios 250X	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Thermaltake Core X31 TG	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	6
Silverstone PM01	\N	ATX Mid Tower	Black	\N	Acrylic	70.3	4
Anidees Crystal	\N	ATX Mid Tower	Black / White	\N	Tempered Glass	\N	3
mean:it 4PM	\N	ATX Desktop	Black	\N	Tempered Glass	48	3
VIVO CASE-V08	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	\N	3
Logisys CS368BB	\N	ATX Mid Tower	Black / Red	480	\N	34	6
mean:it 5PM	\N	ATX Mid Tower	Black	\N	Tempered Glass	51.5	3
Aerocool Aero-500 - B	\N	ATX Mid Tower	Black	\N	\N	45.1	4
Aerocool Aero-500 - BC	\N	ATX Mid Tower	Black	\N	\N	45.1	4
Aerocool Aero-500 - C	\N	ATX Mid Tower	Black	\N	\N	45.1	4
Aerocool Aero-500	\N	ATX Mid Tower	White / Black	\N	\N	45.1	4
Aerocool Aero-500 - B	\N	ATX Mid Tower	White / Black	\N	\N	45.1	4
Aerocool Aero-500 - BC	\N	ATX Mid Tower	White / Black	\N	\N	45.1	4
Aerocool Aero-500 - C	\N	ATX Mid Tower	White / Black	\N	\N	45.1	4
Aerocool Aero-500 - BC	\N	ATX Mid Tower	Black	\N	Acrylic	45.1	4
Aerocool Aero-500 - BC	\N	ATX Mid Tower	Blue / Black	\N	Acrylic	45.1	4
Aerocool Aero-500 - C	\N	ATX Mid Tower	Blue / Black	\N	Acrylic	45.1	4
Aerocool Aero-500 - BC	\N	ATX Mid Tower	Gray / Black	\N	Acrylic	45.1	4
Aerocool Aero-500 - C	\N	ATX Mid Tower	Gray / Black	\N	Acrylic	45.1	4
Aerocool Aero-500 - BC	\N	ATX Mid Tower	White / Black	\N	Acrylic	45.1	4
Nanoxia CoolForce 1	\N	ATX Mid Tower	Black	\N	\N	\N	3
NZXT SCM-01	\N	MicroATX Mini Tower	Black / Red	\N	\N	\N	3
DIYPC Illusion I	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	\N	2
Lian Li PC-T60	\N	ATX Test Bench	Red	\N	\N	45.6	3
Silverstone RL06	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	43.4	3
Silverstone RL06	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	43.4	3
Thermaltake Versa N27	\N	ATX Mid Tower	White	\N	Acrylic	\N	4
LEPA LPC306(2U3)	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
BitFenix Pandora ATX Core	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Apevia X-Harmony	\N	ATX Mid Tower	Black / Red	\N	Acrylic	39.3	2
Apevia X-Harmony	\N	ATX Mid Tower	White	\N	Acrylic	39.3	2
Lian Li PC-O5S	\N	HTPC	Black	\N	Tempered Glass	\N	5
Lian Li PC-O5S	\N	HTPC	White	\N	Tempered Glass	\N	5
In Win D-FRAME MINI	\N	Mini ITX Tower	Red	\N	Tempered Glass	46.3	3
In Win S-FRAME	\N	ATX Full Tower	Black / Gold	\N	Acrylic	131.3	4
Raidmax ATX-404WU	\N	ATX Mid Tower	Black / Green	450	Acrylic	\N	3
Raidmax ATX-404WU	\N	ATX Mid Tower	Black / Blue	450	Acrylic	\N	3
Lian Li PC-V33	\N	ATX Mid Tower	Silver	\N	Acrylic	\N	4
In Win D-FRAME MINI	\N	Mini ITX Tower	Black / Orange	\N	Acrylic	46.3	3
Lian Li PC-D600	\N	ATX Full Tower	Silver	\N	Acrylic	\N	6
Lian Li PC-X510	\N	ATX Mid Tower	Black	\N	Acrylic	\N	6
Lian Li PC-M25	\N	MicroATX Mini Tower	Silver	\N	\N	\N	8
Lian Li PC-7N	\N	ATX Mid Tower	Black	\N	\N	\N	4
Silverstone SG03B-F	\N	MicroATX Mini Tower	Black	\N	Acrylic	22.2	0
Enermax OSTROG Lite	\N	ATX Mid Tower	Gray	\N	Acrylic	\N	2
Anidees AI Crystal Cube	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.5	3
Anidees AI Crystal Cube	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	50.5	3
SHARKOON AM5	\N	ATX Mid Tower	Blue / Black	\N	\N	\N	3
Cooltek UMX3	\N	MicroATX Mini Tower	Silver	\N	Acrylic	24.6	1
Cooler Master MB600L ODD	\N	ATX Mid Tower	Black / Silver	\N	Acrylic	\N	2
Cooler Master MB600L ODD	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	2
In Win EN028.TH350B	\N	MicroATX Mini Tower	\N	350	\N	\N	2
VIVO CASE-V10G	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	34.8	2
Thermaltake Versa N25	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
In Win 305	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
Enermax GraceMESH	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Enermax GraceMESH	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	\N	2
Enermax GraceMESH	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	\N	2
EVGA DG-76	\N	ATX Mid Tower	\N	\N	Tempered Glass	48.6	2
LDLC MX-1	\N	ATX Mid Tower	Black	\N	\N	\N	3
LDLC MX-1	\N	ATX Mid Tower	Silver	\N	\N	\N	3
Nanoxia Rexgear 1	\N	MicroATX Desktop	Black / Orange	\N	Acrylic	\N	3
Nanoxia Rexgear 1	\N	MicroATX Desktop	Green / Black	\N	Acrylic	\N	3
In Win D-FRAME MINI	\N	Mini ITX Tower	Blue	\N	Tempered Glass	46.3	3
In Win D-FRAME MINI	\N	Mini ITX Tower	White	\N	Tempered Glass	46.3	3
Thermaltake View 37	\N	ATX Mid Tower	Black	\N	Acrylic	73.7	3
Nanoxia NXDS5B	\N	ATX Full Tower	White / Black	\N	\N	\N	11
Chieftec FI-01B-U3	\N	Mini ITX Desktop	Black / Silver	250	\N	\N	1
Chieftec FI-01B-U3	\N	Mini ITX Desktop	Black / Silver	250	\N	\N	1
Chieftec FI-01B-U3	\N	Mini ITX Desktop	Black	250	\N	\N	1
DIYPC Model X	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Lian Li PC-Q50	\N	Mini ITX Desktop	Black	\N	\N	\N	2
RIOTORO CR1088	\N	ATX Mid Tower	Black / Red	\N	Acrylic	32.6	2
Cougar Turret	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	\N	2
RAIJINTEK ASTERION CLASSIC	\N	ATX Full Tower	Silver	\N	Tempered Glass	56	3
RAIJINTEK ASTERION PLUS	\N	ATX Full Tower	\N	\N	Acrylic	59.3	3
RAIJINTEK COEUS ELITE	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	50.5	3
RAIJINTEK COEUS EVO TC	\N	ATX Full Tower	Black	\N	Tempered Glass	56.8	0
RAIJINTEK R206-ITX	\N	MicroATX Mini Tower	White	\N	\N	39.1	1
Silverstone FTZ01-E	\N	Mini ITX Desktop	Silver	\N	\N	\N	0
Cooler Master MasterBox E300L	\N	MicroATX Mini Tower	Black / Red	\N	\N	\N	2
In Win 101 PRGB1	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	48.3	2
In Win 101C PRGB2	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	\N	2
In Win 101C PRGB2	\N	ATX Mid Tower	White / Blue	\N	Tempered Glass	\N	2
Cooler Master MasterBox E500L	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Cooler Master MasterBox E500L	\N	ATX Mid Tower	Black / Red	\N	\N	\N	2
Rosewill CULLINAN PX	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	\N	2
Rosewill CULLINAN PX	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	\N	2
RIOTORO CR488	\N	ATX Mid Tower	Black / Red	\N	Acrylic	\N	2
Cooler Master MasterBox MB510L	\N	ATX Mid Tower	Black / Blue	\N	Acrylic	\N	2
Cooler Master MasterBox MB510L	\N	ATX Mid Tower	Black / White	\N	Acrylic	\N	2
Xigmatek Frontliner	\N	ATX Mid Tower	White	\N	Acrylic	45.1	2
Thermaltake Versa J22 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Thermaltake Versa J23	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
MagniumGear NEO MICRO	\N	MicroATX Mid Tower	Silver	\N	Acrylic	\N	2
MagniumGear NEO MICRO	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	2
MagniumGear NEO MINI	\N	Mini ITX Tower	Black	\N	Acrylic	\N	1
Aerocool CruiseStar Advance	\N	ATX Mid Tower	Black	\N	\N	\N	3
DIYPC Crystal-P3	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
In Win 915	\N	ATX Full Tower	Black	\N	Tempered Glass	\N	4
Spartex Osmi	\N	Mini ITX Tower	Black	\N	\N	\N	1
Spartex Osmi	\N	Mini ITX Tower	White	\N	\N	\N	1
Apevia X-Infinity	\N	ATX Mid Tower	Pink / Black	\N	Acrylic	42.7	5
Antec P7 Window	\N	ATX Mid Tower	Black / Green	\N	Acrylic	\N	2
DIYPC D480	\N	ATX Mid Tower	White	\N	Acrylic	\N	2
AvP Hyperion EV33	\N	MicroATX Mini Tower	Black	\N	\N	\N	1
AvP Hyperion EV33	\N	MicroATX Mini Tower	White	\N	\N	\N	1
DIYPC DIY-Line-RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
DIYPC DIY-SD1-RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Cooltek MT-03	\N	MicroATX Mini Tower	Black	\N	\N	\N	2
Thermaltake Commander C32 TG ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Thermaltake Commander C35 TG ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Thermaltake Commander C33 TG ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Azza Cube 802	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	1
Azza APOLLO 430 (Hurricane II)	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.3	4
Azza APOLLO 430 (Hurricane II)	\N	ATX Mid Tower	White	\N	Tempered Glass	41.3	4
HEC HX210	\N	MicroATX Mini Tower	Black	\N	Acrylic	35.5	2
HEC HX310	\N	ATX Mid Tower	Black	\N	Acrylic	35.4	2
HEC HX320	\N	ATX Mid Tower	Black	\N	Acrylic	35.4	2
GameMax California	\N	ATX Mid Tower	Black	\N	Acrylic	52.5	3
GameMax Gamboge	\N	ATX Mid Tower	Black / Orange	\N	Acrylic	46.4	2
GameMax Graphite	\N	ATX Mid Tower	Black	\N	Acrylic	47.7	2
GameMax Kage	\N	ATX Mid Tower	Black	\N	Tempered Glass	42	2
GameMax Mini Kallis	\N	MicroATX Mini Tower	Black	\N	Acrylic	29.9	2
GameMax Osmium	\N	ATX Mid Tower	Black	\N	Tempered Glass	46.7	2
GameMax Phantom	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.7	1
GameMax Proteus	\N	ATX Mid Tower	Black	\N	\N	34.3	4
GameMax Saber	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.8	2
GameMax Solar	\N	ATX Mid Tower	White	\N	Tempered Glass	40.1	1
GameMax Vanguard VR2	\N	ATX Mid Tower	Black	\N	Tinted Acrylic	57.6	2
Aerocool Shard-G	\N	ATX Mid Tower	\N	\N	Tempered Glass	36.5	2
BitFenix Nova Mesh TG 4ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.4	2
DIYPC DIY-A1-BK	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
DIYPC Mirage-ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	38.9	2
Fractal Design Vector RS	\N	ATX Mid Tower	Black	\N	Tempered Glass	64.1	6
DIYPC VII-BK-ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	38.9	2
Apevia X-Infinity	\N	ATX Mid Tower	White / Black	\N	Acrylic	42.7	5
In Win A1 Plus Phantom Gaming Edition	\N	Mini ITX Tower	Black / Red	650	Tempered Glass	21.8	0
RAIJINTEK 0R20B00158	\N	Mini ITX Tower	Pink	\N	Acrylic	13.4	2
RAIJINTEK METIS EVO TGS	\N	Mini ITX Desktop	Silver	\N	Tempered Glass	22.3	2
RAIJINTEK METIS EVO TGS	\N	Mini ITX Desktop	Blue	\N	Tempered Glass	22.3	2
RAIJINTEK METIS EVO TGS	\N	Mini ITX Desktop	Pink	\N	Tempered Glass	22.3	2
RAIJINTEK METIS EVO ALS	\N	Mini ITX Desktop	Black	\N	\N	22.3	2
RAIJINTEK METIS EVO ALS	\N	Mini ITX Desktop	White	\N	\N	22.3	2
RAIJINTEK METIS EVO ALS	\N	Mini ITX Desktop	Red	\N	\N	22.3	2
RAIJINTEK METIS EVO ALS	\N	Mini ITX Desktop	Pink	\N	\N	22.3	2
BitFenix Nova Mesh TG	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.4	2
In Win 905-SILOLED	\N	ATX Mid Tower	Silver / Black	\N	Tinted Tempered Glass	\N	1
Silverstone SG13 V2	\N	Mini ITX Tower	Black	\N	\N	11.5	1
Silverstone SG13 V2	\N	Mini ITX Tower	White / Black	\N	\N	11.5	1
In Win Z-Tower	\N	ATX Full Tower	Silver	\N	\N	\N	2
Raidmax Monster II SE	\N	ATX Mid Tower	White / Silver	\N	Tempered Glass	\N	2
EG EGX211	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
Azza Optima 803	\N	ATX Mid Tower	Black	\N	Tempered Glass	71.1	2
SilentiumPC Regnum RG4T RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	46.8	3
Cougar TROFEO	\N	ATX Mid Tower	Silver / Black	\N	Tempered Glass	\N	2
Aerocool DS Cube	\N	MicroATX Mini Tower	Black / Green	\N	Acrylic	41.5	2
Aerocool DS Cube	\N	MicroATX Mini Tower	Black / Blue	\N	Acrylic	41.5	2
Nanoxia Rexgear 2 Limited Edition	\N	MicroATX Mini Tower	Black	\N	Acrylic	\N	3
Azza ARC 241	\N	ATX Mid Tower	Black	\N	Acrylic	\N	3
Chieftronic M1	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	\N	2
In Win Alice	\N	ATX Mid Tower	Gray / Orange	\N	\N	\N	1
In Win 216	\N	ATX Mid Tower	Black	\N	Tempered Glass	47.1	2
darkFlash V22	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	41.7	1
darkFlash V22	\N	ATX Mid Tower	Green	\N	Tempered Glass	41.7	1
Antec NX100	\N	ATX Mid Tower	Black / Gray	\N	Acrylic	37.7	2
BitFenix Nova Mesh SE	\N	ATX Mid Tower	Black / Red	\N	Tempered Glass	36.1	2
Jonsbo MOD-3	\N	ATX Mid Tower	Pink	\N	Tempered Glass	93.1	1
DIYPC DIY-A9-BK	\N	ATX Mid Tower	Black	\N	Tempered Glass	33.2	2
SilentiumPC Armis AR5	\N	ATX Mid Tower	Black	\N	\N	45.8	2
SilentiumPC Armis AR6	\N	ATX Mid Tower	Black	\N	\N	46	2
SilentiumPC Armis AR7	\N	ATX Mid Tower	Black	\N	\N	61.3	3
Azza Luminous 110RF1	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	36.1	2
Azza Luminous 110ADF	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	36.1	2
Raidmax EVOL H07	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	2
RAIJINTEK Silenos	\N	ATX Mid Tower	Black	\N	Tempered Glass	39.8	2
Corsair iCUE 5000X RGB Shift	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	66.2	2
Corsair iCUE 5000X RGB Glitch	\N	ATX Mid Tower	Black / Blue	\N	Tempered Glass	66.2	2
Tempest Ghost	\N	ATX Mid Tower	Black	\N	Tempered Glass	\N	3
Tempest Spook RGB	\N	ATX Mid Tower	Black	\N	Acrylic	\N	2
Aerocool Mecha v3	\N	ATX Mid Tower	Black	\N	Tempered Glass	33.5	2
Antec NX800	\N	ATX Mid Tower	Pink	\N	Tempered Glass	54	3
Aerocool Trinity Mini V1	\N	MicroATX Mini Tower	White	\N	Tempered Glass	28.1	2
Aerocool Trinity Mini V2	\N	MicroATX Mini Tower	White	\N	Tempered Glass	28.1	2
Aerocool Trinity Mini V1	\N	MicroATX Mini Tower	Pink	\N	Tempered Glass	28.1	2
Aerocool Trinity Mini V2	\N	MicroATX Mini Tower	Pink	\N	Tempered Glass	28.1	2
DIYPC DIY D2 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	38.4	2
DIYPC DIY D2 RGB	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	38.4	2
Golden Field N-1	\N	Mini ITX Desktop	Black	\N	\N	17.2	1
BitFenix BitFenix Neos Window BFC-NEO-100-WWWKS-RP White Steel / Plastic ATX Mid Tower Computer Case	\N	ATX Mid Tower	White / Silver	\N	Acrylic	37	3
Geometric Future Model 6	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	43.5	4
Geometric Future Model 6	\N	ATX Mid Tower	Black / White	\N	Tinted Tempered Glass	43.5	4
Geometric Future Model 6	\N	ATX Mid Tower	Black	\N	Tinted Tempered Glass	43.5	4
Geometric Future Model 8	\N	ATX Mid Tower	White / Multicolor	\N	Tinted Tempered Glass	57.5	3
Geometric Future Model 6	\N	ATX Mid Tower	White / Gray	\N	Tinted Tempered Glass	43.5	4
Geometric Future Model 6	\N	ATX Mid Tower	White / Gray	\N	Tinted Tempered Glass	43.5	4
Vetroo A03	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	\N	2
Cougar MG140 RGB	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	35.3	2
Cougar MG140 RGB	\N	MicroATX Mini Tower	Black / Gray	\N	Tempered Glass	35.3	2
Cougar MX430 Mesh RGB	\N	ATX Mid Tower	Black / Gray	\N	Tempered Glass	37.6	2
Thermaltake AH T200	\N	MicroATX Mid Tower	Green / Black	\N	Tempered Glass	69.1	2
MSI MAG SHIELD 110A	\N	ATX Mid Tower	Black	\N	Tempered Glass	36.5	2
Azza Octane B	\N	ATX Mid Tower	Black	\N	Tempered Glass	44.8	2
Azza Raven 420F	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.8	6
Azza Raven 420LF	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.8	6
Azza Inferno 310DH	\N	ATX Mid Tower	Black	\N	Tempered Glass	46.7	2
Azza Golem 221	\N	ATX Mid Tower	Black	\N	Acrylic	40.4	3
Azza Zircon 7000W	\N	ATX Full Tower	White	\N	Tempered Glass	61.8	5
Azza Bastion 120	\N	MicroATX Mid Tower	Black	\N	Tempered Glass	35.9	2
Deepcool D-Shield V2	\N	ATX Mid Tower	Black	\N	Acrylic	44	2
Lazer3D LZX-8 Storm	\N	Mini ITX Desktop	Black / White	\N	\N	8.6	0
Lian Li PC-8FI	\N	ATX Mid Tower	Black / Silver	\N	\N	80.4	6
Lian Li PC-8FI	\N	ATX Mid Tower	Silver	\N	\N	80.4	6
Lian Li PC-8FI	\N	ATX Mid Tower	Red / Silver	\N	\N	80.4	6
Cougar Dust 2	\N	Mini ITX Tower	Black / Silver	\N	Mesh	23.6	0
Cougar MX440 Mesh RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	46	2
Cougar MX660-T	\N	ATX Mid Tower	Black	\N	Tempered Glass	50	2
Cougar MX660 Iron RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	50	2
Cougar MX660 Iron RGB	\N	ATX Mid Tower	Black / Green	\N	Tempered Glass	50	2
Cougar MX660-T RGB-L	\N	ATX Mid Tower	Black	\N	Tempered Glass	50	2
Cougar MX660 Mesh RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	50	2
Cougar MX660 Mesh RGB-L	\N	ATX Mid Tower	Black	\N	Tempered Glass	50	2
LC-Power 987B Silent Slinger	\N	ATX Mid Tower	Black / White	\N	Acrylic	44.1	2
SSUPD Meshroom S w/PCIe 4.0 Riser	\N	ATX Mini Tower	Yellow	\N	Mesh	14.9	0
Jonsbo V10	\N	Mini ITX Desktop	Silver / Black	\N	\N	18.2	0
Jonsbo V10	\N	Mini ITX Desktop	Silver / Black	\N	Tempered Glass	18.2	0
Anidees AI Atomic	\N	ATX Mid Tower	Black	\N	Mesh	19.5	1
CiT Blaze ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	31.4	2
Jonsbo UMX6	\N	ATX Full Tower	Black	\N	Tempered Glass	54.1	2
Jonsbo UMX6	\N	ATX Full Tower	Silver	\N	Tempered Glass	54.1	2
Jonsbo C5	\N	ATX Mid Tower	Silver	\N	Tempered Glass	34.5	4
Jonsbo V4	\N	MicroATX Mini Tower	\N	\N	\N	19.2	2
RAIJINTEK PAEAN PREMIUM	\N	ATX Mid Tower	Black	\N	Tempered Glass	90.6	2
OCPC MINI2	\N	Mini ITX Test Bench	Black	\N	\N	7.2	0
OCPC MINI2	\N	Mini ITX Test Bench	White	\N	\N	7.2	0
OCPC MINI	\N	Mini ITX Test Bench	Silver	\N	\N	7.2	0
OCPC MINI	\N	Mini ITX Test Bench	White / Blue	\N	\N	7.2	0
Noua Demon T4	\N	ATX Mid Tower	Black	\N	Tempered Glass	32.4	2
Noua Demon T6	\N	ATX Mid Tower	Black	\N	Tempered Glass	38.4	3
Noua Diamond C11	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.3	3
Noua Fobia L10	\N	MicroATX Mid Tower	Pink	\N	Tempered Glass	32.3	2
Noua Ego Z5	\N	ATX Full Tower	White	\N	Tempered Glass	104.6	2
Noua Iron V9	\N	ATX Mid Tower	White	\N	Tempered Glass	47.8	3
Noua Iron V8	\N	ATX Mid Tower	Black	\N	Tempered Glass	47.8	2
Noua Iron V1	\N	ATX Mid Tower	Black	\N	Tempered Glass	63	3
Noua Meta S16	\N	ATX Mid Tower	Black	\N	Tempered Glass	36.9	2
Noua Utopia F4	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.9	2
Noua Utopia F2	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.4	3
Noua Thor S15	\N	ATX Mid Tower	Black	\N	Tempered Glass	33.1	3
Cooler Master MasterBox MB400L with ODD	\N	MicroATX Mini Tower	Black	\N	Tempered Glass	36.7	2
Jonsbo Jonsplus i400	\N	ATX Mid Tower	Black	\N	\N	55.7	6
Azza Opus 809 (PCIE 4.0)	\N	ATX Mid Tower	Silver / Black	\N	Tinted Tempered Glass	\N	1
Jonsbo U5S	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.3	2
Jonsbo UMX4-PLUS	\N	ATX Full Tower	Silver	\N	Tempered Glass	54.1	2
Jonsbo UMX4-PLUS	\N	ATX Full Tower	Black	\N	Tempered Glass	54.1	2
In Win DUBILI DIY	\N	ATX Full Tower	Gray / Orange	\N	Tempered Glass	72.4	2
BGears ‎b-BlackWidow-RGB	\N	ATX Mid Tower	White	\N	Tinted Tempered Glass	41.2	2
FSP Group CUT593A	\N	ATX Full Tower	White	\N	Tempered Glass	62.6	3
FSP Group CUT593	\N	ATX Full Tower	White	\N	Tempered Glass	62.6	3
FSP Group CUT593	\N	ATX Full Tower	Black	\N	Tempered Glass	62.6	3
GAMDIAS ATHENA P1 LITE	\N	ATX Mid Tower	Black	\N	Tempered Glass	49.6	2
MagniumGear NEO Silent (2023)	\N	ATX Mid Tower	Black	\N	Tempered Glass	41.4	2
KOLINK Inspire K4	\N	ATX Mid Tower	Black	\N	Tempered Glass	33.4	2
KOLINK Inspire X1	\N	ATX Mid Tower	\N	\N	Tempered Glass	31.1	2
KOLINK Phalanx V2	\N	ATX Mid Tower	Black	\N	Tempered Glass	47.7	2
Aerocool Menace Saturn FRGB V2	\N	ATX Mid Tower	\N	\N	Tempered Glass	36.7	2
Antec P82 Silent	\N	ATX Mid Tower	Black	\N	\N	46.9	2
DIYPC DIY-Mesh	\N	ATX Mid Tower	Black	\N	Tempered Glass	31.3	2
DIYPC DIY-Mesh	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	31.3	2
DIYPC IDX2-ARGB	\N	ATX Mid Tower	Orange / Black	\N	Tempered Glass	46.9	4
DIYPC Rainbow-Flash-G1	\N	ATX Mid Tower	Black	\N	Tempered Glass	35.9	2
DIYPC S1-ARGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	36.8	2
GameMax AutoBot	\N	ATX Mid Tower	Silver / Black	\N	Tempered Glass	76.8	3
GameMax Brufen C3	\N	ATX Mid Tower	White / Blue	\N	Tempered Glass	42.2	2
GameMax Brufen C3	\N	ATX Mid Tower	White / Pink	\N	Tempered Glass	42.2	2
GameMax RockStar 2	\N	ATX Mid Tower	Black	\N	Tempered Glass	40.7	2
BitFenix Hades	\N	ATX Mid Tower	Black	\N	Tempered Glass	42.3	2
Enermax ENERPAZO EP237 RGB	\N	ATX Mid Tower	Black	\N	Tempered Glass	40	2
Gigabyte C301 GLASS V2	\N	ATX Mid Tower	Black	\N	Tempered Glass	50.6	2
CherryTree Borg Cube w/Lights	\N	ATX Desktop	Black	\N	\N	55.3	0
DARKROCK A8-M	\N	ATX Mid Tower	White	\N	Tempered Glass	\N	2
DARKROCK A8-X	\N	ATX Mid Tower	White	\N	Tempered Glass	42.5	2
SSUPD Meshroom S V2	\N	MicroATX Mini Tower	Green	\N	Mesh	14.9	2
Aerocool GT	\N	ATX Mid Tower	White	\N	Mesh	34.4	3
GameMax F36	\N	MicroATX Mini Tower	Black	\N	\N	35.1	2
RAIJINTEK Ponos Ultra TG4	\N	ATX Mid Tower	Black	\N	\N	46.3	2
RAIJINTEK Ponos Ultra MS4	\N	ATX Mid Tower	Black	\N	\N	46.3	2
GameMax F46	\N	ATX Mid Tower	Black	\N	\N	40.6	2
SHARKOON Skiller SGC1 Window	\N	ATX Mid Tower	Black	\N	Acrylic	47.5	2
SHARKOON Skiller SGC1 Window	\N	ATX Mid Tower	Red	\N	Acrylic	47.5	2
FSP Group CMT120A	\N	ATX Mid Tower	Black	\N	Acrylic	34.5	2
Axiom Nova C013	\N	ATX Mid Tower	White / Black	\N	Tempered Glass	38.5	1
Axiom Nova C013	\N	ATX Mid Tower	Pink	\N	Tempered Glass	38.5	1
APNX C1-R	\N	ATX Mid Tower	Black	\N	Tempered Glass	53.6	3
APNX C1-R	\N	ATX Mid Tower	White	\N	Tempered Glass	53.6	3
APNX C1-R	\N	ATX Mid Tower	Blue	\N	Tempered Glass	53.6	3
PC Cooler IE200	\N	ATX Mid Tower	Black	\N	Tempered Glass	48.1	2
GameMax Violin	\N	Mini ITX Desktop	Black	180	Mesh	5.2	0
GameMax Violin	\N	Mini ITX Desktop	Silver	180	Mesh	5.2	0
\.


--
-- TOC entry 5307 (class 0 OID 25696)
-- Dependencies: 253
-- Data for Name: usage_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usage_profiles (id, profile_name, description, logic_rules) FROM stdin;
\.


--
-- TOC entry 5278 (class 0 OID 25406)
-- Dependencies: 224
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at, role) FROM stdin;
2	Helo	hihi@gmail.com	\N	$2y$12$2FUwHX5BbD4fS50WF57BZebfb4qlgZz6IbC5Hrm3RK0NOJbW9uLz6	\N	2026-04-11 15:18:25	2026-04-11 15:18:25	user
3	hilo	abc@gmail.com	\N	$2y$12$rwpZkCwrbYzQRNXiBHVQcuN5vR3Ld9OeXRuS3elEvldXhSHK9bnei	\N	2026-04-11 15:28:16	2026-04-11 15:28:16	user
4	Pham Xuan Thang	user@gmail.com	\N	$2y$12$Epz5XTpSYJaUAtrapjNy0.3ms9vH9CWgvEp.ZMawSefwmV.ya2/1q	\N	2026-06-01 02:54:03	2026-06-01 02:54:03	user
1	Pham Xuan Thang	xthang260205@gmail.com	\N	$2y$12$ZvSZL2ueWr.GjR1C9yxC.OUo5puUMbQ1Y79hH3rYk8u13meCLvtiO	hVGEM1E6wE9DNrWyrjLWfC8jlyMhaf1MRp688bYfEAJbP5GHW7uFlnc8omhT	2026-04-11 04:37:19	2026-04-11 04:37:40	admin
\.


--
-- TOC entry 5296 (class 0 OID 25584)
-- Dependencies: 242
-- Data for Name: video_cards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.video_cards (component_id, chipset, memory, core_clock, boost_clock, color, length) FROM stdin;
762	Radeon RX 9070	16	2070	2520	Black / Silver	290
763	GeForce GTX 1650 SUPER	4	1530	1740	Black / Silver	180
764	GeForce RTX 3060 8GB	8	1320	1807	Black	235
765	GeForce GTX 1660 Ti	6	1500	1800	Black / Gray	226
766	GeForce RTX 2070	8	1410	1620	Silver / Black	226
768	GeForce RTX 5060	8	2280	2640	Black	300
769	GeForce RTX 3070	8	1500	1845	Black / Silver	275
770	GeForce GTX 1070	8	1670	1898	Black / Orange	291
771	GeForce RTX 4060	8	1830	2580	Black / Gold	300
772	GeForce RTX 5060 Ti	16	2407	2572	Black	245
773	GeForce RTX 3080 10GB	10	1440	1845	Black / Silver	252
774	GeForce RTX 3070	8	1500	1845	Black	290
775	Radeon RX 6700 XT	12	2321	2581	Black	260
777	GeForce RTX 5070 Ti	16	2300	2482	White / Gold	304
778	GeForce RTX 5060 Ti	8	2410	2617	Black	215
780	Radeon RX 6500 XT	4	2365	2820	Black	240
781	GeForce RTX 4070 SUPER	12	1980	2505	Black	261
783	Radeon RX 7800 XT	16	1295	2520	Black	322
784	GeForce GTX 980	4	1178	1279	Black / Red	289
785	GeForce RTX 3070	8	1500	1815	Black / Silver	300
786	GeForce GTX 1070	8	1607	1797	Black / Gray	267
787	GeForce RTX 3060 Ti LHR	8	1410	1695	Black / Gray	316
789	GeForce RTX 3080 10GB	10	1440	1725	Black	318
790	GeForce RTX 3080 10GB LHR	10	1440	1920	Black / Silver	336
792	GeForce GTX 970	4	1050	1178	Black / Blue	257
793	Radeon RX 580	8	1405	1425	Black / White	279
794	GeForce RTX 2060 SUPER	8	1470	1695	Black / Silver	248
795	GeForce RTX 2060 SUPER	8	1470	1650	Black	281
796	Radeon RX 9070	16	2120	2610	Black	312
798	Radeon RX 9070	16	2070	2520	Black	289
800	GeForce GTX 1080 Ti	11	1480	1582	Black / Silver	267
802	GeForce RTX 3060 8GB	8	1320	1867	Black	200
803	GeForce RTX 2080 Ti	11	1350	1560	Black	305
806	GeForce RTX 5060	8	2280	2677	Black	302
807	GeForce RTX 5060 Ti	8	2410	2602	Black	304
808	Radeon RX 5700 XT	8	1605	1905	Black	293
809	RTX 4500 Ada Generation	24	2070	2580	Black / Gold	245
810	GeForce GTX 1070	8	1594	1784	Black / Silver	267
811	Radeon RX 7800 XT	16	1295	2475	Black	267
813	Radeon RX 7900 XT	20	2000	2400	Black	276
814	GeForce RTX 3070 LHR	8	1500	1845	Black / Silver	275
815	GeForce RTX 3090 Ti	24	1560	1890	Black	300
816	GeForce RTX 3070 LHR	8	1500	1770	Black	282
817	GeForce RTX 3060 Ti LHR	8	1410	1890	Black / Silver	318
818	GeForce RTX 2080 Ti	11	1350	1755	Black	327
819	GeForce RTX 5070	12	2160	2557	Black	303
820	GeForce RTX 3060 12GB	12	1320	1777	Black	224
821	Radeon RX 9070 XT	16	1660	2970	White	360
824	GeForce RTX 3050 8GB	8	1550	1890	Black / Silver	300
825	GeForce RTX 3050 6GB	6	1040	1470	Gray / Black	222
827	GeForce RTX 5060	8	2280	2550	Black	220
830	Radeon RX VEGA 64	8	1247	1546	Silver / Red	282
831	GeForce RTX 3050 6GB	6	1040	1470	Black	151
832	GeForce GTX 1650 G6	4	1410	1620	Black / Silver	178
833	Radeon RX 580	8	1257	1366	Black / White	269
834	GeForce RTX 4090	24	2235	2580	Black / Silver	356
835	Radeon RX 6800	16	1850	2190	Black	340
836	GeForce RTX 2070	8	1410	1860	Black	308
837	GeForce RTX 4070	12	1920	2520	Silver / Black	308
838	GeForce RTX 5090	32	2010	2422	White / Copper	330
839	GeForce RTX 3090	24	1395	1815	Black	356
840	GeForce RTX 3090	24	1395	1755	Black / Gray	320
841	Radeon RX 9070 XT	16	1660	2970	White	325
842	Radeon RX 6800 XT	16	1850	2285	Silver / Black	324
843	Radeon RX 9070 XT	16	2520	3060	Black	331
844	Radeon RX 7800 XT	16	1295	2565	Black / Silver	326
847	Radeon RX 570	8	1168	1286	Black / Red	243
849	Radeon RX 7600	8	1875	2655	Black	241
850	Radeon RX 6600	8	1626	2491	Black	200
852	Quadro P400	2	1070	1170	Black	145
854	GeForce RTX 4060 Ti	16	2310	2625	Black	199
855	Radeon RX 6750 XT	12	2150	2623	Black / Gray	296
856	GeForce GTX 980	4	1291	1393	Black / Red	280
858	GeForce RTX 2080 SUPER	8	1650	1815	Black	270
859	GeForce RTX 3060 12GB	12	1320	1837	Black / Gray	282
860	GeForce GTX 1080	8	1607	1733	Black / Gray	267
861	GeForce RTX 2060	6	1365	1710	Black	190
862	GeForce RTX 4080 SUPER	16	2210	2550	Black	307
863	Quadro M5000	8	861	1038	Black / Green	267
864	GeForce GTX 1660 SUPER	6	1530	1830	Black	202
867	GeForce RTX 2070 SUPER	8	1605	1785	Silver / Black	258
868	GeForce RTX 3090 Ti	24	1560	1920	Black	325
869	GeForce GTX 1060 6GB	6	1544	1759	Black / White	275
871	GeForce RTX 3050 6GB	6	1040	1477	Black	181
874	GeForce RTX 3050 8GB	8	1550	1807	Black / Gray	205
876	Arc A750	8	2050	2200	Blue / Black	222
880	GeForce RTX 4080 SUPER	16	2210	2565	Black	340
881	Radeon RX 6500 XT	4	2310	2825	Black / Silver	232
883	GeForce RTX 4070 SUPER	12	1980	2550	Black	227
884	GeForce GTX 1060 6GB	6	1506	1847	Black / Orange	278
888	GeForce RTX 3060 Ti	8	1410	1710	Black	202
893	GeForce RTX 3070 Ti	8	1575	1830	Black / Silver	317
895	GeForce RTX 5060	8	2280	2512	White	197
896	GeForce GTX 1070	8	1632	1860	Black	298
897	Radeon PRO W7600	8	1720	2440	Black	241
900	GeForce RTX 5060 Ti	16	2410	2572	Black	208
901	Quadro K1200	4	1058	1124	Black / Green	160
902	GeForce RTX 5080	16	2300	2640	Black / Copper	304
903	GeForce RTX 4070 SUPER	12	1980	2640	White / Blue	330
904	GeForce RTX 4070 Ti	12	2310	2640	Black	305
906	GeForce RTX 4090	24	2235	2595	Black	326
911	GeForce RTX 5070 Ti	16	2300	2467	Black	303
912	GeForce GTX 1080 Ti	11	1480	1582	Black / Silver	267
913	GeForce RTX 2080 Ti	11	1350	1545	Black / Clear	270
915	GeForce GTX 1060 6GB	6	1620	1847	Black	267
917	GeForce RTX 4080	16	2205	2520	Black	322
918	Radeon RX 9060 XT	16	2220	3320	Black / Silver	320
919	GeForce RTX 5060	8	2280	2580	Black	280
920	Radeon RX 9060 XT	16	2220	3320	White	290
923	GeForce GTX 1070 Ti	8	1607	1683	Black / White	279
925	Quadro P2000	5	1370	1470	Black	201
926	GeForce RTX 2080	8	1515	1710	Silver / Black	268
929	Radeon RX 9070	16	2070	2700	Black / Silver	297
931	GeForce RTX 5060	8	2280	2497	Black	200
932	GeForce RTX 3060 12GB	12	1320	1807	Black	224
936	GeForce GTX 1080 Ti	11	1480	1582	Silver / Black	300
938	GeForce GTX 1070	8	1506	1683	Black / Silver	267
941	GeForce RTX 3080 Ti	12	1365	1770	Black	320
944	Radeon RX 580	8	1257	1380	Black	298
947	Quadro P4000	8	1227	1480	Black / Green	242
948	Radeon RX 9070 XT	16	2400	2970	White / Gray	298
952	GeForce RTX 4070 Ti SUPER	16	2340	2655	White / Silver	300
955	GeForce GTX 1070	8	1531	1746	Black / Orange	169
958	Radeon RX 9070	16	2210	2700	White	320
960	GeForce RTX 4080 SUPER	16	2210	2595	Black	332
962	Arc B580	12	2670	2740	Blue / White	317
963	Radeon RX 6600	8	1626	2491	Black / Silver	243
966	GeForce RTX 2070	8	1410	1740	Black / Silver	309
968	Radeon RX 5500 XT	8	1685	1845	Black / Yellow	241
969	GeForce GTX 1070 Ti	8	1607	1683	Silver / Black	267
970	GeForce GTX 1060 6GB	6	1506	1708	Black	267
971	GeForce RTX 5070	12	2325	2542	Black / Silver	300
973	GeForce GTX 980 Ti	6	1102	1190	Black / Silver	267
974	GeForce RTX 3080 12GB LHR	12	1260	1740	Black / Gray	305
976	Radeon RX 7900 XT	20	2000	2500	Black	320
977	GeForce GT 1030	2	1290	1544	Black	145
980	GeForce RTX 3080 12GB LHR	12	1260	1755	Black	285
982	GeForce RTX 5060 Ti	8	2410	2602	Black	220
986	Radeon RX 6800 XT	16	1825	2310	Black / Silver	324
987	GeForce GTX 1070 Ti	8	1607	1683	Black / Silver	267
988	Radeon Pro WX 5100	8	926	1206	Blue	173
993	GeForce RTX 4080 SUPER	16	2210	2625	Copper / Black	312
995	Radeon RX 580	8	1340	1380	Red / Black	270
997	GeForce RTX 3060 Ti LHR	8	1410	1770	Black	281
1002	Radeon RX 6650 XT	8	2055	2694	Black	251
1003	Radeon RX 9070 XT	16	1870	3100	White	360
1006	Quadro RTX 8000	48	1395	1770	Black / White	267
1011	GeForce RTX 2080 Ti	11	1350	1635	Black / Silver	302
1012	GeForce GTX 1080 Ti	11	1480	1582	Black / Silver	267
1015	Radeon RX 5700 XT	8	1650	1905	Black	240
1016	GeForce GTX 1080	8	1708	1847	Black / Beige	312
1017	T600	4	735	1335	Black / Gray	156
1019	GeForce RTX 5060 Ti	8	2410	2572	Black	220
1021	GeForce RTX 5060 Ti	8	2410	2572	Black	262
1022	Quadro M2000	4	872	1180	Black	168
1023	GeForce GTX 970	4	1101	1241	Black / Blue	266
1025	GeForce GTX 980 Ti	6	1000	1291	Black / Gold	277
1026	GeForce GTX 1060 3GB	3	1607	1835	Black / Silver	267
1029	GeForce RTX 2060	6	1365	1680	Black	168
1030	Quadro P620	2	1266	1354	Black	145
1032	Radeon RX 6900 XT	16	1825	2365	Black / White	310
1033	GeForce GTX 1060 6GB	6	1556	1771	Black / Silver	210
1037	GeForce RTX 3090	24	1395	1875	Silver	336
1047	GeForce RTX 2060	6	1365	1710	Gray / Black	231
1049	GeForce RTX 4080	16	2205	2505	Black	332
1050	GeForce RTX 4090	24	2235	2535	Black	322
1052	GeForce RTX 2060 SUPER	8	1500	1680	Black	268
1056	GeForce GTX 1070 Ti	8	1607	1683	Black / Red	279
1061	GeForce GTX 1660 SUPER	6	1530	1785	Black	168
1064	Radeon RX 7900 XT	20	2000	2400	Black	276
1065	GeForce RTX 5050	8	2317	2617	Black	197
1066	TITAN RTX	24	1350	1770	Gold / Black	267
1067	GeForce RTX 5070 Ti	16	2300	2482	Black / Gold	304
1070	GeForce RTX 3080 10GB LHR	10	1440	1800	Black	300
1073	GeForce RTX 3070	8	1500	1725	Black	265
1077	GeForce RTX 3060 Ti LHR	8	1410	1785	Black	296
1079	Quadro RTX 5000	16	1620	1815	Silver / Black	267
1080	GeForce RTX 5060 Ti	16	2410	2617	Black / Gray	227
1081	GeForce GTX 1650 G6	4	1410	1785	Black	206
1082	GeForce GTX 950 75W	2	1026	1228	White / Blue	210
1088	GeForce RTX 3080 10GB	10	1440	1920	Black / Silver	336
1089	Radeon RX 6900 XT	16	1825	2425	Silver / Black	324
1092	GeForce RTX 3050 8GB	8	1550	1807	Black	177
1093	GeForce GT 1030 DDR4	2	1151	1417	Black	150
1095	Radeon RX VEGA 56	8	1181	1520	Black / Red	270
1096	GeForce RTX 3090	24	1395	1920	Black	289
1098	GeForce GTX 1660 SUPER	6	1530	1815	Black / Silver	204
1100	GeForce RTX 5050	8	2317	2647	Black	202
1101	Arc B580	12	2670	2740	White / Silver	260
1103	Radeon RX 7900 GRE	16	1270	2395	Black	335
1104	GeForce RTX 2070 SUPER	8	1605	1800	Transparent	270
1106	RTX 4000 Ada Generation	20	1500	2175	Black	241
1107	GeForce GTX 1060 6GB	6	1632	1860	Black	267
1110	GeForce RTX 3080 10GB LHR	10	1440	1845	Black	319
1113	GeForce RTX 3050 6GB	6	1040	1492	Black	174
1118	GeForce GT 1030	2	1266	1506	Black / Blue	169
1122	Radeon RX 5700 XT	8	1670	1925	Black	232
1125	Radeon RX 6600 XT	8	1968	2589	Black / Silver	282
1129	GeForce GTX 1070 Ti	8	1607	1721	Black / Orange	280
1138	GeForce GTX Titan Black	6	889	980	Black / Silver	266
1145	GeForce GTX 750 Ti	2	1033	1111	Black / Orange	144
1146	GeForce GTX 1050 Ti	4	1290	1430	Black / Orange	172
1148	Radeon RX 7800 XT	16	1295	2430	Black	335
1149	Radeon RX 7600	8	1720	2725	White	303
1150	GeForce RTX 4090	24	2235	2550	Black	358
1154	GeForce RTX 5090	32	2010	2625	Black	329
1166	GeForce RTX 3060 12GB	12	1320	1807	Black	235
1172	GeForce RTX 2060	6	1365	1830	Black / Gray	247
1174	GeForce RTX 5080	16	2300	2620	Black	329
1176	GeForce GTX 1060 6GB	6	1544	1759	Black / White	188
1178	GeForce RTX 2080	8	1515	1845	Black	314
1179	Radeon RX 6500 XT	8	2420	2825	Black	240
1180	GeForce RTX 5060 Ti	8	2410	2587	Black / Gray	227
1186	GeForce RTX 2080 Ti	11	1350	1665	Black	305
1187	Radeon RX 9070 XT	16	2460	3060	White	340
1192	Radeon RX 6700 XT	12	2321	2622	Black	320
1193	Radeon RX 6600	8	1626	2491	Black	243
1194	GeForce GTX 980	4	1279	1380	Black	269
1197	GeForce RTX 3070	8	1500	1830	Black / Silver	323
1199	Radeon RX 7900 XTX	24	2300	2615	Black	330
1200	GeForce RTX 3090	24	1395	1695	Black	294
1205	GeForce GTX 1660 Ti	6	1500	1845	Black / Gray	206
1207	Radeon Pro WX 2100	2	925	1219	Blue	145
1214	GeForce RTX 5080	16	2300	2617	Black / Copper	304
1215	GeForce RTX 2060	6	1365	1755	Black / Gray	226
1219	GeForce RTX 3050 6GB	6	1040	1470	Pink	160
1220	GeForce GTX 980	4	1126	1216	Black / Silver	267
1222	GeForce RTX 5070	12	2325	2512	Black	300
1223	Radeon RX 6900 XT	16	1825	2525	Black	270
1224	GeForce GTX 980 Ti	6	1000	1076	Black / Silver	267
1229	GeForce RTX 3060 Ti LHR	8	1410	1695	Black / Gray	235
1231	Radeon RX 9070 XT	16	2460	3060	Black	340
1233	Radeon RX 7900 XTX	24	2300	2680	White	345
1238	Radeon RX 9070 XT	16	2400	3010	White	327
1243	Radeon RX 570	4	1168	1284	Black / Red	243
1246	Radeon RX 7900 XT	20	2000	2395	Black / Silver	312
1252	GeForce RTX 5070 Ti	16	2300	2580	Black	338
1254	Vega Frontier Edition	16	1440	1600	Blue / Gold	267
1256	GeForce RTX 4060 Ti	16	2310	2685	White	307
1259	GeForce GTX 1050 Ti	4	1341	1455	Black / White	215
1261	GeForce RTX 5070 Ti	16	2295	2572	Black	300
2331	GeForce RTX 3090 Ti	24	1560	1980	Silver / Black	293
\.


--
-- TOC entry 5315 (class 0 OID 25772)
-- Dependencies: 261
-- Data for Name: votes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.votes (id, user_id, post_id, vote_type, created_at) FROM stdin;
\.


--
-- TOC entry 5339 (class 0 OID 0)
-- Dependencies: 256
-- Name: build_components_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.build_components_id_seq', 1, false);


--
-- TOC entry 5340 (class 0 OID 0)
-- Dependencies: 263
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_id_seq', 3, true);


--
-- TOC entry 5341 (class 0 OID 0)
-- Dependencies: 250
-- Name: compatibility_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.compatibility_rules_id_seq', 1, false);


--
-- TOC entry 5342 (class 0 OID 0)
-- Dependencies: 248
-- Name: component_prices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.component_prices_id_seq', 1381, true);


--
-- TOC entry 5343 (class 0 OID 0)
-- Dependencies: 234
-- Name: component_types_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.component_types_id_seq', 8, true);


--
-- TOC entry 5344 (class 0 OID 0)
-- Dependencies: 236
-- Name: components_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.components_id_seq', 5049, true);


--
-- TOC entry 5345 (class 0 OID 0)
-- Dependencies: 246
-- Name: dealers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dealers_id_seq', 1, true);


--
-- TOC entry 5346 (class 0 OID 0)
-- Dependencies: 232
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- TOC entry 5347 (class 0 OID 0)
-- Dependencies: 229
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- TOC entry 5348 (class 0 OID 0)
-- Dependencies: 221
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 23, true);


--
-- TOC entry 5349 (class 0 OID 0)
-- Dependencies: 254
-- Name: pc_builds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pc_builds_id_seq', 1, false);


--
-- TOC entry 5350 (class 0 OID 0)
-- Dependencies: 258
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posts_id_seq', 2, true);


--
-- TOC entry 5351 (class 0 OID 0)
-- Dependencies: 252
-- Name: usage_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usage_profiles_id_seq', 1, false);


--
-- TOC entry 5352 (class 0 OID 0)
-- Dependencies: 223
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 4, true);


--
-- TOC entry 5353 (class 0 OID 0)
-- Dependencies: 260
-- Name: votes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.votes_id_seq', 1, false);


--
-- TOC entry 5072 (class 2606 OID 25736)
-- Name: build_components build_components_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.build_components
    ADD CONSTRAINT build_components_pkey PRIMARY KEY (id);


--
-- TOC entry 5025 (class 2606 OID 25461)
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- TOC entry 5022 (class 2606 OID 25450)
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- TOC entry 5054 (class 2606 OID 25622)
-- Name: cases cases_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_pkey PRIMARY KEY (component_id);


--
-- TOC entry 5085 (class 2606 OID 26148)
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- TOC entry 5066 (class 2606 OID 25684)
-- Name: compatibility_rules compatibility_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compatibility_rules
    ADD CONSTRAINT compatibility_rules_pkey PRIMARY KEY (id);


--
-- TOC entry 5060 (class 2606 OID 25657)
-- Name: component_prices component_prices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_prices
    ADD CONSTRAINT component_prices_pkey PRIMARY KEY (id);


--
-- TOC entry 5036 (class 2606 OID 25520)
-- Name: component_types component_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_types
    ADD CONSTRAINT component_types_pkey PRIMARY KEY (id);


--
-- TOC entry 5038 (class 2606 OID 25807)
-- Name: component_types component_types_type_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_types
    ADD CONSTRAINT component_types_type_name_key UNIQUE (type_name);


--
-- TOC entry 5040 (class 2606 OID 25530)
-- Name: components components_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT components_pkey PRIMARY KEY (id);


--
-- TOC entry 5044 (class 2606 OID 25559)
-- Name: cpu_coolers cpu_coolers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cpu_coolers
    ADD CONSTRAINT cpu_coolers_pkey PRIMARY KEY (component_id);


--
-- TOC entry 5042 (class 2606 OID 25548)
-- Name: cpus cpus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cpus
    ADD CONSTRAINT cpus_pkey PRIMARY KEY (component_id);


--
-- TOC entry 5058 (class 2606 OID 25646)
-- Name: dealers dealers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dealers
    ADD CONSTRAINT dealers_pkey PRIMARY KEY (id);


--
-- TOC entry 5032 (class 2606 OID 25509)
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 5034 (class 2606 OID 25511)
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- TOC entry 5052 (class 2606 OID 25609)
-- Name: internal_hard_drives internal_hard_drives_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_hard_drives
    ADD CONSTRAINT internal_hard_drives_pkey PRIMARY KEY (component_id);


--
-- TOC entry 5030 (class 2606 OID 25492)
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- TOC entry 5027 (class 2606 OID 25477)
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 5048 (class 2606 OID 25583)
-- Name: memory memory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memory
    ADD CONSTRAINT memory_pkey PRIMARY KEY (component_id);


--
-- TOC entry 5007 (class 2606 OID 25404)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 5046 (class 2606 OID 25572)
-- Name: motherboards motherboards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motherboards
    ADD CONSTRAINT motherboards_pkey PRIMARY KEY (component_id);


--
-- TOC entry 5015 (class 2606 OID 25428)
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- TOC entry 5070 (class 2606 OID 25714)
-- Name: pc_builds pc_builds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pc_builds
    ADD CONSTRAINT pc_builds_pkey PRIMARY KEY (id);


--
-- TOC entry 5076 (class 2606 OID 25760)
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 5056 (class 2606 OID 25635)
-- Name: power_supplies power_supplies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.power_supplies
    ADD CONSTRAINT power_supplies_pkey PRIMARY KEY (component_id);


--
-- TOC entry 5018 (class 2606 OID 25438)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 5064 (class 2606 OID 25914)
-- Name: component_prices uq_component_dealer; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_prices
    ADD CONSTRAINT uq_component_dealer UNIQUE (component_id, dealer_id);


--
-- TOC entry 5068 (class 2606 OID 25705)
-- Name: usage_profiles usage_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usage_profiles
    ADD CONSTRAINT usage_profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 5009 (class 2606 OID 25809)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 5011 (class 2606 OID 25419)
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- TOC entry 5013 (class 2606 OID 25417)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5050 (class 2606 OID 25596)
-- Name: video_cards video_cards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video_cards
    ADD CONSTRAINT video_cards_pkey PRIMARY KEY (component_id);


--
-- TOC entry 5079 (class 2606 OID 25782)
-- Name: votes votes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- TOC entry 5081 (class 2606 OID 25811)
-- Name: votes votes_user_id_post_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_user_id_post_id_key UNIQUE (user_id, post_id);


--
-- TOC entry 5083 (class 2606 OID 25794)
-- Name: votes votes_user_id_post_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_user_id_post_id_unique UNIQUE (user_id, post_id);


--
-- TOC entry 5020 (class 1259 OID 25451)
-- Name: cache_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_expiration_index ON public.cache USING btree (expiration);


--
-- TOC entry 5023 (class 1259 OID 25462)
-- Name: cache_locks_expiration_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX cache_locks_expiration_index ON public.cache_locks USING btree (expiration);


--
-- TOC entry 5073 (class 1259 OID 25812)
-- Name: idx_build_components_build; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_build_components_build ON public.build_components USING btree (build_id);


--
-- TOC entry 5074 (class 1259 OID 25813)
-- Name: idx_posts_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_posts_user ON public.posts USING btree (user_id);


--
-- TOC entry 5061 (class 1259 OID 25814)
-- Name: idx_prices_component; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_prices_component ON public.component_prices USING btree (component_id);


--
-- TOC entry 5062 (class 1259 OID 25815)
-- Name: idx_prices_dealer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_prices_dealer ON public.component_prices USING btree (dealer_id);


--
-- TOC entry 5077 (class 1259 OID 25816)
-- Name: idx_votes_post; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_votes_post ON public.votes USING btree (post_id);


--
-- TOC entry 5028 (class 1259 OID 25478)
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- TOC entry 5016 (class 1259 OID 25440)
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- TOC entry 5019 (class 1259 OID 25439)
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- TOC entry 5114 (class 2606 OID 25817)
-- Name: build_components build_components_build_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.build_components
    ADD CONSTRAINT build_components_build_id_fkey FOREIGN KEY (build_id) REFERENCES public.pc_builds(id) ON DELETE CASCADE;


--
-- TOC entry 5115 (class 2606 OID 25737)
-- Name: build_components build_components_build_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.build_components
    ADD CONSTRAINT build_components_build_id_foreign FOREIGN KEY (build_id) REFERENCES public.pc_builds(id) ON DELETE CASCADE;


--
-- TOC entry 5116 (class 2606 OID 25822)
-- Name: build_components build_components_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.build_components
    ADD CONSTRAINT build_components_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id);


--
-- TOC entry 5117 (class 2606 OID 25742)
-- Name: build_components build_components_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.build_components
    ADD CONSTRAINT build_components_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5100 (class 2606 OID 25827)
-- Name: cases cases_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5101 (class 2606 OID 25616)
-- Name: cases cases_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cases
    ADD CONSTRAINT cases_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5126 (class 2606 OID 26149)
-- Name: comments comments_post_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_post_id_foreign FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- TOC entry 5127 (class 2606 OID 26154)
-- Name: comments comments_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5108 (class 2606 OID 25685)
-- Name: compatibility_rules compatibility_rules_component_type_a_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compatibility_rules
    ADD CONSTRAINT compatibility_rules_component_type_a_foreign FOREIGN KEY (component_type_a) REFERENCES public.component_types(id);


--
-- TOC entry 5109 (class 2606 OID 25690)
-- Name: compatibility_rules compatibility_rules_component_type_b_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compatibility_rules
    ADD CONSTRAINT compatibility_rules_component_type_b_foreign FOREIGN KEY (component_type_b) REFERENCES public.component_types(id);


--
-- TOC entry 5104 (class 2606 OID 25832)
-- Name: component_prices component_prices_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_prices
    ADD CONSTRAINT component_prices_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5105 (class 2606 OID 25658)
-- Name: component_prices component_prices_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_prices
    ADD CONSTRAINT component_prices_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5106 (class 2606 OID 25837)
-- Name: component_prices component_prices_dealer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_prices
    ADD CONSTRAINT component_prices_dealer_id_fkey FOREIGN KEY (dealer_id) REFERENCES public.dealers(id) ON DELETE CASCADE;


--
-- TOC entry 5107 (class 2606 OID 25663)
-- Name: component_prices component_prices_dealer_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_prices
    ADD CONSTRAINT component_prices_dealer_id_foreign FOREIGN KEY (dealer_id) REFERENCES public.dealers(id) ON DELETE CASCADE;


--
-- TOC entry 5086 (class 2606 OID 25531)
-- Name: components components_type_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT components_type_id_foreign FOREIGN KEY (type_id) REFERENCES public.component_types(id);


--
-- TOC entry 5090 (class 2606 OID 25842)
-- Name: cpu_coolers cpu_coolers_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cpu_coolers
    ADD CONSTRAINT cpu_coolers_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5091 (class 2606 OID 25553)
-- Name: cpu_coolers cpu_coolers_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cpu_coolers
    ADD CONSTRAINT cpu_coolers_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5088 (class 2606 OID 25847)
-- Name: cpus cpus_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cpus
    ADD CONSTRAINT cpus_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5089 (class 2606 OID 25542)
-- Name: cpus cpus_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cpus
    ADD CONSTRAINT cpus_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5087 (class 2606 OID 25852)
-- Name: components fk_component_type; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.components
    ADD CONSTRAINT fk_component_type FOREIGN KEY (type_id) REFERENCES public.component_types(id);


--
-- TOC entry 5098 (class 2606 OID 25857)
-- Name: internal_hard_drives internal_hard_drives_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_hard_drives
    ADD CONSTRAINT internal_hard_drives_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5099 (class 2606 OID 25603)
-- Name: internal_hard_drives internal_hard_drives_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.internal_hard_drives
    ADD CONSTRAINT internal_hard_drives_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5094 (class 2606 OID 25862)
-- Name: memory memory_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memory
    ADD CONSTRAINT memory_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5095 (class 2606 OID 25577)
-- Name: memory memory_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.memory
    ADD CONSTRAINT memory_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5092 (class 2606 OID 25867)
-- Name: motherboards motherboards_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motherboards
    ADD CONSTRAINT motherboards_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5093 (class 2606 OID 25566)
-- Name: motherboards motherboards_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.motherboards
    ADD CONSTRAINT motherboards_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5110 (class 2606 OID 25872)
-- Name: pc_builds pc_builds_usage_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pc_builds
    ADD CONSTRAINT pc_builds_usage_profile_id_fkey FOREIGN KEY (usage_profile_id) REFERENCES public.usage_profiles(id);


--
-- TOC entry 5111 (class 2606 OID 25720)
-- Name: pc_builds pc_builds_usage_profile_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pc_builds
    ADD CONSTRAINT pc_builds_usage_profile_id_foreign FOREIGN KEY (usage_profile_id) REFERENCES public.usage_profiles(id) ON DELETE SET NULL;


--
-- TOC entry 5112 (class 2606 OID 25877)
-- Name: pc_builds pc_builds_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pc_builds
    ADD CONSTRAINT pc_builds_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5113 (class 2606 OID 25715)
-- Name: pc_builds pc_builds_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pc_builds
    ADD CONSTRAINT pc_builds_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5118 (class 2606 OID 25882)
-- Name: posts posts_build_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_build_id_fkey FOREIGN KEY (build_id) REFERENCES public.pc_builds(id);


--
-- TOC entry 5119 (class 2606 OID 25766)
-- Name: posts posts_build_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_build_id_foreign FOREIGN KEY (build_id) REFERENCES public.pc_builds(id) ON DELETE SET NULL;


--
-- TOC entry 5120 (class 2606 OID 25887)
-- Name: posts posts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5121 (class 2606 OID 25761)
-- Name: posts posts_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5102 (class 2606 OID 25892)
-- Name: power_supplies power_supplies_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.power_supplies
    ADD CONSTRAINT power_supplies_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5103 (class 2606 OID 25629)
-- Name: power_supplies power_supplies_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.power_supplies
    ADD CONSTRAINT power_supplies_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5096 (class 2606 OID 25897)
-- Name: video_cards video_cards_component_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video_cards
    ADD CONSTRAINT video_cards_component_id_fkey FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5097 (class 2606 OID 25590)
-- Name: video_cards video_cards_component_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.video_cards
    ADD CONSTRAINT video_cards_component_id_foreign FOREIGN KEY (component_id) REFERENCES public.components(id) ON DELETE CASCADE;


--
-- TOC entry 5122 (class 2606 OID 25902)
-- Name: votes votes_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- TOC entry 5123 (class 2606 OID 25788)
-- Name: votes votes_post_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_post_id_foreign FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- TOC entry 5124 (class 2606 OID 25907)
-- Name: votes votes_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5125 (class 2606 OID 25783)
-- Name: votes votes_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


-- Completed on 2026-06-05 16:26:56

--
-- PostgreSQL database dump complete
--

\unrestrict 05J1UtGsFBVjaohYHylTYa6NWFdghILH3yfCBBjiGalhMVi6EEraKkx3nLvdaZd

