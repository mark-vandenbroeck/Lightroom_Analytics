
CREATE TABLE "AgOzAssetSettings" (
   id_local NUMBER ,
   image VARCHAR2(32000) ,
   ozCatalogId VARCHAR2(32000) ,
   sha256 VARCHAR2(32000) ,
   updatedTime VARCHAR2(32000) ,
   CONSTRAINT AgOzAssetSettings_PK PRIMARY KEY (image)
)

/*
CREATE TABLE AgOzAssetSettings(
	id_local INTEGER NOT NULL,
	image PRIMARY KEY,
	ozCatalogId NOT NULL,
	sha256 NOT NULL,
	updatedTime NOT NULL
)
*/
