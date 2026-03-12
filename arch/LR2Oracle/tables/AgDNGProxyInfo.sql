
CREATE TABLE "AgDNGProxyInfo" (
   id_local NUMBER ,
   fileUUID VARCHAR2(32000) ,
   status VARCHAR2(32000) ,
   statusDateTime VARCHAR2(32000) ,
   CONSTRAINT AgDNGProxyInfo_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgDNGProxyInfo (
    id_local INTEGER PRIMARY KEY,
    fileUUID NOT NULL DEFAULT '',
    status NOT NULL DEFAULT 'U',
    statusDateTime NOT NULL DEFAULT 0
)
*/
