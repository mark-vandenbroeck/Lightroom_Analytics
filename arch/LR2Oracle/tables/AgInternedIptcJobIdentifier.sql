
CREATE TABLE "AgInternedIptcJobIdentifier" (
   id_local NUMBER ,
   searchIndex VARCHAR2(32000) ,
   value VARCHAR2(32000) ,
   CONSTRAINT AgInternedIptcJobIdentifier_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgInternedIptcJobIdentifier (
    id_local INTEGER PRIMARY KEY,
    searchIndex,
    value
)
*/
