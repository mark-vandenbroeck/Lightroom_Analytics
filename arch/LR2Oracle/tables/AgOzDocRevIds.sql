
CREATE TABLE "AgOzDocRevIds" (
   localId VARCHAR2(32000) ,
   currRevId VARCHAR2(32000) ,
   docType VARCHAR2(32000) ,
   CONSTRAINT AgOzDocRevIds_PK PRIMARY KEY (localId, docType)
)

/*
CREATE TABLE AgOzDocRevIds(
	localId NOT NULL,
	currRevId NOT NULL,
	docType NOT NULL,
	PRIMARY KEY (localId, docType)
)
*/
