
CREATE TABLE "AgLibraryPublishedCollectionContent" (
   id_local NUMBER ,
   collection NUMBER ,
   content VARCHAR2(32000) ,
   owningModule VARCHAR2(32000) ,
   CONSTRAINT AgLibraryPublishedCollectionContent_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryPublishedCollectionContent (
    id_local INTEGER PRIMARY KEY,
    collection INTEGER NOT NULL DEFAULT 0,
    content,
    owningModule
)
*/
