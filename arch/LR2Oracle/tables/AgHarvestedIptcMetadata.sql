
CREATE TABLE "AgHarvestedIptcMetadata" (
   id_local NUMBER ,
   image NUMBER ,
   cityRef NUMBER ,
   copyrightState NUMBER ,
   countryRef NUMBER ,
   creatorRef NUMBER ,
   isoCountryCodeRef NUMBER ,
   jobIdentifierRef NUMBER ,
   locationDataOrigination NUMBER ,
   locationGPSSequence NUMBER ,
   locationRef NUMBER ,
   stateRef NUMBER ,
   CONSTRAINT AgHarvestedIptcMetadata_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgHarvestedIptcMetadata (
    id_local INTEGER PRIMARY KEY,
    image INTEGER,
    cityRef INTEGER,
    copyrightState INTEGER,
    countryRef INTEGER,
    creatorRef INTEGER,
    isoCountryCodeRef INTEGER,
    jobIdentifierRef INTEGER,
    locationDataOrigination NOT NULL DEFAULT 'unset',
    locationGPSSequence NOT NULL DEFAULT -1,
    locationRef INTEGER,
    stateRef INTEGER
)
*/
