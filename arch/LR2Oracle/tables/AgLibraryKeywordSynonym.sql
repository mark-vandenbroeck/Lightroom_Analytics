
CREATE TABLE "AgLibraryKeywordSynonym" (
   id_local NUMBER ,
   keyword NUMBER ,
   lc_name VARCHAR2(32000) ,
   name VARCHAR2(32000) ,
   CONSTRAINT AgLibraryKeywordSynonym_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryKeywordSynonym (
    id_local INTEGER PRIMARY KEY,
    keyword INTEGER NOT NULL DEFAULT 0,
    lc_name,
    name
)
*/
