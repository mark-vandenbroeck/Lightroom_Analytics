
CREATE TABLE "AgLibraryKeyword" (
   id_local NUMBER ,
   id_global NUMBER ,
   dateCreated NUMBER ,
   genealogy NUMBER ,
   imageCountCache NUMBER ,
   includeOnExport NUMBER ,
   includeParents NUMBER ,
   includeSynonyms NUMBER ,
   keywordType NUMBER ,
   lastApplied NUMBER ,
   lc_name NUMBER ,
   name NUMBER ,
   parent NUMBER ,
   CONSTRAINT AgLibraryKeyword_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryKeyword (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    dateCreated NOT NULL DEFAULT '',
    genealogy NOT NULL DEFAULT '',
    imageCountCache DEFAULT -1,
    includeOnExport INTEGER NOT NULL DEFAULT 1,
    includeParents INTEGER NOT NULL DEFAULT 1,
    includeSynonyms INTEGER NOT NULL DEFAULT 1,
    keywordType,
    lastApplied,
    lc_name,
    name,
    parent INTEGER
)
*/
