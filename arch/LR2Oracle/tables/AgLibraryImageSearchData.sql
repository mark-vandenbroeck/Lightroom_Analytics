
CREATE TABLE "AgLibraryImageSearchData" (
   id_local NUMBER ,
   featInfo VARCHAR2(32000) ,
   height VARCHAR2(32000) ,
   idDesc VARCHAR2(32000) ,
   idDescCh VARCHAR2(32000) ,
   image NUMBER ,
   width VARCHAR2(32000) ,
   CONSTRAINT AgLibraryImageSearchData_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryImageSearchData (
    id_local INTEGER PRIMARY KEY,
    featInfo,
    height,
    idDesc,
    idDescCh,
    image INTEGER NOT NULL DEFAULT 0,
    width
)
*/
