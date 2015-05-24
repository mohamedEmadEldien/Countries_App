DROP TABLE IF EXISTS "Country";
CREATE TABLE "Country" ("ID" TEXT PRIMARY KEY  NOT NULL  check(typeof("ID") = 'text') , "Name" TEXT, "lon" DOUBLE, "lat" DOUBLE);
