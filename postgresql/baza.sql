ALTER TABLE "DFor_post" ADD COLUMN tekst_tsv tsvector;
ALTER TABLE "DFor_temat" ADD COLUMN tytul_tsv tsvector;

CREATE TRIGGER "tsvectorUpdatePost" BEFORE INSERT OR UPDATE ON "DFor_post" FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger(tekst_tsv, "public.polish", tekst);
CREATE TRIGGER "tsvectorUpdateTemat" BEFORE INSERT OR UPDATE ON "DFor_temat" FOR EACH ROW EXECUTE PROCEDURE tsvector_update_trigger(tytul_tsv, "public.polish", tytul);
    
CREATE INDEX "DFor_post_tsv" ON "DFor_post" USING gin(tekst_tsv);
CREATE INDEX "DFor_temat_tsv" ON "DFor_temat" USING gin(tytul_tsv);
    