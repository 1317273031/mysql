DROP DATABASE IF EXISTS Shopping_Management;
CREATE DATABASE Shopping_Management;
USE Shopping_Management;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number CHAR(10) NOT NULL UNIQUE,
    age INT,
    gender ENUM('Male', 'Female', 'Other'),
    country VARCHAR(50) DEFAULT 'India',
    city VARCHAR(50) NOT NULL,
    pincode CHAR(6) DEFAULT '201301',
    registration_date DATE DEFAULT (CURRENT_DATE()),
    registration_time TIME DEFAULT (CURRENT_TIME()),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    address VARCHAR(250),
    customer_status ENUM('Active', 'Inactive', 'Blocked') DEFAULT 'Active',
    customer_notes VARCHAR(1023),

    CONSTRAINT check_phone CHECK (phone_number REGEXP '^[0-9]{10}$'),
    CONSTRAINT check_age CHECK (Age > 0),
    CONSTRAINT check_pincode CHECK (pincode REGEXP '^[0-9]{6}$')
) ENGINE=InnoDB;

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE DEFAULT (CURRENT_DATE()),
    order_amount DECIMAL(10,2) NOT NULL,
    order_status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    payment_method ENUM('Cash', 'Card', 'UPI', 'Net Banking'),
    payment_status ENUM('Pending', 'Paid', 'Failed') DEFAULT 'Pending',
    shipping_address VARCHAR(250) NOT NULL,
    delivery_pincode CHAR(6),
    quantity INT NOT NULL,
    discount_amount DECIMAL(10,2) DEFAULT 0.00,
    delivery_date DATE NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    tracking_number VARCHAR(30) UNIQUE,
    delivery_status ENUM('Not Dispatched', 'In Transit', 'Delivered', 'Returned') DEFAULT 'Not Dispatched',
    order_notes VARCHAR(1023),

    CONSTRAINT check_quantity CHECK (quantity > 0),
    CONSTRAINT check_delivery_pincode CHECK (delivery_pincode REGEXP '^[0-9]{6}$'),
    CONSTRAINT check_order_amount CHECK (order_amount >= 0),
    CONSTRAINT check_discount CHECK (discount_amount >= 0),

    CONSTRAINT fake_orders_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;