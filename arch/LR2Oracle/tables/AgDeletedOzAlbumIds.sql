
CREATE TABLE "AgDeletedOzAlbumIds" (
   id_local VARCHAR2(32000) ,
   ozCatalogId VARCHAR2(32000) ,
   ozAlbumId VARCHAR2(32000) ,
   changeCounter VARCHAR2(32000) ,
   lastSyncedChangeCounter VARCHAR2(32000) 
)

/*
CREATE TABLE AgDeletedOzAlbumIds(
	id_local NOT NULL DEFAULT 0,
	ozCatalogId NOT NULL,
	ozAlbumId NOT NULL,
	changeCounter DEFAULT 0,
	lastSyncedChangeCounter DEFAULT 0
)
*/
