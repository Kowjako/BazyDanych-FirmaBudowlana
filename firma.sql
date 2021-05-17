CREATE TABLE company (
	company_id NUMBER NOT NULL,
	company_name VARCHAR2(50) NOT NULL,
	creation_date DATE NOT NULL,
	city VARCHAR2(20) NOT NULL,
	website VARCHAR2(30) NOT NULL
);

ALTER TABLE company ADD CONSTRAINT company_pk PRIMARY KEY (company_id);

CREATE TABLE operations (
	operation_id NUMBER NOT NULL,
	operation_type VARCHAR2(50) NOT NULL,
	description VARCHAR(70) NOT NULL,
	period_days NUMBER NOT NULL,
	cost NUMBER NOT NULL
);

ALTER TABLE operations ADD CONSTRAINT operation_pk PRIMARY KEY (operation_id);
ALTER TABLE operations ADD CONSTRAINT operation_check1 CHECK (cost>0);

CREATE TABLE people (
	people_id NUMBER NOT NULL,
	first_name VARCHAR2(15) NOT NULL,
	last_name VARCHAR2(15) NOT NULL,
	age	NUMBER NOT NULL,
	email VARCHAR2(30) NOT NULL,
	gender VARCHAR(1) NOT NULL,
	phone VARCHAR2(15) NOT NULL
);

ALTER TABLE people ADD CONSTRAINT people_pk PRIMARY KEY (people_id);
ALTER TABLE people ADD CONSTRAINT people_check1 CHECK (gender IN ('M','K'));
ALTER TABLE people ADD CONSTRAINT people_check2 CHECK (age>0);

CREATE TABLE payments (
	payment_id NUMBER NOT NULL,
	payment_type VARCHAR2(25) NOT NULL,
	percentage NUMBER NOT NULL
);

ALTER TABLE payments ADD CONSTRAINT payments_pk PRIMARY KEY (payment_id);
ALTER TABLE payments ADD CONSTRAINT payments_check1 CHECK (percentage BETWEEN 0 AND 30);

CREATE TABLE workers (
	worker_id NUMBER NOT NULL,
	data_id NUMBER NOT NULL,
	hire_date DATE,
	position VARCHAR2(20),
	company_id NUMBER,
	operation_id NUMBER NOT NULL,
	salary NUMBER
);

ALTER TABLE workers ADD CONSTRAINT workers_pk PRIMARY KEY (worker_id);
ALTER TABLE workers ADD CONSTRAINT workers_unique_data UNIQUE (data_id);
ALTER TABLE workers ADD CONSTRAINT workers_data_fk FOREIGN KEY (data_id) REFERENCES people(people_id);
ALTER TABLE workers ADD CONSTRAINT workers_company_fk FOREIGN KEY (company_id) REFERENCES company(company_id);
ALTER TABLE workers ADD CONSTRAINT workers_operation_fk FOREIGN KEY (operation_id) REFERENCES operations(operation_id);
ALTER TABLE workers ADD CONSTRAINT workers_check1 CHECK (salary > 0 OR salary IS NULL);

CREATE TABLE clients (
	client_id NUMBER NOT NULL,
	orders_count NUMBER NOT NULL,
	company_id NUMBER,
	data_id NUMBER NOT NULL
);

ALTER TABLE clients ADD CONSTRAINT clients_pk PRIMARY KEY (client_id);
ALTER TABLE clients ADD CONSTRAINT clients_unique_data UNIQUE (data_id);
ALTER TABLE clients ADD CONSTRAINT clients_data_fk FOREIGN KEY (data_id) REFERENCES people(people_id);
ALTER TABLE clients ADD CONSTRAINT clients_company_fk FOREIGN KEY (company_id) REFERENCES company(company_id);

CREATE TABLE orders (
	order_id NUMBER NOT NULL,
	client_id NUMBER NOT NULL,
	worker_id NUMBER NOT NULL,
	payment_id NUMBER NOT NULL,
	finish_date DATE NOT NULL,
	material_cost NUMBER NOT NULL
);

ALTER TABLE orders ADD CONSTRAINT orders_pk PRIMARY KEY (order_id);
ALTER TABLE orders ADD CONSTRAINT orders_check1 CHECK (material_cost>0);
ALTER TABLE orders ADD CONSTRAINT orders_client_fk FOREIGN KEY (client_id) REFERENCES clients(client_id);
ALTER TABLE orders ADD CONSTRAINT orders_worker_fk FOREIGN KEY (worker_id) REFERENCES workers(worker_id);
ALTER TABLE orders ADD CONSTRAINT orders_payment_fk FOREIGN KEY (payment_id) REFERENCES payments(payment_id);

CREATE TABLE profit (
	profit_id NUMBER NOT NULL,
	company_id NUMBER NOT NULL,
	enrollment_date DATE NOT NULL,
	amount NUMBER NOT NULL,
	order_id NUMBER NOT NULL
);

ALTER TABLE profit ADD CONSTRAINT profit_pk PRIMARY KEY (profit_id);
ALTER TABLE profit ADD CONSTRAINT profit_check1 CHECK (amount>0);
ALTER TABLE profit ADD CONSTRAINT profit_company_fk FOREIGN KEY (company_id) REFERENCES company(company_id);
ALTER TABLE profit ADD CONSTRAINT profit_unique_order UNIQUE (order_id);
ALTER TABLE profit ADD CONSTRAINT profit_order_fk FOREIGN KEY (order_id) REFERENCES orders(order_id);

CREATE TABLE expenses (
	expenses_id	NUMBER NOT NULL,
	order_id NUMBER NOT NULL,
	company_id NUMBER NOT NULL,
	payment_date DATE NOT NULL,
	amount NUMBER NOT NULL,
	material VARCHAR2(35) NOT NULL
);

ALTER TABLE expenses ADD CONSTRAINT expenses_pk PRIMARY KEY (expenses_id);
ALTER TABLE expenses ADD CONSTRAINT expenses_check1 CHECK (amount>0);
ALTER TABLE expenses ADD CONSTRAINT expenses_company_fk FOREIGN KEY (company_id) REFERENCES company(company_id);
ALTER TABLE expenses ADD CONSTRAINT expenses_order_fk FOREIGN KEY (order_id) REFERENCES orders(order_id);