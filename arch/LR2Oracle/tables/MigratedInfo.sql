
CREATE TABLE "MigratedInfo" (
   ozCatalogId VARCHAR2(32000) ,
   migrationStatus VARCHAR2(32000) ,
   timestamp VARCHAR2(32000) ,
   CONSTRAINT MigratedInfo_PK PRIMARY KEY (ozCatalogId)
)

/*
CREATE TABLE MigratedInfo(
			ozCatalogId TEXT PRIMARY KEY,
			migrationStatus NOT NULL,
			timestamp NOT NULL
		)
*/
