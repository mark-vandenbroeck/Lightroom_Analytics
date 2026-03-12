
CREATE TABLE "AgLibraryKeywordPopularity" (
   id_local NUMBER ,
   occurrences NUMBER ,
   popularity NUMBER ,
   tag NUMBER ,
   CONSTRAINT AgLibraryKeywordPopularity_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryKeywordPopularity (
    id_local INTEGER PRIMARY KEY,
    occurrences NOT NULL DEFAULT 0,
    popularity NOT NULL DEFAULT 0,
    tag UNIQUE NOT NULL DEFAULT ''
)
*/
