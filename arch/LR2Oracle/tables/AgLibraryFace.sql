
CREATE TABLE "AgLibraryFace" (
   id_local NUMBER ,
   bl_x NUMBER ,
   bl_y NUMBER ,
   br_x NUMBER ,
   br_y NUMBER ,
   cluster_ NUMBER ,
   compatibleVersion NUMBER ,
   ignored NUMBER ,
   image NUMBER ,
   imageOrientation NUMBER ,
   orientation NUMBER ,
   origination NUMBER ,
   propertiesCache NUMBER ,
   regionType NUMBER ,
   skipSuggestion NUMBER ,
   tl_x NUMBER ,
   tl_y NUMBER ,
   touchCount NUMBER ,
   touchTime NUMBER ,
   tr_x NUMBER ,
   tr_y NUMBER ,
   version NUMBER ,
   CONSTRAINT AgLibraryFace_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryFace (
    id_local INTEGER PRIMARY KEY,
    bl_x,
    bl_y,
    br_x,
    br_y,
    cluster INTEGER,
    compatibleVersion,
    ignored INTEGER,
    image INTEGER NOT NULL DEFAULT 0,
    imageOrientation NOT NULL DEFAULT '',
    orientation,
    origination NOT NULL DEFAULT 0,
    propertiesCache,
    regionType NOT NULL DEFAULT 0,
    skipSuggestion INTEGER,
    tl_x NOT NULL DEFAULT '',
    tl_y NOT NULL DEFAULT '',
    touchCount NOT NULL DEFAULT 0,
    touchTime NOT NULL DEFAULT -63113817600,
    tr_x,
    tr_y,
    version
)
*/
