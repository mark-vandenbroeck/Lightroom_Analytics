
CREATE TABLE "AgLibraryPublishedCollectionLabel" (
   id_local NUMBER ,
   id_global VARCHAR2(32000) ,
   collection NUMBER ,
   label VARCHAR2(32000) ,
   labelData VARCHAR2(32000) ,
   labelGenerics VARCHAR2(32000) ,
   labelType VARCHAR2(32000) ,
   CONSTRAINT AgLibraryPublishedCollectionLabel_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryPublishedCollectionLabel (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    collection INTEGER NOT NULL DEFAULT 0,
    label,
    labelData,
    labelGenerics,
    labelType NOT NULL DEFAULT ''
)
*/
