-- dvdrental

-- calculate_late_fees

CREATE OR REPLACE FUNCTION calculate_late_fee(rental_date timestamp, return_date timestamp)
RETURNS NUMERIC
AS
$$
DECLARE
late_fee numeric;
days_late interval;
BEGIN
IF return_date > rental_date + INTERVAL '3 days'
	THEN days_late := return_date - rental_date - interval '3 days';
	late_fee := EXTRACT(DAY FROM (days_late)) * 1.5;
ELSE 
	late_fee := 0;
end if;
RETURN late_fee;
END;
$$
LANGUAGE plpgsql;


-- anonymize_email

CREATE FUNCTION anonymize_email(email varchar)
RETURNS varchar
AS 
$$
DECLARE anonymized_email varchar;
BEGIN
anonymized_email := LEFT(email, 3) || '****';
RETURN anonymized_email;
END;
$$ 
LANGUAGE plpgsql;