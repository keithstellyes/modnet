CREATE TABLE Boards (
    Title varchar(31),
    Description varchar(127),
    Id serial
);

CREATE TABLE Subboards (
    ParentId integer,
    ChildId integer
);

CREATE TABLE Threads (
    Title varchar(127),
    BoardId integer,
    PostId integer,
    Id serial 
);

CREATE TABLE Posts (
   ThreadId integer,
   Content text,
   timestamp timestamp default current_timestamp,
   Id serial
);

CREATE TABLE Users (
    Username varchar(127),
    Passhash text, --md5 hash
    AvatarId integer
);
