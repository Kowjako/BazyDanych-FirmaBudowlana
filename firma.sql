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


INSERT INTO company (company_id, company_name, creation_date, city, website) VALUES(1, 'Reynolds, Keeling and Moore', '17/11/15', 'Warsaw', 'https://geocities.com');
INSERT INTO company (company_id, company_name, creation_date, city, website) VALUES(2, 'Greenfelder-Pagac', '21/04/18', 'Wroclaw', 'https://chronoengine.com');
INSERT INTO company (company_id, company_name, creation_date, city, website) VALUES(3, 'Kiehn-Windler', '02/04/16', 'Minsk', 'http://usatoday.com');
INSERT INTO company (company_id, company_name, creation_date, city, website) VALUES(4, 'Dietrich LLC', '19/09/17', 'Moskwa', 'https://blogtalkradio.com');
INSERT INTO company (company_id, company_name, creation_date, city, website) VALUES(5, 'Kunde, Little and Quitzon', '24/06/16', 'Lingshan', 'http://tinyurl.com');
INSERT INTO company (company_id, company_name, creation_date, city, website) VALUES(6, 'Bernhard Group', '03/07/16', 'Stambul', 'https://smh.com.au');
INSERT INTO company (company_id, company_name, creation_date, city, website) VALUES(7, 'Shields, Cormier and Walter', '24/02/16', 'Paris', 'http://usnews.com');
INSERT INTO company (company_id, company_name, creation_date, city, website) VALUES(8, 'Grady Inc', '30/06/16', 'Los Angeles', 'http://cafepress.com');
INSERT INTO company (company_id, company_name, creation_date, city, website) VALUES(9, 'Erdman, Graham and Hand', '14/10/19', 'New Jork', 'http://dion.ne.jp');
INSERT INTO company (company_id, company_name, creation_date, city, website) VALUES(10, 'Senger-Schiller', '06/10/18', 'St. Petersburg', 'https://1688.com');


INSERT INTO operations (operation_id, operation_type, description, period_days, cost) VALUES (1, 'Roboty ziemne', 'Osadzenia fundamentów budynku', 10, 400);
INSERT INTO operations (operation_id, operation_type, description, period_days, cost) VALUES (2, 'Roboty malarskie', 'Wykonywanie powłok przy użyciu lakierów', 45, 1300);
INSERT INTO operations (operation_id, operation_type, description, period_days, cost) VALUES (3, 'Roboty murarskie', 'Murowanie z pustaków ceramicznych', 25, 780);
INSERT INTO operations (operation_id, operation_type, description, period_days, cost) VALUES (4, 'Roboty spawalnicze', 'Spawanie metodą TIG', 5, 200);
INSERT INTO operations (operation_id, operation_type, description, period_days, cost) VALUES (5, 'Roboty ziemne', 'Przygotowanie nawierzchni pod budowę', 20, 5300);
INSERT INTO operations (operation_id, operation_type, description, period_days, cost) VALUES (6, 'Roboty malarskie', 'Wykonywanie powłok wyrobami olejnymi', 15, 650);
INSERT INTO operations (operation_id, operation_type, description, period_days, cost) VALUES (7, 'Roboty murarskie', 'Murowanie z betonu komórkowego', 18, 750);
INSERT INTO operations (operation_id, operation_type, description, period_days, cost) VALUES (8, 'Roboty dekarskie', 'Zmiana pokrycia dachowego', 35, 2500);
INSERT INTO operations (operation_id, operation_type, description, period_days, cost) VALUES (9, 'Roboty dekarskie', 'Montaż pokryć dachowych', 15, 1000);
INSERT INTO operations (operation_id, operation_type, description, period_days, cost) VALUES (10, 'Roboty dekarskie', 'Obróbka dachów blacharskich', 10, 500);
INSERT INTO operations (operation_id, operation_type, description, period_days, cost) VALUES (11, 'Roboty spawalnicze', 'Spawanie oporowe', 3, 150);

INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (1, 'Tamar', 'Bramer', 23, 'tbramer0@paypal.com', 'K', '646-838-3396');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (2, 'Chauncey', 'Tocqueville', 35, 'ctocqueville1@china.com.cn', 'M', '692-878-0126');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (3, 'Jewelle', 'Storkes', 34, 'jstorkes2@skyrock.com', 'K', '957-995-2360');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (4, 'Wye', 'Luchelli', 25, 'wluchelli3@google.co.uk', 'M', '670-533-6807');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (5, 'Cordie', 'Sutherel', 36, 'csutherel4@about.com', 'M', '940-856-2994');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (6, 'Nathanial', 'Straun', 26, 'nstraun5@qq.com', 'M', '561-733-7547');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (7, 'Samuel', 'Streatfeild', 38, 'sstreatfeild6@rakuten.co.jp', 'M', '449-595-8193');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (8, 'Jolene', 'Medgewick', 50, 'jmedgewick7@mlb.com', 'K', '461-544-5258');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (9, 'Tailor', 'McLanachan', 44, 'tmclanachan8@ebay.co.uk', 'M', '322-450-4218');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (10, 'Elga', 'Sibthorp', 22, 'esibthorp9@census.gov', 'K', '930-659-7113');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (11, 'Gwendolin', 'Elcom', 23, 'gelcoma@newsvine.com', 'K', '752-130-8687');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (12, 'Bethina', 'Joel', 42, 'bjoelb@psu.edu', 'K', '346-180-2829');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (13, 'Friederike', 'Pirnie', 25, 'fpirniec@ifeng.com', 'K', '170-169-6258');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (14, 'Verene', 'Boarder', 20, 'vboarderd@phoca.cz', 'K', '846-346-5272');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (15, 'Pyotr', 'Ricardou', 23, 'pricardoue@mail.ru', 'M', '757-636-6730');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (16, 'Bartholomew', 'Took', 45, 'btookf@noaa.gov', 'M', '205-690-5797');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (17, 'Freddie', 'Michele', 25, 'fmicheleg@pcworld.com', 'K', '178-439-9188');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (18, 'Micki', 'Reimer', 42, 'mreimerh@sitemeter.com', 'K', '788-546-2684');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (19, 'Lenore', 'Pogue', 26, 'lpoguei@goo.gl', 'K', '594-576-5112');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (20, 'Bax', 'Leaning', 40, 'bleaningj@si.edu', 'M', '769-963-5613');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (21, 'Karney', 'Syplus', 23, 'ksyplusk@woothemes.com', 'M', '169-521-2516');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (22, 'Lotti', 'Neljes', 37, 'lneljesl@jiathis.com', 'K', '835-538-6813');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (23, 'Huntley', 'Alten', 26, 'haltenm@alibaba.com', 'M', '903-360-2435');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (24, 'Maure', 'Brabyn', 28, 'mbrabynn@wikipedia.org', 'K', '726-563-0691');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (25, 'Lonna', 'Ridsdole', 25, 'lridsdoleo@cam.ac.uk', 'K', '864-391-4608');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (26, 'Skipp', 'Jennison', 35, 'sjennisonp@skype.com', 'M', '803-913-0031');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (27, 'Tamarah', 'Diggle', 38, 'tdiggleq@amazon.de', 'K', '948-536-9339');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (28, 'Robinia', 'Girton', 36, 'rgirtonr@chicagotribune.com', 'K', '231-881-3062');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (29, 'Kasper', 'Lucy', 44, 'klucys@4shared.com', 'M', '462-402-5079');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (30, 'Caro', 'Snoddin', 43, 'csnoddint@mtv.com', 'K', '693-770-3608');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (31, 'Addie', 'Fortoun', 49, 'afortoun0@wordpress.com', 'M', '269-745-2323');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (32, 'Ryann', 'Edington', 33, 'redington1@uiuc.edu', 'K', '362-230-3604');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (33, 'Kendricks', 'Gockeler', 45, 'kgockeler2@booking.com', 'M', '631-859-3759');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (34, 'Joeann', 'Marte', 30, 'jmarte3@jugem.jp', 'K', '929-174-5960');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (35, 'Wlodzimierz', 'Kowjako', 2, 'anonymus@squidoo.com', 'M', '512-217-9011');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (36, 'Jehanna', 'Roundtree', 48, 'jroundtree5@typepad.com', 'K', '590-173-9336');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (37, 'Bonny', 'Stoll', 46, 'bstoll6@cbc.ca', 'K', '559-438-6061');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (38, 'Jose', 'Aulsford', 47, 'jaulsford7@uol.com.br', 'M', '379-608-6809');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (39, 'Salem', 'Skipsea', 29, 'sskipsea8@yelp.com', 'M', '949-291-0988');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (40, 'Charlean', 'Tichelaar', 41, 'ctichelaar9@a8.net', 'K', '255-110-3917');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (41, 'Natal', 'Blowne', 33, 'nblownea@rediff.com', 'M', '752-759-5130');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (42, 'Kathryn', 'Prosek', 38, 'kprosekb@sciencedaily.com', 'K', '771-217-2891');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (43, 'Sandro', 'Hundal', 35, 'shundalc@google.de', 'M', '962-448-2740');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (44, 'Jacquelyn', 'Connikie', 47, 'jconnikied@opensource.org', 'K', '446-984-3614');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (45, 'Fleur', 'Froment', 38, 'ffromente@umich.edu', 'K', '511-425-7699');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (46, 'Anette', 'Theakston', 29, 'atheakstonf@sourceforge.net', 'K', '513-373-1541');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (47, 'Isacco', 'Carvil', 24, 'icarvilg@uiuc.edu', 'M', '603-933-2061');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (48, 'Babita', 'Goadby', 23, 'bgoadbyh@theglobeandmail.com', 'K', '536-838-4466');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (49, 'Donella', 'McIlwain', 49, 'dmcilwaini@devhub.com', 'K', '341-116-0678');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (50, 'Alvira', 'Dellit', 21, 'adellitj@oaic.gov.au', 'K', '728-508-9995');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (51, 'Selestina', 'Castell', 34, 'scastellk@gravatar.com', 'K', '995-625-9676');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (52, 'Katuscha', 'Aulton', 38, 'kaultonl@i2i.jp', 'K', '731-770-7329');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (53, 'Nelia', 'Caris', 46, 'ncarism@linkedin.com', 'K', '976-589-5002');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (54, 'Isidor', 'Berringer', 50, 'iberringern@ocn.ne.jp', 'M', '169-503-4922');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (55, 'Margaretta', 'Nelsen', 33, 'mnelseno@umn.edu', 'K', '298-558-4791');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (56, 'Bertha', 'Hirschmann', 40, 'bhirschmannp@bandcamp.com', 'K', '775-285-4189');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (57, 'Reese', 'Gauge', 46, 'rgaugeq@npr.org', 'M', '353-542-0890');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (58, 'Dulcia', 'Tolson', 46, 'dtolsonr@yandex.ru', 'K', '676-271-1060');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (59, 'Westbrook', 'Melato', 46, 'wmelatos@scientific.com', 'M', '512-217-9037');
INSERT INTO people (people_id, first_name, last_name, age, email, gender, phone) VALUES (60, 'Addie', 'Faustin', 21, 'afaustint@taobao.com', 'K', '432-207-3556');

INSERT INTO payments (payment_id, payment_type, percentage) VALUES (1, 'BLIK', 16);
INSERT INTO payments (payment_id, payment_type, percentage) VALUES (2, 'Apple Pay', 15);
INSERT INTO payments (payment_id, payment_type, percentage) VALUES (3, 'Karta', 8);
INSERT INTO payments (payment_id, payment_type, percentage) VALUES (4, 'Płatności w Internecie', 11);
INSERT INTO payments (payment_id, payment_type, percentage) VALUES (5, 'Gotówka', 29);

/* Tworzenie kierownikow */
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (1, 10, '18/01/16', 'Kierownik', 2, 6, 11000);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (2, 9, '19/06/18', 'Kierownik', 2, 11, 31286);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (3, 8, '13/02/18', 'Kierownik', 8, 3, 20300);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (4, 7, '19/04/19', 'Kierownik', 5, 8, 14900);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (5, 6, '23/10/15', 'Kierownik', 9, 7, 12900);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (6, 5, '08/01/20', 'Kierownik', 6, 4, 24017);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (7, 4, '10/07/17', 'Kierownik', 9, 11, 32600);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (8, 3, '31/03/17', 'Kierownik', 1, 5, 18200);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (9, 2, '26/02/18', 'Kierownik', 4, 5, 12700);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (10, 1, '06/11/17', 'Kierownik', 7, 4, 24600);

/*Tworzenie pracownikow */
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (11, 11, '18/01/16', 'Pracwonik starszy', 1, 5, 5000);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (12, 13, '19/06/18', 'Pracownik starszy', 1, 4, 7000);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (13, 12, '13/02/18', 'Pracownik młodszy', 1, 3, 3500);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (14, 15, '19/04/19', 'Pracownik młodszy', 2, 1, 2200);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (15, 14, '23/10/15', 'Pracownik młodszy', 2, 2, 1290);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (16, 17, '08/01/20', 'Pracownik młodszy', 2, 3, 2400);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (17, 16, '10/07/17', 'Pracownik młodszy', 3, 6, 3260);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (18, 19, '31/03/17', 'Pracwonik starszy', 3, 7, 4200);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (19, 18, '26/02/18', 'Pracownik młodszy', 3, 8, 5500);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (20, 21, '06/11/17', 'Pracownik młodszy', 4, 6, 6000);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (21, 20, '18/01/16', 'Pracownik młodszy', 4, 7, 3300);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (22, 23, '19/06/18', 'Pracownik młodszy', 4, 10, 3100);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (23, 22, '13/02/18', 'Pracwonik starszy', 5, 10, 2030);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (24, 25, '19/04/19', 'Pracownik młodszy', 5, 6, 1490);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (25, 24, '23/10/15', 'Pracownik młodszy', 5, 5, 1290);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (26, 27, '08/01/20', 'Pracownik młodszy', 6, 9, 2400);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (27, 26, '10/07/17', 'Pracownik młodszy', 6, 11, 3260);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (28, 29, '31/03/17', 'Pracwonik starszy', 6, 5, 1820);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (29, 28, '26/02/18', 'Pracownik młodszy', 7, 9, 1270);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (30, 31, '06/11/17', 'Pracownik młodszy', 7, 9, 2460);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (31, 30, '18/01/16', 'Pracwonik starszy', 7, 2, 1100);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (32, 33, '19/06/18', 'Pracownik młodszy', 8, 11, 3130);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (33, 32, '13/02/18', 'Pracownik młodszy', 8, 3, 2090);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (34, 35, '19/04/19', 'Pracwonik starszy', 8, 8, 1590);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (35, 34, '23/10/15', 'Pracownik młodszy', 9, 7, 1230);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (36, 37, '08/01/20', 'Pracownik młodszy', 9, 4, 2490);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (37, 36, '10/07/17', 'Pracwonik starszy', 9, 11, 3350);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (38, 39, '31/03/17', 'Pracownik młodszy', 10, 5, 3700);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (39, 38, '26/02/18', 'Pracwonik starszy', 10, 5, 9100);
INSERT INTO workers (worker_id, data_id, hire_date, position, company_id, operation_id, salary) VALUES (40, 40, '06/11/17', 'Pracownik młodszy', 10, 4, 11500);

INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (1, 7, 10, 41);
INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (2, 9, 6, 42);
INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (3, 4, 9, 43);
INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (4, 4, 7, 44);
INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (5, 1, 3, 45);
INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (6, 7, 4, 46);
INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (7, 6, 5, 47);
INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (8, 6, 8, 48);
INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (9, 8, 7, 49);
INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (10, 9, 2, 50);
INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (11, 1, 2, 51);
INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (12, 1, 3, 52);
INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (13, 6, 5, 53);
INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (14, 8, 8, 54);
INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (15, 8, 3, 55);
INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (16, 4, 4, 56);
INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (17, 9, 1, 57);
INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (18, 4, 1, 58);
INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (19, 10, 6, 59);
INSERT INTO clients (client_id, orders_count, company_id, data_id) VALUES (20, 4, 1, 60);

INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (1, 15, 25, 1, '24/06/17', 4230);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (2, 19, 23, 3, '22/11/16', 4850);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (3, 9, 38, 1, '20/07/17', 3930);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (4, 17, 35, 2, '01/01/19', 4720);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (5, 6, 30, 5, '09/05/17', 2540);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (6, 10, 33, 4, '02/07/18', 3330);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (7, 18, 30, 2, '20/08/19', 2230);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (8, 18, 38, 2, '27/03/18', 3650);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (9, 20, 35, 3, '04/11/15', 2920);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (10, 4, 14, 3, '25/10/18', 4300);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (11, 19, 33, 3, '13/12/15', 2960);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (12, 14, 22, 2, '24/11/18', 4660);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (13, 1, 25, 5, '07/10/18', 1590);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (14, 18, 36, 5, '21/09/19', 1240);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (15, 13, 33, 5, '10/03/19', 4050);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (16, 17, 13, 1, '30/12/18', 1130);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (17, 12, 21, 2, '10/02/19', 2430);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (18, 7, 13, 5, '27/10/16', 4800);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (19, 20, 28, 5, '03/02/16', 1180);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (20, 8, 15, 1, '27/05/16', 2580);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (21, 8, 40, 5, '26/12/17', 4510);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (22, 11, 25, 5, '04/09/19', 2110);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (23, 18, 40, 5, '17/03/20', 3040);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (24, 19, 13, 2, '07/09/15', 2590);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (25, 15, 18, 2, '09/07/17', 4790);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (26, 11, 22, 4, '12/02/20', 2110);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (27, 10, 28, 3, '02/11/19', 4450);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (28, 7, 25, 2, '11/04/16', 3550);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (29, 10, 11, 1, '17/11/16', 3440);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (30, 6, 31, 4, '28/05/17', 2710);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (31, 9, 15, 1, '14/11/15', 3850);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (32, 6, 34, 4, '30/11/19', 2930);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (33, 12, 17, 5, '08/07/19', 1420);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (34, 11, 24, 1, '03/08/16', 3580);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (35, 17, 28, 5, '27/09/19', 4300);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (36, 19, 36, 2, '06/01/20', 1130);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (37, 12, 32, 1, '21/01/19', 4700);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (38, 18, 16, 1, '13/04/16', 2720);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (39, 15, 35, 4, '26/09/15', 1280);
INSERT INTO orders (order_id, client_id, worker_id, payment_id, finish_date, material_cost) VALUES (40, 19, 15, 3, '16/06/18', 1060);

INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (1, 7, '30/06/19', 13580, 40);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (2, 4, '26/05/18', 12400, 39);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (3, 10, '17/11/19', 9550, 38);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (4, 2, '30/12/16', 5040, 37);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (5, 3, '30/11/16', 4620, 36);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (6, 1, '03/09/16', 4950, 35);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (7, 3, '05/03/16', 5740, 34);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (8, 5, '04/03/19', 14580, 33);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (9, 4, '25/09/18', 7560, 32);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (10, 2, '01/09/15', 9260, 31);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (11, 6, '02/03/16', 13540, 30);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (12, 8, '27/08/16', 14210, 29);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (13, 9, '19/02/16', 13770, 28);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (14, 9, '30/11/17', 14970, 27);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (15, 4, '04/09/17', 7260, 26);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (16, 1, '05/07/18', 12000, 25);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (17, 9, '04/08/17', 13250, 24);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (18, 6, '16/01/17', 14330, 23);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (19, 3, '26/06/17', 12790, 22);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (20, 4, '23/04/17', 7850, 21);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (21, 8, '25/09/15', 4610, 20);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (22, 5, '10/07/19', 14580, 19);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (23, 9, '27/08/19', 11180, 18);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (24, 4, '07/03/17', 4610, 17);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (25, 6, '29/03/17', 4510, 16);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (26, 2, '26/04/17', 8880, 15);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (27, 1, '18/08/16', 11500, 14);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (28, 6, '21/11/18', 12750, 13);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (29, 6, '17/01/16', 14180, 12);
INSERT INTO profit (profit_id, company_id, enrollment_date, amount, order_id) VALUES (30, 4, '24/10/16', 6610, 11);

INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (1, 10, 1, '04/04/19', 4, 'Izolacja cieplna');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (2, 30, 5, '20/04/19', 5, 'Zaprawy cementowe');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (3, 36, 10, '23/02/16', 2, 'Płyty gipsowo - kartonowe');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (4, 3, 2, '23/12/16', 2, 'Zaprawy cementowe');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (5, 11, 4, '10/10/18', 2, 'Parapety zewnętrzne');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (6, 35, 7, '23/09/15', 5, 'Kleje do systemów ociepleń');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (7, 37, 10, '19/10/18', 2, 'Drewno konstrukcyjne');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (8, 13, 7, '24/01/18', 1, 'Cement budowlany');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (9, 14, 6, '24/06/19', 5, 'Zaprawy cementowe');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (10, 33, 5, '04/04/17', 4, 'Drewno konstrukcyjne');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (11, 30, 1, '07/10/18', 5, 'Wyciskacze do kartuszy');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (12, 20, 10, '27/02/17', 1, 'Wyciskacze do kartuszy');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (13, 16, 5, '14/09/19', 4, 'Płyty gipsowo - kartonowe');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (14, 15, 5, '05/11/18', 1, 'Drewno konstrukcyjne');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (15, 29, 3, '04/01/19', 4, 'Płyty gipsowo - kartonowe');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (16, 1, 10, '22/02/18', 4, 'Sufity podwieszane');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (17, 9, 9, '25/04/16', 1, 'Cement budowlany');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (18, 8, 2, '01/10/19', 2, 'Cegła klinkierowa');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (19, 16, 3, '31/01/17', 2, 'Kleje do systemów ociepleń');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (20, 38, 8, '29/11/17', 2, 'Cegła klinkierowa');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (21, 26, 5, '01/09/15', 1, 'Wyłazy dachowe');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (22, 16, 9, '06/10/16', 5, 'Cegła klinkierowa');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (23, 29, 1, '16/07/15', 2, 'Płyty gipsowo - kartonowe');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (24, 12, 4, '16/12/18', 2, 'Wyciskacze do kartuszy');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (25, 36, 3, '02/11/16', 5, 'Izolacja cieplna');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (26, 31, 7, '28/05/19', 5, 'Sufity podwieszane');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (27, 12, 2, '04/03/19', 5, 'Parapety zewnętrzne');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (28, 18, 4, '01/03/18', 3, 'Izolacja cieplna');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (29, 39, 4, '21/03/18', 2, 'Zaprawy cementowe');
INSERT INTO expenses (expenses_id, order_id, company_id, payment_date, amount, material) VALUES (30, 3, 3, '13/03/19', 4, 'Kleje do systemów ociepleń');

/* Tworzenie triggerow dla tabeli logow */
CREATE TABLE logger (
	log_id NUMBER NOT NULL,
	log_operation VARCHAR2(20) NOT NULL,
	change_table VARCHAR2(20) NOT NULL,
	change_date DATE NOT NULL
);

/* Sekwencja dla wstawiania id logow */
CREATE SEQUENCE logger_id MINVALUE 0 MAXVALUE 999 START WITH 0 INCREMENT BY 1;

ALTER TABLE logger ADD CONSTRAINT logger_pk PRIMARY KEY (log_id);
ALTER TABLE logger ADD CONSTRAINT logger_check1 CHECK (log_operation IN ('Insert', 'Update', 'Delete'));

/* Trigger dla tabeli company */
CREATE OR REPLACE TRIGGER COMPANY_CHANGES_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON company
DECLARE
  log_action  logger.log_operation%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'Insert';
  ELSIF UPDATING THEN
    log_action := 'Update';
  ELSIF DELETING THEN
    log_action := 'Delete';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO logger (log_id, log_operation, change_table, change_date)
    VALUES (logger_id.nextval, log_action, 'Company', SYSDATE);
END;

/* Trigger dla tabeli payment*/
CREATE OR REPLACE TRIGGER PAYMENTS_CHANGES_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON payments
DECLARE
  log_action  logger.log_operation%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'Insert';
  ELSIF UPDATING THEN
    log_action := 'Update';
  ELSIF DELETING THEN
    log_action := 'Delete';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO logger (log_id, log_operation, change_table, change_date)
    VALUES (logger_id.nextval, log_action, 'Payments', SYSDATE);
END;

/* Trigger dla tabeli expenses*/
CREATE OR REPLACE TRIGGER EXPENSES_CHANGES_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON expenses
DECLARE
  log_action  logger.log_operation%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'Insert';
  ELSIF UPDATING THEN
    log_action := 'Update';
  ELSIF DELETING THEN
    log_action := 'Delete';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO logger (log_id, log_operation, change_table, change_date)
    VALUES (logger_id.nextval, log_action, 'Expenses', SYSDATE);
END;

/* Trigger dla tabeli profit */
CREATE OR REPLACE TRIGGER PROFIT_CHANGES_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON profit
DECLARE
  log_action  logger.log_operation%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'Insert';
  ELSIF UPDATING THEN
    log_action := 'Update';
  ELSIF DELETING THEN
    log_action := 'Delete';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO logger (log_id, log_operation, change_table, change_date)
    VALUES (logger_id.nextval, log_action, 'Profit', SYSDATE);
END;

/* Trigger dla tabeli orders */
CREATE OR REPLACE TRIGGER ORDERS_CHANGES_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON orders
DECLARE
  log_action  logger.log_operation%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'Insert';
  ELSIF UPDATING THEN
    log_action := 'Update';
  ELSIF DELETING THEN
    log_action := 'Delete';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO logger (log_id, log_operation, change_table, change_date)
    VALUES (logger_id.nextval, log_action, 'Orders', SYSDATE);
END;

/* Trigger dla tabeli clients */
CREATE OR REPLACE TRIGGER CLIENTS_CHANGES_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON clients
DECLARE
  log_action  logger.log_operation%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'Insert';
  ELSIF UPDATING THEN
    log_action := 'Update';
  ELSIF DELETING THEN
    log_action := 'Delete';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO logger (log_id, log_operation, change_table, change_date)
    VALUES (logger_id.nextval, log_action, 'Clients', SYSDATE);
END;

/* Trigger dla tabeli workers */
CREATE OR REPLACE TRIGGER WORKERS_CHANGES_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON workers
DECLARE
  log_action  logger.log_operation%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'Insert';
  ELSIF UPDATING THEN
    log_action := 'Update';
  ELSIF DELETING THEN
    log_action := 'Delete';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO logger (log_id, log_operation, change_table, change_date)
    VALUES (logger_id.nextval, log_action, 'Workers', SYSDATE);
END;
	

/* Trigger dla tabeli people */
CREATE OR REPLACE TRIGGER PEOPLE_CHANGES_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON people
DECLARE
  log_action  logger.log_operation%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'Insert';
  ELSIF UPDATING THEN
    log_action := 'Update';
  ELSIF DELETING THEN
    log_action := 'Delete';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO logger (log_id, log_operation, change_table, change_date)
    VALUES (logger_id.nextval, log_action, 'People', SYSDATE);
END;

/* Trigger dla tabeli operations */
CREATE OR REPLACE TRIGGER OPERATIONS_CHANGES_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON operations
DECLARE
  log_action  logger.log_operation%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'Insert';
  ELSIF UPDATING THEN
    log_action := 'Update';
  ELSIF DELETING THEN
    log_action := 'Delete';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO logger (log_id, log_operation, change_table, change_date)
    VALUES (logger_id.nextval, log_action, 'Operations', SYSDATE);
END;



/* Usuwanie wszystkich tabel 
DROP TABLE EXPENSES;
DROP TABLE PROFIT;
DROP TABLE ORDERS;
DROP TABLE PAYMENTS;
DROP TABLE LOGGER;
DROP TABLE COMPANY;
DROP TABLE PEOPLE;
DROP TABLE OPERATIONS;
DROP TABLE WORKERS;
DROP TABLE CLIENTS; 
DROP SEQUENCE logger_id;
DROP TRIGGER COMPANY_CHANGES_TRIGGER;
DROP TRIGGER PAYMENTS_CHANGES_TRIGGER;
DROP TRIGGER EXPENSES_CHANGES_TRIGGER;
DROP TRIGGER PROFIT_CHANGES_TRIGGER;
DROP TRIGGER ORDERS_CHANGES_TRIGGER;
DROP TRIGGER CLIENTS_CHANGES_TRIGGER;
DROP TRIGGER WORKERS_CHANGES_TRIGGER;
DROP TRIGGER PEOPLE_CHANGES_TRIGGER;
DROP TRIGGER OPERATIONS_CHANGES_TRIGGER; */







