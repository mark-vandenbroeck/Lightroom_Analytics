
CREATE TABLE "AgHarvestedDNGMetadata" (
   id_local NUMBER ,
   image NUMBER ,
   hasFastLoadData NUMBER ,
   hasLossyCompression NUMBER ,
   isDNG NUMBER ,
   isHDR NUMBER ,
   isPano NUMBER ,
   isReducedResolution NUMBER ,
   CONSTRAINT AgHarvestedDNGMetadata_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgHarvestedDNGMetadata (
    id_local INTEGER PRIMARY KEY,
    image INTEGER,
    hasFastLoadData INTEGER,
    hasLossyCompression INTEGER,
    isDNG INTEGER,
    isHDR INTEGER,
    isPano INTEGER,
    isReducedResolution INTEGER
)
*/
