
CREATE TABLE "AgLibraryImport" (
   id_local NUMBER ,
   imageCount VARCHAR2(32000) ,
   importDate VARCHAR2(32000) ,
   name VARCHAR2(32000) ,
   CONSTRAINT AgLibraryImport_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryImport (
    id_local INTEGER PRIMARY KEY,
    imageCount,
    importDate NOT NULL DEFAULT '',
    name
)
*/
