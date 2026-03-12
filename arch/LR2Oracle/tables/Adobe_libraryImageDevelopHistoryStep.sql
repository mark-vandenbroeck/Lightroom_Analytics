
CREATE TABLE "Adobe_libraryImageDevelopHistoryStep" (
   id_local NUMBER ,
   id_global VARCHAR2(32000) ,
   dateCreated VARCHAR2(32000) ,
   digest VARCHAR2(32000) ,
   hasBigData NUMBER ,
   hasDevelopAdjustments VARCHAR2(32000) ,
   image NUMBER ,
   name VARCHAR2(32000) ,
   relValueString VARCHAR2(32000) ,
   text VARCHAR2(32000) ,
   valueString VARCHAR2(32000) ,
   CONSTRAINT Adobe_libraryImageDevelopHistoryStep_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE Adobe_libraryImageDevelopHistoryStep (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    dateCreated,
    digest,
    hasBigData INTEGER NOT NULL DEFAULT 0,
    hasDevelopAdjustments,
    image INTEGER,
    name,
    relValueString,
    text,
    valueString
)
*/
