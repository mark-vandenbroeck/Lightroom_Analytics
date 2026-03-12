
CREATE TABLE "AgLibraryImageOzAssetIds" (
   id_local VARCHAR2(32000) ,
   image VARCHAR2(32000) ,
   ozCatalogId VARCHAR2(32000) ,
   ozAssetId VARCHAR2(32000) ,
   ownedByCatalog VARCHAR2(32000) 
)

/*
CREATE TABLE AgLibraryImageOzAssetIds(
	id_local NOT NULL DEFAULT 0,
	image NOT NULL,
	ozCatalogId NOT NULL,
	ozAssetId DEFAULT "pending",
	ownedByCatalog DEFAULT 'Y'
)
*/
