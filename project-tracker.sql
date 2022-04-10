--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

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

SET default_table_access_method = heap;

--
-- Name: grades; Type: TABLE; Schema: public; Owner: gingerbreadhouse
--

CREATE TABLE public.grades (
    id integer NOT NULL,
    student_github character varying(30),
    project_title character varying(30),
    grade integer
);


ALTER TABLE public.grades OWNER TO gingerbreadhouse;

--
-- Name: grades_id_seq; Type: SEQUENCE; Schema: public; Owner: gingerbreadhouse
--

CREATE SEQUENCE public.grades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grades_id_seq OWNER TO gingerbreadhouse;

--
-- Name: grades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gingerbreadhouse
--

ALTER SEQUENCE public.grades_id_seq OWNED BY public.grades.id;


--
-- Name: new_students; Type: TABLE; Schema: public; Owner: gingerbreadhouse
--

CREATE TABLE public.new_students (
    id integer NOT NULL,
    first_name character varying(30),
    last_name character varying(30),
    github character varying(30) NOT NULL
);


ALTER TABLE public.new_students OWNER TO gingerbreadhouse;

--
-- Name: projects; Type: TABLE; Schema: public; Owner: gingerbreadhouse
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    title character varying(30),
    description text,
    max_grade integer
);


ALTER TABLE public.projects OWNER TO gingerbreadhouse;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: gingerbreadhouse
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_id_seq OWNER TO gingerbreadhouse;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gingerbreadhouse
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: report_card_view; Type: VIEW; Schema: public; Owner: gingerbreadhouse
--

CREATE VIEW public.report_card_view AS
 SELECT new_students.first_name,
    new_students.last_name,
    projects.title,
    projects.max_grade,
    grades.grade
   FROM ((public.new_students
     JOIN public.grades ON (((new_students.github)::text = (grades.student_github)::text)))
     JOIN public.projects ON (((projects.title)::text = (grades.project_title)::text)));


ALTER TABLE public.report_card_view OWNER TO gingerbreadhouse;

--
-- Name: students_id_seq; Type: SEQUENCE; Schema: public; Owner: gingerbreadhouse
--

CREATE SEQUENCE public.students_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.students_id_seq OWNER TO gingerbreadhouse;

--
-- Name: students_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: gingerbreadhouse
--

ALTER SEQUENCE public.students_id_seq OWNED BY public.new_students.id;


--
-- Name: grades id; Type: DEFAULT; Schema: public; Owner: gingerbreadhouse
--

ALTER TABLE ONLY public.grades ALTER COLUMN id SET DEFAULT nextval('public.grades_id_seq'::regclass);


--
-- Name: new_students id; Type: DEFAULT; Schema: public; Owner: gingerbreadhouse
--

ALTER TABLE ONLY public.new_students ALTER COLUMN id SET DEFAULT nextval('public.students_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: gingerbreadhouse
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: gingerbreadhouse
--

COPY public.grades (id, student_github, project_title, grade) FROM stdin;
1	jhacks	Markov	10
2	jhacks	Blockly	2
3	sdevelops	Markov	50
4	sdevelops	Blockly	100
\.


--
-- Data for Name: new_students; Type: TABLE DATA; Schema: public; Owner: gingerbreadhouse
--

COPY public.new_students (id, first_name, last_name, github) FROM stdin;
1	Jane	Hacker	jhacks
2	Sarah	Developer	sdevelops
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: gingerbreadhouse
--

COPY public.projects (id, title, description, max_grade) FROM stdin;
1	Markov	Tweets generated from Markov chains	50
2	Blockly	Programmatic Logic Puzzle Game	100
3	My nerdy neighbor	Book review system	80
4	Ghost Project	Ghost hunting by location	30
5	playdate Project	Mom	100
\.


--
-- Name: grades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gingerbreadhouse
--

SELECT pg_catalog.setval('public.grades_id_seq', 4, true);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gingerbreadhouse
--

SELECT pg_catalog.setval('public.projects_id_seq', 5, true);


--
-- Name: students_id_seq; Type: SEQUENCE SET; Schema: public; Owner: gingerbreadhouse
--

SELECT pg_catalog.setval('public.students_id_seq', 2, true);


--
-- Name: grades grades_pkey; Type: CONSTRAINT; Schema: public; Owner: gingerbreadhouse
--

ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: gingerbreadhouse
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: new_students students_pkey; Type: CONSTRAINT; Schema: public; Owner: gingerbreadhouse
--

ALTER TABLE ONLY public.new_students
    ADD CONSTRAINT students_pkey PRIMARY KEY (github);


--
-- PostgreSQL database dump complete
--

