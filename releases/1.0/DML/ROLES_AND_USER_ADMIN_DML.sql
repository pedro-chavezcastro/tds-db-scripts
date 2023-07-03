INSERT INTO public."ROLES" (id, "name") VALUES(1, 'ROLE_ADMIN');
INSERT INTO public."ROLES" (id, "name") VALUES(2, 'ROLE_USER');

INSERT INTO public."USERS" (id, username, "password", enabled, "name", last_name, email, attempts) VALUES(1, 'tds.root', '$2a$10$Rk007.3NbjwrSEHaM36abO/2NqI6gbwmwcXaCTzf5bbnr8WpZtVPa', true, 'Tds', 'Root', 'tds.root@tds.com', 0);

INSERT INTO public."USERS_ROLES" (id, id_user_fk, id_role_fk) VALUES(1, 1, 1);
INSERT INTO public."USERS_ROLES" (id, id_user_fk, id_role_fk) VALUES(2, 1, 1);