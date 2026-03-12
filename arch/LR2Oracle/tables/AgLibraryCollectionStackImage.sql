
CREATE TABLE "AgLibraryCollectionStackImage" (
   id_local NUMBER ,
   collapsed NUMBER ,
   collection NUMBER ,
   image NUMBER ,
   position VARCHAR2(32000) ,
   stack NUMBER ,
   CONSTRAINT AgLibraryCollectionStackImage_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryCollectionStackImage (
    id_local INTEGER PRIMARY KEY,
    collapsed INTEGER NOT NULL DEFAULT 0,
    collection INTEGER NOT NULL DEFAULT 0,
    image INTEGER NOT NULL DEFAULT 0,
    position NOT NULL DEFAULT '',
    stack INTEGER NOT NULL DEFAULT 0
)
*/
