
CREATE TABLE "AgPendingOzAlbumAssetIds" (
   ozCatalogId VARCHAR2(32000) ,
   ozAlbumAssetId VARCHAR2(32000) ,
   ozAssetId VARCHAR2(32000) ,
   ozAlbumId VARCHAR2(32000) ,
   ozSortOrder VARCHAR2(32000) ,
   ozIsCover VARCHAR2(32000) 
)

/*
CREATE TABLE AgPendingOzAlbumAssetIds(
	ozCatalogId NOT NULL,
	ozAlbumAssetId NOT NULL,
	ozAssetId NOT NULL,
	ozAlbumId NOT NULL,
	ozSortOrder DEFAULT "",
	ozIsCover DEFAULT 0
)
*/
