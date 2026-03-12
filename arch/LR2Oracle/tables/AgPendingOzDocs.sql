
CREATE TABLE "AgPendingOzDocs" (
   id_local NUMBER ,
   ozDocId VARCHAR2(32000) ,
   ozCatalogId VARCHAR2(32000) ,
   state VARCHAR2(32000) ,
   fileName VARCHAR2(32000) ,
   path VARCHAR2(32000) ,
   binaryType VARCHAR2(32000) ,
   needAux VARCHAR2(32000) ,
   needDevelopXmp VARCHAR2(32000) ,
   needSidecar VARCHAR2(32000) ,
   payload VARCHAR2(32000) ,
   revId VARCHAR2(32000) ,
   isLibImage VARCHAR2(32000) ,
   isPathChanged VARCHAR2(32000) ,
   errorDescription VARCHAR2(32000) ,
   CONSTRAINT AgPendingOzDocs_PK PRIMARY KEY (ozDocId)
)

/*
CREATE TABLE AgPendingOzDocs(
	id_local INTEGER NOT NULL,
	ozDocId PRIMARY KEY,
	ozCatalogId NOT NULL,
	state DEFAULT "needs_binary",
	fileName NOT NULL,
	path NOT NULL,
	binaryType DEFAULT "original",
	needAux DEFAULT 0,
	needDevelopXmp DEFAULT 0,
	needSidecar DEFAULT 0,
	payload NOT NULL,
	revId DEFAULT 0,
	isLibImage DEFAULT 0,
	isPathChanged DEFAULT 0,
	errorDescription Default ''
)
*/
