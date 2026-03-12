
CREATE TABLE "AgMetadataSearchIndex" (
   id_local NUMBER ,
   exifSearchIndex VARCHAR2(32000) ,
   image NUMBER ,
   iptcSearchIndex VARCHAR2(32000) ,
   otherSearchIndex VARCHAR2(32000) ,
   searchIndex VARCHAR2(32000) ,
   CONSTRAINT AgMetadataSearchIndex_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgMetadataSearchIndex (
    id_local INTEGER PRIMARY KEY,
    exifSearchIndex NOT NULL DEFAULT '',
    image INTEGER,
    iptcSearchIndex NOT NULL DEFAULT '',
    otherSearchIndex NOT NULL DEFAULT '',
    searchIndex NOT NULL DEFAULT ''
)
*/
