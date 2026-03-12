
CREATE TABLE "AgLibraryPublishedCollection" (
   id_local NUMBER ,
   creationId VARCHAR2(32000) ,
   genealogy VARCHAR2(32000) ,
   imageCount VARCHAR2(32000) ,
   isDefaultCollection VARCHAR2(32000) ,
   name VARCHAR2(32000) ,
   parent NUMBER ,
   publishedUrl VARCHAR2(32000) ,
   remoteCollectionId VARCHAR2(32000) ,
   systemOnly VARCHAR2(32000) ,
   CONSTRAINT AgLibraryPublishedCollection_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryPublishedCollection (
    id_local INTEGER PRIMARY KEY,
    creationId NOT NULL DEFAULT '',
    genealogy NOT NULL DEFAULT '',
    imageCount,
    isDefaultCollection,
    name NOT NULL DEFAULT '',
    parent INTEGER,
    publishedUrl,
    remoteCollectionId,
    systemOnly NOT NULL DEFAULT ''
)
*/
