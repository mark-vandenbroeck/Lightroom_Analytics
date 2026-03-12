
CREATE TABLE "AgLibraryCollectionCoverImage" (
   id_local NUMBER ,
   collection NUMBER ,
   collectionImage NUMBER ,
   CONSTRAINT AgLibraryCollectionCoverImage_PK PRIMARY KEY (collection)
)

/*
CREATE TABLE AgLibraryCollectionCoverImage(
	id_local NOT NULL DEFAULT 0,
	collection PRIMARY KEY,
	collectionImage NOT NULL
)
*/
