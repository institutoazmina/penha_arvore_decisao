
create extension if not exists "uuid-ossp";

BEGIN;

--
-- Name: f_tgr_quiz_config_after_update(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.f_tgr_quiz_config_after_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

    IF (TG_OP = 'UPDATE') THEN

        update questionnaires
         set modified_on = now()
         where id = NEW.questionnaire_id OR  id = OLD.questionnaire_id;
     ELSIF (TG_OP = 'INSERT') THEN
        update questionnaires
         set modified_on = now()
         where id = NEW.questionnaire_id;
     END IF;

    RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: anonymous_quiz_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.anonymous_quiz_session (
    id bigint NOT NULL,
    remote_id character varying NOT NULL,
    questionnaire_id bigint NOT NULL,
    finished_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    stash json DEFAULT '{}'::json,
    responses json DEFAULT '{}'::json,
    deleted_at timestamp with time zone,
    deleted boolean DEFAULT false NOT NULL
);


--
-- Name: anonymous_quiz_session_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.anonymous_quiz_session_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: anonymous_quiz_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.anonymous_quiz_session_id_seq OWNED BY public.anonymous_quiz_session.id;


--
-- Name: geo_cache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.geo_cache (
    id bigint NOT NULL,
    key character varying(200) NOT NULL,
    value character varying(200) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    valid_until timestamp with time zone NOT NULL
);


--
-- Name: geo_cache_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.geo_cache_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: geo_cache_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.geo_cache_id_seq OWNED BY public.geo_cache.id;


--
-- Name: penhas_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.penhas_config (
    id integer NOT NULL,
    name character varying NOT NULL,
    value character varying NOT NULL,
    valid_from timestamp without time zone DEFAULT now() NOT NULL,
    valid_to timestamp without time zone DEFAULT 'infinity'::timestamp without time zone NOT NULL
);


--
-- Name: penhas_config_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.penhas_config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: penhas_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.penhas_config_id_seq OWNED BY public.penhas_config.id;


--
-- Name: questionnaires; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.questionnaires (
    id bigint NOT NULL,
    created_on timestamp with time zone,
    modified_on timestamp with time zone,
    active boolean NOT NULL,
    name character varying(200) NOT NULL,
    condition character varying(2000) DEFAULT '0'::character varying NOT NULL,
    end_screen character varying(200) DEFAULT 'home'::character varying NOT NULL,
    owner uuid,
    modified_by uuid,
    penhas_start_automatically boolean DEFAULT true NOT NULL,
    penhas_cliente_required boolean DEFAULT true NOT NULL
);


--
-- Name: COLUMN questionnaires.name; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.questionnaires.name IS 'Nome interno';


--
-- Name: COLUMN questionnaires.condition; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.questionnaires.condition IS 'Pra quem deve aparecer';


--
-- Name: questionnaires_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.questionnaires_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: questionnaires_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.questionnaires_id_seq OWNED BY public.questionnaires.id;


--
-- Name: quiz_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quiz_config (
    id bigint NOT NULL,
    status character varying(20) DEFAULT 'published'::character varying NOT NULL,
    sort integer,
    modified_on timestamp with time zone,
    type character varying(100) NOT NULL,
    code character varying NOT NULL,
    question character varying(800) NOT NULL,
    questionnaire_id bigint NOT NULL,
    yesnogroup json DEFAULT '[]'::json,
    intro json DEFAULT '[]'::json,
    relevance character varying(2000) DEFAULT '1'::character varying NOT NULL,
    button_label character varying(200) DEFAULT NULL::character varying,
    modified_by uuid,
    options json DEFAULT '[]'::json NOT NULL
);


--
-- Name: COLUMN quiz_config.code; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.quiz_config.code IS 'Identificador da resposta, precisa iniciar com A-Z, depois A-Z0-9 e _';


--
-- Name: COLUMN quiz_config.question; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.quiz_config.question IS 'Pode usar template TT para  formatar o texto e usar respostas anteriores';


--
-- Name: COLUMN quiz_config.yesnogroup; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.quiz_config.yesnogroup IS 'Até 20 questões sim/não. Cada resposta "sim" será "adicionada" {AND operation} para a resposta, baseado em Power2anwser. ';


--
-- Name: COLUMN quiz_config.intro; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.quiz_config.intro IS 'Textos de intrução';


--
-- Name: COLUMN quiz_config.button_label; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.quiz_config.button_label IS 'Texto para ser usado no label do botão';


--
-- Name: quiz_config_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quiz_config_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quiz_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quiz_config_id_seq OWNED BY public.quiz_config.id;


--
-- Name: anonymous_quiz_session id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anonymous_quiz_session ALTER COLUMN id SET DEFAULT nextval('public.anonymous_quiz_session_id_seq'::regclass);


--
-- Name: geo_cache id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.geo_cache ALTER COLUMN id SET DEFAULT nextval('public.geo_cache_id_seq'::regclass);


--
-- Name: penhas_config id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.penhas_config ALTER COLUMN id SET DEFAULT nextval('public.penhas_config_id_seq'::regclass);


--
-- Name: questionnaires id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questionnaires ALTER COLUMN id SET DEFAULT nextval('public.questionnaires_id_seq'::regclass);


--
-- Name: quiz_config id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_config ALTER COLUMN id SET DEFAULT nextval('public.quiz_config_id_seq'::regclass);


--
-- Data for Name: anonymous_quiz_session; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: geo_cache; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: penhas_config; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.penhas_config VALUES (1, 'ANON_QUIZ_SECRET', uuid_generate_v4(), '2021-08-03 17:52:28.383229', 'infinity');


--
-- Data for Name: questionnaires; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.questionnaires VALUES (2, '2021-05-31 15:31:21.186-03', '2021-07-09 23:49:49.379455-03', true, 'anon-test', '0', 'home', NULL, '8bc23069-7341-4c75-9c35-e1ab182ea526', false, false);


--
-- Data for Name: quiz_config; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.quiz_config VALUES (30, 'published', 999, '2021-07-09 23:37:12.322-03', 'botao_fim', 'botao_fim', 'Obrigado por responder. Você também pode ligar para 190 ou XXX.', 2, '[]', '[{"text":"olá"}]', '_self==''botao_fim''', 'Finalizar', '04729ae2-61a4-4b02-b56b-f10928faf6fb', '[]');
INSERT INTO public.quiz_config VALUES (29, 'published', 0, '2021-05-31 15:41:12.801-03', 'onlychoice', 'chooseone', 'choose one', 2, '[]', '[]', '1', NULL, '8bc23069-7341-4c75-9c35-e1ab182ea526', '[{"value":"a","label":"option a"},{"value":"b","label":"option b"}]');
INSERT INTO public.quiz_config VALUES (39, 'published', 4, '2021-07-09 23:49:49.379-03', 'cep_address_lookup', 'cep_01', 'digite seu cep', 2, '[]', '[]', '_self==''cep_01''', NULL, '04729ae2-61a4-4b02-b56b-f10928faf6fb', '[]');


--
-- Name: anonymous_quiz_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.anonymous_quiz_session_id_seq', 1, false);


--
-- Name: geo_cache_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.geo_cache_id_seq', 1, false);


--
-- Name: penhas_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.penhas_config_id_seq', 1, true);


--
-- Name: questionnaires_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.questionnaires_id_seq', 8, true);


--
-- Name: quiz_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.quiz_config_id_seq', 126, true);


--
-- Name: anonymous_quiz_session anonymous_quiz_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anonymous_quiz_session
    ADD CONSTRAINT anonymous_quiz_session_pkey PRIMARY KEY (id);


--
-- Name: geo_cache idx_237008_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.geo_cache
    ADD CONSTRAINT idx_237008_primary PRIMARY KEY (id);


--
-- Name: questionnaires idx_237175_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questionnaires
    ADD CONSTRAINT idx_237175_primary PRIMARY KEY (id);


--
-- Name: quiz_config idx_237186_primary; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_config
    ADD CONSTRAINT idx_237186_primary PRIMARY KEY (id);


--
-- Name: penhas_config penhas_config_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.penhas_config
    ADD CONSTRAINT penhas_config_pkey PRIMARY KEY (id);


--
-- Name: idx_237186_questionnaire_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_237186_questionnaire_id ON public.quiz_config USING btree (questionnaire_id);


--
-- Name: idx_config_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_config_key ON public.penhas_config USING btree (name) WHERE (valid_to = 'infinity'::timestamp without time zone);


--
-- Name: quiz_config tgr_on_quiz_config_after_update; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER tgr_on_quiz_config_after_update AFTER INSERT OR DELETE OR UPDATE ON public.quiz_config FOR EACH ROW EXECUTE PROCEDURE public.f_tgr_quiz_config_after_update();


--
-- Name: anonymous_quiz_session anonymous_quiz_session_questionnaire_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.anonymous_quiz_session
    ADD CONSTRAINT anonymous_quiz_session_questionnaire_id_fkey FOREIGN KEY (questionnaire_id) REFERENCES public.questionnaires(id);


--
-- Name: quiz_config quiz_config_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quiz_config
    ADD CONSTRAINT quiz_config_ibfk_1 FOREIGN KEY (questionnaire_id) REFERENCES public.questionnaires(id) ON UPDATE CASCADE ON DELETE CASCADE;


CREATE TABLE public.twitter_bot_config (
    id integer NOT NULL,
    user_created uuid,
    date_created timestamp with time zone,
    user_updated uuid,
    date_updated timestamp with time zone,
    config json DEFAULT '{}'::json NOT NULL
);

CREATE SEQUENCE public.twitter_bot_config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.twitter_bot_config_id_seq OWNED BY public.twitter_bot_config.id;


ALTER TABLE ONLY public.twitter_bot_config ALTER COLUMN id SET DEFAULT nextval('public.twitter_bot_config_id_seq'::regclass);

ALTER TABLE ONLY public.twitter_bot_config
    ADD CONSTRAINT twitter_bot_config_pkey PRIMARY KEY (id);


insert into public.twitter_bot_config(config) values ('{}');

commit;
