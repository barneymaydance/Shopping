create database if not exists shopping;

use shopping;

create table ruser
(
id int primary key auto_increment,
username  varchar(40),
password varchar(16),
phone varchar(40),
addr varchar(255),
rdate datetime
);

create table category
(
id int primary key auto_increment,
name varchar(255),
descr varchar(255),
pid int,
isleaf int, #1 for leaf, 0 for no-leaf
grade int
);

create table product
(
id int primary key auto_increment,
name varchar(255),
descr varchar(255),
normalprice double,
memberprice double,
pdate datetime,
categoryid int references catergory(id)
);

create table salesorder
(
id int primary key auto_increment,
userid int,
addr varchar(255),
odate datetime,
status int #0 stands for 
);

create table salesitem
(
id int primary key auto_increment,
productid int,
uniprice double,
pcount int,
orderid int
);






