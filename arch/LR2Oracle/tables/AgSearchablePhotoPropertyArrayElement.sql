
CREATE TABLE "AgSearchablePhotoPropertyArrayElement" (
   id_local NUMBER ,
   id_global VARCHAR2(32000) ,
   arrayIndex VARCHAR2(32000) ,
   dataType VARCHAR2(32000) ,
   internalValue VARCHAR2(32000) ,
   lc_idx_internalValue VARCHAR2(32000) ,
   photo NUMBER ,
   propertySpec NUMBER ,
   CONSTRAINT AgSearchablePhotoPropertyArrayElement_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgSearchablePhotoPropertyArrayElement (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    arrayIndex NOT NULL DEFAULT '',
    dataType,
    internalValue,
    lc_idx_internalValue,
    photo INTEGER NOT NULL DEFAULT 0,
    propertySpec INTEGER NOT NULL DEFAULT 0
)
*/
