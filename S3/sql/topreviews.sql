UNLOAD ('SELECT salesid, dateid, buyerid, sum(qtysold) as total_qtysold FROM public.sales GROUP BY dateid,salesid,buyerid order by total_qtysold desc')
TO 's3://mydemobucket1354/output/'
iam_role 'arn:aws:iam::153782920160:role/service-role/AmazonRedshift-CommandsAccessRole-20231217T093936'
allowoverwrite 
CSV DELIMITER AS ',' 
header
parallel off;