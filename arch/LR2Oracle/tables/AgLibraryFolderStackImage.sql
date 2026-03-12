
CREATE TABLE "AgLibraryFolderStackImage" (
   id_local NUMBER ,
   collapsed NUMBER ,
   image NUMBER ,
   position NUMBER ,
   stack NUMBER ,
   CONSTRAINT AgLibraryFolderStackImage_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgLibraryFolderStackImage (
    id_local INTEGER PRIMARY KEY,
    collapsed INTEGER NOT NULL DEFAULT 0,
    image INTEGER NOT NULL DEFAULT 0,
    position NOT NULL DEFAULT '',
    stack INTEGER NOT NULL DEFAULT 0
)
*/
