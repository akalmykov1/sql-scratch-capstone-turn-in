Task 1
SELECT * 
FROM survey
LIMIT 10;

Task 2	
SELECT COUNT(user_id), question
FROM survey
GROUP BY question;

Task 4	
SELECT * FROM quiz
LIMIT 5;

SELECT * FROM home_try_on
LIMIT 5;

SELECT * FROM purchase
LIMIT 5;

Task 5	
SELECT q.user_id, 
h.user_id IS NOT NULL AS 'is_home_try_on', 
number_of_pairs, 
p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz 'q'
LEFT JOIN home_try_on 'h'
ON q.user_id = h.user_id
LEFT JOIN purchase 'p'
ON h.user_id=p.user_id
LIMIT 10;


Task 6
--Conversion rates
WITH funnels AS(SELECT q.user_id, 
h.user_id IS NOT NULL AS 'is_home_try_on', 
number_of_pairs, 
p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h'
ON q.user_id = h.user_id
LEFT JOIN purchase AS 'p'
ON h.user_id=p.user_id)
SELECT COUNT(*) 'num_quiz', SUM(is_home_try_on) 'num_home_try_on', 
SUM(is_purchase) 'num_purchase', 
1.0*SUM(is_home_try_on)/COUNT(user_id) 'quiz_to_home_try_on', 
1.0*SUM(is_purchase)/SUM(is_home_try_on) 'home_try_on_to_purchase'
FROM funnels;

--Number of people who recieved 3 or 5 pairs
WITH funnels AS(SELECT q.user_id, 
h.user_id IS NOT NULL AS 'is_home_try_on', 
number_of_pairs, 
p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h'
ON q.user_id = h.user_id
LEFT JOIN purchase AS 'p'
ON h.user_id=p.user_id)
SELECT COUNT(*), number_of_pairs AS'n'
FROM funnels
GROUP BY 2;

Purchase rate by 3 or 5 pairs:
WITH funnels AS(SELECT q.user_id, 
h.user_id IS NOT NULL AS 'is_home_try_on', 
number_of_pairs, 
p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz 'q'
LEFT JOIN home_try_on 'h'
ON q.user_id = h.user_id
LEFT JOIN purchase 'p'
ON h.user_id=p.user_id)
SELECT is_purchase,
COUNT(DISTINCT CASE 
      WHEN number_of_pairs ='5 pairs'
      THEN user_id
      END)'5 pairs', 
COUNT(DISTINCT CASE 
      WHEN number_of_pairs ='3 pairs'
      THEN user_id
      END) '3 pairs'       
FROM funnels
GROUP BY 1;

--Quiz question answers
SELECT question, count(*), response
FROM survey
GROUP BY response
ORDER BY 1;

--Purchases
SELECT count(*), product_id, style, model_name, color
FROM purchase
GROUP BY 2
ORDER BY 2;

--Purchases by model
SELECT count(*), model_name
FROM purchase
GROUP BY 2
ORDER BY 1 DESC;

--Purchases by color
SELECT count(*), color
FROM purchase
GROUP BY 2
ORDER BY 1 DESC;
