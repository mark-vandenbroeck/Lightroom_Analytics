
CREATE TABLE "AgLibraryKeywordFace" (
   id_local NUMBER ,
   face NUMBER ,
   keyFace NUMBER ,
   rankOrder NUMBER ,
   tag NUMBER ,
   userPick NUMBER ,
   userReject NUMBER ,
   CONSTRAINT AgLibraryKeywordFace_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryKeywordFace (
    id_local INTEGER PRIMARY KEY,
    face INTEGER NOT NULL DEFAULT 0,
    keyFace INTEGER,
    rankOrder,
    tag INTEGER NOT NULL DEFAULT 0,
    userPick INTEGER,
    userReject INTEGER
)
*/
