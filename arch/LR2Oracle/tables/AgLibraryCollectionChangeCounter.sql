
CREATE TABLE "AgLibraryCollectionChangeCounter" (
   collection NUMBER ,
   changeCounter NUMBER ,
   lastSyncedChangeCounter NUMBER ,
   CONSTRAINT AgLibraryCollectionChangeCounter_PK PRIMARY KEY (collection)
)

/*
CREATE TABLE AgLibraryCollectionChangeCounter(
	collection PRIMARY KEY,
	changeCounter DEFAULT 0,
	lastSyncedChangeCounter DEFAULT 0
)
*/
