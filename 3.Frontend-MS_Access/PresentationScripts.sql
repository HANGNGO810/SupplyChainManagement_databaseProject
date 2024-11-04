SELECT * FROM Product;

SELECT * FROM Customer;

select s.saleOrd_id Ord_ID, s.saleOrd_quantity Ord_Qty, s.saleOrd_orderDate Ord_Date 
, concat(c.cust_fName, ' ', c.cust_lName) Customer_Name, p.pro_name Product_Name, pro_unitPrice*s.saleOrd_quantity as Total
FROM SalesOrder s
INNER JOIN Product p  ON s.pro_id_fk = p.pro_id
INNER JOIN Customer c ON s.cust_id_fk = c.cust_id