
CREATE TABLE "AgRemotePhoto" (
   id_local NUMBER ,
   id_global VARCHAR2(32000) ,
   collection NUMBER ,
   commentCount VARCHAR2(32000) ,
   developSettingsDigest VARCHAR2(32000) ,
   fileContentsHash VARCHAR2(32000) ,
   fileModTimestamp VARCHAR2(32000) ,
   metadataDigest VARCHAR2(32000) ,
   mostRecentCommentTime VARCHAR2(32000) ,
   orientation VARCHAR2(32000) ,
   photo NUMBER ,
   photoNeedsUpdating VARCHAR2(32000) ,
   publishCount VARCHAR2(32000) ,
   remoteId VARCHAR2(32000) ,
   serviceAggregateRating VARCHAR2(32000) ,
   url VARCHAR2(32000) ,
   CONSTRAINT AgRemotePhoto_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgRemotePhoto (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    collection INTEGER NOT NULL DEFAULT 0,
    commentCount,
    developSettingsDigest,
    fileContentsHash,
    fileModTimestamp,
    metadataDigest,
    mostRecentCommentTime,
    orientation,
    photo INTEGER NOT NULL DEFAULT 0,
    photoNeedsUpdating DEFAULT 2,
    publishCount,
    remoteId,
    serviceAggregateRating,
    url
)
*/
