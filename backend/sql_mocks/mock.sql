INSERT INTO public.endpoint (endpoint_number, label, sensor_url) VALUES (96, 'AGH Test sensor', '/pl/datasets/dyplomy-2022/endpoints/96/data/');
INSERT INTO public.endpoint (endpoint_number, label, sensor_url) VALUES (101, 'AGH Sensor 101', '/pl/datasets/env-mon-agh/endpoints/101/data/');
INSERT INTO public.endpoint (endpoint_number, label, sensor_url) VALUES (59, 'AGH Sensor 59', '/pl/datasets/env-mon-agh/endpoints/59/data/');

INSERT INTO public.field (label) VALUES ('temperature');
INSERT INTO public.field (label) VALUES ('pressure');
INSERT INTO public.field (label) VALUES ('humidity');
INSERT INTO public.field (label) VALUES ('pm1_0');
INSERT INTO public.field (label) VALUES ('pm2_5');
INSERT INTO public.field (label) VALUES ('pm10');
INSERT INTO public.field (label) VALUES ('label');
INSERT INTO public.field (label) VALUES ('id');
INSERT INTO public.field (label) VALUES ('timestamp');

INSERT INTO public.field_parser (path) VALUES ('/data/envSensor/temperature');
INSERT INTO public.field_parser (path) VALUES ('/data/envSensor/pressure');
INSERT INTO public.field_parser (path) VALUES ('/data/envSensor/relativeHumidity');
INSERT INTO public.field_parser (path) VALUES ('/data/particleConcentrationSensor/concentration/pm1');
INSERT INTO public.field_parser (path) VALUES ('/data/particleConcentrationSensor/concentration/pm2_5');
INSERT INTO public.field_parser (path) VALUES ('/data/particleConcentrationSensor/concentration/pm10');
INSERT INTO public.field_parser (path) VALUES ('/label');
INSERT INTO public.field_parser (path) VALUES ('/data/id');
INSERT INTO public.field_parser (path) VALUES ('/timestamp');

INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (1, 1, 1);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (1, 2, 2);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (1, 3, 3);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (1, 4, 4);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (1, 5, 5);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (1, 6, 6);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (1, 7, 7);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (1, 8, 8);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (1, 9, 9);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (2, 1, 1);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (2, 2, 2);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (2, 3, 3);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (2, 4, 4);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (2, 5, 5);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (2, 6, 6);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (2, 7, 7);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (2, 8, 8);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (2, 9, 9);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (3, 1, 1);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (3, 2, 2);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (3, 3, 3);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (3, 4, 4);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (3, 5, 5);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (3, 6, 6);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (3, 7, 7);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (3, 8, 8);
INSERT INTO public.fields_parser_mapping (endpoint_id, field_parser_id, field_id) VALUES (3, 9, 9);

INSERT INTO public.group (name) VALUES ('Best officials');

INSERT INTO public.user (email, name) VALUES ('test@test.com', 'Jan');

INSERT INTO public.users_in_group (group_id, user_id) VALUES (1, 1);

INSERT INTO public.enable_endpoints_for_group (endpoint_id, group_id, approximation_precission, detailed_measurement_days) VALUES (1, 1, 10, 10);
INSERT INTO public.enable_endpoints_for_group (endpoint_id, group_id, approximation_precission, detailed_measurement_days) VALUES (2, 1, 10, 10);
INSERT INTO public.enable_endpoints_for_group (endpoint_id, group_id, approximation_precission, detailed_measurement_days) VALUES (3, 1, 10, 10);

INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (1, 1, 1);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (1, 1, 2);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (1, 1, 3);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (1, 1, 4);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (1, 1, 5);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (1, 1, 6);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (1, 1, 7);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (1, 1, 8);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (1, 1, 9);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (2, 1, 1);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (2, 1, 2);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (2, 1, 3);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (2, 1, 4);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (2, 1, 5);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (2, 1, 6);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (2, 1, 7);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (2, 1, 8);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (2, 1, 9);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (3, 1, 1);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (3, 1, 2);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (3, 1, 3);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (3, 1, 4);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (3, 1, 5);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (3, 1, 6);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (3, 1, 9);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (3, 1, 7);
INSERT INTO public.enable_fields (endpoint_id, gropu_id, field_id) VALUES (3, 1, 8);
