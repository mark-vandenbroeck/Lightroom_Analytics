
CREATE TABLE "AgPhotoProperty" (
   id_local NUMBER ,
   id_global NUMBER ,
   dataType NUMBER ,
   internalValue NUMBER ,
   photo NUMBER ,
   propertySpec NUMBER ,
   CONSTRAINT AgPhotoProperty_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgPhotoProperty (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    dataType,
    internalValue,
    photo INTEGER NOT NULL DEFAULT 0,
    propertySpec INTEGER NOT NULL DEFAULT 0
)
*/
