
CREATE TABLE "AgDevelopAdditionalMetadata" (
   id_local NUMBER ,
   caiAuthenticationInfo NUMBER ,
   hasCAISign NUMBER ,
   hasDepthMap NUMBER ,
   hasEnhance NUMBER ,
   image NUMBER ,
   CONSTRAINT AgDevelopAdditionalMetadata_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgDevelopAdditionalMetadata (
    id_local INTEGER PRIMARY KEY,
    caiAuthenticationInfo,
    hasCAISign INTEGER,
    hasDepthMap INTEGER,
    hasEnhance,
    image INTEGER
)
*/
