
CREATE TABLE "Adobe_variablesTable" (
   id_local NUMBER ,
   id_global VARCHAR2(32000) ,
   name VARCHAR2(32000) ,
   type VARCHAR2(32000) ,
   value VARCHAR2(32000) ,
   CONSTRAINT Adobe_variablesTable_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE Adobe_variablesTable (
	    id_local INTEGER PRIMARY KEY,
	    id_global UNIQUE NOT NULL,
	    name,
	    type,
	    value NOT NULL DEFAULT ''
	)
*/
