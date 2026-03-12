
CREATE TABLE "Adobe_imageProofSettings" (
   id_local NUMBER ,
   colorProfile VARCHAR2(32000) ,
   image NUMBER ,
   renderingIntent VARCHAR2(32000) ,
   CONSTRAINT Adobe_imageProofSettings_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE Adobe_imageProofSettings (
    id_local INTEGER PRIMARY KEY,
    colorProfile,
    image INTEGER,
    renderingIntent
)
*/
