
CREATE TABLE "AgLibraryCollectionImageOzSortOrder" (
   collectionImage VARCHAR2(32000) ,
   collection VARCHAR2(32000) ,
   positionInCollection VARCHAR2(32000) ,
   ozSortOrder VARCHAR2(32000) ,
   CONSTRAINT AgLibraryCollectionImageOzSortOrder_PK PRIMARY KEY (collectionImage)
)

/*
CREATE TABLE AgLibraryCollectionImageOzSortOrder(
	collectionImage  PRIMARY KEY,
	collection NOT NULL,
	positionInCollection NOT NULL,
	ozSortOrder NOT NULL
)
*/
