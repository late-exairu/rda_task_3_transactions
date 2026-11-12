USE ShopDB;

-- Create the order outside the transaction
INSERT INTO Orders (CustomerID, Date)
VALUES (1, '2023-01-01');

-- Values used inside the transaction
SET @orderId   = LAST_INSERT_ID();
SET @productId = 1;
SET @itemCount = 1;

START TRANSACTION;

-- Add the order item
INSERT INTO OrderItems (OrderID, ProductID, Count)
VALUES (@orderId, @productId, @itemCount);

-- Decrease the warehouse stock
UPDATE Products
SET WarehouseAmount = WarehouseAmount - @itemCount
WHERE ID = @productId;

COMMIT;