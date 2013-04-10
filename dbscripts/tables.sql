
CREATE TABLE "typePrerequisites"(
	"typeID" smallint(6),
	"skillTypeID" smallint(6),
	"skillLevel" smallint(2),
	"skillOrder" smallint(2)
);
CREATE INDEX "typePrerequisites_IX_typeID" ON "typePrerequisites" ("typeID");

CREATE TABLE "metAttributeTypes" (
	"attributeID" smallint(6) NOT NULL,
	"unitID" tinyint(3),
	"graphicID" smallint(6),
	"displayName" varchar(32),
	"attributeName" varchar(32),
	"displayType" smallint(6),
	PRIMARY KEY ("attributeID")
);

CREATE TABLE "version"(
	"versionNum" smallint(6),
	"versionName" text(32)
);

CREATE TABLE "metLanguage"(
	"languageNum" smallint(6),
	"languageCode" char(2),
	"languageName" varchar(16),
	PRIMARY KEY ("languageNum")
);

INSERT INTO metLanguage VALUES(0,'EN','English');
INSERT INTO metLanguage VALUES(1,'DE','German');
INSERT INTO metLanguage VALUES(2,'RU','Russian');
