
CREATE TABLE "Adobe_AdditionalMetadata" (
   id_local NUMBER ,
   id_global BLOB ,
   additionalInfoSet NUMBER ,
   embeddedXmp NUMBER ,
   externalXmpIsDirty NUMBER ,
   image NUMBER ,
   incrementalWhiteBalance NUMBER ,
   internalXmpDigest BLOB ,
   isRawFile NUMBER ,
   lastSynchronizedHash BLOB ,
   lastSynchronizedTimestamp BLOB ,
   metadataPresetID BLOB ,
   metadataVersion BLOB ,
   monochrome NUMBER ,
   xmp BLOB ,
   CONSTRAINT Adobe_AdditionalMetadata_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE Adobe_AdditionalMetadata (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    additionalInfoSet INTEGER NOT NULL DEFAULT 0,
    embeddedXmp INTEGER NOT NULL DEFAULT 0,
    externalXmpIsDirty INTEGER NOT NULL DEFAULT 0,
    image INTEGER,
    incrementalWhiteBalance INTEGER NOT NULL DEFAULT 0,
    internalXmpDigest,
    isRawFile INTEGER NOT NULL DEFAULT 0,
    lastSynchronizedHash,
    lastSynchronizedTimestamp NOT NULL DEFAULT -63113817600,
    metadataPresetID,
    metadataVersion,
    monochrome INTEGER NOT NULL DEFAULT 0,
    xmp NOT NULL DEFAULT ''
)
*/
