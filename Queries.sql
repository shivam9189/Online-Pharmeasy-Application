--  Average Order Value Per Customer (Only Delivered Orders)

SELECT 
    c.cust_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    AVG(p.amount) AS avg_order_value
FROM Customers c
JOIN "Order" o ON c.cust_id = o.cust_id
JOIN Payment p ON o.order_id = p.order_id
JOIN Delivered_by d ON o.order_id = d.order_id
WHERE d.delivery_status = 'Delivered'
GROUP BY c.cust_id, c.name
ORDER BY avg_order_value DESC;


--  Find the Most Popular Medicine Based on Total Quantity Sold

SELECT med.med_id, med.name, SUM(pi.quantity) AS total_quantity_sold
FROM Medicine med
JOIN Purchased_items pi ON med.med_id = pi.med_id
GROUP BY med.med_id, med.name
ORDER BY total_quantity_sold DESC
LIMIT 3;


--  Find customers with multiple shipping addresses and their order frequencies

SELECT 
    c.cust_id,
    c.name,
    COUNT(DISTINCT a.pin) AS address_count,
    COUNT(o.order_id) AS total_orders,
    COUNT(o.order_id) / COUNT(DISTINCT a.pin) AS orders_per_address,
    SUM(p.amount) AS total_spent
FROM 
    Customers c
JOIN 
    Address a ON c.cust_id = a.cust_id
JOIN 
    "Order" o ON c.cust_id = o.cust_id
JOIN 
    Payment p ON o.order_id = p.order_id
GROUP BY 
    c.cust_id, c.name
HAVING 
    COUNT(DISTINCT a.pin) > 1
ORDER BY 
    total_spent DESC;


--  Find all orders that have been delayed beyond the estimated delivery date

SELECT 
    o.order_id,
    o.order_date,
    o.estimated_delivery_date,
    CURRENT_DATE - o.estimated_delivery_date AS days_overdue,
    o.order_status,
    db.delivery_status,
    e.name AS assigned_delivery_person
FROM 
    "Order" o
JOIN 
    Customers c ON o.cust_id = c.cust_id
LEFT JOIN 
    Delivered_by db ON o.order_id = db.order_id
LEFT JOIN 
    Employee e ON db.emp_id = e.emp_id
LEFT JOIN 
    Delivery d ON e.emp_id = d.emp_id
WHERE 
    o.estimated_delivery_date < CURRENT_DATE
    AND (o.order_status != 'Delivered' OR db.delivery_status != 'Delivered')
ORDER BY 
    days_overdue DESC;



--  Fixed query for medicines with stock value > 20 in cart

SELECT 
    m.med_id, 
    m.name, 
    m.expiry_date, 
    m.price, 
    SUM(a.quantity) AS total_quantity,
    m.price * SUM(a.quantity) AS total_value
FROM 
    Medicine m
JOIN 
    Add_to_cart a ON m.med_id = a.med_id
GROUP BY 
    m.med_id, m.name, m.expiry_date, m.price
HAVING 
    m.price * SUM(a.quantity) > 20
ORDER BY 
    m.expiry_date;


--  Identify customers who might need membership renewal reminders

SELECT 
    c.cust_id,
    c.name,
    c.email,
    c.phone_no,
    m.expiry_date,
    m.expiry_date - CURRENT_DATE AS days_until_expiry,
    mt.membership_type_id,
    mt.validity,
    mt.price
FROM 
    Customers c
JOIN 
    Members m ON c.cust_id = m.cust_id
JOIN 
    Membership_Type mt ON m.membership_type_id = mt.membership_type_id
WHERE 
    m.expiry_date > CURRENT_DATE
    AND NOT EXISTS (
        SELECT 1 
        FROM Members m2 
        WHERE m2.cust_id = c.cust_id AND m2.expiry_date > m.expiry_date
    )
ORDER BY 
    days_until_expiry;


--  Calculate the discount rate by medicine category

SELECT 
    c.category_id,
    c.category_name,
    AVG(m.discount) AS avg_category_discount
FROM 
    Category c
JOIN 
    Medicine m ON c.category_id = m.category_id
GROUP BY 
    c.category_id, c.category_name;


--  Top 5 cities with most customers

SELECT city, COUNT(DISTINCT cust_id) AS customer_count
FROM Address
GROUP BY city
ORDER BY customer_count DESC
LIMIT 5;


--  Find medicines that are in prescribed orders vs. non-prescribed orders

SELECT 
    m.med_id, 
    m.name,
    CASE
        WHEN m.med_id IN (
            SELECT DISTINCT pi.med_id
            FROM Purchased_items pi
            JOIN Prescription_status ps ON pi.order_id = ps.order_id
        ) THEN 'Prescribed'
        ELSE 'Non-Prescribed'
    END AS prescription_status,
    COUNT(DISTINCT pi.order_id) AS order_count
FROM 
    Medicine m
JOIN 
    Purchased_items pi ON m.med_id = pi.med_id
GROUP BY 
    m.med_id, m.name, prescription_status
ORDER BY 
    prescription_status, order_count DESC;



--  Fixed query for delivery employee efficiency

SELECT 
    e.emp_id, 
    e.name, 
    COUNT(db.order_id) AS deliveries_completed,
    AVG(o.estimated_delivery_date - o.order_date) AS avg_delivery_time_days
FROM 
    Employee e
JOIN 
    Delivery d ON e.emp_id = d.emp_id
JOIN 
    Delivered_by db ON e.emp_id = db.emp_id
JOIN 
    "Order" o ON db.order_id = o.order_id
WHERE 
    db.delivery_status = 'Delivered'
GROUP BY 
    e.emp_id, e.name
ORDER BY 
    deliveries_completed DESC, 
    avg_delivery_time_days ASC
LIMIT 3;


--  Upcoming Expiry Medicines with Category Information

SELECT m.med_id, m.name, m.expiry_date, c.category_name
FROM Medicine m
JOIN Belongs_To bt ON m.med_id = bt.med_id
JOIN Category c ON bt.category_id = c.category_id
WHERE m.expiry_date < (CURRENT_DATE + INTERVAL '6 months');


--  Identify trends in medicine categories purchases by month

SELECT 
    EXTRACT(YEAR FROM o.order_date) AS year,
    EXTRACT(MONTH FROM o.order_date) AS month,
    c.category_name,
    COUNT(DISTINCT o.order_id) AS order_count,
    SUM(pi.quantity) AS total_quantity,
    SUM(pi.net_price) AS total_revenue
FROM 
    "Order" o
JOIN 
    Purchased_items pi ON o.order_id = pi.order_id
JOIN 
    Medicine m ON pi.med_id = m.med_id
JOIN 
    Category c ON m.category_id = c.category_id
GROUP BY 
    EXTRACT(YEAR FROM o.order_date),
    EXTRACT(MONTH FROM o.order_date),
    c.category_name
ORDER BY 
    year, month, total_revenue DESC;


--  Revenue Breakdown by Payment Type

SELECT p.payment_type, SUM(p.amount) AS total_revenue, COUNT(p.trans_id) AS transactions_count
FROM Payment p
GROUP BY p.payment_type;


--  Get the names of employees who have handled the highest number of prescription verifications

SELECT 
    e.emp_id,
    e.name,
    COUNT(ps.order_id) AS prescriptions_verified
FROM 
    Employee e
JOIN 
    Doctor d ON e.emp_id = d.emp_id
JOIN 
    Prescription_status ps ON d.emp_id = ps.emp_id
WHERE 
    ps.verified = 'Yes'
GROUP BY 
    e.emp_id, e.name
ORDER BY 
    prescriptions_verified DESC
LIMIT 3;



--  Find customers who have spent more than 50 on medicines, along with their membership type

SELECT 
    c.cust_id,
    c.name AS customer_name,
    mt.membership_type_id,
    mt.validity,
    SUM(p.amount) AS total_spent
FROM 
    Customers c
JOIN 
    "Order" o ON c.cust_id = o.cust_id
JOIN 
    Payment p ON o.order_id = p.order_id
LEFT JOIN 
    Members m ON c.cust_id = m.cust_id
LEFT JOIN 
    Membership_Type mt ON m.membership_type_id = mt.membership_type_id
GROUP BY 
    c.cust_id, c.name, mt.membership_type_id, mt.validity
HAVING 
    SUM(p.amount) > 50
ORDER BY 
    total_spent DESC;



