# Bazy Danych — Projekt Firmy Budowlanej 💿  
Projekt przedstawia bazę danych do biura firm budowlanych, tabela zaprojektowana zgodnie z trzecią postacią normalną. Zostały napisane i sprawdzone zapytania testowe.  
# Składniki
💾 Plik ``firma.sql`` — przedstawia skrypt generujący bazę danych i wypełniający tą bazę danymi.  
💾 Plik ``widoki.sql`` — przedstawia zapytania SQL które odpowiadają wymaganiam funkcjonalnym danej bazy danych.  
💾 Plik ``triggery.sql`` — przedstawia skrypt generujący triggery dla wypełnienia tabeli logów. 
# Diagram ERD 
![Relational_1](https://user-images.githubusercontent.com/19534189/120900434-12729e80-c635-11eb-83c6-1ea3f9ff61ec.png)
# Tabele 
🔸 Tabela ``Company`` — informacje odnośnie poszczególnych firm  
🔸 Tabela ``Workers`` — informacje odnośnie pracowników  
🔸 Tabela ``Clients`` — informacje odnośnie klientów  
🔸 Tabela ``Profit`` — informacje odnośnie dochodów poszczególnych firm  
🔸 Tabela ``Expenses`` — informacje odnośnie wydatków poszczególnych firm  
🔸 Tabela ``Operations`` — informacje odnośnie typów wykonywanych robot  
🔸 Tabela ``People`` — informacje odnośnie danych osobowych wszystkich użytkowników  
🔸 Tabela ``Orders`` — informacje odnośnie wszystkich zamówień  
🔸 Tabela ``Payments`` — informacje odnośnie typów dokonania zapłaty  
🔸 Tabela ``Logger`` — informacje odnośnie operowania nad tablicami
