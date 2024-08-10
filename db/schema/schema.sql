--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg120+1)
-- Dumped by pg_dump version 16.4 (Debian 16.4-1.pgdg120+1)

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
-- Name: accounts; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.accounts (
    id bigint NOT NULL,
    owner character varying NOT NULL,
    balance double precision NOT NULL,
    currency character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.accounts OWNER TO root;

--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.accounts_id_seq OWNER TO root;

--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.accounts_id_seq OWNED BY public.accounts.id;


--
-- Name: entries; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.entries (
    id bigint NOT NULL,
    account_id bigint,
    amount double precision NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.entries OWNER TO root;

--
-- Name: COLUMN entries.amount; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN public.entries.amount IS 'Can be negative or positive';


--
-- Name: entries_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.entries_id_seq OWNER TO root;

--
-- Name: entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.entries_id_seq OWNED BY public.entries.id;


--
-- Name: transfers; Type: TABLE; Schema: public; Owner: root
--

CREATE TABLE public.transfers (
    id bigint NOT NULL,
    from_account_id bigint NOT NULL,
    to_account_id bigint NOT NULL,
    amount double precision NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.transfers OWNER TO root;

--
-- Name: COLUMN transfers.amount; Type: COMMENT; Schema: public; Owner: root
--

COMMENT ON COLUMN public.transfers.amount IS 'Must be positive';


--
-- Name: transfers_id_seq; Type: SEQUENCE; Schema: public; Owner: root
--

CREATE SEQUENCE public.transfers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transfers_id_seq OWNER TO root;

--
-- Name: transfers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: root
--

ALTER SEQUENCE public.transfers_id_seq OWNED BY public.transfers.id;


--
-- Name: accounts id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.accounts ALTER COLUMN id SET DEFAULT nextval('public.accounts_id_seq'::regclass);


--
-- Name: entries id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.entries ALTER COLUMN id SET DEFAULT nextval('public.entries_id_seq'::regclass);


--
-- Name: transfers id; Type: DEFAULT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.transfers ALTER COLUMN id SET DEFAULT nextval('public.transfers_id_seq'::regclass);


--
-- Name: accounts accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: entries entries_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.entries
    ADD CONSTRAINT entries_pkey PRIMARY KEY (id);


--
-- Name: transfers transfers_pkey; Type: CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_pkey PRIMARY KEY (id);


--
-- Name: accounts_owner_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX accounts_owner_idx ON public.accounts USING btree (owner);


--
-- Name: entries_account_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX entries_account_id_idx ON public.entries USING btree (account_id);


--
-- Name: transfers_from_account_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX transfers_from_account_id_idx ON public.transfers USING btree (from_account_id);


--
-- Name: transfers_from_account_id_to_account_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX transfers_from_account_id_to_account_id_idx ON public.transfers USING btree (from_account_id, to_account_id);


--
-- Name: transfers_to_account_id_idx; Type: INDEX; Schema: public; Owner: root
--

CREATE INDEX transfers_to_account_id_idx ON public.transfers USING btree (to_account_id);


--
-- Name: entries entries_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.entries
    ADD CONSTRAINT entries_account_id_fkey FOREIGN KEY (account_id) REFERENCES public.accounts(id);


--
-- Name: entries entries_account_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.entries
    ADD CONSTRAINT entries_account_id_fkey1 FOREIGN KEY (account_id) REFERENCES public.accounts(id) ON DELETE CASCADE;


--
-- Name: transfers transfers_from_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_from_account_id_fkey FOREIGN KEY (from_account_id) REFERENCES public.accounts(id);


--
-- Name: transfers transfers_from_account_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_from_account_id_fkey1 FOREIGN KEY (from_account_id) REFERENCES public.accounts(id) ON DELETE CASCADE;


--
-- Name: transfers transfers_to_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_to_account_id_fkey FOREIGN KEY (to_account_id) REFERENCES public.accounts(id);


--
-- Name: transfers transfers_to_account_id_fkey1; Type: FK CONSTRAINT; Schema: public; Owner: root
--

ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_to_account_id_fkey1 FOREIGN KEY (to_account_id) REFERENCES public.accounts(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

