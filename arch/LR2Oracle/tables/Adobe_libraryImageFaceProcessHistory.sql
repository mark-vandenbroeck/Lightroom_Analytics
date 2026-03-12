
CREATE TABLE "Adobe_libraryImageFaceProcessHistory" (
   id_local NUMBER ,
   image NUMBER ,
   lastFaceDetector NUMBER ,
   lastFaceRecognizer NUMBER ,
   lastImageIndexer NUMBER ,
   lastImageOrientation NUMBER ,
   lastTryStatus NUMBER ,
   userTouched NUMBER ,
   CONSTRAINT Adobe_libraryImageFaceProcessHistory_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE Adobe_libraryImageFaceProcessHistory (
    id_local INTEGER PRIMARY KEY,
    image INTEGER NOT NULL DEFAULT 0,
    lastFaceDetector,
    lastFaceRecognizer,
    lastImageIndexer,
    lastImageOrientation,
    lastTryStatus,
    userTouched
)
*/
