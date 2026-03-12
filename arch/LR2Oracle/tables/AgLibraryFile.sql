
CREATE TABLE "AgLibraryFile" (
   id_local NUMBER ,
   id_global VARCHAR2(32000) ,
   baseName VARCHAR2(32000) ,
   errorMessage VARCHAR2(32000) ,
   errorTime VARCHAR2(32000) ,
   extension VARCHAR2(32000) ,
   externalModTime VARCHAR2(32000) ,
   folder NUMBER ,
   idx_filename VARCHAR2(32000) ,
   importHash VARCHAR2(32000) ,
   lc_idx_filename VARCHAR2(32000) ,
   lc_idx_filenameExtension VARCHAR2(32000) ,
   md5 VARCHAR2(32000) ,
   modTime VARCHAR2(32000) ,
   originalFilename VARCHAR2(32000) ,
   sidecarExtensions VARCHAR2(32000) ,
   CONSTRAINT AgLibraryFile_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryFile (
    id_local INTEGER PRIMARY KEY,
    id_global UNIQUE NOT NULL,
    baseName NOT NULL DEFAULT '',
    errorMessage,
    errorTime,
    extension NOT NULL DEFAULT '',
    externalModTime,
    folder INTEGER NOT NULL DEFAULT 0,
    idx_filename NOT NULL DEFAULT '',
    importHash,
    lc_idx_filename NOT NULL DEFAULT '',
    lc_idx_filenameExtension NOT NULL DEFAULT '',
    md5,
    modTime,
    originalFilename NOT NULL DEFAULT '',
    sidecarExtensions
)
*/
