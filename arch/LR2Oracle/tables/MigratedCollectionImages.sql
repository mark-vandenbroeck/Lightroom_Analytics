
CREATE TABLE "MigratedCollectionImages" (
   ozAlbumId VARCHAR2(32000) ,
   ozAlbumAssetId VARCHAR2(32000) ,
   ozCatalogId VARCHAR2(32000) ,
   localCollectionId NUMBER ,
   localCollectionImageId NUMBER 
)

/*
CREATE TABLE MigratedCollectionImages(
			ozAlbumId NOT NULL,
			ozAlbumAssetId NOT NULL,
			ozCatalogId NOT NULL,
			localCollectionId INTEGER NOT NULL,
			localCollectionImageId INTEGER NOT NULL,
			UNIQUE ( localCollectionImageId, ozCatalogId )
		)
*/
