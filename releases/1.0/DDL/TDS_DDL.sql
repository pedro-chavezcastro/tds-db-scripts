--====================== public.brand definition ========================
DROP TABLE IF EXISTS public."BRANDS";
CREATE TABLE public."BRANDS" (
	id integer NOT NULL,
  name text NOT NULL
);

ALTER TABLE public."BRANDS" ADD CONSTRAINT brand_pkey PRIMARY KEY (id);

DROP SEQUENCE IF EXISTS public."SEQ_BRAND_ID";
CREATE SEQUENCE public."SEQ_BRAND_ID"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
--=======================================================================


--====================== public.measure_type definition  ================
DROP TABLE IF EXISTS  public."MEASURES_TYPES";
CREATE TABLE public."MEASURES_TYPES" (
	id bigint NOT NULL,
  name character varying(255) NOT NULL
);

ALTER TABLE public."MEASURES_TYPES" ADD CONSTRAINT measure_type_pkey PRIMARY KEY (id);

DROP SEQUENCE IF EXISTS public."SEQ_MEASURE_TYPE_ID";
CREATE SEQUENCE public."SEQ_MEASURE_TYPE_ID"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
--=======================================================================



--====================== public."content" definition  ===================
DROP TABLE IF EXISTS  public."CONTENTS";
CREATE TABLE public."CONTENTS" (
	id bigint NOT NULL,
  value double precision NOT NULL,
  id_measure_type_fk bigint NOT NULL
);

ALTER TABLE public."CONTENTS" ADD CONSTRAINT content_pkey PRIMARY KEY (id);
ALTER TABLE public."CONTENTS" ADD CONSTRAINT fk_measures_types_contents FOREIGN KEY (id_measure_type_fk) REFERENCES public."MEASURES_TYPES"(id);

DROP SEQUENCE IF EXISTS public."SEQ_CONTENT_ID";
CREATE SEQUENCE public."SEQ_CONTENT_ID"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
--=======================================================================


--====================== public.product definition ======================
DROP TABLE IF EXISTS  public."PRODUCTS";
CREATE TABLE public."PRODUCTS" (
  id bigint NOT NULL,
  current_num_items integer NOT NULL,
  description character varying(255),
  minimum_stock integer NOT NULL,
  name character varying(255) NOT NULL,
  price double precision NOT NULL,
  id_content_fk bigint NOT NULL,
  id_brand_fk integer
);

ALTER TABLE public."PRODUCTS" ADD CONSTRAINT product_pkey PRIMARY KEY (id);
ALTER TABLE public."PRODUCTS" ADD CONSTRAINT fk_contents_products FOREIGN KEY (id_content_fk) REFERENCES public."CONTENTS"(id);
ALTER TABLE public."PRODUCTS" ADD CONSTRAINT fk_brands_products FOREIGN KEY (id_brand_fk) REFERENCES public."BRANDS"(id);

DROP SEQUENCE IF EXISTS public."SEQ_PRODUCT_ID";
CREATE SEQUENCE public."SEQ_PRODUCT_ID"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
--=======================================================================


--====================== public.supplier definition =====================
DROP TABLE IF EXISTS public."SUPPLIERS";
CREATE TABLE public."SUPPLIERS" (
	id bigint NOT NULL,
  business_name character varying(255) NOT NULL,
  identification_number character varying(255) NOT NULL,
  phone character varying(255) NOT NULL
);
ALTER TABLE public."SUPPLIERS" ADD CONSTRAINT supplier_pkey PRIMARY KEY (id);

DROP SEQUENCE IF EXISTS public."SEQ_SUPPLIER_ID";
CREATE SEQUENCE public."SEQ_SUPPLIER_ID"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
--=======================================================================


--====================== public.product_supplier definition =============
DROP TABLE IF EXISTS public."PRODUCTS_SUPPLIERS";
CREATE TABLE public."PRODUCTS_SUPPLIERS" (
	id bigint NOT NULL,
  id_product_fk bigint NOT NULL,
  id_supplier_fk bigint NOT NULL
);
ALTER TABLE public."PRODUCTS_SUPPLIERS" ADD CONSTRAINT product_supplier_pkey PRIMARY KEY (id);
ALTER TABLE public."PRODUCTS_SUPPLIERS" ADD CONSTRAINT fk_products_products_suppliers  FOREIGN KEY (id_product_fk) REFERENCES public."PRODUCTS"(id);
ALTER TABLE public."PRODUCTS_SUPPLIERS" ADD CONSTRAINT fk_suppliers_products_suppliers FOREIGN KEY (id_supplier_fk) REFERENCES public."SUPPLIERS"(id);  

DROP SEQUENCE IF EXISTS public."SEQ_PRODUCT_SUPPLIER_ID";
CREATE SEQUENCE public."SEQ_PRODUCT_SUPPLIER_ID"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--=======================================================================



--====================== public.orden definition ========================
DROP TABLE IF EXISTS public."ORDERS";
CREATE TABLE public."ORDERS" (
	id bigint NOT NULL,
  amount double precision NOT NULL,
  date date NOT NULL,
  id_supplier_fk bigint NOT NULL,
  user_name character varying(255) NOT NULL
);
ALTER TABLE public."ORDERS" ADD CONSTRAINT order_pkey PRIMARY KEY (id);
ALTER TABLE public."ORDERS" ADD CONSTRAINT fk_suppliers_orders FOREIGN KEY (id_supplier_fk) REFERENCES public."SUPPLIERS"(id);

DROP SEQUENCE IF EXISTS public."SEQ_ORDER_ID";
CREATE SEQUENCE public."SEQ_ORDER_ID"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
--=======================================================================


--====================== public.order_detail definition =================
DROP TABLE IF EXISTS public."ORDER_DETAILS";
CREATE TABLE public."ORDER_DETAILS" (
	id bigint NOT NULL,
  amount double precision NOT NULL,
  num_items integer NOT NULL,
  id_product_fk bigint NOT NULL,
  id_order_fk bigint NOT NULL
);
ALTER TABLE public."ORDER_DETAILS" ADD CONSTRAINT order_detail_pkey PRIMARY KEY (id);
ALTER TABLE public."ORDER_DETAILS" ADD CONSTRAINT fk_products_order_details FOREIGN KEY (id_product_fk) REFERENCES public."PRODUCTS"(id);
ALTER TABLE public."ORDER_DETAILS" ADD CONSTRAINT fk_orders_order_details FOREIGN KEY (id_order_fk) REFERENCES public."ORDERS"(id);

DROP SEQUENCE IF EXISTS public."SEQ_ORDER_DETAIL_ID";
CREATE SEQUENCE public."SEQ_ORDER_DETAIL_ID"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
--=======================================================================


--====================== public.sale definition =========================
DROP TABLE IF EXISTS public."SALES";
CREATE TABLE public."SALES" (
	id bigint NOT NULL,
  amount double precision NOT NULL,
  date date NOT NULL,
  user_name character varying(255) NOT NULL,
  "time" time without time zone NOT NULL
);
ALTER TABLE public."SALES" ADD CONSTRAINT sale_pkey PRIMARY KEY (id);

DROP SEQUENCE IF EXISTS public."SEQ_SALE_ID";
CREATE SEQUENCE public."SEQ_SALE_ID"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
--=======================================================================



--====================== public.sale_detail definition ==================
DROP TABLE IF EXISTS public."SALE_DETAILS";
CREATE TABLE public."SALE_DETAILS" (
	id bigint NOT NULL,
  num_items integer NOT NULL,
  id_product_fk bigint NOT NULL,
  id_sale_fk bigint NOT NULL,
  price_unit double precision NOT NULL
);
ALTER TABLE public."SALE_DETAILS" ADD CONSTRAINT sale_detail_pkey PRIMARY KEY (id);
ALTER TABLE public."SALE_DETAILS" ADD CONSTRAINT fk_products_sale_details FOREIGN KEY (id_product_fk) REFERENCES public."PRODUCTS"(id);
ALTER TABLE public."SALE_DETAILS" ADD CONSTRAINT fk_sales_sale_details FOREIGN KEY (id_sale_fk) REFERENCES public."SALES"(id);

DROP SEQUENCE IF EXISTS public."SEQ_SALE_DETAIL_ID";
CREATE SEQUENCE public."SEQ_SALE_DETAIL_ID"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
--======================================================================= 


--====================== public.users definition ========================
DROP TABLE IF EXISTS public."USERS";
CREATE TABLE public."USERS" (
	id integer NOT NULL,
  username text NOT NULL,
  password text NOT NULL,
  enabled boolean NOT NULL,
  name text NOT NULL,
  last_name text NOT NULL,
  email text NOT NULL,
  attempts integer
);
ALTER TABLE public."USERS" ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE public."USERS" ADD CONSTRAINT username_unique UNIQUE (username) INCLUDE (username);

DROP SEQUENCE IF EXISTS public."SEQ_USER_ID";
CREATE SEQUENCE public."SEQ_USER_ID"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
--=======================================================================



--====================== public.roles definition ========================
DROP TABLE IF EXISTS public."ROLES";
CREATE TABLE public."ROLES" (
	id integer NOT NULL,
  name text NOT NULL
);
ALTER TABLE public."ROLES" ADD CONSTRAINT roles_pkey PRIMARY KEY (id);
--=======================================================================


--====================== public.users_roles definition ==================
DROP TABLE IF EXISTS public."USERS_ROLES";
CREATE TABLE public."USERS_ROLES" (
	id integer NOT NULL,
  id_user_fk integer NOT NULL,
  id_role_fk integer NOT NULL
);
ALTER TABLE public."USERS_ROLES" ADD CONSTRAINT users_roles_pkey PRIMARY KEY (id);
ALTER TABLE public."USERS_ROLES" ADD CONSTRAINT fk_users_users_roles FOREIGN KEY (id_user_fk) REFERENCES public."USERS"(id);
ALTER TABLE public."USERS_ROLES" ADD CONSTRAINT fk_roles_users_roles FOREIGN KEY (id_role_fk) REFERENCES public."ROLES"(id);

DROP SEQUENCE IF EXISTS public."SEQ_USERS_ROLES_ID";
CREATE SEQUENCE public."SEQ_USERS_ROLES_ID"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
--=======================================================================    