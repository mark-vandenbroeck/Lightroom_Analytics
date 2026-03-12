
CREATE TABLE "AgLibraryCollectionStack" (
   id_local NUMBER ,
   id_global VARCHAR2(32000) ,
   collapsed NUMBER ,
   collection NUMBER ,
   text VARCHAR2(32000) ,
   CONSTRAINT AgLibraryCollectionStack_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryCollectionStack (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    collapsed INTEGER NOT NULL DEFAULT 0,
    collection INTEGER NOT NULL DEFAULT 0,
    text NOT NULL DEFAULT ''
)
*/
