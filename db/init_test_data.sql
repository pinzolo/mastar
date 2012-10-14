-- % sqlite3 db/test.db < db/init_test_data.sql
--create table dows (id integer, name text, short_name text, holiday integer);
insert into dows (id, name, short_name, holiday) values (1, 'Sunday'   , 'Sun.', 1);
insert into dows (id, name, short_name, holiday) values (2, 'Monday'   , 'Mon.', 0);
insert into dows (id, name, short_name, holiday) values (3, 'tuesday'  , 'Tue.', 0);
insert into dows (id, name, short_name, holiday) values (4, 'Wednesday', 'Wed.', 0);
insert into dows (id, name, short_name, holiday) values (5, 'Thursday' , 'Thu.', 0);
insert into dows (id, name, short_name, holiday) values (6, 'Friday'   , 'Fri.', 0);
insert into dows (id, name, short_name, holiday) values (7, 'Saturday' , 'Sat.', 1);

--create table months (id integer, month_number integer, name text, short_name text);
insert into months (id, month_number, name, short_name) values (1,  1,  'January'  , 'Jan.');
insert into months (id, month_number, name, short_name) values (2,  2,  'February' , 'Feb.');
insert into months (id, month_number, name, short_name) values (3,  3,  'March'    , 'Mar.');
insert into months (id, month_number, name, short_name) values (4,  4,  'April'    , 'Apr.');
insert into months (id, month_number, name, short_name) values (5,  5,  'May'      , 'May' );
insert into months (id, month_number, name, short_name) values (6,  6,  'June'     , 'Jun.');
insert into months (id, month_number, name, short_name) values (7,  7,  'July'     , 'Jul.');
insert into months (id, month_number, name, short_name) values (8,  8,  'August'   , 'Aug.');
insert into months (id, month_number, name, short_name) values (9,  9,  'September', 'Sep.');
insert into months (id, month_number, name, short_name) values (10, 10, 'October'  , 'Oct.');
insert into months (id, month_number, name, short_name) values (11, 11, 'November' , 'Nov.');
insert into months (id, month_number, name, short_name) values (12, 12, 'December' , 'Dec.');
