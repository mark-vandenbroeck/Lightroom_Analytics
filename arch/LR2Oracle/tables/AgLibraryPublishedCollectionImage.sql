
CREATE TABLE "AgLibraryPublishedCollectionImage" (
   id_local NUMBER ,
   collection NUMBER ,
   image NUMBER ,
   pick VARCHAR2(32000) ,
   positionInCollection VARCHAR2(32000) ,
   CONSTRAINT AgLibraryPublishedCollectionImage_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryPublishedCollectionImage (
    id_local INTEGER PRIMARY KEY,
    collection INTEGER NOT NULL DEFAULT 0,
    image INTEGER NOT NULL DEFAULT 0,
    pick NOT NULL DEFAULT 0,
    positionInCollection
)
*/
