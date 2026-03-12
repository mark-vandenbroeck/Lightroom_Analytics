
CREATE TABLE "Adobe_namedIdentityPlate" (
   id_local NUMBER ,
   id_global VARCHAR2(32000) ,
   description VARCHAR2(32000) ,
   identityPlate VARCHAR2(32000) ,
   identityPlateHash VARCHAR2(32000) ,
   moduleFont VARCHAR2(32000) ,
   moduleSelectedTextColor VARCHAR2(32000) ,
   moduleTextColor VARCHAR2(32000) ,
   CONSTRAINT Adobe_namedIdentityPlate_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE Adobe_namedIdentityPlate (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    description,
    identityPlate,
    identityPlateHash,
    moduleFont,
    moduleSelectedTextColor,
    moduleTextColor
)
*/
