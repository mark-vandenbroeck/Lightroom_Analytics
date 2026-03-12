
CREATE TABLE "AgLibraryFolderLabel" (
   id_local NUMBER ,
   id_global VARCHAR2(32000) ,
   folder NUMBER ,
   label VARCHAR2(32000) ,
   labelData VARCHAR2(32000) ,
   labelGenerics VARCHAR2(32000) ,
   labelType VARCHAR2(32000) ,
   CONSTRAINT AgLibraryFolderLabel_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryFolderLabel (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    folder INTEGER NOT NULL DEFAULT 0,
    label,
    labelData,
    labelGenerics,
    labelType NOT NULL DEFAULT ''
)
*/
