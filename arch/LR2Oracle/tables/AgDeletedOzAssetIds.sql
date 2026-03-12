
CREATE TABLE "AgDeletedOzAssetIds" (
   id_local VARCHAR2(32000) ,
   ozCatalogId VARCHAR2(32000) ,
   ozAssetId VARCHAR2(32000) ,
   changeCounter VARCHAR2(32000) ,
   lastSyncedChangeCounter VARCHAR2(32000) 
)

/*
CREATE TABLE AgDeletedOzAssetIds(
	id_local NOT NULL DEFAULT 0,
	ozCatalogId NOT NULL,
	ozAssetId NOT NULL,
	changeCounter DEFAULT 0,
	lastSyncedChangeCounter DEFAULT 0
)
*/
