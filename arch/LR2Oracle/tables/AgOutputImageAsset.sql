
CREATE TABLE "AgOutputImageAsset" (
   id_local NUMBER ,
   assetId VARCHAR2(32000) ,
   collection NUMBER ,
   image NUMBER ,
   moduleId VARCHAR2(32000) ,
   CONSTRAINT AgOutputImageAsset_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgOutputImageAsset (
    id_local INTEGER PRIMARY KEY,
    assetId NOT NULL DEFAULT '',
    collection INTEGER NOT NULL DEFAULT 0,
    image INTEGER NOT NULL DEFAULT 0,
    moduleId NOT NULL DEFAULT ''
)
*/
