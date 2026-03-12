
CREATE TABLE "AgLibraryCollection" (
   id_local NUMBER ,
   creationId NUMBER ,
   genealogy NUMBER ,
   imageCount NUMBER ,
   name NUMBER ,
   parent NUMBER ,
   systemOnly NUMBER ,
   CONSTRAINT AgLibraryCollection_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryCollection (
    id_local INTEGER PRIMARY KEY,
    creationId NOT NULL DEFAULT '',
    genealogy NOT NULL DEFAULT '',
    imageCount,
    name NOT NULL DEFAULT '',
    parent INTEGER,
    systemOnly NOT NULL DEFAULT ''
)
*/
