--
-- PostgreSQL database dump
--

-- Dumped from database version 10.17 (Ubuntu 10.17-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.17 (Ubuntu 10.17-0ubuntu0.18.04.1)

begin;

--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50) NOT NULL,
    user_agent character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text
);


--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(30),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying
);


--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    "group" integer,
    translations json,
    note text
);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    uploaded_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize integer,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json
);


--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    role uuid,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    "limit" integer
);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    filters json,
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer
);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    many_primary character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_primary character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(255)
);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer
);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(30) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    module_list json,
    collection_list json,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT true NOT NULL
);


--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid NOT NULL,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent character varying(255)
);


--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(10) DEFAULT '#00C897'::character varying,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text
);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128) NOT NULL,
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(8) DEFAULT 'en-US'::character varying,
    theme character varying(20) DEFAULT 'auto'::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255)
);


--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url text,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections text
);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability) VALUES ('geo_cache', NULL, NULL, NULL, true, false, NULL, NULL, true, NULL, NULL, NULL, 'all');
INSERT INTO public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability) VALUES ('quiz_config', NULL, 'Configurações de perguntas dos questionários', NULL, false, false, '[{"language":"pt-BR","translation":"Perguntas dos questionários"}]', 'status', true, 'deleted', 'published', NULL, 'all');
INSERT INTO public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability) VALUES ('questionnaires', NULL, 'Lista de questionários', NULL, false, false, '[{"language":"pt-BR","translation":"Questionários"}]', NULL, true, NULL, NULL, NULL, 'all');
INSERT INTO public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability) VALUES ('penhas_config', NULL, NULL, NULL, true, false, NULL, NULL, true, NULL, NULL, NULL, 'all');
INSERT INTO public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability) VALUES ('twitter_bot_config', NULL, NULL, NULL, false, true, NULL, NULL, true, NULL, NULL, NULL, 'all');
INSERT INTO public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability) VALUES ('anonymous_quiz_session', NULL, NULL, NULL, false, false, NULL, NULL, true, NULL, NULL, NULL, 'all');


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (433, 'questionnaires', 'id', NULL, NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (460, 'quiz_config', 'yesnogroup', NULL, 'list', '{"choices":[{}],"template":"{{ question }}","addLabel":"Adicionar novo item","fields":[{"field":"question","name":"Questão","type":"string","meta":{"name":"Questão","field":"question","width":"full","type":"string","note":"Qual pergunta será feita.","options":{"trim":true},"interface":"input"}},{"field":"power2answer","name":"número power of 2","type":"string","meta":{"name":"número power of 2","field":"power2answer","width":"half","type":"string","note":"quando respondido sim, a resposta terá esse número adicionado.","options":{"choices":[{"text":"2","value":"2"},{"text":"4","value":"4"},{"text":"8","value":"8"},{"text":"16","value":"16"},{"text":"32","value":"32"},{"text":"64","value":"64"},{"text":"128","value":"128"},{"text":"256","value":"256"},{"text":"512","value":"512"},{"text":"1024","value":"1024"},{"text":"2048","value":"2048"},{"text":"4096","value":"4096"},{"text":"8192","value":"8192"},{"text":"16384","value":"16384"}]},"interface":"select-dropdown"}},{"field":"referencia","name":"referencia","type":"string","meta":{"name":"referencia","field":"referencia","width":"half","type":"string","note":"Referencia para esta pergunta nas respostas.","options":{"trim":true},"interface":"input"}}]}', 'formatted-json-value', '{"format":"{{ question }}"}', true, true, 14, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (434, 'questionnaires', 'created_on', 'date-created', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (435, 'questionnaires', 'active', NULL, 'boolean', NULL, 'boolean', NULL, false, false, NULL, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (436, 'questionnaires', 'modified_on', 'date-updated', NULL, NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (437, 'questionnaires', 'modified_by', 'user-updated', NULL, NULL, NULL, NULL, false, true, NULL, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (438, 'questionnaires', 'owner', 'user-created', 'input', NULL, 'user', NULL, false, true, NULL, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (439, 'questionnaires', 'name', NULL, 'input', NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (440, 'questionnaires', 'condition', NULL, 'input', NULL, 'raw', NULL, false, false, NULL, 'full', NULL, NULL, 'Condição em formato TT, quando esse questionário deve aparecer para as usuárias');
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (441, 'questionnaires', 'end_screen', NULL, 'select-dropdown', '{"allowOther":true,"choices":[{"text":"[% controlador  >  0 ? \"/mainboard?page=helpcenter\" : \"/mainboard?page=feed\" %]","value":"[% controlador  >  0 ? \"/mainboard?page=helpcenter\" : \"/mainboard?page=feed\" %]"},{"text":"/mainboard?page=feed","value":"/mainboard?page=feed"}]}', 'raw', NULL, false, false, NULL, 'full', NULL, NULL, 'Qual rota do app deve levar ao finalizar');
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (451, 'quiz_config', 'id', NULL, NULL, NULL, NULL, NULL, false, false, 1, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (452, 'quiz_config', 'status', NULL, 'select-dropdown', '{"choices":[{"text":"publicado","value":"published"},{"text":"removido","value":"deleted"}]}', 'raw', NULL, false, false, 2, 'half', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (459, 'quiz_config', 'questionnaire_id', NULL, 'select-dropdown-m2o', '{"template":"({{id}}) {{name}}"}', 'related-values', '{"template":"({{id}}) {{name}}"}', false, false, 3, 'half', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (461, 'quiz_config', 'intro', NULL, 'list', '{"fields":[{"field":"text","name":"text","type":"text","meta":{"field":"text","width":"full","type":"text","interface":"input-multiline"}}],"template":"{{ text }}","addLabel":"Nova introdução"}', 'formatted-json-value', '{"format":"{{text}}"}', false, false, 5, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (458, 'quiz_config', 'question', NULL, 'input-code', '{"language":"plaintext"}', 'raw', NULL, false, false, 6, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (457, 'quiz_config', 'code', NULL, 'input', '{"font":"monospace"}', 'raw', NULL, false, false, 8, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (462, 'quiz_config', 'relevance', NULL, 'input', NULL, 'raw', NULL, false, false, 9, 'full', NULL, NULL, 'Expressão TT, quando deve aparecer essa questão');
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (469, 'quiz_config', 'options', NULL, 'list', '{"template":"{{label}}","addLabel":"Nova opção","fields":[{"field":"value","name":"value","type":"string","meta":{"field":"value","width":"half","type":"string","note":"valor a ser salvo na resposta","interface":"input"}},{"field":"label","name":"label","type":"string","meta":{"field":"label","width":"half","type":"string","note":"Valor a ser exibido para usuário selecionar","interface":"input"}}]}', 'raw', NULL, false, false, 10, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (454, 'quiz_config', 'modified_on', 'date-updated', NULL, NULL, NULL, NULL, false, true, 13, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (463, 'quiz_config', 'button_label', NULL, 'input', NULL, 'raw', NULL, false, false, 11, 'half', NULL, NULL, 'Quando botões, qual o valor do botão');
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (464, 'quiz_config', 'modified_by', 'user-updated', 'input', NULL, 'user', NULL, false, true, 12, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (472, 'questionnaires', 'penhas_start_automatically', NULL, 'boolean', NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (473, 'questionnaires', 'penhas_cliente_required', NULL, 'boolean', NULL, NULL, NULL, false, false, NULL, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (474, 'twitter_bot_config', 'id', NULL, 'input', NULL, NULL, NULL, true, true, NULL, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (475, 'twitter_bot_config', 'user_created', 'user-created', 'select-dropdown-m2o', '{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"}', 'user', NULL, true, true, NULL, 'half', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (476, 'twitter_bot_config', 'date_created', 'date-created', 'datetime', NULL, 'datetime', '{"relative":true}', true, true, NULL, 'half', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (477, 'twitter_bot_config', 'user_updated', 'user-updated', 'select-dropdown-m2o', '{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"}', 'user', NULL, true, true, NULL, 'half', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (478, 'twitter_bot_config', 'date_updated', 'date-updated', 'datetime', NULL, 'datetime', '{"relative":true}', true, true, NULL, 'half', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (479, 'twitter_bot_config', 'config', 'json', 'input-code', '{"language":"JSON","template":"{\n}"}', 'raw', NULL, false, false, NULL, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (471, 'quiz_config', 'sort', NULL, 'input', NULL, 'raw', NULL, false, false, 4, 'full', NULL, NULL, NULL);
INSERT INTO public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, "group", translations, note) VALUES (455, 'quiz_config', 'type', NULL, 'select-dropdown', '{"choices":[{"text":"Lista de opção (selecionar uma)","value":"onlychoice"},{"text":"Texto livre (apenas twitter)","value":"text"},{"text":"Apenas Exibir texto","value":"displaytext"},{"text":"Botão de finalizar","value":"botao_fim"},{"text":"Busca de cep","value":"cep_address_lookup"}]}', 'labels', '{"choices":[{"text":"Texto livre","value":"text"},{"text":"Exibir texto","value":"displaytext"},{"text":"Botão de finalizar","value":"botao_fim"},{"text":"Busca de cep","value":"cep_address_lookup"},{"text":"Lista de opção (selecionar uma)","value":"onlychoice"}]}', false, false, 7, 'half', NULL, NULL, NULL);


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, uploaded_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata) VALUES ('1bff9d7d-0d81-46b4-b329-884b1e83970d', 'local', '1bff9d7d-0d81-46b4-b329-884b1e83970d.png', 'penhas-logo-copy.png', 'Penhas Logo Copy', 'image/png', NULL, '8bc23069-7341-4c75-9c35-e1ab182ea526', '2021-05-19 14:11:05.874593-03', NULL, '2021-05-19 14:11:05.887-03', NULL, 4307, 155, 50, NULL, NULL, NULL, NULL, NULL, '{}');
INSERT INTO public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, uploaded_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata) VALUES ('d9f8ee65-7ca7-4407-8524-4c4d7df2aa67', 'local', 'd9f8ee65-7ca7-4407-8524-4c4d7df2aa67.png', 'penhas-logo-copy.png', 'Penhas Logo Copy', 'image/png', NULL, '8bc23069-7341-4c75-9c35-e1ab182ea526', '2021-05-20 15:28:24.737055-03', NULL, '2021-05-20 15:28:24.748-03', NULL, 4307, 155, 50, NULL, NULL, NULL, NULL, NULL, '{}');


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20201028A', 'Remove Collection Foreign Keys', '2021-05-19 14:08:59.900682-03');
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20201029A', 'Remove System Relations', '2021-05-19 14:08:59.903164-03');
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20201029B', 'Remove System Collections', '2021-05-19 14:08:59.905252-03');
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20201029C', 'Remove System Fields', '2021-05-19 14:08:59.915998-03');
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20201105A', 'Add Cascade System Relations', '2021-05-19 14:08:59.949457-03');
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20201105B', 'Change Webhook URL Type', '2021-05-19 14:08:59.953474-03');
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20210225A', 'Add Relations Sort Field', '2021-05-19 14:08:59.956673-03');
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20210304A', 'Remove Locked Fields', '2021-05-19 14:08:59.959012-03');
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20210312A', 'Webhooks Collections Text', '2021-05-19 14:08:59.962422-03');
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20210331A', 'Add Refresh Interval', '2021-05-19 14:08:59.964632-03');
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20210415A', 'Make Filesize Nullable', '2021-05-19 14:08:59.968784-03');
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20210416A', 'Add Collections Accountability', '2021-05-19 14:08:59.972342-03');
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20210422A', 'Remove Files Interface', '2021-05-19 14:08:59.974305-03');
INSERT INTO public.directus_migrations (version, name, "timestamp") VALUES ('20210506A', 'Rename Interfaces', '2021-05-19 14:08:59.994403-03');


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (3, 'chat_clientes_notifications', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (4, 'chat_support', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (5, 'chat_support_message', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (6, 'cliente_ativacoes_panico', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (7, 'cliente_ativacoes_policia', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (8, 'cliente_bloqueios', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (9, 'cliente_ponto_apoio_avaliacao', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (10, 'cliente_skills', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (11, 'clientes_active_sessions', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (12, 'clientes_app_activity', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (13, 'clientes_app_notifications', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (14, 'clientes_audios_eventos', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (15, 'clientes_audios', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (16, 'clientes_guardioes', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (17, 'clientes_preferences', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (18, 'clientes_quiz_session', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (19, 'clientes_reset_password', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (20, 'login_erros', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (21, 'login_logs', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (22, 'media_upload', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (23, 'notification_log', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (24, 'ponto_apoio_sugestoes', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (25, 'tweets', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (26, 'tweets_likes', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (27, 'tweets_reports', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (28, 'cliente_bloqueios', 'blocked_cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (41, 'rss_feeds_tags', 'rss_feeds_id', 'id', 'rss_feeds', 'forced_tags', 'id', NULL, NULL, 'tags_id', NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (42, 'rss_feeds_tags', 'tags_id', 'id', 'tags', NULL, 'id', NULL, NULL, 'rss_feeds_id', NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (29, 'cliente_ponto_apoio_avaliacao', 'ponto_apoio_id', 'id', 'ponto_apoio', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (30, 'cliente_skills', 'skill_id', 'id', 'skills', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (43, 'faq_tela_sobre', 'fts_categoria_id', 'id', 'faq_tela_sobre_categoria', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (45, 'noticias_aberturas', 'noticias_id', 'id', 'noticias', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (46, 'noticias_aberturas', 'cliente_id', 'id', 'clientes', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (47, 'ponto_apoio_sugestoes', 'categoria', 'id', 'ponto_apoio_categoria', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (36, 'ponto_apoio_categoria2projetos', 'ponto_apoio_categoria_id', 'id', 'ponto_apoio_categoria', 'projetos', 'id', NULL, NULL, 'ponto_apoio_projeto_id', NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (35, 'ponto_apoio_categoria2projetos', 'ponto_apoio_projeto_id', 'id', 'ponto_apoio_projeto', NULL, 'id', NULL, NULL, 'ponto_apoio_categoria_id', NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (37, 'clientes_preferences', 'preference_id', 'id', 'preferences', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (38, 'ponto_apoio', 'categoria', 'id', 'ponto_apoio_categoria', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (48, 'tags_highlight', 'tag_id', 'id', 'tags', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (49, 'tag_indexing_config', 'tag_id', 'id', 'tags', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (50, 'tweets_likes', 'tweet_id', 'id', 'tweets', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (51, 'tweets_reports', 'reported_id', 'id', 'tweets', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (39, 'rss_feed_forced_tags', 'tags_id', 'id', 'tags', NULL, 'id', NULL, NULL, 'rss_feeds_id', NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (52, 'tweets', 'parent_id', 'id', 'tweets', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (53, 'noticias', 'rss_feed_id', 'id', 'rss_feeds', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (40, 'rss_feed_forced_tags', 'rss_feed_id', 'rss_feed_id', 'rss_feeds', NULL, 'id', NULL, NULL, 'tag_id', NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (54, 'clientes_quiz_session', 'questionnaire_id', 'id', 'questionnaires', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (55, 'quiz_config', 'questionnaire_id', 'id', 'questionnaires', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (57, 'noticias_tags', 'noticias_id', 'id', 'noticias', 'tags', 'id', NULL, NULL, 'tags_id', NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (56, 'noticias_tags', 'tags_id', 'id', 'tags', NULL, 'id', NULL, NULL, 'noticias_id', NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (58, 'twitter_bot_config', 'user_created', 'id', 'directus_users', NULL, 'id', NULL, NULL, NULL, NULL);
INSERT INTO public.directus_relations (id, many_collection, many_field, many_primary, one_collection, one_field, one_primary, one_collection_field, one_allowed_collections, junction_field, sort_field) VALUES (59, 'twitter_bot_config', 'user_updated', 'id', 'directus_users', NULL, 'id', NULL, NULL, NULL, NULL);


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.directus_roles (id, name, icon, description, ip_access, enforce_tfa, module_list, collection_list, admin_access, app_access) VALUES ('a843b72e-2d1f-4859-992b-891e0fa6589f', 'Admin', 'supervised_user_circle', NULL, NULL, false, NULL, NULL, true, true);


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.directus_sessions (token, "user", expires, ip, user_agent) VALUES ('32I1DeTGLg_i3tLU_0a7LU-4lMFt9-Y65Jr0pufb_0MQjGlU8fqvYxtUdDeQRmvE', '8bc23069-7341-4c75-9c35-e1ab182ea526', '2021-08-11 15:40:59.592-03', '::ffff:172.21.0.1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36');


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css) VALUES (1, 'Penhas', 'https://exemple.com', NULL, NULL, NULL, NULL, NULL, 25, '/^.{8,}$/', 'all', NULL, NULL);


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, theme, tfa_secret, status, role, token, last_access, last_page) VALUES ('8bc23069-7341-4c75-9c35-e1ab182ea526', NULL, NULL, 'admin@example.com', '$argon2i$v=19$m=4096,t=3,p=1$ouvWXEDPDogqDyOO/ir1dQ$LBS6JETkOHpf285J8KF1YNXef6VW8YJngCDTzmF/v1g', NULL, NULL, NULL, NULL, NULL, 'pt-BR', 'auto', NULL, 'active', 'a843b72e-2d1f-4859-992b-891e0fa6589f', NULL, '2021-08-04 15:44:12.326-03', '/settings/data-model/quiz_config');


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 3327, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 479, true);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 243, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 28, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 59, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 212, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_fields(id);


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id);


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_permissions directus_permissions_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id);


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id);


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id);


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id);


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id);


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id);


--
-- PostgreSQL database dump complete
--

commit;
