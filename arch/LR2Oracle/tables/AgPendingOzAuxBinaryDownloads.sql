
CREATE TABLE "AgPendingOzAuxBinaryDownloads" (
   auxId VARCHAR2(32000) ,
   ozAssetId VARCHAR2(32000) ,
   ozCatalogId VARCHAR2(32000) ,
   payloadHash VARCHAR2(32000) ,
   whenQueued VARCHAR2(32000) ,
   state VARCHAR2(32000) 
)

/*
CREATE TABLE AgPendingOzAuxBinaryDownloads(
	auxId NOT NULL,
	ozAssetId NOT NULL,
	ozCatalogId NOT NULL,
	payloadHash NOT NULL,
	whenQueued NOT NULL,
	state NOT NULL
)
*/
