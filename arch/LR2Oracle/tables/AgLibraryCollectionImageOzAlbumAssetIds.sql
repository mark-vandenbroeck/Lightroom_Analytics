
CREATE TABLE "AgLibraryCollectionImageOzAlbumAssetIds" (
   id_local VARCHAR2(32000) ,
   collectionImage VARCHAR2(32000) ,
   collection VARCHAR2(32000) ,
   image VARCHAR2(32000) ,
   ozCatalogId VARCHAR2(32000) ,
   ozAlbumAssetId VARCHAR2(32000) 
)

/*
CREATE TABLE AgLibraryCollectionImageOzAlbumAssetIds(
	id_local NOT NULL DEFAULT 0,
	collectionImage NOT NULL,
	collection NOT NULL,
	image NOT NULL,
	ozCatalogId NOT NULL,
	ozAlbumAssetId DEFAULT "pending"
)
*/
