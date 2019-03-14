DROP TABLE IF EXISTS mandex;
CREATE TABLE mandex (
    cik CHAR(20) NOT NULL,
    company_name VARCHAR NOT NULL,
    form_type VARCHAR NOT NULL,
    date_filed DATE NOT NULL,
    filename VARCHAR NOT NULL
);
