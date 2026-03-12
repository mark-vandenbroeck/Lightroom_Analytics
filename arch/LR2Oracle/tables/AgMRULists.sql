
CREATE TABLE "AgMRULists" (
   id_local NUMBER ,
   listID VARCHAR2(32000) ,
   timestamp VARCHAR2(32000) ,
   value VARCHAR2(32000) ,
   CONSTRAINT AgMRULists_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgMRULists (
    id_local INTEGER PRIMARY KEY,
    listID NOT NULL DEFAULT '',
    timestamp NOT NULL DEFAULT 0,
    value NOT NULL DEFAULT ''
)
*/
