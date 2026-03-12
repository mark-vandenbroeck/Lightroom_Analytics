
CREATE TABLE "AgPendingOzUploads" (
   id_local NUMBER ,
   localId VARCHAR2(32000) ,
   ozDocId VARCHAR2(32000) ,
   operation VARCHAR2(32000) ,
   ozCatalogId VARCHAR2(32000) ,
   changeCounter VARCHAR2(32000) 
)

/*
CREATE TABLE AgPendingOzUploads(
	id_local INTEGER NOT NULL,
	localId,
	ozDocId,
	operation NOT NULL,
	ozCatalogId NOT NULL,
	changeCounter DEFAULT 0
)
*/
