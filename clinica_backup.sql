--
-- PostgreSQL database dump
--

\restrict wexpubWLTSjZC6HSzEeuhk3591UHaX5MB1OShvJQY2r3Y3LXb6uhyvrRwmBK6Qd

-- Dumped from database version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)

-- Started on 2026-04-15 21:48:14 -05

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
-- TOC entry 5 (class 2615 OID 16389)
-- Name: clinica; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA clinica;


ALTER SCHEMA clinica OWNER TO postgres;

--
-- TOC entry 854 (class 1247 OID 16400)
-- Name: id_cita; Type: DOMAIN; Schema: clinica; Owner: postgres
--

CREATE DOMAIN clinica.id_cita AS character(7) NOT NULL
	CONSTRAINT id_cita_check CHECK ((VALUE ~ '^[CM]{2}[-]{1}\d{4}$'::text));


ALTER DOMAIN clinica.id_cita OWNER TO postgres;

--
-- TOC entry 850 (class 1247 OID 16397)
-- Name: id_meespecialista; Type: DOMAIN; Schema: clinica; Owner: postgres
--

CREATE DOMAIN clinica.id_meespecialista AS character(7) NOT NULL
	CONSTRAINT id_meespecialista_check CHECK ((VALUE ~ '^[ME]{2}[-]{1}\d{4}$'::text));


ALTER DOMAIN clinica.id_meespecialista OWNER TO postgres;

--
-- TOC entry 846 (class 1247 OID 16394)
-- Name: id_paciente; Type: DOMAIN; Schema: clinica; Owner: postgres
--

CREATE DOMAIN clinica.id_paciente AS character(6) NOT NULL
	CONSTRAINT id_paciente_check CHECK ((VALUE ~ '^[P]{1}[-]{1}\d{4}$'::text));


ALTER DOMAIN clinica.id_paciente OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 16461)
-- Name: agendar_cita; Type: TABLE; Schema: clinica; Owner: postgres
--

CREATE TABLE clinica.agendar_cita (
    fk_idcita clinica.id_cita NOT NULL,
    fk_idespecialista clinica.id_meespecialista NOT NULL,
    consultario character varying(20) NOT NULL,
    fechacita date NOT NULL,
    horacita time without time zone NOT NULL,
    turno character varying(10) NOT NULL,
    status character varying(10) NOT NULL,
    observaciones character varying(100) NOT NULL
);


ALTER TABLE clinica.agendar_cita OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16449)
-- Name: cita; Type: TABLE; Schema: clinica; Owner: postgres
--

CREATE TABLE clinica.cita (
    pk_idcita clinica.id_cita NOT NULL,
    fk_idpaciente clinica.id_paciente,
    fecha date NOT NULL,
    hora time without time zone NOT NULL
);


ALTER TABLE clinica.cita OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16411)
-- Name: especialista; Type: TABLE; Schema: clinica; Owner: postgres
--

CREATE TABLE clinica.especialista (
    pk_idespecialista clinica.id_meespecialista NOT NULL,
    nombre character varying(20) NOT NULL,
    apellido character varying(20) NOT NULL,
    sexo character(1) NOT NULL,
    fechanacimiento date NOT NULL,
    especialidad character varying(30) NOT NULL
);


ALTER TABLE clinica.especialista OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16418)
-- Name: expediente; Type: TABLE; Schema: clinica; Owner: postgres
--

CREATE TABLE clinica.expediente (
    pk_idpaciente clinica.id_paciente NOT NULL,
    tiposangre character varying(10) NOT NULL,
    tipoalergia character varying(50) NOT NULL,
    padecimientocro character varying(50) NOT NULL,
    fechacreacion timestamp without time zone NOT NULL
);


ALTER TABLE clinica.expediente OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16431)
-- Name: expediente_diagnostico; Type: TABLE; Schema: clinica; Owner: postgres
--

CREATE TABLE clinica.expediente_diagnostico (
    folio integer NOT NULL,
    fk_idespecialista clinica.id_meespecialista,
    fk_idpaciente clinica.id_paciente,
    edad character(3) NOT NULL,
    peso character(3) NOT NULL,
    altura character(4) NOT NULL,
    imc character(5) NOT NULL,
    nivelpeso character(10) NOT NULL,
    presionarterial character(8) NOT NULL,
    diagnostico character varying(150) NOT NULL,
    recetario character varying(150) NOT NULL,
    fechacreacion timestamp without time zone NOT NULL
);


ALTER TABLE clinica.expediente_diagnostico OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16430)
-- Name: expediente_diagnostico_folio_seq; Type: SEQUENCE; Schema: clinica; Owner: postgres
--

CREATE SEQUENCE clinica.expediente_diagnostico_folio_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE clinica.expediente_diagnostico_folio_seq OWNER TO postgres;

--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 218
-- Name: expediente_diagnostico_folio_seq; Type: SEQUENCE OWNED BY; Schema: clinica; Owner: postgres
--

ALTER SEQUENCE clinica.expediente_diagnostico_folio_seq OWNED BY clinica.expediente_diagnostico.folio;


--
-- TOC entry 215 (class 1259 OID 16402)
-- Name: paciente; Type: TABLE; Schema: clinica; Owner: postgres
--

CREATE TABLE clinica.paciente (
    pk_idpaciente clinica.id_paciente NOT NULL,
    nombre character varying(20) NOT NULL,
    apellido character varying(20) NOT NULL,
    sexo character(1) NOT NULL,
    fechanacimiento date NOT NULL,
    ciudad character varying(20) NOT NULL,
    estado character varying(20) NOT NULL,
    telefono character(10)
);


ALTER TABLE clinica.paciente OWNER TO postgres;

--
-- TOC entry 3357 (class 2604 OID 16434)
-- Name: expediente_diagnostico folio; Type: DEFAULT; Schema: clinica; Owner: postgres
--

ALTER TABLE ONLY clinica.expediente_diagnostico ALTER COLUMN folio SET DEFAULT nextval('clinica.expediente_diagnostico_folio_seq'::regclass);


--
-- TOC entry 3527 (class 0 OID 16461)
-- Dependencies: 221
-- Data for Name: agendar_cita; Type: TABLE DATA; Schema: clinica; Owner: postgres
--

COPY clinica.agendar_cita (fk_idcita, fk_idespecialista, consultario, fechacita, horacita, turno, status, observaciones) FROM stdin;
CM-0001	ME-0001	CONSULTORIO 1	2022-10-04	12:00:00	MATUTINO	ESPERA	NA
CM-0002	ME-0001	CONSULTORIO 1	2022-10-04	12:20:00	MATUTINO	ESPERA	NA
CM-0003	ME-0002	CONSULTORIO 2	2022-10-05	12:00:00	MATUTINO	ESPERA	NA
CM-0004	ME-0002	CONSULTORIO 2	2022-10-05	12:00:00	MATUTINO	ESPERA	NA
CM-0005	ME-0003	CONSULTORIO 3	2022-10-06	12:00:00	MATUTINO	ESPERA	NA
CM-0006	ME-0003	CONSULTORIO 3	2022-10-07	14:00:00	VESPERTINO	ESPERA	NA
CM-0007	ME-0003	CONSULTORIO 3	2022-10-07	14:20:00	VESPERTINO	ESPERA	NA
CM-0008	ME-0004	CONSULTORIO 4	2022-10-08	13:00:00	VESPERTINO	ESPERA	NA
CM-0009	ME-0004	CONSULTORIO 4	2022-10-08	13:20:00	VESPERTINO	ESPERA	NA
CM-0010	ME-0005	CONSULTORIO 5	2022-10-08	15:00:00	VESPERTINO	ESPERA	NA
\.


--
-- TOC entry 3526 (class 0 OID 16449)
-- Dependencies: 220
-- Data for Name: cita; Type: TABLE DATA; Schema: clinica; Owner: postgres
--

COPY clinica.cita (pk_idcita, fk_idpaciente, fecha, hora) FROM stdin;
CM-0001	P-0001	2022-10-01	12:00:00
CM-0002	P-0002	2022-10-01	12:20:00
CM-0003	P-0003	2022-10-02	12:20:00
CM-0004	P-0004	2022-10-02	10:00:00
CM-0005	P-0005	2022-10-03	08:20:00
CM-0006	P-0006	2022-10-03	12:20:00
CM-0007	P-0007	2022-10-04	12:20:00
CM-0008	P-0008	2022-10-04	10:00:00
CM-0009	P-0009	2022-10-04	08:20:00
CM-0010	P-0010	2022-10-05	08:20:00
\.


--
-- TOC entry 3522 (class 0 OID 16411)
-- Dependencies: 216
-- Data for Name: especialista; Type: TABLE DATA; Schema: clinica; Owner: postgres
--

COPY clinica.especialista (pk_idespecialista, nombre, apellido, sexo, fechanacimiento, especialidad) FROM stdin;
ME-0001	REYNA	GUADALUPE	F	1986-01-01	MEDICO GENERAL
ME-0002	ENRIQUE	ORTIZ	M	1968-10-01	NEFROLOGIA
ME-0003	FELIPE	HERNANDEZ	M	1980-10-02	MEDICO GENERAL
ME-0004	KENIA	LOPEZ	F	1973-01-01	PEDIATRA
ME-0005	JUAN	MARTINEZ	M	1980-02-23	MEDICO GENERAL
\.


--
-- TOC entry 3523 (class 0 OID 16418)
-- Dependencies: 217
-- Data for Name: expediente; Type: TABLE DATA; Schema: clinica; Owner: postgres
--

COPY clinica.expediente (pk_idpaciente, tiposangre, tipoalergia, padecimientocro, fechacreacion) FROM stdin;
P-0001	B POSITIVO	NA	NA	2022-06-10 00:00:00
P-0002	B NEGATIVO	ALERGIA AL POLVO	NA	2022-06-10 00:00:00
P-0003	O NEGATIVO	NA	DIABETES	2022-06-14 00:00:00
P-0004	B POSITIVO	ALERGIA A LOS MARISCOS	ASMA	2022-06-15 00:00:00
P-0005	B POSITIVO	NA	DIABETES	2022-06-16 00:00:00
P-0006	B POSITIVO	ALERGIA AL POLVO	NA	2022-06-17 00:00:00
P-0007	B POSITIVO	NA	CANCER	2022-06-20 00:00:00
P-0008	B POSITIVO	NA	NA	2022-06-24 00:00:00
P-0009	B POSITIVO	NA	NA	2022-07-02 00:00:00
P-0010	B POSITIVO	NA	NA	2022-07-06 00:00:00
\.


--
-- TOC entry 3525 (class 0 OID 16431)
-- Dependencies: 219
-- Data for Name: expediente_diagnostico; Type: TABLE DATA; Schema: clinica; Owner: postgres
--

COPY clinica.expediente_diagnostico (folio, fk_idespecialista, fk_idpaciente, edad, peso, altura, imc, nivelpeso, presionarterial, diagnostico, recetario, fechacreacion) FROM stdin;
1	ME-0001	P-0001	24 	70 	1.70	24.0 	NORMAL    	120/70  	NA	NA	2022-11-22 00:00:00
2	ME-0001	P-0002	33 	80 	1.77	27.0 	SOBREPESO 	125/73  	NA	NA	2022-11-23 00:00:00
3	ME-0001	P-0003	45 	62 	1.64	26.6 	NORMAL    	130/70  	NA	NA	2022-11-24 00:00:00
4	ME-0002	P-0003	45 	62 	1.64	26.6 	NORMAL    	129/70  	NA	NA	2022-11-24 00:00:00
5	ME-0002	P-0004	23 	65 	1.60	23.0 	NORMAL    	125/70  	NA	NA	2022-11-25 00:00:00
6	ME-0003	P-0005	37 	90 	1.77	29.0 	OBESIDAD  	129/80  	NA	NA	2022-11-25 00:00:00
7	ME-0003	P-0005	37 	90 	1.77	29.0 	OBESIDAD  	128/78  	NA	NA	2022-11-25 00:00:00
8	ME-0003	P-0006	46 	72 	1.68	24.0 	NORMAL    	120/69  	NA	NA	2022-11-26 00:00:00
9	ME-0003	P-0007	31 	76 	1.77	24.0 	NORMAL    	125/73  	NA	NA	2022-11-27 00:00:00
10	ME-0004	P-0007	31 	76 	1.77	24.0 	NORMAL    	125/67  	NA	NA	2022-11-27 00:00:00
11	ME-0004	P-0008	21 	68 	1.63	24.0 	NORMAL    	119/69  	NA	NA	2022-11-29 00:00:00
12	ME-0005	P-0009	26 	90 	1.75	29.0 	SOBREPESO 	132/76  	NA	NA	2022-12-01 00:00:00
13	ME-0005	P-0009	26 	90 	1.75	29.0 	SOBREPESO 	130/74  	NA	NA	2022-12-01 00:00:00
14	ME-0005	P-0010	18 	60 	1.59	23.0 	NORMAL    	120/68  	NA	NA	2022-12-02 00:00:00
15	ME-0005	P-0010	18 	60 	1.59	23.0 	NORMAL    	119/65  	NA	NA	2022-12-02 00:00:00
\.


--
-- TOC entry 3521 (class 0 OID 16402)
-- Dependencies: 215
-- Data for Name: paciente; Type: TABLE DATA; Schema: clinica; Owner: postgres
--

COPY clinica.paciente (pk_idpaciente, nombre, apellido, sexo, fechanacimiento, ciudad, estado, telefono) FROM stdin;
P-0001	DANIEL	CARMONA	M	1998-12-07	MEXICO	MEXICO	551234567 
P-0002	JUAN	HERNANDEZ	M	1990-07-21	MONTERREY	NUEVO LEON	551234321 
P-0003	FERNANDA	MORALES	F	1973-07-01	MEXICO	MEXICO	5412309872
P-0004	ANDREA	ZUÑIGA	F	2000-12-02	GUADALAJARA	JALISCO	3309876522
P-0005	ALBERTO	PEREYRA	M	1986-10-23	MEXICO	MEXICO	5565423983
P-0006	KAREN	SOTO	F	1978-07-07	MEXICO	MEXICO	5565423097
P-0007	ANDRES	ORTIZ	M	1990-10-09	MONTERREY	MEXICO	5698782347
P-0008	LESLY	RODRIGUEZ	F	2001-02-11	MEXICO	MEXICO	5543454352
P-0009	ENRIQUE	VERA	M	1996-11-12	GUADALAJARA	JALISCO	3309815273
P-0010	VICTORIA	SOLIS	F	2002-03-10	MEXICO	MEXICO	5565278126
\.


--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 218
-- Name: expediente_diagnostico_folio_seq; Type: SEQUENCE SET; Schema: clinica; Owner: postgres
--

SELECT pg_catalog.setval('clinica.expediente_diagnostico_folio_seq', 15, true);


--
-- TOC entry 3371 (class 2606 OID 16467)
-- Name: agendar_cita agendar_cita_pkey; Type: CONSTRAINT; Schema: clinica; Owner: postgres
--

ALTER TABLE ONLY clinica.agendar_cita
    ADD CONSTRAINT agendar_cita_pkey PRIMARY KEY (fk_idcita, fk_idespecialista);


--
-- TOC entry 3369 (class 2606 OID 16455)
-- Name: cita cita_pkey; Type: CONSTRAINT; Schema: clinica; Owner: postgres
--

ALTER TABLE ONLY clinica.cita
    ADD CONSTRAINT cita_pkey PRIMARY KEY (pk_idcita);


--
-- TOC entry 3363 (class 2606 OID 16417)
-- Name: especialista especialista_pkey; Type: CONSTRAINT; Schema: clinica; Owner: postgres
--

ALTER TABLE ONLY clinica.especialista
    ADD CONSTRAINT especialista_pkey PRIMARY KEY (pk_idespecialista);


--
-- TOC entry 3367 (class 2606 OID 16438)
-- Name: expediente_diagnostico expediente_diagnostico_pkey; Type: CONSTRAINT; Schema: clinica; Owner: postgres
--

ALTER TABLE ONLY clinica.expediente_diagnostico
    ADD CONSTRAINT expediente_diagnostico_pkey PRIMARY KEY (folio);


--
-- TOC entry 3365 (class 2606 OID 16424)
-- Name: expediente expediente_pkey; Type: CONSTRAINT; Schema: clinica; Owner: postgres
--

ALTER TABLE ONLY clinica.expediente
    ADD CONSTRAINT expediente_pkey PRIMARY KEY (pk_idpaciente);


--
-- TOC entry 3359 (class 2606 OID 16408)
-- Name: paciente paciente_pkey; Type: CONSTRAINT; Schema: clinica; Owner: postgres
--

ALTER TABLE ONLY clinica.paciente
    ADD CONSTRAINT paciente_pkey PRIMARY KEY (pk_idpaciente);


--
-- TOC entry 3361 (class 2606 OID 16410)
-- Name: paciente paciente_telefono_key; Type: CONSTRAINT; Schema: clinica; Owner: postgres
--

ALTER TABLE ONLY clinica.paciente
    ADD CONSTRAINT paciente_telefono_key UNIQUE (telefono);


--
-- TOC entry 3376 (class 2606 OID 16468)
-- Name: agendar_cita agendar_cita_fk_idcita_fkey; Type: FK CONSTRAINT; Schema: clinica; Owner: postgres
--

ALTER TABLE ONLY clinica.agendar_cita
    ADD CONSTRAINT agendar_cita_fk_idcita_fkey FOREIGN KEY (fk_idcita) REFERENCES clinica.cita(pk_idcita) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3377 (class 2606 OID 16473)
-- Name: agendar_cita agendar_cita_fk_idespecialista_fkey; Type: FK CONSTRAINT; Schema: clinica; Owner: postgres
--

ALTER TABLE ONLY clinica.agendar_cita
    ADD CONSTRAINT agendar_cita_fk_idespecialista_fkey FOREIGN KEY (fk_idespecialista) REFERENCES clinica.especialista(pk_idespecialista) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3375 (class 2606 OID 16456)
-- Name: cita cita_fk_idpaciente_fkey; Type: FK CONSTRAINT; Schema: clinica; Owner: postgres
--

ALTER TABLE ONLY clinica.cita
    ADD CONSTRAINT cita_fk_idpaciente_fkey FOREIGN KEY (fk_idpaciente) REFERENCES clinica.paciente(pk_idpaciente) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3373 (class 2606 OID 16439)
-- Name: expediente_diagnostico expediente_diagnostico_fk_idespecialista_fkey; Type: FK CONSTRAINT; Schema: clinica; Owner: postgres
--

ALTER TABLE ONLY clinica.expediente_diagnostico
    ADD CONSTRAINT expediente_diagnostico_fk_idespecialista_fkey FOREIGN KEY (fk_idespecialista) REFERENCES clinica.especialista(pk_idespecialista) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3374 (class 2606 OID 16444)
-- Name: expediente_diagnostico expediente_diagnostico_fk_idpaciente_fkey; Type: FK CONSTRAINT; Schema: clinica; Owner: postgres
--

ALTER TABLE ONLY clinica.expediente_diagnostico
    ADD CONSTRAINT expediente_diagnostico_fk_idpaciente_fkey FOREIGN KEY (fk_idpaciente) REFERENCES clinica.expediente(pk_idpaciente) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3372 (class 2606 OID 16425)
-- Name: expediente expediente_pk_idpaciente_fkey; Type: FK CONSTRAINT; Schema: clinica; Owner: postgres
--

ALTER TABLE ONLY clinica.expediente
    ADD CONSTRAINT expediente_pk_idpaciente_fkey FOREIGN KEY (pk_idpaciente) REFERENCES clinica.paciente(pk_idpaciente) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2026-04-15 21:48:15 -05

--
-- PostgreSQL database dump complete
--

\unrestrict wexpubWLTSjZC6HSzEeuhk3591UHaX5MB1OShvJQY2r3Y3LXb6uhyvrRwmBK6Qd

