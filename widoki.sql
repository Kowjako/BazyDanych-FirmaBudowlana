1. Wyszukanie ceny za daną usługę wśród firm
CREATE VIEW Cennik AS 
SELECT DISTINCT cost, company_name FROM 
((SELECT o.cost, w.company_id FROM Workers w JOIN Operations o ON (w.operation_id = o.operation_id) AND o.operation_type = 'Roboty dekarskie') tmp JOIN Company c ON (tmp.company_id = c.company_id)) 
ORDER BY cost;

2. Sprawdzanie zapotrzebowania na dana usługę wśród firm
CREATE VIEW Ranking AS
SELECT DISTINCT b.operation_type, count(b.order_id), c.company_name
FROM company c 
JOIN (SELECT o.order_id, w.company_id, m.operation_type
FROM orders o 
JOIN workers w USING(worker_id)
JOIN operations m USING(operation_id)) b USING (company_id)
GROUP BY company_name, operation_type
ORDER BY operation_type,count(order_id);

3. Wyznaczenie kosztorysu wybranej pracy w zależności od usług w różnych firmach
CREATE VIEW Kosztorys AS
SELECT company_name, SUM(Cost) as "Cennik zestawu prac" FROM
(SELECT c.company_name, w.worker_id, w.operation_id FROM Company c
JOIN Workers w ON (w.company_id = c.company_id)) tmp
JOIN Operations o ON(tmp.operation_id = o.operation_id) 
WHERE o.operation_type IN ('Roboty ziemne', 'Roboty spawalnicze')
GROUP BY company_name;

4. Sprawdzenie popularności używanych metod płatności
CREATE VIEW Platnosci AS
SELECT p.payment_type, COUNT(*) as "Ile razy wykorzystano"
FROM Orders o JOIN Payments p ON (o.payment_id = p.payment_id)
GROUP BY p.payment_type;

5. Sprawdzenie najczęsciej wybieranego pracownika dla danej usługi wśród firm
CREATE VIEW Pracownicy AS
SELECT company_name, first_name, last_name, 
(SELECT COUNT(*) FROM Orders o WHERE o.worker_id = tmp.worker_id) as "Ilosc realizowanych zamowien"
FROM
(SELECT c.company_name, w.data_id, w.worker_id
FROM Company c JOIN Workers w ON (w.company_id = c.company_id)
WHERE w.operation_id = 
(SELECT operation_id FROM Operations WHERE description = 'Przygotowanie nawierzchni pod budowę')) tmp
JOIN People d ON (tmp.data_id = d.people_id)
ORDER BY "Ilosc realizowanych zamowien" DESC;

6. Zestawienie wydatków i dochodów firmy w okresie kwartału
CREATE VIEW Bilans AS
SELECT c.company_name,sum(p.amount)as "Profit", sum(e.amount) as "Expenses" 
FROM profit p JOIN company c using(company_id)
JOIN expenses e using(company_id)
WHERE Months_between(sysdate,e.payment_date)<=3
AND Months_between(sysdate,p.enrollment_date)<=3
GROUP BY company_name;
