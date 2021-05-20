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
/

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
/

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
/

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
/

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
/

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
/

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
/

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
/

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
/