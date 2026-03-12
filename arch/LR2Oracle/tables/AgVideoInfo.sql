
CREATE TABLE "AgVideoInfo" (
   id_local NUMBER ,
   duration VARCHAR2(32000) ,
   frame_rate VARCHAR2(32000) ,
   has_audio NUMBER ,
   has_video NUMBER ,
   image NUMBER ,
   poster_frame VARCHAR2(32000) ,
   poster_frame_set_by_user NUMBER ,
   trim_end VARCHAR2(32000) ,
   trim_start VARCHAR2(32000) ,
   CONSTRAINT AgVideoInfo_PK PRIMARY KEY (id_local)
)

/*
CREATE TABLE AgVideoInfo (
    id_local INTEGER PRIMARY KEY,
    duration,
    frame_rate,
    has_audio INTEGER NOT NULL DEFAULT 1,
    has_video INTEGER NOT NULL DEFAULT 1,
    image INTEGER NOT NULL DEFAULT 0,
    poster_frame NOT NULL DEFAULT '0000000000000000/0000000000000001',
    poster_frame_set_by_user INTEGER NOT NULL DEFAULT 0,
    trim_end NOT NULL DEFAULT '0000000000000000/0000000000000001',
    trim_start NOT NULL DEFAULT '0000000000000000/0000000000000001'
)
*/
