-- II
-- 1) Les clients viennent de combien de villes et d’état différents?

SELECT COUNT(DISTINCT(customer_city)) FROM customers;

-- Result : 4119

-- 2) Dans l’état de Sao Paolo (SP), combien y a t il de ville différentes? (utilisez pour cette question la table customers)

SELECT COUNT(DISTINCT customer_city)
FROM customers
WHERE customer_state  ='SP'
;

-- Result : 629

-- 3) La table Customers présente-t-elle des valeurs nulles? 

SELECT * FROM customers
WHERE (customer_id IS NULL) OR (customer_unique_id IS NULL) OR (customer_zip_code_prefix IS NULL) OR (customer_city IS NULL) OR (customer_state IS NULL);

-- Result : rien, pas de valeurs nulles dans la table customers

-- 4) La table présente deux id, (un de jointure, l’autre comme clef primaire). Est ce que l’un de ces ID est en doublon?

SELECT COUNT(customer_id) - COUNT(DISTINCT customer_unique_id)
FROM customers
;

Result : il y a 3345 doublons de customer_unique_id

-- 5) Quelle est la relation théorique entre customers et orders (one to many ou many to one)?

-- Result : one to many (un customer peut avoir plusieurs commandes, mais une commande ne peut avoir qu'un seul customer)

-- 6) Quelle relation est encodée dans les bases?

-- Result : le champ customer_id est utilisé dans la table orders et fait référence à la clé primaire customer_id de la table customers

-- 7) A partir de l’analyse précédente, calculez le nombre réel de client par état (state)

SELECT customer_state, COUNT(DISTINCT customer_unique_id)
FROM customers
GROUP BY customer_state;

-- note : un customer_unique_id peut être repertorié dans plusieurs états

----------------------------------------------------------------------------------------------------------------------------------

-- III
-- On cherche à calculer le nombre de commandes, le nombre de produits vendus et le chiffre d'affaires (qui n’intègre pas les frais de port) pour chaque état du client
-- Pour cela, à l’aide d’une requête imbriquée ou d’une table temporaire procédez en trois temps:
-- à partir de la table orders items calculez les indicateurs souhaités
-- faire une jointure ensuite avec la table order le customer_id
-- faire une jointure enfin sur la table consumers pour récupérer le pays.

SELECT DISTINCT customer_state, count(DISTINCT orders.order_id) AS nb_cdes, count(orders_items.order_id) AS nb_pdts_vendus, sum(orders_items.price) AS CA
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN orders_items ON orders.order_id = orders_items.order_id
GROUP BY customer_state
;




