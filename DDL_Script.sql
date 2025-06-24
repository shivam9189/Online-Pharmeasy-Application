CREATE TABLE Customers (
    cust_id INT PRIMARY KEY,
    email VARCHAR(20),
    name TEXT,
    phone_no INT,
    password VARCHAR(10)
);


CREATE TABLE Address (
    cust_id INT,
    street_area TEXT,
    city VARCHAR(30),
    pin INT,
    house_building TEXT,
    PRIMARY KEY (cust_id, pin),
    FOREIGN KEY (cust_id) REFERENCES Customers(cust_id)
);


CREATE TABLE Membership_Type (
    membership_type_id INT PRIMARY KEY,
    validity VARCHAR(10),
    price NUMERIC
);


CREATE TABLE Members (
    cust_id INT PRIMARY KEY,
    expiry_date DATE,
    membership_type_id INT,
    purchase_date DATE,
    FOREIGN KEY (cust_id) REFERENCES Customers(cust_id),
    FOREIGN KEY (membership_type_id) REFERENCES Membership_Type(membership_type_id)
);


CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    name TEXT,
    salary NUMERIC,
    contact_no INT
);


CREATE TABLE Doctor (
    emp_id INT PRIMARY KEY,
    license_id INT UNIQUE NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);


CREATE TABLE Staff (
    emp_id INT PRIMARY KEY,
    working_hours INT,
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);


CREATE TABLE Query (
    query_id INT PRIMARY KEY,
    status VARCHAR(10),
    query_date DATE,
    cust_id INT,
    emp_id INT,
    FOREIGN KEY (cust_id) REFERENCES Customers(cust_id),
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);


CREATE TABLE Category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(20),
    description TEXT
);


CREATE TABLE Medicine (
    med_id INT PRIMARY KEY,
    name TEXT,
    company TEXT,
    discount NUMERIC,
    manufacturing_date DATE,
    expiry_date DATE,
    price NUMERIC,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);


CREATE TABLE Drug_Composition (
    med_id INT,
    composition VARCHAR(30),
    power VARCHAR(10),
    PRIMARY KEY (med_id, composition),
    FOREIGN KEY (med_id) REFERENCES Medicine(med_id)
);


CREATE TABLE Add_to_cart (
    cust_id INT,
    quantity INT,
    med_id INT,
    PRIMARY KEY (cust_id, med_id),
    FOREIGN KEY (cust_id) REFERENCES Customers(cust_id),
    FOREIGN KEY (med_id) REFERENCES Medicine(med_id)
);


CREATE TABLE "Order" (
    order_id INT PRIMARY KEY,
    cust_id INT,
    order_date DATE,
    order_status VARCHAR(10),
    delivery_fee NUMERIC,
    estimated_delivery_date DATE,
    FOREIGN KEY (cust_id) REFERENCES Customers(cust_id)
);


CREATE TABLE Purchased_items (
    med_id INT,
    quantity INT,
    total_price INT,
    net_price INT,
    order_id INT,
    PRIMARY KEY (med_id, order_id),
    FOREIGN KEY (med_id) REFERENCES Medicine(med_id),
    FOREIGN KEY (order_id) REFERENCES "Order"(order_id)
);


CREATE TABLE Prescription_status (
    order_id INT PRIMARY KEY,
    status VARCHAR(10),
    verified VARCHAR(10),
    emp_id INT,
    FOREIGN KEY (order_id) REFERENCES "Order"(order_id),
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);


CREATE TABLE Delivery (
    emp_id INT PRIMARY KEY,
    vehicle_no VARCHAR(15),
    driving_license_no VARCHAR(20),
    area_code INT,
    experience VARCHAR(10),
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id)
);


CREATE TABLE Delivered_by (
    emp_id INT,
    order_id INT,
    delivery_status VARCHAR(10),
    PRIMARY KEY (emp_id, order_id),
    FOREIGN KEY (emp_id) REFERENCES Employee(emp_id),
    FOREIGN KEY (order_id) REFERENCES "Order"(order_id)
);


CREATE TABLE Payment (
    trans_id VARCHAR(20) PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    payment_date DATE,
    amount NUMERIC,
    status VARCHAR(10),
    payment_type VARCHAR(10),
    FOREIGN KEY (order_id) REFERENCES "Order"(order_id)
);


