-- Total amount of reviews that each user has written across Restaurant businesses, along with their names

SELECT usr.name, COUNT(rv.review_id) AS
 review_count FROM users usr
 INNER JOIN reviews rv
 ON usr.user_id = rv.user_id
 WHERE rv.business_id IN (
 	 SELECT bs.business_id 
 	 FROM business bs
)
GROUP BY usr.user_id
ORDER BY review_count DESC;

-- Calculating the cumulative review count per user over time

SELECT user_id, review_date, 
  COUNT(*) AS review_count,
  SUM(COUNT(*)) OVER (
    PARTITION BY user_id 
    ORDER BY review_date
  ) AS cumulative_count
FROM reviews
GROUP BY user_id, review_date
ORDER BY user_id, review_date;

-- Top 3 businesses in each city based on Saturday check-ins for 2016
SELECT city, name AS business_name, checkins
FROM (
	SELECT city, name, checkins,
	ROW_NUMBER() OVER (
		PARTITION BY city
		ORDER BY checkins DESC
	) AS rank
	FROM (
		SELECT b.city, b.name,
        SUM(c.checkins) AS checkins
		FROM public.business b
		INNER JOIN public.checkins c
        ON b.business_id = c.business_id 
		GROUP BY b.business_id, b.city, b.name
	) AS checkins_by_business
) AS ranked_checkins
WHERE rank <= 3
ORDER BY city, rank;

-- Business with most dietary restrictions

SELECT b.name,
    COUNT(dtr.dietary_restriction_type)
    AS number_of_restrictions
FROM business b
JOIN dietary_restrictions dtr 
    ON b.business_id = dtr.business_id
GROUP BY b.business_id
ORDER BY number_of_restrictions DESC
LIMIT 1;

-- City with most business

SELECT city, COUNT(*)
    AS number_of_restaurants
FROM business
GROUP BY city
ORDER BY number_of_restaurants DESC;

-- Top 3 most common dietary restriction

SELECT dtype.dietary_restriction_name,
    COUNT(dtr.dietary_restriction_type)
        AS num_occurrences
FROM dietary_restrictions dtr
INNER JOIN dietary_restriction_types dtype
ON dtr.dietary_restriction_type =
    dtype.dietary_restriction_type
GROUP BY dtype.dietary_restriction_name
ORDER BY num_occurrences DESC
LIMIT 3;

-- Business with minimum 2 star ratings

SELECT DISTINCT(usr.name)
FROM users usr
JOIN reviews rv
    ON usr.user_id = rv.user_id
JOIN business b
    ON rv.business_id = b.business_id
WHERE b.stars >= 2;

-- Highest-checked-in businesses for each day of the week

SELECT weekday, business_id, checkins
FROM (
  SELECT weekday, business_id, checkins,
    ROW_NUMBER()
    OVER (
        PARTITION BY weekday
        ORDER BY checkins DESC
    ) AS rank
  FROM checkins
) AS ranked_checkins
WHERE rank = 1;

-- 10 latest reviews for Toronto restaurants with the highest star rating

SELECT b.name, b.stars,
    rv.review_date,rv.comments 
FROM business b 
JOIN reviews rv 
ON b.business_id = rv.business_id 
JOIN (
	SELECT business_id,
        MAX(stars) AS max_stars 
	FROM reviews
    GROUP BY business_id) max_reviews 
ON rv.business_id = max_reviews.business_id
AND rv.stars = max_reviews.max_stars
WHERE b.city = 'Toronto' 
ORDER BY rv.review_date DESC 
LIMIT 10;

-- Businesses offering outdoor seating and accept credit cards

SELECT b.name
FROM business b
JOIN restaurants_service rs
ON b.business_id = rs.business_id
JOIN business_details_extended bde
ON b.business_id = bde.business_id
WHERE bde.accepts_credit_cards = true
AND rs.outdoor_seating = true;