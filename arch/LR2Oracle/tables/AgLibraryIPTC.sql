
CREATE TABLE "AgLibraryIPTC" (
   id_local NUMBER ,
   altTextAccessibility NUMBER ,
   caption NUMBER ,
   copyright NUMBER ,
   extDescrAccessibility NUMBER ,
   image NUMBER ,
   CONSTRAINT AgLibraryIPTC_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryIPTC (
    id_local INTEGER PRIMARY KEY,
    altTextAccessibility,
    caption,
    copyright,
    extDescrAccessibility,
    image INTEGER NOT NULL DEFAULT 0
)
*/
