-- Creator:       MySQL Workbench 6.3.8/ExportSQLite Plugin 0.1.0
-- Author:        parphis
-- Caption:       New Model
-- Project:       Name of the project
-- Changed:       2017-02-14 22:57
-- Created:       2017-02-14 22:37
PRAGMA foreign_keys = OFF;

-- Schema: mydb
ATTACH "mydb.sdb" AS "mydb";
BEGIN;
CREATE TABLE "mydb"."LANGUAGE"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" VARCHAR(45)
);
CREATE TABLE "mydb"."CONTACT_TYPE"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" VARCHAR(45)
);
CREATE TABLE "mydb"."COMPANY"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" VARCHAR(45),
  "city" VARCHAR(45),
  "zip" VARCHAR(45),
  "street" VARCHAR(45),
  "email" VARCHAR(45),
  "phone" VARCHAR(45),
  "contact" VARCHAR(45),
  "freetext" VARCHAR(1024)
);
CREATE TABLE "mydb"."EVENT"(
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "name" VARCHAR(45)
);
CREATE TABLE "mydb"."CV"(
  "id" INTEGER NOT NULL,
  "sent_date" DATETIME,
  "lang" INTEGER,
  "pending" BOOL,
  "applied" BOOL,
  "LANGUAGE_id" INTEGER NOT NULL,
  "file" BLOB,
  PRIMARY KEY("id","LANGUAGE_id"),
  CONSTRAINT "fk_CV_LANGUAGE"
    FOREIGN KEY("LANGUAGE_id")
    REFERENCES "LANGUAGE"("id")
);
CREATE INDEX "mydb"."CV.fk_CV_LANGUAGE_idx" ON "CV" ("LANGUAGE_id");
CREATE TABLE "mydb"."HISTORY"(
  "id" INTEGER NOT NULL,
  "company" INTEGER,
  "cv" INTEGER,
  "event" INTEGER,
  "contact_type" INTEGER,
  "person" VARCHAR(45),
  "event_date" DATETIME,
  "freetext" VARCHAR(1024),
  "outcome" INTEGER,
  "travelby" VARCHAR(45),
  "EVENT_id" INTEGER NOT NULL,
  "CONTACT_TYPE_id" INTEGER NOT NULL,
  "COMPANY_id" INTEGER NOT NULL,
  "CV_id" INTEGER NOT NULL,
  "CV_LANGUAGE_id" INTEGER NOT NULL,
  PRIMARY KEY("id","EVENT_id","CONTACT_TYPE_id","COMPANY_id","CV_id","CV_LANGUAGE_id"),
  CONSTRAINT "id_UNIQUE"
    UNIQUE("id"),
  CONSTRAINT "fk_HISTORY_EVENT1"
    FOREIGN KEY("EVENT_id")
    REFERENCES "EVENT"("id"),
  CONSTRAINT "fk_HISTORY_CONTACT_TYPE1"
    FOREIGN KEY("CONTACT_TYPE_id")
    REFERENCES "CONTACT_TYPE"("id"),
  CONSTRAINT "fk_HISTORY_COMPANY1"
    FOREIGN KEY("COMPANY_id")
    REFERENCES "COMPANY"("id"),
  CONSTRAINT "fk_HISTORY_CV1"
    FOREIGN KEY("CV_id","CV_LANGUAGE_id")
    REFERENCES "CV"("id","LANGUAGE_id")
);
CREATE INDEX "mydb"."HISTORY.fk_HISTORY_EVENT1_idx" ON "HISTORY" ("EVENT_id");
CREATE INDEX "mydb"."HISTORY.fk_HISTORY_CONTACT_TYPE1_idx" ON "HISTORY" ("CONTACT_TYPE_id");
CREATE INDEX "mydb"."HISTORY.fk_HISTORY_COMPANY1_idx" ON "HISTORY" ("COMPANY_id");
CREATE INDEX "mydb"."HISTORY.fk_HISTORY_CV1_idx" ON "HISTORY" ("CV_id","CV_LANGUAGE_id");
COMMIT;
