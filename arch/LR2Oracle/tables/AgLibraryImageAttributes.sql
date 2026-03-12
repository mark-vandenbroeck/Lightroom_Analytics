
CREATE TABLE "AgLibraryImageAttributes" (
   id_local NUMBER ,
   image NUMBER ,
   lastExportTimestamp NUMBER ,
   lastPublishTimestamp NUMBER ,
   CONSTRAINT AgLibraryImageAttributes_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryImageAttributes (
    id_local INTEGER PRIMARY KEY,
    image INTEGER NOT NULL DEFAULT 0,
    lastExportTimestamp DEFAULT 0,
    lastPublishTimestamp DEFAULT 0
)
*/
