
CREATE TABLE "AgUnsupportedOzAssets" (
   id_local NUMBER ,
   ozAssetId VARCHAR2(32000) ,
   ozCatalogId VARCHAR2(32000) ,
   path VARCHAR2(32000) ,
   type VARCHAR2(32000) ,
   payload VARCHAR2(32000) ,
   CONSTRAINT AgUnsupportedOzAssets_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgUnsupportedOzAssets(
	id_local INTEGER PRIMARY KEY,
	ozAssetId NOT NULL,
	ozCatalogId NOT NULL,
	path NOT NULL,
	type NOT NULL,
	payload NOT NULL
)
*/
