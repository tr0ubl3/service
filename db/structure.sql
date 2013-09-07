CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "machines" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "manufacturer_id" integer, "machine_owner_id" integer, "machine_number" varchar(255), "machine_type" varchar(255), "delivery_date" date, "waranty_period" integer, "display_name" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_machines_on_manufacturer_id" ON "machines" ("manufacturer_id");
CREATE INDEX "index_machines_on_machine_owner_id" ON "machines" ("machine_owner_id");
CREATE TABLE "events" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "machine_id" integer, "event_date" date, "event_type" varchar(255), "event_description" text, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "hour_counter" integer);
CREATE INDEX "index_events_on_machine_id" ON "events" ("machine_id");
CREATE TABLE "firms" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "address" varchar(255), "office_tel" varchar(255), "office_mail" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "country" varchar(255), "city" varchar(255), "postal_code" varchar(255), "fax" varchar(255), "mobile" varchar(255), "type" varchar(255));
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "first_name" varchar(255), "last_name" varchar(255), "nick" varchar(255), "email" varchar(255) DEFAULT '' NOT NULL, "encrypted_password" varchar(255) DEFAULT '' NOT NULL, "reset_password_token" varchar(255), "reset_password_sent_at" datetime, "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar(255), "last_sign_in_ip" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
INSERT INTO schema_migrations (version) VALUES ('20130623172417');

INSERT INTO schema_migrations (version) VALUES ('20130623172455');

INSERT INTO schema_migrations (version) VALUES ('20130623172515');

INSERT INTO schema_migrations (version) VALUES ('20130623174148');

INSERT INTO schema_migrations (version) VALUES ('20130728141811');

INSERT INTO schema_migrations (version) VALUES ('20130729121603');

INSERT INTO schema_migrations (version) VALUES ('20130729123712');

INSERT INTO schema_migrations (version) VALUES ('20130729153843');

INSERT INTO schema_migrations (version) VALUES ('20130730132236');

INSERT INTO schema_migrations (version) VALUES ('20130901155844');