
CREATE TABLE "AgPhotoPropertySpec" (
   id_local NUMBER ,
   id_global VARCHAR2(32000) ,
   flattenedAttributes VARCHAR2(32000) ,
   key VARCHAR2(32000) ,
   pluginVersion VARCHAR2(32000) ,
   sourcePlugin VARCHAR2(32000) ,
   userVisibleName VARCHAR2(32000) ,
   CONSTRAINT AgPhotoPropertySpec_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgPhotoPropertySpec (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    flattenedAttributes,
    key NOT NULL DEFAULT '',
    pluginVersion NOT NULL DEFAULT '',
    sourcePlugin NOT NULL DEFAULT '',
    userVisibleName
)
*/
