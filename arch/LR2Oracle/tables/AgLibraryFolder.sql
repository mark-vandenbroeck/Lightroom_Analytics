
CREATE TABLE "AgLibraryFolder" (
   id_local NUMBER ,
   id_global VARCHAR2(32000) ,
   parentId NUMBER ,
   pathFromRoot VARCHAR2(32000) ,
   rootFolder NUMBER ,
   visibility NUMBER ,
   CONSTRAINT AgLibraryFolder_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryFolder (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    parentId INTEGER,
    pathFromRoot NOT NULL DEFAULT '',
    rootFolder INTEGER NOT NULL DEFAULT 0,
    visibility INTEGER
)
*/
