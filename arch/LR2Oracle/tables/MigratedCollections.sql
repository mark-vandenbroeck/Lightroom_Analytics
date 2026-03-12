
CREATE TABLE "MigratedCollections" (
   ozAlbumId VARCHAR2(32000) ,
   ozCatalogId VARCHAR2(32000) ,
   ozName VARCHAR2(32000) ,
   localId NUMBER 
)

/*
CREATE TABLE MigratedCollections(
			ozAlbumId NOT NULL,
			ozCatalogId NOT NULL,
			ozName NOT NULL,
			localId INTEGER NOT NULL,
			UNIQUE ( localId, ozCatalogId )
		)
*/
