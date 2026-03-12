
CREATE TABLE "AgLibraryFolderStack" (
   id_local NUMBER ,
   id_global VARCHAR2(32000) ,
   collapsed NUMBER ,
   text VARCHAR2(32000) ,
   CONSTRAINT AgLibraryFolderStack_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryFolderStack (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    collapsed INTEGER NOT NULL DEFAULT 0,
    text NOT NULL DEFAULT ''
)
*/
