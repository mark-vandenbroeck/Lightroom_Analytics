
CREATE TABLE "AgLibraryFolderFavorite" (
   id_local NUMBER ,
   id_global VARCHAR2(32000) ,
   favorite VARCHAR2(32000) ,
   folder NUMBER ,
   CONSTRAINT AgLibraryFolderFavorite_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryFolderFavorite (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    favorite,
    folder INTEGER NOT NULL DEFAULT 0
)
*/
