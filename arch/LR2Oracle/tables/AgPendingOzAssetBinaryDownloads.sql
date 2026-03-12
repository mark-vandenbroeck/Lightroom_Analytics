
CREATE TABLE "AgPendingOzAssetBinaryDownloads" (
   ozAssetId VARCHAR2(32000) ,
   ozCatalogId VARCHAR2(32000) ,
   whenQueued VARCHAR2(32000) ,
   path VARCHAR2(32000) ,
   state VARCHAR2(32000) 
)

/*
CREATE TABLE AgPendingOzAssetBinaryDownloads(
	ozAssetId NOT NULL,
	ozCatalogId NOT NULL,
	whenQueued NOT NULL,
	path NOT NULL,
	state DEFAULT "master"
)
*/
