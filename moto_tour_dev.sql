--
-- PostgreSQL database dump
--

-- Dumped from database version 14.15 (Ubuntu 14.15-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.15 (Ubuntu 14.15-0ubuntu0.22.04.1)

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
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: circuits; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.circuits (
    id bigint NOT NULL,
    nom character varying(255),
    tarifs character varying,
    "durée" character varying(255),
    participant text,
    moto character varying(255),
    "difficulté" integer,
    photo character varying(255),
    details text,
    remarque text,
    desc_card text,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    archiver boolean,
    assistance boolean
);


ALTER TABLE public.circuits OWNER TO postgres;

--
-- Name: circuits_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.circuits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.circuits_id_seq OWNER TO postgres;

--
-- Name: circuits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.circuits_id_seq OWNED BY public.circuits.id;


--
-- Name: itineraires; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.itineraires (
    id bigint NOT NULL,
    idcircuit integer,
    itineraire text,
    remarque text,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.itineraires OWNER TO postgres;

--
-- Name: itineraires_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.itineraires_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.itineraires_id_seq OWNER TO postgres;

--
-- Name: itineraires_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.itineraires_id_seq OWNED BY public.itineraires.id;


--
-- Name: nontarif; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nontarif (
    id bigint NOT NULL,
    prestation text,
    idcircuit integer,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.nontarif OWNER TO postgres;

--
-- Name: nontarif_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nontarif_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nontarif_id_seq OWNER TO postgres;

--
-- Name: nontarif_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nontarif_id_seq OWNED BY public.nontarif.id;


--
-- Name: photos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.photos (
    id bigint NOT NULL,
    nom character varying(255),
    idcircuit integer,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    photo character varying,
    principal boolean
);


ALTER TABLE public.photos OWNER TO postgres;

--
-- Name: photos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.photos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.photos_id_seq OWNER TO postgres;

--
-- Name: photos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.photos_id_seq OWNED BY public.photos.id;


--
-- Name: question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question (
    id bigint NOT NULL,
    idcircuit integer,
    nom character varying(255),
    email character varying(255),
    message text,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    telephone character varying
);


ALTER TABLE public.question OWNER TO postgres;

--
-- Name: question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.question_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.question_id_seq OWNER TO postgres;

--
-- Name: question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.question_id_seq OWNED BY public.question.id;


--
-- Name: reservations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservations (
    id bigint NOT NULL,
    idcircuit integer,
    nom character varying(255),
    email character varying(255),
    telephone character varying(255),
    participant integer,
    date_res date,
    besoin text,
    archivage integer,
    validation integer,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.reservations OWNER TO postgres;

--
-- Name: reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reservations_id_seq OWNER TO postgres;

--
-- Name: reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservations_id_seq OWNED BY public.reservations.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: tarif; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tarif (
    id bigint NOT NULL,
    prestation text,
    idcircuit integer,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.tarif OWNER TO postgres;

--
-- Name: tarif_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tarif_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tarif_id_seq OWNER TO postgres;

--
-- Name: tarif_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tarif_id_seq OWNED BY public.tarif.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email public.citext NOT NULL,
    hashed_password character varying(255) NOT NULL,
    confirmed_at timestamp(0) without time zone,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
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
-- Name: users_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_tokens (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    token bytea NOT NULL,
    context character varying(255) NOT NULL,
    sent_to character varying(255),
    inserted_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.users_tokens OWNER TO postgres;

--
-- Name: users_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_tokens_id_seq OWNER TO postgres;

--
-- Name: users_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_tokens_id_seq OWNED BY public.users_tokens.id;


--
-- Name: circuits id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.circuits ALTER COLUMN id SET DEFAULT nextval('public.circuits_id_seq'::regclass);


--
-- Name: itineraires id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itineraires ALTER COLUMN id SET DEFAULT nextval('public.itineraires_id_seq'::regclass);


--
-- Name: nontarif id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nontarif ALTER COLUMN id SET DEFAULT nextval('public.nontarif_id_seq'::regclass);


--
-- Name: photos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photos ALTER COLUMN id SET DEFAULT nextval('public.photos_id_seq'::regclass);


--
-- Name: question id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question ALTER COLUMN id SET DEFAULT nextval('public.question_id_seq'::regclass);


--
-- Name: reservations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations ALTER COLUMN id SET DEFAULT nextval('public.reservations_id_seq'::regclass);


--
-- Name: tarif id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif ALTER COLUMN id SET DEFAULT nextval('public.tarif_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: users_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_tokens ALTER COLUMN id SET DEFAULT nextval('public.users_tokens_id_seq'::regclass);


--
-- Data for Name: circuits; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.circuits (id, nom, tarifs, "durée", participant, moto, "difficulté", photo, details, remarque, desc_card, inserted_at, updated_at, archiver, assistance) FROM stdin;
4	Le Sud Sauvage	3690 	11 j - 11 nuits (10 jours de moto)	2 à 16	KTM 350 & 450 Six-Days 2024	4	4.jpg	<div class="container_details">\r\n  <h2 class="lead">Programme de Voyage</h2>\r\n  \r\n  <section class="lead-text">\r\n    <h5 class="text-primary">Sites Marquants</h5>\r\n    <ul class="list-group">\r\n      <li class="list-group-item">Découverte d’Antsirabe</li>\r\n      <li class="list-group-item">Ambositra, capitale de l’artisanat malgache</li>\r\n      <li class="list-group-item">Réserve de Ranomafana</li>\r\n      <li class="list-group-item">Canal des Pangalanes</li>\r\n      <li class="list-group-item">Fort Dauphin</li>\r\n      <li class="list-group-item">Faux Cap / Lavanono</li>\r\n      <li class="list-group-item">Réserve naturelle de Tsimanampetsotsa</li>\r\n      <li class="list-group-item">Anakao</li>\r\n    </ul>\r\n  </section>\r\n  \r\n  <section class="lead-text">\r\n    <h5 class="text-primary">Nos Prestations Comprennent</h5>\r\n    <ul class="list-group">\r\n      <li class="list-group-item">Une moto enduro spécialement préparée pour votre voyage</li>\r\n      <li class="list-group-item">L’assurance responsabilité civile en cas d’accident avec votre moto</li>\r\n      <li class="list-group-item">Un guide expérimenté dans l’accompagnement de raids moto</li>\r\n      <li class="list-group-item">Un véhicule 4x4 d’assistance avec chauffeur transportant vos bagages et l’équipement mécanique (pour 5 motards et plus)</li>\r\n      <li class="list-group-item">L’hébergement en chambre double/twin (catégorie standard ou supérieure selon votre choix)</li>\r\n      <li class="list-group-item">Les repas en pension complète (petit-déjeuner et dîner à l’hôtel, paniers-déjeuner pour le repas du midi)</li>\r\n      <li class="list-group-item">Les droits d’entrée et de guidage pour la visite des parcs et monuments prévus durant votre voyage</li>\r\n      <li class="list-group-item">Les transferts aéroport – hôtel</li>\r\n      <li class="list-group-item">Les taxes et vignettes touristiques</li>\r\n    </ul>\r\n  </section>\r\n  \r\n  <section class="lead-text">\r\n    <h5 class="text-primary">Nos Prestations Ne Comprennent Pas</h5>\r\n    <ul class="list-group">\r\n      <li class="list-group-item">Les assurances personnelles pour votre séjour à Madagascar, telles que l’assurance rapatriement</li>\r\n      <li class="list-group-item">Les frais de visa</li>\r\n      <li class="list-group-item">Les vols internationaux et nationaux et les taxes d’aéroport</li>\r\n      <li class="list-group-item">Une caution de 1 000 euros en chèque ou espèces pour l’utilisation de votre moto</li>\r\n      <li class="list-group-item">Les repas lors de jours de transfert</li>\r\n      <li class="list-group-item">Les dépenses personnelles (boissons, pourboires, divers achats)</li>\r\n      <li class="list-group-item">Les droits d’entrée aux monuments et parcs non prévus dans le programme du voyage</li>\r\n    </ul>\r\n  </section>\r\n  \r\n  <section class="lead-text">\r\n    <h5 class="text-primary">Tarif</h5>\r\n    <p>Sur la base d’un groupe de 10 pilotes, le tarif inclut :</p>\r\n    <ul class="list-group">\r\n      <li class="list-group-item">Le transfert et l’hôtel à l’arrivée de l’aéroport</li>\r\n      <li class="list-group-item">L’hébergement en pension complète</li>\r\n      <li class="list-group-item">La location et le carburant de la moto</li>\r\n      <li class="list-group-item">Le guide Moto Accompagnateur</li>\r\n      <li class="list-group-item">Le 4x4 d’assistance avec son carburant</li>\r\n      <li class="list-group-item">Le vol interne province – Tananarive</li>\r\n    </ul>\r\n  </section>\r\n</div>	Le Sud de Madagascar s’offre à vous : cette descente progressive depuis les hautes terres verdoyantes, les pistes humides de la côte Est, jusqu'au Grand-Sud désertique, vous permettra d'apprécier une variété hors du commun de paysages, de faunes et flores endémiques, et de cultures ancestrales. Un parcours pas toujours facile mais somptueux, le Sud Sauvage se mérite et s'apprécie sans modération...	 Antananarivo, Ambositra, Manakara, Fort-Dauphin, Ranomafana, Lavanono, Itampolo, Tulear	2024-11-15 00:00:00	2024-12-12 13:47:41	\N	\N
2	Les 2 lacs en 3 jours	990	3 jours, dont 3 jours de moto, circuit de 450 km	2 à 16	  KTM 350 – 450 Six-Days 2024	2	2.jpg	Parcours journalier, Région : Hauts plateaux	Circuit court mais intense, la découverte des grands lacs des hauts-plateaux se fait par des pistes Enduro techniques, pour escalader les sommets des collines et profiter des panoramas exceptionnels qu'offre ce circuit.	Antananarivo, Mantasoa, Tsiazompaniry	2024-11-15 00:00:00	2025-01-17 13:10:08	\N	\N
1	Les 3 lacs en 6 jours	1890	6 jours, dont 6 jours de moto, circuit de 900 km	2 à 8	 KTM 350 – 450 Six-Days 2024	3	1.jpg	Parcours journalier, Région : Hauts plateaux	Certainement le plus beau circuit Enduro de Madagascar ! La qualité des pistes et chemins, les paysages spectaculaires variés, le confort et l'hospitalité des lodges et auberges familiales qui jalonnent ce parcours d'exception, font de ce circuit un des Must du catalogue.\r\nMoyen ou difficile, le guide se chargera de mettre le curseur sur le niveau qui vous correspond pour apprécier davantage cette découverte des trois lacs des hauts-plateaux. 	Antananarivo, Mantasoa, Tsiazompaniry, Ambatolampy, Ampefy	2024-11-15 00:00:00	2025-01-29 11:32:32	\N	f
3	La piste des Baobabs	3390	10 j - 11 nuits (09 jours de moto)	2 à 16	KTM 350 & 450 Six-Days 2024	4	3.jpg	\r\n  <div class="container_details">\r\n  <h2 class="lead">Programme de Voyage</h2>\r\n  \r\n  <section class="lead-text">\r\n    <h5 class="text-primary">Sites Marquants</h5>\r\n    <ul class="list-group">\r\n      <li class="list-group-item">Lac de Mantasoa et forêt d’eucalyptus</li>\r\n      <li class="list-group-item">Ville thermale Antsirabe</li>\r\n      <li class="list-group-item">Passage du col de l’Itremo</li>\r\n      <li class="list-group-item">Visite de l’Allée des Baobabs</li>\r\n      <li class="list-group-item">Visite du parc et de la réserve de Kirindy</li>\r\n      <li class="list-group-item">Dunes de sable et plages de Salary</li>\r\n      <li class="list-group-item">Ifaty – Tuléar</li>\r\n    </ul>\r\n  </section>\r\n  \r\n  <section class="lead-text">\r\n    <h5 class="text-primary">Nos Prestations Comprennent</h5>\r\n    <ul class="list-group">\r\n      <li class="list-group-item">Une KTM 350 EXCF 2017 enduro spécialement préparée pour votre voyage</li>\r\n      <li class="list-group-item">L’assurance responsabilité civile en cas d’accident avec votre moto</li>\r\n      <li class="list-group-item">Un guide expérimenté dans l’accompagnement de raids moto</li>\r\n      <li class="list-group-item">Un véhicule 4x4 d’assistance avec chauffeur transportant vos bagages et l’équipement mécanique</li>\r\n      <li class="list-group-item">L’hébergement en chambre double/twin (catégorie standard ou supérieure selon votre choix)</li>\r\n      <li class="list-group-item">Les repas en pension complète (petit-déjeuner et dîner à l’hôtel, paniers-déjeuner pour le repas du midi)</li>\r\n      <li class="list-group-item">Les droits d’entrée et de guidage pour la visite des parcs et monuments prévus durant votre voyage</li>\r\n      <li class="list-group-item">Les transferts aéroport – hôtel</li>\r\n      <li class="list-group-item">Les taxes et vignettes touristiques</li>\r\n    </ul>\r\n  </section>\r\n  \r\n  <section class="lead-text">\r\n    <h5 class="text-primary">Nos Prestations Ne Comprennent Pas</h5>\r\n    <ul class="list-group">\r\n      <li class="list-group-item">Les assurances personnelles pour votre séjour à Madagascar, telles que l’assurance rapatriement</li>\r\n      <li class="list-group-item">Les frais de visa</li>\r\n      <li class="list-group-item">Les vols internationaux et nationaux et les taxes d’aéroport</li>\r\n      <li class="list-group-item">Une caution de 2 000 euros en chèque ou espèces pour l’utilisation de votre moto</li>\r\n      <li class="list-group-item">Les repas lors de jours de transfert</li>\r\n      <li class="list-group-item">Les dépenses personnelles (boissons, pourboires, divers achats)</li>\r\n      <li class="list-group-item">Les droits d’entrée aux monuments et parcs non prévus dans le programme du voyage</li>\r\n    </ul>\r\n  </section>\r\n  \r\n  <section class="lead-text">\r\n    <h5 class="text-primary">Tarif</h5>\r\n    <p>Sur la base d’un groupe de 10 pilotes, le tarif inclut :</p>\r\n    <ul class="list-group">\r\n      <li class="list-group-item">Le transfert et l’hôtel à l’arrivée de l’aéroport</li>\r\n      <li class="list-group-item">L’hébergement en pension complète</li>\r\n      <li class="list-group-item">La location et le carburant de la moto</li>\r\n      <li class="list-group-item">Le guide Moto Accompagnateur</li>\r\n      <li class="list-group-item">Le 4x4 d’assistance avec son carburant</li>\r\n      <li class="list-group-item">Le vol interne province – Tananarive</li>\r\n    </ul>\r\n  </section>\r\n</div>	C’est le circuit phare qui est à l’origine de l’aventure malgache. Ce parcours offre une variété de paysages et de pistes hors du commun. \r\nRares sont les circuits où chaque journée écrit une nouvelle histoire, dans un décor différent, avec une ambiance et des ethnies différentes, et toujours la même hospitalité bienveillante. \r\nLes hauts-plateaux se découvrent par de belles petites pistes façon « single track » entre blocs de granit et rizières en terrasse, grands lacs et forêts d’eucalyptus. \r\nLa descente vers la côte Ouest commence après la traversée du massif rocheux de l’Itremo à plus de 2000M d’altitude offrant des paysages spectaculaires. \r\nL’arrivée au bord du Canal du Mozambique au milieu des baobabs restera un moment fort de ce circuit, tout comme les premiers contacts avec les lémuriens, et la visite du village de pécheurs Vezo sur l’ile de Bétania. \r\nLes pistes sablonneuses commencent lors de la traversée du bush malgache entouré de milliers de baobabs et de villages primitifs, pour rejoindre le fabuleux lagon d’Andavadoaka et suivre la piste côtière jusqu'à Ankasy et Tulear.	Antananarivo, Antsirabe, Morondava, Andavadoaka, Tulear	2024-11-15 00:00:00	2025-01-20 12:52:15	\N	\N
\.


--
-- Data for Name: itineraires; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.itineraires (id, idcircuit, itineraire, remarque, inserted_at, updated_at) FROM stdin;
1	1	Antananarivo	A votre arrivée à l’aéroport international d’Ivato, vous êtes accueillis et conduits directement à votre hôtel.	2021-11-18 00:00:00	2024-11-18 00:00:00
8	3	J0 – ANTANANARIVO	A votre arrivée à l’aéroport international d’Ivato, vous serez accueillis et conduits directement à votre hôtel.	2024-11-19 00:00:00	2024-11-19 00:00:00
9	3	J10 – TULEAR – ANTANANARIVO (TRANSFERT)	Selon l’heure de votre vol vers Antananarivo, vous pourrez visiter les rues animées de Tuléar et ses marchés multicolores.\n\nUn taxi vous emmènera à l’aéroport pour votre vol retour vers Tana.\n\nFin de nos services.	2024-11-19 00:00:00	2024-11-19 00:00:00
10	3	J12 -VOL INTERNATIONAL	VOL INTERNATIONAL	2024-11-19 00:00:00	2024-11-19 00:00:00
11	4	J0 – TANANARIVE	A votre arrivée à l’aéroport international d’Ivato, vous serez accueillis et conduits directement à votre hôtel.	2024-11-19 00:00:00	2024-11-19 00:00:00
12	4	J4 –RANOMAFANA - MANAKARA –150 km (Bitume)	De bon matin, vous quittez Ranomafana pour une belle route bitumée qui vous conduira jusqu’à Manakara, capitale régionale ; vous pourrez profiter l’après-midi d’une visite du canal des Pangalanes.\n\nDîner et nuit à l’hôtel	2024-11-19 00:00:00	2024-11-19 00:00:00
13	4	J6 –SANDRAVINANY – FORT DAUPHIN – 100 km (Terre)	Cette journée débute par de nouveaux passages de bac : les rivières se succèdent avant une partie assez technique de piste souvent boueuse qui vous mènera jusqu’à Fort Dauphin.\n\nDîner et nuit à l’hôtel	2024-11-19 00:00:00	2024-11-19 00:00:00
14	4	J7 –FORT DAUPHIN ET SES ENVIRONS OU JOURNÉE DE CONGÉ	Fort Dauphin et ses environs ou Journée de congé.	2024-11-19 00:00:00	2024-11-19 00:00:00
15	4	J8 – FORT DAUPHIN – LAVANONO - 250 km (Bitume – Terre - Sable)	Cette très belle étape vous fera passer en quelques dizaines de kilomètres des paysages de foret humide de l’est au bush désertique du sud. Vous traverserez les pays Anosy et Antandroy jusqu’à Lavanono et ses somptueuses plages.\n\nDîner et nuit à l’hôtel	2024-11-19 00:00:00	2024-11-19 00:00:00
16	4	J9 – LAVANONO - BEHELOKA 250 km	J9 – LAVANONO - BEHELOKA 250 km	2024-11-19 00:00:00	2024-11-19 00:00:00
17	4	J10 –BEHELOKA -TULÉAR 250 km	BEHELOKA -TULÉAR 250 km	2024-11-19 00:00:00	2024-11-19 00:00:00
18	4	J11 – TULEAR – ANTANANARIVO (TRANSFERT)	Selon l’heure de votre vol vers Antananarivo, vous pourrez visiter les rues animées de Tuléar et ses marchés multicolores.\n\nUn taxi vous emmènera à l’aéroport pour votre vol retour vers Tana.\n\nFin de nos services.	2024-11-19 00:00:00	2024-11-19 00:00:00
19	4	J12 –VOL INTERNATIONALE	VOL INTERNATIONALE	2024-11-19 00:00:00	2024-11-19 00:00:00
7	2	Jour 1 : Antananarivo – Mantasoa : 100 km	Vous partirez de la capitale pour mettre le cap vers le Nord-Est. Vous arriverez à Anjozorobe et au bord du lac de Tsiazompaniry.\r\nVous appércierez les découvertes sur le chemin et la vue du lac arrivée à destination.	2024-11-19 00:00:00	2025-01-16 11:08:55
20	2	Jour 2 - test 	test	2025-01-16 13:12:45	2025-01-16 13:12:45
23	1	Jour 6 : Ampefy - Tananarive : 180 km	Découverte du lac Itasy avant d'en faire le tour pour découvrir l'ouest des hauts-plateaux, région volcanique unique, qui complètera ces jours en immersion totale autour des grands lacs de la province de Tananarive.	2025-01-29 13:55:22	2025-01-29 13:55:22
2	1	Jour 1 : Antananarivo – Mantasoa : 100 km	Départ le matin direction Mantasoa, entre blocs de granit, rizières en cascade, et forêt d'eucalyptus. Après le déjeuner la balade continue jusqu'au lac de Mantasoa. 	2024-11-18 00:00:00	2025-01-29 11:37:32
3	1	Jour 2 : Mantasoa – Tsiazompaniry : 110 km	Après le tour du lac de Mantasoa, direction le grand lac de Tsiazompaniry. Labyrinthe de pistes dans la forêt et vues panoramiques aux sommets des collines. Nuit au Tsia Island lodge sur une petite ile.	2024-11-18 00:00:00	2025-01-29 11:44:57
4	1	Jour 3 : Tsiazompaniry – Ambatolampy : 95 km	Découverte des environs du lac avant de rejoindre Ambatolampy par des petites pistes offrant de beaux panorama au sommet des collines. Diner et nuit en auberge familiale.	2024-11-18 00:00:00	2025-01-29 13:28:25
21	1	Jour 4 : Ambatolampy - Antsirabe : 150 km	Immersion dans la campagne qui travaille, au milieu des villages traditionnels, des grandes étendues de rizières, des larges pistes de latérite ou on croise de nombreuses charrettes à zébu. Arrivée dans l'après-midi dans la ville thermale d'Antsirabe.	2025-01-29 13:39:24	2025-01-29 13:39:54
22	1	Jour 5 : Antsirabe - Ampefy : 195 km	Départ par la RN7 pour rejoindre la route des volcans jusqu'à Faratsiho, où une piste pure Enduro à flan de montagne nous amènera jusqu'au lac Itasy, avec des vues spectaculaires sur la vallée. Nuit dans la petite ville d'Ampefy entouré de vieux cratères.	2025-01-29 13:49:00	2025-01-29 13:49:00
\.


--
-- Data for Name: nontarif; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nontarif (id, prestation, idcircuit, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: photos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.photos (id, nom, idcircuit, inserted_at, updated_at, photo, principal) FROM stdin;
5	photo	\N	2024-12-12 05:39:12	2024-12-12 05:39:12	IMG_6984.jpg	\N
21	\N	2	2024-12-13 14:39:20	2024-12-13 14:39:20	5348F351-1DB7-4637-A6C4-21E12FD8F2C5.jpeg	t
6	photo	1	2024-12-12 05:45:42	2024-12-12 05:45:42	1.jpg	f
27	\N	1	2024-12-13 14:47:20	2024-12-13 14:47:20	A7038B97-3985-4787-B1FA-704DB145BC05_1_201_a.heic	f
26	\N	1	2024-12-13 14:45:56	2024-12-13 14:45:56	D4B91291-63AF-4FD4-99C8-569FFED47509.jpeg	f
25	\N	1	2024-12-13 14:44:40	2024-12-13 14:44:40	733575AF-6794-45CF-9537-D31899E1B530.jpeg	t
10	photo	\N	2024-12-12 05:50:40	2024-12-12 05:50:40	hot-pepper.svg	\N
30	\N	3	2024-12-13 14:58:51	2024-12-13 14:58:51	AC430FFD-3E2A-4817-9941-19C5B58047D4.jpeg	f
31	\N	3	2024-12-13 15:00:24	2024-12-13 15:00:24	B41D36F4-51BC-448B-840A-4CCBBF34F197.png	f
32	\N	3	2024-12-13 15:00:49	2024-12-13 15:00:49	30963576-5E90-4325-91C6-121D41FC3B84.jpeg	f
33	\N	3	2024-12-13 15:01:22	2024-12-13 15:01:22	36077A4D-E1DB-4154-AFE2-0244FD332817.jpeg	f
13	photo	\N	2024-12-12 10:46:09	2024-12-12 10:46:09	françois.jpg	\N
14	photo	\N	2024-12-12 10:46:20	2024-12-12 10:46:20	guy.jpg	\N
15	photo	\N	2024-12-12 10:46:34	2024-12-12 10:46:34	nanar.jpg	\N
16	photo	\N	2024-12-12 10:46:44	2024-12-12 10:46:44	roger.jpg	\N
17	photo	\N	2024-12-13 08:22:50	2024-12-13 08:22:50	IMG_6984.png	\N
18	\N	\N	2024-12-13 14:26:24	2024-12-13 14:26:24	5348F351-1DB7-4637-A6C4-21E12FD8F2C5.jpeg	\N
19	\N	\N	2024-12-13 14:29:35	2024-12-13 14:29:35	B72F34A5-FE3E-4105-9D17-FCF7A8DD62A2.jpeg	\N
29	\N	3	2024-12-13 14:58:27	2024-12-13 14:58:27	9BCB8876-A254-4785-B863-7979B72FB35C.jpeg	t
20	\N	\N	2024-12-13 14:33:51	2024-12-13 14:33:51	52C04EA5-F468-4F55-9A17-E825E1B833A9.jpeg	\N
34	\N	4	2024-12-13 15:09:18	2024-12-13 15:09:18	86BA5B65-B048-408C-B191-5B6B55F14046.jpeg	f
35	\N	4	2024-12-13 15:10:40	2024-12-13 15:10:40	FB1D882A-D258-4BAC-9AA6-D98F2D70D267.jpeg	f
36	\N	4	2024-12-13 15:12:44	2024-12-13 15:12:44	7EAD4641-5134-43CE-9490-BF3F3487B341.jpeg	t
22	\N	2	2024-12-13 14:40:27	2024-12-13 14:40:27	B72F34A5-FE3E-4105-9D17-FCF7A8DD62A2.jpeg	f
24	\N	2	2024-12-13 14:43:37	2024-12-13 14:43:37	52C04EA5-F468-4F55-9A17-E825E1B833A9.jpeg	f
\.


--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question (id, idcircuit, nom, email, message, inserted_at, updated_at, telephone) FROM stdin;
1	\N	John	stockdreams@growwealthy.info	Dear Creative Entrepreneur,\r\n\r\nToday marks the final opportunity to access StockDreams – the platform that's transformed graphic design into a simple, profitable, and enjoyable process.\r\n\r\n?? Remember, StockDreams is your ticket to:\r\n\r\nCrafting AI-generated visuals that captivate and sell, in mere minutes.\r\n\r\nOpening a floodgate of traffic through eye-catching, SEO-friendly images. It's time to tap into a gold mine that most are overlooking: Google Image Search powered by AI: https://www.growwealthy.info/stockdream \r\n\r\nLaunching a graphic design service that requires zero traditional training.\r\n\r\nEarning from a variety of revenue streams, passive and active, online.\r\n\r\nWe've watched users go from design novices to in-demand pros, selling their artwork on global marketplaces and securing a steady income stream, all thanks to StockDreams' intuitive AI-powered platform.\r\n\r\nBut now, the window is closing.\r\n\r\nThis is your LAST CHANCE to grab StockDreams at the current offer, with full access to all its features – from AI-generated stock images and illustrations to logos, icons, and more, all crafted within a user-friendly editor that’s been a game-changer for so many.\r\n\r\nDon't let hesitation hold you back from what could be the turning point in your creative and financial path.\r\n\r\n?? Click here to claim your access before the clock runs out: https://www.growwealthy.info/stockdream \r\n\r\nAs the saying goes, 'opportunity doesn't knock twice.' This is your moment, seize it with StockDreams and watch as your design capabilities – and revenue – soar to new heights.\r\n\r\nWishing you a future brimming with success and creativity.\r\n\r\nFarewell, for now, let's make these final hours count!\r\n\r\nTo your unlimited creative potential,\r\n\r\nJohn Ford\r\n\r\n\r\nP.S.: Miss this, and you'll miss out on the simplest path to design success and financial growth. Let's end this chapter on a high note. Join us, and let's create masterpieces together with StockDreams.\r\n\r\n\r\n\r\n\r\nUNSUBSCRIBE: https://www.growwealthy.info/unsubscribe/?d=moto-madagascar.com   \r\nAddress: 2089 Kelly Drive\r\nClarksburg, WV 26301	2024-12-26 14:20:19	2024-12-26 14:20:19	0431 47 92 32
2	\N	Lori	vinhgrowth@gmail.com	Hi. We run a YouTube growth service, which increases your number of subscribers both safety and practically.\r\n\r\n- We guarantee to gain you new 700+ subscribers per month\r\n- People subscribe because they are interested in your videos/channel, increasing video likes, comments and interaction.\r\n- All actions are made manually by our team. We do not use any bots.\r\n\r\nThe price is just $60 (USD) per month, and we can start immediately. If you are interested and would like to see some of our previous work, let me know and we can discuss further.\r\n\r\nKind Regards,\r\n\r\nTo Unsubscribe, reply with the word unsubscribe in the subject.	2025-01-03 11:23:00	2025-01-03 11:23:00	9289139524
3	\N	Jennifer	openappai20@dollartip.info	Hey moto-madagascar.com,\r\n\r\nImagine this: you have an idea for a fantastic mobile app, but the thought of coding or hiring a developer stops you cold.\r\n\r\nWhat if I told you there's a revolutionary AI tool that can turn your website URL, blog, keywords, or even just your ideas into a fully functional Android and iOS app...   in under a minute?\r\n\r\nIt's true!\r\n\r\nIntroducing..    OpenApp AI 2.0\r\n\r\n==> Watch OpenApp AI 2.0 Demo In Action: https://www.dollartip.info/openappai20 \r\n\r\nThis game-changing app uses powerful AI to create stunning mobile apps for any niche, without needing any coding experience.    Here's what you can do:\r\n\r\nTransform your website, blog, or even just keywords into a beautiful and functional app.\r\n\r\nBuild an app from scratch based on your ideas.\r\n\r\nDesign your app with their library of 1500+ professional templates.\r\n\r\nPublish your app to the Google Play Store and Apple App Store in a flash!\r\n\r\nPlus, you can integrate payments, send push notifications, and even manage users directly through the platform.\r\n\r\nDon't miss out on this opportunity to join the ranks of successful app entrepreneurs.    Join the OpenApp AI 2.0 revolution and start building your app empire today!\r\n\r\nAccess OpenApp AI 2.0 Now and Build Your Dream Mobile App in Seconds: https://www.dollartip.info/openappai20 \r\n\r\nOops, did I forget to mention…\r\nYou’re also getting exclusive bonuses worth $....    that will make this deal an unforgettable affair .\r\n\r\nBut these are available for a very limited time.\r\n\r\nSo, don’t you dare miss out on this.\r\n\r\nJennifer Marcil\r\n\r\n\r\n\r\n\r\nUNSUBSCRIBE: https://www.dollartip.info/unsubscribe/?d=moto-madagascar.com \r\nAddress: 1867 Edgewood Road\r\nMemphis, TN 38110	2025-01-19 15:56:09	2025-01-19 15:56:09	027 915 88 72
4	\N	Rafael	mdatraffic@getmoreopportunities.info	Hi moto-madagascar.com !\r\n\r\nIf you’re ready to boost your sales and commissions, MDA Traffic has a quick, cost-free hack that only takes 10-15 minutes to set up.\r\n\r\nThis isn’t another ad platform or social media strategy – it’s a method that leverages Google traffic without SEO, cost, or complexity.\r\n\r\nHere’s how it works: MDA Traffic uses third-party assets, AI, and targeted “buyer intent” phrases to help you land high up in Google search results in days: https://www.getmoreopportunities.info/mdatraffic .\r\n\r\nYou don’t need any experience or a budget.   Just follow the simple steps, and you could start seeing results in 1-3 days.\r\n\r\nImagine reaching Google’s top pages for keywords people are already searching.\r\n\r\nIt’s a beginner-friendly way to get noticed without spending hours on SEO or competing with hundreds of others.\r\n\r\nWant to see it in action?\r\n\r\nLearn more about MDA Traffic here: https://www.getmoreopportunities.info/mdatraffic \r\n\r\nRafael Jenkins\r\n\r\n\r\n\r\nUNSUBSCRIBE: https://www.getmoreopportunities.info/unsubscribe/?d=moto-madagascar.com \r\nAddress: 3050 Weekley Street\r\nSan Antonio, TX 78023\r\n	2025-01-19 22:49:52	2025-01-19 22:49:52	440 5584
5	\N	DuaneWak	0dayflaclabels@gmail.com	Hello, \r\n \r\nExclusive promo quality music for VIP DJ's https://sceneflac.blogspot.com \r\n440TB MP3/FLAC, Label, LIVESETS, Music Videos.  fans that help you gain full access to exclusive electronic music. \r\n \r\nSceneflac team.	2025-01-21 08:46:10	2025-01-21 08:46:10	86823747138
6	\N	Heather	spark@increasetraffic.shop	\r\nWhat if I told you today your LAST EVER payment for a hosting service is due…\r\n\r\n…and yet you’d still get 100% uptime, blazingly fast loading times,\r\nSUPERIOR service and the best possible support Webmasters/Internet Marketers\r\nwish for\r\n\r\nAND – brand new for 2025: your own premium accounts to over 99\r\ndifferent Ais, including the newly released Sora AI\r\n\r\n Now you can = Introducing SPARK Cloud Hosting: https://www.increasetraffic.shop/spark \r\n\r\nSPARK is the next step in cloud hosting. A revolution like no other that enables you to enjoy:\r\n\r\n[+] Faster loading websites than ever before\r\n[+] 60-Second Quick Setup Using Built-in Wizard\r\n[+] Built-in “ClickFunnels KILLER” drag & drop funnel builder\r\n[+] 100% uptime with free SSL encryption built-in\r\n[+] Unlimited sites, email accounts & more\r\n[+] Next-Generation Control Panel\r\n[+] Free one-click Wordpress installer\r\n[+] 24/7 support from marketing gurus\r\n\r\n… and here’s the kicker: you get all of this, for LIFE, with just ONE time low fee today…\r\n\r\nand if you act FAST, you get the “ClickFunnels killer” drag&drop page and funnel builder FREE:\r\n\r\n\r\n Get started now (available ONLY during early bird): https://www.increasetraffic.shop/spark \r\n\r\nPlus, get never-seen before features like DDOS protection, built-in malware security and a hacker-proof dedicated server cluster so your sites never go down and never get hacked!\r\n\r\n\r\n… and here’s the kicker: you get all of this PLUS immediate direct access to over 99 premium paid Ais, including… \r\n\r\nSora AI, \r\nChatGPT 4 omni Plus\r\nGoogle Gemini Ultra Advanced\r\nDallE 3 HD\r\nWhisper AI Text-to-Speech\r\nMidjourney Mega\r\nLeonardo AI PRO Plan\r\nMicrosoft Copilot Pro\r\nMeta Llama 3.1\r\n\r\nAnd more.\r\n\r\nGet this today – and enjoy lifetime hosting for nothing (yes that’s zero\r\nfuture hosting payments)\r\n\r\nYou’re finally able to cancel one of those pesky monthly subscriptions that keep\r\nadding up – and yet get BETTER service than before still!\r\n\r\nIt’s a true win-win, but only available until the timer on the page hits ZERO so HURRY!\r\n\r\nOh, and wait till you see the price – you get lifetime hosting for LESS than what you previously used to pay for one month of service!\r\n\r\n Click here now to claim yours: https://www.increasetraffic.shop/spark \r\n\r\nTo your success,\r\nHeather Young\r\n\r\n\r\n\r\nUNSUBSCRIBE: https://www.increasetraffic.shop/unsubscribe/?d=moto-madagascar.com \r\nAddress: 1968 Logan Lane\r\nDenver, CO 80205\r\n	2025-01-22 04:25:58	2025-01-22 04:25:58	02.44.49.59.07
7	\N	Patrick	mdatraffic@goldtip.shop	Hi moto-madagascar.com,\r\n\r\nHave you ever wanted to get on Google’s page 1 without having to worry about SEO?\r\nWith MDA Traffic, it’s possible, and the best part – it doesn’t cost a thing .\r\n\r\nMDA Traffic uses a clever combination of high-authority sites, interest spikes, and AI to help you rank quickly for valuable, targeted phrases: https://www.goldtip.shop/mdatraffic .\r\n\r\nYou don’t need experience or any technical knowledge.   Just a few minutes to follow the steps, and you’re ready to roll!\r\n\r\nImagine how much targeted traffic you could drive in just a few days.\r\n\r\nWhether you’re promoting affiliate offers, selling your own products, or growing a YouTube channel, MDA Traffic can help you reach the right audience fast.\r\n\r\nReady to get started?\r\n\r\nClick here to discover how to use MDA Traffic: https://www.goldtip.shop/mdatraffic !\r\n\r\nPatrick House\r\n\r\n\r\nUNSUBSCRIBE: https://www.goldtip.shop/unsubscribe/?d=moto-madagascar.com \r\nAddress: 2153 Liberty Avenue\r\nAnaheim, CA 92805\r\n	2025-01-23 09:16:43	2025-01-23 09:16:43	08330 30 56 92
8	\N	Jason	liveblueprint@unlockrevenue.info	Hi,\r\n\r\nMedia Labs has helped thousands make 60-second videos and earn thousands monthly. \r\n\r\nBusinesses struggle to find skilled creators. At Media Labs, we train creators to be the internet's best, connecting them with brands ready to pay generously for top-notch content.  Join us to start making serious, reliable WIFI money: https://www.unlockrevenue.info/liveblueprint .\r\n\r\nYou will get:\r\n\r\nStable monthly income directly deposited to your bank for making content.\r\nNear immediate access to brand deals and retainers after passing our entry quiz.\r\nAccess to 7 $100,000+ GMV coaches for video feedback\r\nWeekly live calls with the community\r\nUnlock the secrets to VIRAL Livestreams that generate THOUSANDS: https://www.unlockrevenue.info/liveblueprint \r\n\r\n\r\nBest,\r\nJason Klinger\r\n\r\n\r\n\r\nUNSUBSCRIBE: https://www.unlockrevenue.info/unsubscribe/?d=moto-madagascar.com \r\nAddress: 2579 Ritter Street\r\nBirmingham, AL 35203	2025-01-24 05:57:43	2025-01-24 05:57:43	079 3446 8107
9	\N	Bradley	mdatraffic@getprofitnow.info	Hello moto-madagascar.com !\r\n\r\nMDA Traffic is a revolutionary method designed for both beginners and experienced marketers.\r\n\r\nWhether you’re looking to get more visits, boost sales, or increase affiliate commissions, this system makes it easy to drive targeted traffic – even if you’ve never done it before.\r\n\r\nWith just 10-15 minutes, you can set up what we call a “traffic conduit” – a way to direct Google search traffic to your website without spending a cent: https://www.getprofitnow.info/mdatraffic .\r\n\r\nThis is 100% legal, completely beginner-friendly, and gets you on Google’s page 1 .\r\n\r\nImagine being able to drive traffic from one of the world’s largest search engines without a single ad dollar.\r\n\r\nThat’s the power of MDA Traffic.   Ready to find out more?\r\n\r\nClick here to unlock targeted traffic today: https://www.getprofitnow.info/mdatraffic !\r\n\r\nBradley Heuer\r\n\r\n\r\nUNSUBSCRIBE: https://www.getprofitnow.info/unsubscribe/?d=moto-madagascar.com \r\nAddress: 2622 Benson Street\r\nGoodman, WI 54125	2025-01-26 02:11:28	2025-01-26 02:11:28	070 0639 1254
10	\N	Cherie	kaizen@growwealthy.info	Join forces with industry-leading analysts boasting over 5000+ winning trades since September 2023, guiding you through this year’s bull run with unmatched expertise.\r\n\r\n\r\nWe help you make money in crypto - Kaizen is a premium crypto membership offering expert trade setups, in-depth research, market insights, educational content, and a supportive community to help you win in crypto: https://www.growwealthy.info/kaizen .\r\n\r\nWhat you will get:\r\n\tReceive reliable, high-quality trading signals to enhance your market entries.\r\n\tAccess real-time market analysis and strategies from expert traders.\r\n\tGet detailed breakdowns of market trends and forecasts to improve your trading.\r\n\tJoin a network of traders sharing strategies, tips, and support.\r\n\tGain access to courses and materials to improve your skills and knowledge.\r\n\r\nWebmaster like you have turned his 18k portfolio into 28k in just two weeks: https://www.growwealthy.info/kaizen .         \r\n\r\nCherie Bennett\r\n\r\n\r\n\r\nUNSUBSCRIBE: https://www.growwealthy.info/unsubscribe/?d=moto-madagascar.com  \r\nAddress: 2767 Franklee Lane\r\nPortland, PA 97205\r\n	2025-01-28 02:41:28	2025-01-28 02:41:28	905-380-3077
11	\N	Paul	coursemateai@greatbusi.info	Hi ,\r\n\r\nWow...\r\n\r\nThis new AI eLearning platform has blown me away, and I can't stop myself from sharing it with you...\r\n\r\nWhat if you could have an all-in-one eLearning business solution with your own marketplace, courses, and a built-in student interface for practically pennies?\r\n\r\n=>> Check this out: https://www.greatbusi.info/coursemateai \r\n\r\nIt's called CourseMateAi, and I think you're really going to like it.\r\n\r\nHow would you like to turn any IDEA into a profitable eLearning business?\r\n\r\nAnd to do it WITHOUT any hassle or technical skills?\r\n\r\nWell! The time has come to make that happen!\r\n\r\nCourseMateAi is a brand new web-based platform that lets you start your own eLearning business in a matter of minutes.\r\n\r\nCheck out some of the great benefits of CourseMateAi:\r\n\r\n[+] Start your own business with NO experience required\r\n[+] Turn mere ideas into full educational courses with AI\r\n[+] Create your own academy sites in just minutes\r\n[+] Use AI to generate courses to start selling immediately\r\n[+] Sell courses on your own marketplace & keep 100% profits\r\n[+] Create courses on any Topic – Become authority in any Niche\r\n[+] Manage your courses, students, payments & more from one dashboard\r\n[+] Create courses quick & easy – add unlimited lessons with AI\r\n[+] Keep 100% of the profits, traffic & leads\r\n[+] Target multiple niches and markets\r\n[+] And so much more...\r\n\r\nI know it sounds incredible, which is why you really just need to see it. Check out the demo here: https://www.greatbusi.info/coursemateai \r\n\r\nTo be clear, you don't even have to create your own courses. You simply harness the power of AI to generate brand new original courses from scratch.\r\n\r\nRight now they are offering it on a special launch deal. As you will see on the page, the price is going to increase very soon.\r\n\r\nTherefore I recommend checking it out today, and claim your access to everything with this special deal... while you still can: https://www.greatbusi.info/coursemateai \r\n\r\nNow is the perfect time to get into this business, as the eLearning industry is exploding with growth. Don't wait, join me on CourseMateAi today!\r\n\r\nTo your success,\r\n\r\nPaul Vaughan\r\n\r\n\r\nUNSUBSCRIBE: https://www.greatbusi.info/unsubscribe/?d=moto-madagascar.com  \r\nAddress: 73 Heavens Way\r\nWinter Haven, FL 33830	2025-01-28 04:03:04	2025-01-28 04:03:04	619-744-5711
12	\N	Wayne	gptdash@dollartip.info	Hi,\r\n\r\nAre you struggling to create content that not only engages your audience but also drives profits for your business?\r\n\r\nLook no further than this new AI solution: https://www.dollartip.info/gptdash \r\n\r\nThis dashboard was designed by top internet marketers and copywriters who know how to leverage ChatGPT to create profitable content. With GPTDash, all you have to do is enter a few keywords and let the engine do the rest.\r\n\r\nThe result? Original, engaging, and profitable content that will set you apart from your competition. Plus, with this easy-to-use dashboard, you'll save valuable time and resources.\r\n\r\nDon't just take my word for it. I encourage you to try GPTDash today and see the results for yourself. There is a launch special today that I don't want you to miss: https://www.dollartip.info/gptdash \r\n\r\nStay ahead of the game with this new AI dashboard. As always, I'm here to help you succeed.\r\n\r\nTo your success,\r\n\r\nWayne Brady\r\n\r\n\r\n\r\nUNSUBSCRIBE: https://www.dollartip.info/unsubscribe/?d=moto-madagascar.com \r\nAddress: 4657 Cross Street\r\nSaginaw, MI 48601\r\n	2025-01-29 10:28:32	2025-01-29 10:28:32	06-73034676
13	\N	TedRaF	moqagides18@gmail.com	Hi, kam dashur të di çmimin tuaj	2025-01-29 11:33:34	2025-01-29 11:33:34	83398452451
14	\N	Mack	mdatraffic@moredollar.info	Hi moto-madagascar.com !\r\n\r\nIf you’re ready to boost your sales and commissions, MDA Traffic has a quick, cost-free hack that only takes 10-15 minutes to set up.\r\n\r\nThis isn’t another ad platform or social media strategy – it’s a method that leverages Google traffic without SEO, cost, or complexity.\r\n\r\nHere’s how it works: MDA Traffic uses third-party assets, AI, and targeted “buyer intent” phrases to help you land high up in Google search results in days: https://www.moredollar.info/mdatraffic .\r\n\r\nYou don’t need any experience or a budget.   Just follow the simple steps, and you could start seeing results in 1-3 days.\r\n\r\nImagine reaching Google’s top pages for keywords people are already searching.\r\n\r\nIt’s a beginner-friendly way to get noticed without spending hours on SEO or competing with hundreds of others.\r\n\r\nWant to see it in action?\r\n\r\nLearn more about MDA Traffic here: https://www.moredollar.info/mdatraffic \r\n\r\nMack Fowler\r\n\r\n\r\n\r\nUNSUBSCRIBE: https://www.moredollar.info/unsubscribe/?d=moto-madagascar.com \r\nAddress: 1531 Hartland Avenue\r\nGreen Bay, WI 54302	2025-01-30 05:06:25	2025-01-30 05:06:25	(02) 4734 9235
\.


--
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservations (id, idcircuit, nom, email, telephone, participant, date_res, besoin, archivage, validation, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version, inserted_at) FROM stdin;
20241119072556	2024-11-20 12:24:53
20241119072609	2024-11-20 12:24:53
20241121114500	2024-11-29 11:40:15
20241125132417	2024-11-29 11:40:15
20241127063958	2024-11-29 11:40:15
20241203085009	2024-12-05 06:37:38
20250122130413	2025-01-23 13:39:59
20250122130545	2025-01-23 13:39:59
\.


--
-- Data for Name: tarif; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tarif (id, prestation, idcircuit, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, hashed_password, confirmed_at, inserted_at, updated_at) FROM stdin;
1	adminMotoTour@gmail.com	$pbkdf2-sha512$160000$hqa7KEfYpuoNs.hFYsoLTw$Qj6qkwzG2WjrBCMw8TOIqXIRQK7J9Haa3Hxeu6hN6WuEih2GrTNIcx3jRkVfNONhQ6YB17Bu4eo2NDcXHLO07g	\N	2024-12-05 05:30:01	2024-12-05 05:30:01
\.


--
-- Data for Name: users_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_tokens (id, user_id, token, context, sent_to, inserted_at) FROM stdin;
1	1	\\x9b405a1eb0f011eea15af8e5004e6adb75f2eb58212d31f574624a6239776980	confirm	adminMotoTour@gmail.com	2024-12-05 05:30:01
4	1	\\x8d36c085570ef0937b57372021e5d8c4f5ac84cf8a3b866713968e4fea956055	session	\N	2024-12-05 08:31:29
8	1	\\x898635aa16e7fad2c8f70a7f97b2f40fbe1c1871afdac30deba27ff8fd054ad2	session	\N	2024-12-05 11:57:03
9	1	\\x6d3a1ed85be4edc2aea7026f32b326d42e8ea25a9af3def807c88704d210308d	session	\N	2024-12-05 12:14:47
10	1	\\xdf9c03af5b2518356f0ba242f943e0aecac284d2e71541023eb85f939648fc8f	session	\N	2024-12-05 12:21:30
11	1	\\x9bd26ce4b4b7996e9fd757d9a14ec1e8a7f68b9e2581030ab389b9a9a1b3d4c7	session	\N	2024-12-06 08:10:09
12	1	\\x222e534ce74a10ec573d3ba38c01de8c963a6572a71f43cc0f7fb1974a55ba65	session	\N	2024-12-10 13:41:04
13	1	\\x53d9cde83f4c635b4698a6a1a0245783f988689534f1eca782551e27b4212150	session	\N	2024-12-12 05:32:04
14	1	\\x42bc44b58b06674f9767970d3afdc96c7809b8fa9deafcd0e65403ddaa05ece4	session	\N	2024-12-12 07:07:27
15	1	\\xfdbe47c493beb75c3fec25f5b14ba307d0390934a8ef4e229b3d2fd46fa092ac	session	\N	2024-12-12 10:17:28
18	1	\\x2b64166946930cf99004e476b7d5dc8e7c66c25e331a740884df2199bacd751b	session	\N	2024-12-12 13:19:16
19	1	\\xe5411f90312e2767f0bfb1cee1a29f9a13717e55caf9e81ace00425edaa6cc1b	session	\N	2024-12-13 08:22:24
20	1	\\xf8a47a3e04e3e50a823f96a2858df2f0c06e9d444d577b01bb44c1c6bb838b0a	session	\N	2024-12-13 14:25:00
21	1	\\x5d4a6855a174bb76a961a436f4224ebe45a34d1a258dd0178683e9377b300ae3	session	\N	2024-12-20 06:27:49
22	1	\\xbbd30432b03b2f7876dc3a801c42bdf7e5a308037bf4b9558d54d2fd0899668a	session	\N	2024-12-23 11:22:21
23	1	\\x816742e599a4304f6e146adf0b3cb62ddb93f087f36129816a17603339893059	session	\N	2024-12-27 13:39:09
24	1	\\x13cd56d919df39f6fc0398d0887d0c952c91ada556c53a1da5ebcbee4d552c68	session	\N	2024-12-30 07:27:08
25	1	\\xc40e7480839964b0a796eca781885511c61a0ea2ce951104d0df4228153a29bb	session	\N	2024-12-31 08:17:08
26	1	\\x415b07c583b58d6c42317a48180b91b4db6ef08bd2c3846607d7348deca3bade	session	\N	2025-01-03 14:06:42
28	1	\\x8020d531ccb9ec1304046f016b0a96b4d1e0a6fbdec4b634cd05639b0db6cc4c	session	\N	2025-01-07 12:25:16
29	1	\\xe2201f2bcc312be2c1da1c5a7512dc2c78fd9019a5e566481ea709c1178b936e	session	\N	2025-01-10 08:00:26
31	1	\\xa561b6fa763bc1ee85de2f3cfa2bcfc91702bef5139bc6c7e8fa460ca5690480	session	\N	2025-01-16 11:03:35
33	1	\\xdc4cd717f14e3009b57ca2a26c25b2404977bb9a8688e06fea65ec5a94a3b77a	session	\N	2025-01-17 11:34:57
35	1	\\x36242ee7ac9172dca3269efe81c97876799ec98a9976d3f9747a5399a88b324e	session	\N	2025-01-17 13:51:01
37	1	\\x61846dbbc09898cbc6c776fa7371905e22864f5fbec86f1f2f307e99dc3ec470	session	\N	2025-01-20 08:22:32
38	1	\\xfa9feeaa3091771024948ac2ec01bc0921177b4d6c83d25fb35913fdf1dac6a1	session	\N	2025-01-20 12:42:24
42	1	\\x74ec19ac36be84422672098da173ff28f7a5c2bee0e59e1524cc2f05dd611aca	session	\N	2025-01-21 05:36:02
43	1	\\x775a56aaa8b1dc8996c132cbc113ab203fd9b4e9dea126ee8fa10b9362c275bc	session	\N	2025-01-22 05:57:53
44	1	\\xeb7bc21ecf17dce22e16440754014a08d0353100639b8c102faeafb5a72aa51d	session	\N	2025-01-23 13:40:37
46	1	\\x1ad59933e7f4fbc2d5ed14bcfaf2a0c13420e2fc2f9f2df7607d053cd965593a	session	\N	2025-01-24 11:26:10
47	1	\\xfe4f499adc5d061449085a7777d3c5d92ec338cb226c71980d9ec08372b16ce3	session	\N	2025-01-24 14:24:58
50	1	\\xa503a2e3134e6ed176f936e494eb5e77c5b6d1deefe3984b8c3777d0bd1dbfb0	session	\N	2025-01-29 11:03:22
52	1	\\x7d3c6bb54fe7dba6dce4107e2c341734853ffd2167fc20ab823832ee493dfbc8	session	\N	2025-01-30 12:52:33
\.


--
-- Name: circuits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.circuits_id_seq', 6, true);


--
-- Name: itineraires_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.itineraires_id_seq', 25, true);


--
-- Name: nontarif_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nontarif_id_seq', 1, true);


--
-- Name: photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.photos_id_seq', 38, true);


--
-- Name: question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_id_seq', 14, true);


--
-- Name: reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservations_id_seq', 1, false);


--
-- Name: tarif_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tarif_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: users_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_tokens_id_seq', 52, true);


--
-- Name: circuits circuits_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.circuits
    ADD CONSTRAINT circuits_pkey PRIMARY KEY (id);


--
-- Name: itineraires itineraires_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.itineraires
    ADD CONSTRAINT itineraires_pkey PRIMARY KEY (id);


--
-- Name: nontarif nontarif_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nontarif
    ADD CONSTRAINT nontarif_pkey PRIMARY KEY (id);


--
-- Name: photos photos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.photos
    ADD CONSTRAINT photos_pkey PRIMARY KEY (id);


--
-- Name: question question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT question_pkey PRIMARY KEY (id);


--
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: tarif tarif_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif
    ADD CONSTRAINT tarif_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_tokens users_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_tokens
    ADD CONSTRAINT users_tokens_pkey PRIMARY KEY (id);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_email_index ON public.users USING btree (email);


--
-- Name: users_tokens_context_token_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_tokens_context_token_index ON public.users_tokens USING btree (context, token);


--
-- Name: users_tokens_user_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_tokens_user_id_index ON public.users_tokens USING btree (user_id);


--
-- Name: users_tokens users_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_tokens
    ADD CONSTRAINT users_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

