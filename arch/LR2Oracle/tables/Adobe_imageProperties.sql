
CREATE TABLE "Adobe_imageProperties" (
   id_local NUMBER ,
   id_global VARCHAR2(32000) ,
   image NUMBER ,
   propertiesString VARCHAR2(32000) ,
   CONSTRAINT Adobe_imageProperties_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE Adobe_imageProperties (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    image INTEGER,
    propertiesString
)
*/
