drop table if exists hiveads.sales_part;
drop schema if exists hiveads ;
drop table if exists public.sales;

CREATE EXTERNAL SCHEMA  hiveads
from data catalog
database 'hiveads'
iam_role 'arn:aws:iam::153782920160:role/service-role/AmazonRedshift-CommandsAccessRole-20231217T093936'
CREATE EXTERNAL database IF NOT EXISTS;

create external table  hiveads.sales_part(
salesid integer,
listid integer,
sellerid integer,
buyerid integer,
eventid integer,
dateid smallint,
qtysold smallint,
pricepaid decimal(8,2),
commission decimal(8,2),
saletime timestamp)
partitioned by (saledate date)
row format delimited
fields terminated by '|'
stored as textfile
location 's3://mydatabucket1712/tickit/spectrum/sales_partition/'
table properties ('numRows'='170000');

alter table hiveads.sales_part
add if not exists partition (saledate='2008-01-01')
location 's3://mydatabucket1712/tickit/spectrum/sales_partition/saledate=2008-01/';
alter table hiveads.sales_part
add if not exists partition (saledate='2008-02-01')
location 's3://mydatabucket1712/tickit/spectrum/sales_partition/saledate=2008-03/';
alter table hiveads.sales_part
add if not exists partition (saledate='2008-03-01')
location 's3://mydatabucket1712/tickit/spectrum/sales_partition/saledate=2008-04/';

create table public.sales(
salesid integer,
listid integer,
sellerid integer,
buyerid integer,
eventid integer,
dateid smallint,
qtysold smallint,
pricepaid decimal(8,2),
commission decimal(8,2),
saletime timestamp,
saledate varchar(10))
  SORTKEY (
     saledate
    );
