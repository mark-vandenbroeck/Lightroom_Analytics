
CREATE TABLE "Adobe_imageDevelopBeforeSettings" (
   id_local NUMBER ,
   beforeDigest NUMBER ,
   beforeHasDevelopAdjustments NUMBER ,
   beforePresetID NUMBER ,
   beforeText NUMBER ,
   developSettings NUMBER ,
   hasBigData NUMBER ,
   CONSTRAINT Adobe_imageDevelopBeforeSettings_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE Adobe_imageDevelopBeforeSettings (
    id_local INTEGER PRIMARY KEY,
    beforeDigest,
    beforeHasDevelopAdjustments,
    beforePresetID,
    beforeText,
    developSettings INTEGER,
    hasBigData INTEGER NOT NULL DEFAULT 0
)
*/
