DROP TABLE IF EXISTS "num";

CREATE TABLE "num" (
    "adsh" CHAR(20) NOT NULL,
    "tag" VARCHAR NOT NULL,
    "version" VARCHAR NOT NULL,
    "coreg" VARCHAR,
    "ddate" CHAR(8) NOT NULL,
    "qtrs" INTEGER NOT NULL,
    "uom" VARCHAR NOT NULL,
    "value" DECIMAL(28,4),
    "footnote" VARCHAR(512)
);
