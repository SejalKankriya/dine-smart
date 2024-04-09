-- Creating a clustered index on the primary key of the 'business' table

CLUSTER business USING business_pkey;

-- Creating an unclustered index on the foreign key column 'business_id' of the 'business_details_extended' table

CREATE INDEX idx_business_details_extended
ON business_details_extended (business_id);

-- Creating an unclustered index on the foreign key column 'business_id' of the 'business_hours' table

CREATE INDEX idx_business_hours
ON business_hours (business_id);

-- Creating an unclustered index on the foreign key column 'business_id' of the 'checkins' table

CREATE INDEX idx_checkins
ON checkins (business_id);

-- Creating an unclustered index on the foreign key column 'business_id' of the 'dietary_restrictions' table

CREATE INDEX idx_dietary_restrictions
ON dietary_restrictions (business_id);

-- Creating an unclustered index on the foreign key column 'business_id' of the 'music' table

CREATE INDEX idx_music
ON music (business_id);

-- Creating an unclustered index on the foreign key column 'business_id' of the 'other_info' table

CREATE INDEX idx_other_info
ON other_info (business_id);

-- Creating an unclustered index on the foreign key column 'business_id' of the 'parking' table

CREATE INDEX idx_parking
ON parking (business_id);

-- Creating an unclustered index on the foreign key column 'business_id' of the 'restaurants_service' table

CREATE INDEX idx_restaurants_service
ON restaurants_service (business_id);

-- Creating an unclustered index on the foreign key column 'business_id' of the 'speciality' table

CREATE INDEX idx_speciality
ON speciality (business_id);

-- Creating an unclustered index on the foreign key column 'business_id' of the 'reviews' table

CREATE INDEX idx_reviews
ON reviews (business_id);

-- Creating an unclustered index on the foreign key column 'user_id' of the 'reviews' table

CREATE INDEX idx_reviews_user
ON reviews (user_id);
