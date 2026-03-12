
CREATE TABLE "AgLibraryOzFeedbackInfo" (
   id_local NUMBER ,
   image VARCHAR2(32000) ,
   lastFeedbackTime VARCHAR2(32000) ,
   lastReadTime VARCHAR2(32000) ,
   newCommentCount VARCHAR2(32000) ,
   newFavoriteCount VARCHAR2(32000) ,
   ozAssetId VARCHAR2(32000) ,
   ozCatalogId VARCHAR2(32000) ,
   ozSpaceId VARCHAR2(32000) ,
   CONSTRAINT AgLibraryOzFeedbackInfo_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryOzFeedbackInfo (
    id_local INTEGER PRIMARY KEY,
    image NOT NULL DEFAULT '',
    lastFeedbackTime,
    lastReadTime,
    newCommentCount NOT NULL DEFAULT 0,
    newFavoriteCount NOT NULL DEFAULT 0,
    ozAssetId NOT NULL DEFAULT '',
    ozCatalogId NOT NULL DEFAULT '',
    ozSpaceId NOT NULL DEFAULT ''
)
*/
