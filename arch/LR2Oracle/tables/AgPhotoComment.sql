
CREATE TABLE "AgPhotoComment" (
   id_local NUMBER ,
   id_global VARCHAR2(32000) ,
   comment_ VARCHAR2(32000) ,
   commentRealname VARCHAR2(32000) ,
   commentUsername VARCHAR2(32000) ,
   dateCreated VARCHAR2(32000) ,
   photo NUMBER ,
   remoteId VARCHAR2(32000) ,
   remotePhoto NUMBER ,
   url VARCHAR2(32000) ,
   CONSTRAINT AgPhotoComment_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgPhotoComment (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    comment,
    commentRealname,
    commentUsername,
    dateCreated,
    photo INTEGER NOT NULL DEFAULT 0,
    remoteId NOT NULL DEFAULT '',
    remotePhoto INTEGER,
    url
)
*/
