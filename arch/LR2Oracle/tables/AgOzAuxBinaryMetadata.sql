
CREATE TABLE "AgOzAuxBinaryMetadata" (
   auxId VARCHAR2(32000) ,
   ozAssetId VARCHAR2(32000) ,
   ozCatalogId VARCHAR2(32000) ,
   digest VARCHAR2(32000) ,
   sha256 VARCHAR2(32000) ,
   fileSize VARCHAR2(32000) ,
   type VARCHAR2(32000) 
)

/*
CREATE TABLE AgOzAuxBinaryMetadata(
	auxId NOT NULL,
	ozAssetId NOT NULL,
	ozCatalogId NOT NULL,
	digest NOT NULL,
	sha256 NOT NULL,
	fileSize DEFAULT 0,
	type NOT NULL
)
*/
