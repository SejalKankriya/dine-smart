-- Creating a trigger to calculate the average stars for each business

CREATE OR REPLACE FUNCTION calculate_avg_stars()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE business
    SET avg_stars = (
        SELECT AVG(stars)
        FROM review
        WHERE business_id = NEW.business_id
    )
    WHERE business_id = NEW.business_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER calculate_avg_stars_trigger
AFTER INSERT ON review
FOR EACH ROW
EXECUTE FUNCTION calculate_avg_stars();