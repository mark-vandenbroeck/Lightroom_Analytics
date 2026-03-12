
CREATE TABLE "AgHarvestedExifMetadata" (
   id_local NUMBER ,
   image NUMBER ,
   aperture NUMBER ,
   cameraModelRef NUMBER ,
   cameraSNRef NUMBER ,
   dateDay NUMBER ,
   dateMonth NUMBER ,
   dateYear NUMBER ,
   flashFired NUMBER ,
   focalLength NUMBER ,
   gpsLatitude NUMBER ,
   gpsLongitude NUMBER ,
   gpsSequence NUMBER ,
   hasGPS NUMBER ,
   isoSpeedRating NUMBER ,
   lensRef NUMBER ,
   shutterSpeed NUMBER ,
   CONSTRAINT AgHarvestedExifMetadata_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgHarvestedExifMetadata (
    id_local INTEGER PRIMARY KEY,
    image INTEGER,
    aperture,
    cameraModelRef INTEGER,
    cameraSNRef INTEGER,
    dateDay,
    dateMonth,
    dateYear,
    flashFired INTEGER,
    focalLength,
    gpsLatitude,
    gpsLongitude,
    gpsSequence NOT NULL DEFAULT 0,
    hasGPS INTEGER,
    isoSpeedRating,
    lensRef INTEGER,
    shutterSpeed
)
*/
