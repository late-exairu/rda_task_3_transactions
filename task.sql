-- Use our database
USE ShopDB;

SET @customerId = 1;
SET @orderDate  = '2023-01-01';
SET @productId  = 1;
SET @itemCount  = 1;

-- Start the transaction
START TRANSACTION;

INSERT INTO Orders (CustomerID, Date)
VALUES (@customerId, @orderDate);

SET @orderId = LAST_INSERT_ID();

INSERT INTO OrderItems (OrderID, ProductID, Count)
VALUES (@orderId, @productId, @itemCount);

UPDATE Products
SET WarehouseAmount = WarehouseAmount - @itemCount
WHERE ID = @productId;

COMMIT;