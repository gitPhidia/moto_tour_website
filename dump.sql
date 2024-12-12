--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

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
    tarifs numeric,
    "durée" character varying(255),
    participant character varying,
    moto character varying(255),
    "difficulté" integer,
    photo character varying(255),
    details text,
    remarque text,
    desc_card text,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
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


ALTER SEQUENCE public.circuits_id_seq OWNER TO postgres;

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


ALTER SEQUENCE public.itineraires_id_seq OWNER TO postgres;

--
-- Name: itineraires_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.itineraires_id_seq OWNED BY public.itineraires.id;


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


ALTER SEQUENCE public.photos_id_seq OWNER TO postgres;

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
    updated_at timestamp(0) without time zone NOT NULL
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


ALTER SEQUENCE public.question_id_seq OWNER TO postgres;

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


ALTER SEQUENCE public.reservations_id_seq OWNER TO postgres;

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


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

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


ALTER SEQUENCE public.users_tokens_id_seq OWNER TO postgres;

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

COPY public.circuits (id, nom, tarifs, "durée", participant, moto, "difficulté", photo, details, remarque, desc_card, inserted_at, updated_at) FROM stdin;
4	Le Sud Sauvage	3690	11 j - 11 nuits (10 jours de moto)	\N	\N	5	4.jpg	<div class="container_details">\r\n  <h2 class="lead">Programme de Voyage</h2>\r\n  \r\n  <section class="lead-text">\r\n    <h5 class="text-primary">Sites Marquants</h5>\r\n    <ul class="list-group">\r\n      <li class="list-group-item">Découverte d’Antsirabe</li>\r\n      <li class="list-group-item">Ambositra, capitale de l’artisanat malgache</li>\r\n      <li class="list-group-item">Réserve de Ranomafana</li>\r\n      <li class="list-group-item">Canal des Pangalanes</li>\r\n      <li class="list-group-item">Fort Dauphin</li>\r\n      <li class="list-group-item">Faux Cap / Lavanono</li>\r\n      <li class="list-group-item">Réserve naturelle de Tsimanampetsotsa</li>\r\n      <li class="list-group-item">Anakao</li>\r\n    </ul>\r\n  </section>\r\n  \r\n  <section class="lead-text">\r\n    <h5 class="text-primary">Nos Prestations Comprennent</h5>\r\n    <ul class="list-group">\r\n      <li class="list-group-item">Une moto enduro spécialement préparée pour votre voyage</li>\r\n      <li class="list-group-item">L’assurance responsabilité civile en cas d’accident avec votre moto</li>\r\n      <li class="list-group-item">Un guide expérimenté dans l’accompagnement de raids moto</li>\r\n      <li class="list-group-item">Un véhicule 4x4 d’assistance avec chauffeur transportant vos bagages et l’équipement mécanique (pour 5 motards et plus)</li>\r\n      <li class="list-group-item">L’hébergement en chambre double/twin (catégorie standard ou supérieure selon votre choix)</li>\r\n      <li class="list-group-item">Les repas en pension complète (petit-déjeuner et dîner à l’hôtel, paniers-déjeuner pour le repas du midi)</li>\r\n      <li class="list-group-item">Les droits d’entrée et de guidage pour la visite des parcs et monuments prévus durant votre voyage</li>\r\n      <li class="list-group-item">Les transferts aéroport – hôtel</li>\r\n      <li class="list-group-item">Les taxes et vignettes touristiques</li>\r\n    </ul>\r\n  </section>\r\n  \r\n  <section class="lead-text">\r\n    <h5 class="text-primary">Nos Prestations Ne Comprennent Pas</h5>\r\n    <ul class="list-group">\r\n      <li class="list-group-item">Les assurances personnelles pour votre séjour à Madagascar, telles que l’assurance rapatriement</li>\r\n      <li class="list-group-item">Les frais de visa</li>\r\n      <li class="list-group-item">Les vols internationaux et nationaux et les taxes d’aéroport</li>\r\n      <li class="list-group-item">Une caution de 1 000 euros en chèque ou espèces pour l’utilisation de votre moto</li>\r\n      <li class="list-group-item">Les repas lors de jours de transfert</li>\r\n      <li class="list-group-item">Les dépenses personnelles (boissons, pourboires, divers achats)</li>\r\n      <li class="list-group-item">Les droits d’entrée aux monuments et parcs non prévus dans le programme du voyage</li>\r\n    </ul>\r\n  </section>\r\n  \r\n  <section class="lead-text">\r\n    <h5 class="text-primary">Tarif</h5>\r\n    <p>Sur la base d’un groupe de 10 pilotes, le tarif inclut :</p>\r\n    <ul class="list-group">\r\n      <li class="list-group-item">Le transfert et l’hôtel à l’arrivée de l’aéroport</li>\r\n      <li class="list-group-item">L’hébergement en pension complète</li>\r\n      <li class="list-group-item">La location et le carburant de la moto</li>\r\n      <li class="list-group-item">Le guide Moto Accompagnateur</li>\r\n      <li class="list-group-item">Le 4x4 d’assistance avec son carburant</li>\r\n      <li class="list-group-item">Le vol interne province – Tananarive</li>\r\n    </ul>\r\n  </section>\r\n</div>	Le Sud de Madagascar s’offre à vous : entre ciel et mer, au milieu d’un paysage de bush et de sable semi-désertique, vous découvrirez une culture et une nature à nul autre pareil. Cette descente progressive depuis les hautes terres jusqu’aux côtes de l’est vous permettra d’apprécier une multitude de paysages et de types de piste : sable, terre, boue ponctueront un parcours difficile mais somptueux.	Antananarivo, Tuléar, Ambositra, Manakara, Fort-Dauphin, Ranomafana, Lavanono, Itampolo, Anakao	2024-11-15 00:00:00	2024-12-10 14:18:37
3	La piste des Baobabs	3390	10 j - 11nuits (09 jours de moto)	\N	\N	5	3.jpg	<div class="container_details">\n  <h2 class="lead">Programme de Voyage</h2>\n  \n  <section class="lead-text">\n    <h5 class="text-primary">Sites Marquants</h5>\n    <ul class="list-group">\n      <li class="list-group-item">Lac de Mantasoa et forêt d’eucalyptus</li>\n      <li class="list-group-item">Ville thermale Antsirabe</li>\n      <li class="list-group-item">Passage du col de l’Itremo</li>\n      <li class="list-group-item">Visite de l’Allée des Baobabs</li>\n      <li class="list-group-item">Visite du parc et de la réserve de Kirindy</li>\n      <li class="list-group-item">Dunes de sable et plages de Salary</li>\n      <li class="list-group-item">Ifaty – Tuléar</li>\n    </ul>\n  </section>\n  \n  <section class="lead-text">\n    <h5 class="text-primary">Nos Prestations Comprennent</h5>\n    <ul class="list-group">\n      <li class="list-group-item">Une KTM 350 EXCF 2017 enduro spécialement préparée pour votre voyage</li>\n      <li class="list-group-item">L’assurance responsabilité civile en cas d’accident avec votre moto</li>\n      <li class="list-group-item">Un guide expérimenté dans l’accompagnement de raids moto</li>\n      <li class="list-group-item">Un véhicule 4x4 d’assistance avec chauffeur transportant vos bagages et l’équipement mécanique</li>\n      <li class="list-group-item">L’hébergement en chambre double/twin (catégorie standard ou supérieure selon votre choix)</li>\n      <li class="list-group-item">Les repas en pension complète (petit-déjeuner et dîner à l’hôtel, paniers-déjeuner pour le repas du midi)</li>\n      <li class="list-group-item">Les droits d’entrée et de guidage pour la visite des parcs et monuments prévus durant votre voyage</li>\n      <li class="list-group-item">Les transferts aéroport – hôtel</li>\n      <li class="list-group-item">Les taxes et vignettes touristiques</li>\n    </ul>\n  </section>\n  \n  <section class="lead-text">\n    <h5 class="text-primary">Nos Prestations Ne Comprennent Pas</h5>\n    <ul class="list-group">\n      <li class="list-group-item">Les assurances personnelles pour votre séjour à Madagascar, telles que l’assurance rapatriement</li>\n      <li class="list-group-item">Les frais de visa</li>\n      <li class="list-group-item">Les vols internationaux et nationaux et les taxes d’aéroport</li>\n      <li class="list-group-item">Une caution de 2 000 euros en chèque ou espèces pour l’utilisation de votre moto</li>\n      <li class="list-group-item">Les repas lors de jours de transfert</li>\n      <li class="list-group-item">Les dépenses personnelles (boissons, pourboires, divers achats)</li>\n      <li class="list-group-item">Les droits d’entrée aux monuments et parcs non prévus dans le programme du voyage</li>\n    </ul>\n  </section>\n  \n  <section class="lead-text">\n    <h5 class="text-primary">Tarif</h5>\n    <p>Sur la base d’un groupe de 10 pilotes, le tarif inclut :</p>\n    <ul class="list-group">\n      <li class="list-group-item">Le transfert et l’hôtel à l’arrivée de l’aéroport</li>\n      <li class="list-group-item">L’hébergement en pension complète</li>\n      <li class="list-group-item">La location et le carburant de la moto</li>\n      <li class="list-group-item">Le guide Moto Accompagnateur</li>\n      <li class="list-group-item">Le 4x4 d’assistance avec son carburant</li>\n      <li class="list-group-item">Le vol interne province – Tananarive</li>\n    </ul>\n  </section>\n</div>\n	Bienvenue à Madagascar. Nous réservons ce périple de 9 jours aux motards ayant déjà une expérience de la moto tout-terrain. Aucune notion de vitesse dans nos circuits, mais il faut être d’esprit sportif, et avoir un minimum de technique pour apprécier en toute sécurité la piste et les paysages traversés. \nLa variété hors normes de ce parcours Enduro qui part de la capitale Antananarivo située dans les hauts-plateaux, jusqu’aux pistes côtières longeant le Canal du Mozambique, \njustifie les efforts quotidiens. Beau mais pas facile, il faut gérer sur la longueur du circuit les pistes de latérite rouge, \ntantot dur comme du béton, tantot patinoire si la pluie se mêle de la partie, et les pistes de sables qui réclament un peu de technique. \nC’est ce circuit qui est à l’origine de l’Aventure Malgache qui continue depuis 25 ans…	Antananarivo, Tuléar, Antsirabe, Morondava, Manja, Andavadoaka	2024-11-15 00:00:00	2024-11-15 00:00:00
1	Les trois lacs en 6 jours	1890	6 jours, dont 6 jours de moto, circuit de 900 km	\N	 KTM 350 – 450	3	1.jpg	Parcours journalier,Région : Hauts plateaux	En quête d’aventure, sillonner les toits de Madagascar avec cet enduro de 6 jours sur les pistes des trois lacs. Ce parcours autour des hauts plateaux vous réservera : plusieurs kilomètres de routes, pistes, terres et boues. En partant de la capitale, découvrez la végétation le long de la RN2. Faites des rencontres avec la population aussi hospitalière, et découvrez les spécialités culinaires locales.     Surtout, sur votre moto, profitez des magnifiques paysages, des rizières, cultures en terrasse et de la vue sur les sentiers volcaniques d’Ampefy.	Antananarivo, Antsirabe, Anjozorobe, Ampefy, Mantasoa, Ambatolampy	2024-11-15 00:00:00	2024-12-10 13:50:13
2	Les 2 lacs en 3 jours	990	3 jours, dont 3 jours de moto, circuit de 450 km	\N	  KTM 350 – 450	2	2.jpg	Parcours journalier,Région : Hauts plateaux	Circuit sur les pistes des deux lacs en trois jours sera une grande aventure et des difficultés destinées aux enduristes confirmés.    Prendre la route pour arriver au bord du lac de Tsiazompaniry, le plus grand lac barrage du pays, puis continuer vers l’Est pour visiter le célèbre lac de Mantasoa et le village,    appréciez chaque instant en découvrant les multiples facettes des hauts plateaux. Pendant ce circuit, vous serez servis par la beauté des paysages naturelles des hautes terres.	Antananarivo, Anjozorobe, Mantaso	2024-11-15 00:00:00	2024-12-10 14:14:17
\.


--
-- Data for Name: itineraires; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.itineraires (id, idcircuit, itineraire, remarque, inserted_at, updated_at) FROM stdin;
4	1	Jour 1 : Antananarivo – Ampefy : 221 km	Vous partirez de bonne heure de la capitale pour rejoindre le centre de Madagascar. Vous découvrirez les pistes environnant les hauts plateaux, et vous arriverez à Ampefy. Découvrez le lac Itasy ainsi que les sentiers volcaniques de la région.	2024-11-18 00:00:00	2024-11-18 00:00:00
5	1	Jour 2 : Ampefy – Antsirabe : 211 km	Après cette virée à Ampefy, vous reprenez la route vers le Sud de la capitale. Vous traverserez les magnifiques paysages et atteindrez la célèbre ville thermale Antsirabe sur la RN7	2024-11-18 00:00:00	2024-11-18 00:00:00
6	1	Jour 3 : Antsirabe – Ambatolampy : 150 km	Vous continuez la route progressivement, et découvrez les pistes qui vous mèneront à la petite ville rurale d’Ambatolampy. Vous apprécierez chaque découverte, le long de la route et des pistes et surtout les animations sur la ville d’Ambatolampy.	2024-11-18 00:00:00	2024-11-18 00:00:00
7	1	Jour 4 : Ambatolampy – Mantasoa : 152 km	En route vers le second lac. Plusieurs kilomètres vous mèneront à la célèbre ville de Mantasoa et son lac artificiel. Vous aurez l’occasion de partir à la découverte de la ville. Appréciez les paysages environnant et la vue du lac, ou vous pourriez vous détendre après ces quelques jours du circuit.	2024-11-18 00:00:00	2024-11-18 00:00:00
8	1	Jour 5 : Mantasoa – Anjozorobe : 160 km	Vous repartez de Mantasoa pour aller à la découverte de la prochaine destination. En direction vers le Nord Est d’Antananarivo, admirez les paysages et la nature sur la route vers Anjozorobe. Vous découvrirez le célèbre lac de Tsiazompaniry et le plus grand lac barrage du pays.	2024-11-18 00:00:00	2024-11-18 00:00:00
9	1	Jour 6 : Anjozorobe – Antananarivo : 130 km	Pour ce dernier jour du circuit, parcourrez les centaines de kilomètres de pistes pour rejoindre la capitale. Vous apprécierez chaque moment de découverte et surtout socialisez avec la population dans les villages le long du circuit.Fin de nos services	2024-11-18 00:00:00	2024-11-18 00:00:00
32	3	J8 – ANDAVADOAKA – ANKASY – 110 km (Sable)	Préparez-vous à la traversée d’une des pistes les plus difficiles de Madagascar. Le long d’une côte splendide, parsemée de baobabs, vous serez confrontés à l’un des plus gros sables imaginables. Pas question de vous arrêter en route sous peine de vous enliser. La concentration et le sang-froid seront de mise pour vous permettre d’apprécier en fin de journée les exceptionnelles plages de Salary, petit village de pêcheur de la côte ouest.\n\nDîner et nuit à l’hôtel	2024-11-19 00:00:00	2024-11-19 00:00:00
20	2	Jour 0 : Antananarivo	A votre arrivée à l’aéroport international d’Ivato, vous êtes accueillis et conduits directement à votre hôtel.	2024-11-19 00:00:00	2024-11-19 00:00:00
21	2	Jour 1 : Antananarivo – Anjozorobe : 130 km	Vous partirez de la capitale pour mettre le cap vers le Nord-Est. Vous arriverez à Anjozorobe et au bord du lac de Tsiazompaniry.\nVous appércierez les découvertes sur le chemin et la vue du lac arrivée à destination.	2024-11-19 00:00:00	2024-11-19 00:00:00
22	2	Jour 2 : Anjozorobe – Mantasoa : 160 km	Vous parcourrez les pistes des hautes terres pour rejoindre la deuxième destination, le lac de Mantasoa.\n\nVous arriverez dans la célèbre ville de Mantasoa où vous pourriez apprécier un moment de détente au bord du lac, et découvrir quelques facettes de la ville	2024-11-19 00:00:00	2024-11-19 00:00:00
23	2	Jour 3 : Mantasoa – Antananarivo : 91 km	Après la visite des deux célèbres lacs autour des hautes terres, vous repartez de Mantasoa pour rejoindre la capitale.\n\nVous sillonnerez les pistes des hauts plateaux, et admirez les paysages uniques et appréciez également les animations et découvertes locales le long du parcours\n\nFin de nos services	2024-11-19 00:00:00	2024-11-19 00:00:00
24	3	J0 – ANTANANARIVO	A votre arrivée à l’aéroport international d’Ivato, vous serez accueillis et conduits directement à votre hôtel.	2024-11-19 00:00:00	2024-11-19 00:00:00
25	3	J1 -ANTANANARIVO -MANTASOA 80 km	Après un premier briefing en compagnie de l’équipe qui vous accompagnera tout au long de votre parcours, vous pourrez effectuer une première prise en main de vos motos enduro spécialement équipées et préparées pour votre raid. En sortant de la capitale et de ses artères animées et congestionnées, vous emprunterez directement les pistes roulantes de latérite de la région des grands lacs. La piste est bien plus accueillante que la route nationale. Entre rizières, forêts et blocs de granit, vous découvrirez le cœur rouge des Hautes Terres. Les nombreux villages qui jalonnent la piste vous donneront l’occasion d’échanger avec la population Malgache.\n\nDîner et nuit à l’hôtel	2024-11-19 00:00:00	2024-11-19 00:00:00
26	3	J2 -MANTASOA - ANTSIRABE 230 km	Après un premier briefing en compagnie de l’équipe qui vous accompagnera tout au long de votre parcours, vous pourrez effectuer une première prise en main de vos motos enduro spécialement équipées et préparées pour votre raid. En sortant de la capitale et de ses artères animées et congestionnées, vous emprunterez directement les pistes roulantes de latérite de la région des grands lacs. La piste est bien plus accueillante que la route nationale. Entre rizières, forêts et blocs de granit, vous découvrirez le cœur rouge des Hautes Terres. Les nombreux villages qui jalonnent la piste vous donneront l’occasion d’échanger avec la population Malgache.\n\nDîner et nuit à l’hôtel	2024-11-19 00:00:00	2024-11-19 00:00:00
27	3	J3 – ANTSIRABE – AMBATOFINANDRAHANO – 160 km (Terre – Bitume)	Au lever du soleil, vous quitterez la ville thermale d’Antsirabe pour découvrir le lac Tritriva, faille volcanique remplie de légendes et de fady (tabous) avant de vous aventurer hors des sentiers battus par des pistes oubliées qui rejoignent Ambatofinandrahano, logée au pied du massif de l’Itremo.\n\nDîner et nuit à l’hôtel	2024-11-19 00:00:00	2024-11-19 00:00:00
28	3	J4 – AMBATOFINANDRAHANO – MALAIMBANDY – MORONDAVA – 380 km (Sable, Terre, Bitume)	Départ très tôt le matin pour profiter des magnifiques pistes montagneuses. Les portes du grand Ouest s’ouvriront à vous lors du franchissement du massif montagneux de l’Itremo et de son col culminant à plus de 2000 m. La descente vers la côte Ouest réserve des panoramas spectaculaires sur une piste que seuls les motards peuvent emprunter.\n\nDîner et nuit à l’hôtel	2024-11-19 00:00:00	2024-11-19 00:00:00
29	3	J5 – MORONDAVA -130 km (Sable)	Départ dans la matinée de Morondava, pour une étape courte mais intense dans les sables de la fameuse « allée des baobabs ». La visite de la réserve de Kirindy vous permettra d’admirer les centaines d’espèces endémiques qui forment un écosystème unique. Forêts sèches et fourrés épineux, baies, dunes côtières et îlots se dessineront au fil de votre retour vers Morondava, où vous pourrez profiter d’un moment de détente sur les plages du canal du Mozambique.\n\nDîner et nuit à l’hôtel	2024-11-19 00:00:00	2024-11-19 00:00:00
30	3	J6 – MORONDAVA – MANJA – 160 km (Sable)	Départ dans la matinée de Morondava, pour une étape intense. Cette journée de moto commence par l’impressionnante traversé du gué de la Kabatomena, d’une largeur de plus de 50 mètres de large, avant de se poursuivre dans un paysage de bush jusqu’au lac salé de Belo. Nous traversons les salines pour rejoindre ensuite la piste qui vous mènera à Manja.\n\nDîner et nuit à l’hôtel	2024-11-19 00:00:00	2024-11-19 00:00:00
31	3	J7 – MANJA - ANDAVADOAKA - 220 km (Sable – Terre)	Départ matinal pour une grosse journée de moto sur des pistes variées et techniques, tantôt sablonneuses, tantôt en latérite dure semée de termitières. Autour de vous, un paysage de savane arborée vous fera apprécier d’énormes baobabs jusqu’aux rives du Mangoky où un bac fera traverser vos motos.\n\nDîner et nuit à l’hôtel	2024-11-19 00:00:00	2024-11-19 00:00:00
33	3	J9 – ANKASY – TULEAR – 100 km (Sable)	La large piste vous donnera l’occasion de croiser d’énormes camions brousse transportant personnes, coton et autres marchandises débordant les plateformes. Dans les nombreux villages que vous traverserez, il vous faudra passer prudemment, surtout les jours de marché, où il faut se frayer un passage au klaxon pour circuler. Les grands couloirs de sable annoncent votre arrivée sur la côte. En arrivant au village de pécheur d’Ifaty, vous pourrez prendre un bon moment de détente sur la plage avant de rejoindre Tulear votre destination finale.\n\nFin de la prestation moto.\n\nDîner et nuit à l’hôtel	2024-11-19 00:00:00	2024-11-19 00:00:00
34	3	J10 – TULEAR – ANTANANARIVO (TRANSFERT)	Selon l’heure de votre vol vers Antananarivo, vous pourrez visiter les rues animées de Tuléar et ses marchés multicolores.\n\nUn taxi vous emmènera à l’aéroport pour votre vol retour vers Tana.\n\nFin de nos services.	2024-11-19 00:00:00	2024-11-19 00:00:00
35	3	J12 -VOL INTERNATIONAL	VOL INTERNATIONAL	2024-11-19 00:00:00	2024-11-19 00:00:00
36	4	J0 – TANANARIVE	A votre arrivée à l’aéroport international d’Ivato, vous serez accueillis et conduits directement à votre hôtel.	2024-11-19 00:00:00	2024-11-19 00:00:00
37	4	J1 –TANANARIVE – ANTSIRABE - 200 km (Terre - Bitume)	Après un premier briefing en compagnie de l’équipe qui vous accompagnera tout au long de votre parcours, vous pourrez effectuer une première prise en main de vos motos enduro spécialement équipées et préparées pour votre raid. En sortant de la capitale et de ses artères animées et congestionnées, vous emprunterez directement les pistes roulantes de latérite. La piste est bien plus accueillante que la route nationale. Entre rizières, forêts et blocs de granit, vous découvrirez le cœur rouge des Hautes Terres. Les nombreux villages qui jalonnent la piste vous donneront l’occasion d’échanger avec la population Malgache.\n\nDîner et nuit à l’hôtel	2024-11-19 00:00:00	2024-11-19 00:00:00
38	4	J2 –ANTSIRABE – AMBOSITRA - 140 km (Terre)	Cette étape de terre vous immergera de nouveau dans les paysages grandioses des Hautes Terres : rizières, nombreux villages de terre, collines et rivières ponctueront cette très belle descente vers Ambositra, capitale de l’artisanat malgache.\n\nDîner et nuit à l’hôtel	2024-11-19 00:00:00	2024-11-19 00:00:00
39	4	J3 –AMBOSITRA - RANOMAFANA - 150 km (Terre - Boue)	Cette étape vous mènera dans l’un des territoires les plus sauvages de l’île rouge. Sur une piste de terre rendue très rapidement boueuse, vous longerez une splendide rivière au milieu de la forêt primaire humide. La piste se poursuivra jusqu’à Parc National de Ranomafana.\n\nDîner et nuit à l’hôtel	2024-11-19 00:00:00	2024-11-19 00:00:00
40	4	J4 –RANOMAFANA - MANAKARA –150 km (Bitume)	De bon matin, vous quittez Ranomafana pour une belle route bitumée qui vous conduira jusqu’à Manakara, capitale régionale ; vous pourrez profiter l’après-midi d’une visite du canal des Pangalanes.\n\nDîner et nuit à l’hôtel	2024-11-19 00:00:00	2024-11-19 00:00:00
41	4	J5 –MANAKARA – SANDRAVINANY - 230 km (Bitume – Terre)	Cette étape débute sur le bitume. Après avoir traversé Vangaindrano, vous découvrez une belle piste de terre longeant les plages de l’Océan Indien. Le premier des dix passages de bac qui ponctueront votre route jusqu’à Fort Dauphin vous attend. En fin d’après-midi, vous atteignez Sandravinany.\n\nDîner et nuit à l’hôtel	2024-11-19 00:00:00	2024-11-19 00:00:00
42	4	J6 –SANDRAVINANY – FORT DAUPHIN – 100 km (Terre)	Cette journée débute par de nouveaux passages de bac : les rivières se succèdent avant une partie assez technique de piste souvent boueuse qui vous mènera jusqu’à Fort Dauphin.\n\nDîner et nuit à l’hôtel	2024-11-19 00:00:00	2024-11-19 00:00:00
43	4	J7 –FORT DAUPHIN ET SES ENVIRONS OU JOURNÉE DE CONGÉ	Fort Dauphin et ses environs ou Journée de congé.	2024-11-19 00:00:00	2024-11-19 00:00:00
44	4	J8 – FORT DAUPHIN – LAVANONO - 250 km (Bitume – Terre - Sable)	Cette très belle étape vous fera passer en quelques dizaines de kilomètres des paysages de foret humide de l’est au bush désertique du sud. Vous traverserez les pays Anosy et Antandroy jusqu’à Lavanono et ses somptueuses plages.\n\nDîner et nuit à l’hôtel	2024-11-19 00:00:00	2024-11-19 00:00:00
46	4	J10 –BEHELOKA -TULÉAR 250 km	BEHELOKA -TULÉAR 250 km	2024-11-19 00:00:00	2024-11-19 00:00:00
47	4	J11 – TULEAR – ANTANANARIVO (TRANSFERT)	Selon l’heure de votre vol vers Antananarivo, vous pourrez visiter les rues animées de Tuléar et ses marchés multicolores.\n\nUn taxi vous emmènera à l’aéroport pour votre vol retour vers Tana.\n\nFin de nos services.	2024-11-19 00:00:00	2024-11-19 00:00:00
48	4	J12 –VOL INTERNATIONALE	VOL INTERNATIONALE	2024-11-19 00:00:00	2024-11-19 00:00:00
45	4	J9 – LAVANONO - BEHELOKA 250 km	LAVANONO - BEHELOKA 250 km	2024-11-19 00:00:00	2024-11-19 00:00:00
\.


--
-- Data for Name: photos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.photos (id, nom, idcircuit, inserted_at, updated_at, photo, principal) FROM stdin;
19	photo	3	2024-12-10 13:16:27	2024-12-10 13:16:27	IMG-20241108-WA0008.jpg	\N
12	photo	4	2024-12-09 11:37:58	2024-12-09 11:37:58	3.jpg	t
13	photo	1	2024-12-09 11:41:35	2024-12-09 11:41:35	4.jpg	t
11	photo	3	2024-12-09 11:37:37	2024-12-09 11:37:37	5.jpg	t
1	bla	\N	2024-12-04 08:18:51	2024-12-04 08:18:51	s-l400.jpg	f
2	blabla	\N	2024-12-04 08:24:54	2024-12-04 08:24:54	undefined_image.png	f
3	blabla	\N	2024-12-04 08:26:16	2024-12-04 08:26:16	s-l400.jpg	f
4	test_photo	\N	2024-12-04 12:09:53	2024-12-04 12:09:53	undefined_image.png	f
9	photo	\N	2024-12-06 11:11:23	2024-12-06 11:11:23	IMG_6984.jpg	f
16	photo	2	2024-12-09 12:04:30	2024-12-09 12:04:30	car-1.jpg	f
14	photo	2	2024-12-09 11:49:04	2024-12-09 11:49:04	1.jpg	f
15	photo	2	2024-12-09 11:55:12	2024-12-09 11:55:12	car-2.jpg	f
18	photo	2	2024-12-09 12:57:22	2024-12-09 12:57:22	4.jpg	f
10	photo	2	2024-12-09 11:34:28	2024-12-09 11:34:28	2.jpg	t
\.


--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question (id, idcircuit, nom, email, message, inserted_at, updated_at) FROM stdin;
\.


--
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservations (id, idcircuit, nom, email, telephone, participant, date_res, besoin, archivage, validation, inserted_at, updated_at) FROM stdin;
1	1	phidia	fanambyrahari@gmail.com	0329492964	4	2024-11-25	besoin	0	0	2024-11-25 00:00:00	2024-11-25 00:00:00
2	1	phidia	fanambyrahari@gmail.com	0329492964	4	2024-11-25	besoin	0	0	2024-11-25 00:00:00	2024-11-25 00:00:00
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version, inserted_at) FROM stdin;
20241119072556	2024-11-19 07:27:19
20241119072609	2024-11-19 07:27:19
20241121114500	2024-11-21 11:57:18
20241125132417	2024-11-25 13:24:32
20241125134029	2024-11-25 13:50:20
20241127063958	2024-11-27 06:40:51
20241203085009	2024-12-03 08:51:25
20241203082345	2024-12-03 08:51:41
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, hashed_password, confirmed_at, inserted_at, updated_at) FROM stdin;
1	fanambyraharisandratana@gmail.com	$pbkdf2-sha512$160000$WU5cGjSTH2/NhYUG3kkFzw$pIY429EqbZTP7mZ2QYgzj8WqWzraBh1eflK9eFDREiFTZxr1Dy/teF.xtgsVSUh5zO5YIS2v/5S2JupMACJz9A	\N	2024-11-21 12:39:40	2024-11-21 12:39:40
\.


--
-- Data for Name: users_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_tokens (id, user_id, token, context, sent_to, inserted_at) FROM stdin;
1	1	\\xb86b5d90d4aca088f8f4cca10b41681e982279a1962627b6035868c890f4079f	confirm	fanambyraharisandratana@gmail.com	2024-11-21 12:39:40
4	1	\\x501093d0894c1d5d6183f3732d7d4fb2c73f0d024ba38de7f7dbaf73518af8cc	session	\N	2024-11-21 13:51:01
11	1	\\x11a78b9bfdfc22dbb90cda9baee2f7e9bd80eca3914dfe5df063baf0df8193ab	session	\N	2024-11-22 14:02:38
14	1	\\x4432939c67ab808c3e554a28f4e9a01c8e850124fa18dbcce31a5033042f45b4	session	\N	2024-11-25 07:29:11
17	1	\\x505f5c97790d38901f33492f09005a4de36f5b5159943cdaff68a06b895bbec9	session	\N	2024-11-26 13:58:18
18	1	\\x9e33178b790b729608384d184754149566ecd63e12c99145c8e2d8fea11b61d3	session	\N	2024-11-27 06:06:55
20	1	\\x3e4483008e2454632ed15f3c54e129895fc4f3fbac8b561437083ecb40c5472e	session	\N	2024-11-29 11:46:16
21	1	\\x3a37e91030bbd2962d5a165f5a6b84093dda4bb864784521ffbf6870158f8c17	session	\N	2024-12-02 05:28:37
22	1	\\x8aff8044c0e4c1f8a0f1ebdf64bb844037a383b6134fe6d673ec10a11a1134af	session	\N	2024-12-03 06:23:25
23	1	\\xcbede4d6e9e52648732111cbfc1946adf7fe7f5ca6c3665d2938eb4d2d4fa875	session	\N	2024-12-05 07:13:28
24	1	\\x91147cd405a932d35bddb9c84c4988a83ac70ae9c248ae55fbeb7936bb74a2ff	session	\N	2024-12-06 11:06:40
25	1	\\x8bbd687cea7bb92e208dda0c31e61236e0803d04b2edfe880f14e39f6b103f7b	session	\N	2024-12-09 11:33:19
26	1	\\xa4518881ddbe0f89043887a89a764796481bef085caca8e83f4e9bfcdb63af8f	session	\N	2024-12-10 06:17:01
27	1	\\xb21ce128e4dcf3f730c61e4c66cc9a91c08807e025536b0f208c266257b4bb68	session	\N	2024-12-10 07:31:43
\.


--
-- Name: circuits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.circuits_id_seq', 14, true);


--
-- Name: itineraires_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.itineraires_id_seq', 48, true);


--
-- Name: photos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.photos_id_seq', 19, true);


--
-- Name: question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.question_id_seq', 3, true);


--
-- Name: reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservations_id_seq', 2, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: users_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_tokens_id_seq', 27, true);


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

