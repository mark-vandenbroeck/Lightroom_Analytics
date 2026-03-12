
CREATE TABLE "AgSourceColorProfileConstants" (
   id_local NUMBER ,
   image NUMBER ,
   profileName VARCHAR2(32000) ,
   CONSTRAINT AgSourceColorProfileConstants_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgSourceColorProfileConstants (
    id_local INTEGER PRIMARY KEY,
    image INTEGER NOT NULL DEFAULT 0,
    profileName NOT NULL DEFAULT 'Untagged'
)
*/
