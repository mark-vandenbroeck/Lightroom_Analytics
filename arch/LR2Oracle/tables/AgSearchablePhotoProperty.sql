
CREATE TABLE "AgSearchablePhotoProperty" (
   id_local NUMBER ,
   id_global VARCHAR2(32000) ,
   dataType VARCHAR2(32000) ,
   internalValue VARCHAR2(32000) ,
   lc_idx_internalValue VARCHAR2(32000) ,
   photo NUMBER ,
   propertySpec NUMBER ,
   CONSTRAINT AgSearchablePhotoProperty_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgSearchablePhotoProperty (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    dataType,
    internalValue,
    lc_idx_internalValue,
    photo INTEGER NOT NULL DEFAULT 0,
    propertySpec INTEGER NOT NULL DEFAULT 0
)
*/
