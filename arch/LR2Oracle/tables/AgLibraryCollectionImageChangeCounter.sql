
CREATE TABLE "AgLibraryCollectionImageChangeCounter" (
   collectionImage NUMBER ,
   collection NUMBER ,
   image NUMBER ,
   changeCounter NUMBER ,
   lastSyncedChangeCounter NUMBER ,
   CONSTRAINT AgLibraryCollectionImageChangeCounter_PK PRIMARY KEY (collectionImage)
)

/*
CREATE TABLE AgLibraryCollectionImageChangeCounter(
	collectionImage PRIMARY KEY,
	collection NOT NULL,
	image NOT NULL,
	changeCounter DEFAULT 0,
	lastSyncedChangeCounter DEFAULT 0
)
*/
