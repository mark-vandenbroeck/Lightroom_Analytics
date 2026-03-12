
CREATE TABLE "AgLibraryCollectionOzAlbumIds" (
   id_local VARCHAR2(32000) ,
   collection VARCHAR2(32000) ,
   ozCatalogId VARCHAR2(32000) ,
   ozAlbumId VARCHAR2(32000) 
)

/*
CREATE TABLE AgLibraryCollectionOzAlbumIds(
	id_local NOT NULL DEFAULT 0,
	collection NOT NULL,
	ozCatalogId NOT NULL,
	ozAlbumId DEFAULT "pending"
)
*/
