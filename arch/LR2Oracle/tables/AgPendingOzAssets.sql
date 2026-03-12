
CREATE TABLE "AgPendingOzAssets" (
   ozAssetId VARCHAR2(32000) ,
   ozCatalogId VARCHAR2(32000) ,
   state VARCHAR2(32000) ,
   path VARCHAR2(32000) ,
   payload VARCHAR2(32000) 
)

/*
CREATE TABLE AgPendingOzAssets(
	ozAssetId NOT NULL,
	ozCatalogId NOT NULL,
	state DEFAULT "needs_binary",
	path NOT NULL,
	payload NOT NULL
)
*/
