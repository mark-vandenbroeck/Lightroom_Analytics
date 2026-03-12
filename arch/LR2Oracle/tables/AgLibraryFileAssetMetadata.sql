
CREATE TABLE "AgLibraryFileAssetMetadata" (
   fileId VARCHAR2(32000) ,
   sha256 VARCHAR2(32000) ,
   fileSize VARCHAR2(32000) ,
   CONSTRAINT AgLibraryFileAssetMetadata_PK PRIMARY KEY (fileId)
)

/*
CREATE TABLE AgLibraryFileAssetMetadata(
	fileId PRIMARY KEY,
	sha256 NOT NULL,
	fileSize DEFAULT 0
)
*/
