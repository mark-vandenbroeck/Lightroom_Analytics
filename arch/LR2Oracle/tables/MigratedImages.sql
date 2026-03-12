
CREATE TABLE "MigratedImages" (
   ozAssetId VARCHAR2(32000) ,
   ozCatalogId VARCHAR2(32000) ,
   localId NUMBER 
)

/*
CREATE TABLE MigratedImages(
			ozAssetId NOT NULL,
			ozCatalogId NOT NULL,
			localId INTEGER NOT NULL,
			UNIQUE ( localId, ozCatalogId )
		)
*/
