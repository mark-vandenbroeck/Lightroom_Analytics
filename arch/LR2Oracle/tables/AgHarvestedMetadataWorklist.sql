
CREATE TABLE "AgHarvestedMetadataWorklist" (
   id_local NUMBER ,
   taskID VARCHAR2(32000) ,
   taskStatus VARCHAR2(32000) ,
   whenPosted VARCHAR2(32000) ,
   CONSTRAINT AgHarvestedMetadataWorklist_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgHarvestedMetadataWorklist (
    id_local INTEGER PRIMARY KEY,
    taskID UNIQUE NOT NULL DEFAULT '',
    taskStatus NOT NULL DEFAULT 'pending',
    whenPosted NOT NULL DEFAULT ''
)
*/
