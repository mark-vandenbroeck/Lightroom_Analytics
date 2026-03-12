
CREATE TABLE "AgFolderContent" (
   id_local NUMBER ,
   id_global VARCHAR2(32000) ,
   containingFolder NUMBER ,
   content VARCHAR2(32000) ,
   name VARCHAR2(32000) ,
   owningModule VARCHAR2(32000) ,
   CONSTRAINT AgFolderContent_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgFolderContent (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    containingFolder INTEGER NOT NULL DEFAULT 0,
    content,
    name,
    owningModule
)
*/
