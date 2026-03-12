
CREATE TABLE "AgLibraryImageChangeCounter" (
   image NUMBER ,
   changeCounter NUMBER ,
   lastSyncedChangeCounter NUMBER ,
   changedAtTime NUMBER ,
   localTimeOffsetSecs NUMBER ,
   CONSTRAINT AgLibraryImageChangeCounter_PK PRIMARY KEY (image)
)

/*
CREATE TABLE AgLibraryImageChangeCounter(
	image PRIMARY KEY,
	changeCounter DEFAULT 0,
	lastSyncedChangeCounter DEFAULT 0,
	changedAtTime DEFAULT '',
	localTimeOffsetSecs DEFAULT 0
)
*/
