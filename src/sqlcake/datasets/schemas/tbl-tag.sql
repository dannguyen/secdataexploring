DROP TABLE IF EXISTS "tag";

CREATE TABLE "tag" (
	"tag" VARCHAR NOT NULL,
	"version" VARCHAR NOT NULL,
	"custom" VARCHAR NOT NULL,
	"abstract" VARCHAR NOT NULL,
	"datatype" VARCHAR,
	"iord" VARCHAR,
	"crdr" VARCHAR,
	"tlabel" VARCHAR,
	"doc" VARCHAR
);
