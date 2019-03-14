CREATE INDEX num_idx_adsh_tag ON "num"("adsh", "tag");
CREATE INDEX num_idx_tag ON "num"("tag");

CREATE UNIQUE INDEX sub_idx_adsh ON "sub"("adsh");
CREATE INDEX sub_idx_cik ON "sub"("cik");
CREATE INDEX sub_idx_name ON "sub"("name");
CREATE INDEX sub_idx_sic ON "sub"("sic");
CREATE INDEX sub_idx_cityba ON "sub"("cityba");
CREATE INDEX sub_idx_form_period ON "sub"("form", "period");

CREATE INDEX pre_idx_adsh_tag ON "pre"("adsh", "tag");
