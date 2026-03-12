
CREATE TABLE "AgDeletedOzSpaceIds" (
   id_local VARCHAR2(32000) ,
   ozCatalogId VARCHAR2(32000) ,
   ozSpaceId VARCHAR2(32000) ,
   changeCounter VARCHAR2(32000) ,
   lastSyncedChangeCounter VARCHAR2(32000) 
)

/*
CREATE TABLE AgDeletedOzSpaceIds(
	id_local NOT NULL DEFAULT 0,
	ozCatalogId NOT NULL,
	ozSpaceId NOT NULL,
	changeCounter default 0,
	lastSyncedChangeCounter DEFAULT 0
)
*/
