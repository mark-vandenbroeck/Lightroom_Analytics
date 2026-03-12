
CREATE TABLE "AgSpecialSourceContent" (
   id_local NUMBER ,
   content VARCHAR2(32000) ,
   owningModule VARCHAR2(32000) ,
   source VARCHAR2(32000) ,
   CONSTRAINT AgSpecialSourceContent_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgSpecialSourceContent (
    id_local INTEGER PRIMARY KEY,
    content,
    owningModule,
    source NOT NULL DEFAULT ''
)
*/
