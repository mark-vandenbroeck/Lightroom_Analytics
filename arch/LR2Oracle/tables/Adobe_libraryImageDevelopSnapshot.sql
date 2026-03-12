
CREATE TABLE "Adobe_libraryImageDevelopSnapshot" (
   id_local NUMBER ,
   id_global VARCHAR2(32000) ,
   digest VARCHAR2(32000) ,
   hasBigData NUMBER ,
   hasDevelopAdjustments VARCHAR2(32000) ,
   image NUMBER ,
   locked VARCHAR2(32000) ,
   name VARCHAR2(32000) ,
   snapshotID VARCHAR2(32000) ,
   text VARCHAR2(32000) ,
   CONSTRAINT Adobe_libraryImageDevelopSnapshot_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE Adobe_libraryImageDevelopSnapshot (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    digest,
    hasBigData INTEGER NOT NULL DEFAULT 0,
    hasDevelopAdjustments,
    image INTEGER,
    locked,
    name,
    snapshotID,
    text
)
*/
