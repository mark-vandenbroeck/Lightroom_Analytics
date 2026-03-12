
CREATE TABLE "AgLibraryKeywordCooccurrence" (
   id_local NUMBER ,
   tag1 NUMBER ,
   tag2 NUMBER ,
   value NUMBER ,
   CONSTRAINT AgLibraryKeywordCooccurrence_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryKeywordCooccurrence (
    id_local INTEGER PRIMARY KEY,
    tag1 NOT NULL DEFAULT '',
    tag2 NOT NULL DEFAULT '',
    value NOT NULL DEFAULT 0
)
*/
