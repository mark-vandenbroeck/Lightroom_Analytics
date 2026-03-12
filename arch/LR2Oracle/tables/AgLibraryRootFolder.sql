
CREATE TABLE "AgLibraryRootFolder" (
   id_local NUMBER ,
   id_global VARCHAR2(32000) ,
   absolutePath VARCHAR2(32000) ,
   name VARCHAR2(32000) ,
   relativePathFromCatalog VARCHAR2(32000) ,
   CONSTRAINT AgLibraryRootFolder_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryRootFolder (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    absolutePath UNIQUE NOT NULL DEFAULT '',
    name NOT NULL DEFAULT '',
    relativePathFromCatalog
)
*/
