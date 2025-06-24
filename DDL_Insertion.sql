INSERT INTO Customers VALUES
(1, 'john@example.com', 'John Doe', '9876543210', 'pass123'),
(2, 'jane@example.com', 'Jane Smith', '9123456780', 'secure1'),
(3, 'alice@example.com', 'Alice Brown', '9988776655', 'alicepw'),
(4, 'bob@example.com', 'Bob Stone', '8765432109', 'bobbypw'),
(5, 'emma@example.com', 'Emma Watson', '9001122334', 'emmapass');


INSERT INTO Address VALUES
(1, 'Green St', 'New York', 10001, 'Apt 101'),
(2, 'Sunset Blvd', 'Los Angeles', 90001, 'House 5B'),
(3, 'Bay Area', 'San Francisco', 94102, 'Flat 3A'),
(4, 'Park Lane', 'Chicago', 60601, 'Block C'),
(5, 'Downtown', 'Houston', 77001, 'Villa 4');


INSERT INTO Membership_Type VALUES
(1, '1 year', 999.99),
(2, '6 months', 549.99),
(3, '3 months', 299.99);


INSERT INTO Members VALUES
(1, '2025-04-11', 1, '2024-04-11'),
(2, '2024-10-10', 2, '2024-04-10'),
(3, '2024-07-01', 3, '2024-04-01');


INSERT INTO Employee VALUES
(1, 'Dr. Sarah', 80000, '9988776655'),
(2, 'Mike', 30000, '9876543212'),
(3, 'Anna', 35000, '8765432190'),
(4, 'Tom', 28000, '7654321987'),
(5, 'Lisa', 45000, '8123456789');


INSERT INTO Doctor VALUES
(1, 123456);


INSERT INTO Staff VALUES
(2, 40),
(3, 35),
(4, 30),
(5, 45);


INSERT INTO Query VALUES
(1, 'Open', '2024-04-01', 1, 2),
(2, 'Closed', '2024-03-15', 2, 3),
(3, 'Open', '2024-04-05', 3, 5);


INSERT INTO Category VALUES
(1, 'Painkiller', 'Used to relieve pain'),
(2, 'Antibiotic', 'Fights bacterial infections'),
(3, 'Vitamin', 'Supplements vitamins'),
(4, 'Cough', 'Relieves cough symptoms');


INSERT INTO Medicine VALUES
(1, 'Paracetamol', 'MediCorp', 10, '2023-12-01', '2025-12-01', 50, 1),
(2, 'Amoxicillin', 'HealWell', 5, '2023-11-01', '2025-11-01', 100, 2),
(3, 'Vitamin C', 'NutriPlus', 15, '2024-01-15', '2026-01-15', 60, 3),
(4, 'Cough Syrup', 'ColdCare', 12, '2023-10-01', '2025-10-01', 80, 4);


INSERT INTO Drug_Composition VALUES
(1, 'Acetaminophen', '500mg'),
(2, 'Amoxicillin Trihydrate', '250mg'),
(3, 'Ascorbic Acid', '1000mg'),
(4, 'Dextromethorphan', '15ml');


INSERT INTO Add_to_cart VALUES
(1, 2, 1),
(2, 1, 2),
(3, 3, 3);


INSERT INTO "Order" VALUES
(101, 1, '2024-04-01', 'Pending', 10, '2024-04-05'),
(102, 2, '2024-04-02', 'Delivered', 15, '2024-04-06');


INSERT INTO Purchased_items VALUES
(2, 1, 100, 90, 101),
(1, 2, 100, 95, 102);


INSERT INTO Prescription_status VALUES
(101, 'Checked', 'Yes', 1, 'url1.jpg'),
(102, 'Pending', 'No', 1, 'url2.jpg');


INSERT INTO Delivery VALUES
(4, 'MH12AB1234', 'DL987654321', 110001, '5 years');


INSERT INTO Delivered_by VALUES
(4, 102, 'Delivered');


INSERT INTO Payment VALUES
('TXN001', 101, '2024-04-01', 90, 'Paid', 'Card'),
('TXN002', 102, '2024-04-02', 95, 'Paid', 'UPI');


INSERT INTO Belongs_To VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);