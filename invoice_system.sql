CREATE DATABASE invoice_system;

USE invoice_system;

CREATE TABLE invoices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id VARCHAR(255) NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    subject VARCHAR(255) NOT NULL,
    from_company VARCHAR(255) NOT NULL,
    from_address VARCHAR(255) NOT NULL,
    to_company VARCHAR(255) NOT NULL,
    to_address VARCHAR(255) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    tax DECIMAL(10, 2) NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    status ENUM('PAID', 'UNPAID') NOT NULL DEFAULT 'UNPAID'
);

CREATE TABLE invoice_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id INT NOT NULL,
    item_type VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    quantity DECIMAL(10, 2) NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (invoice_id) REFERENCES invoices(id) ON DELETE CASCADE
);

INSERT INTO invoices (invoice_id, issue_date, due_date, subject, from_company, from_address, to_company, to_address, subtotal, tax, total, status)
VALUES
('INV001', '2024-11-01', '2024-11-15', 'Website Development', 'TechCorp Inc.', '123 Tech Street', 'Startup Ltd.', '456 Innovation Road', 1000.00, 100.00, 1100.00, 'PAID'),
('INV002', '2024-11-02', '2024-11-16', 'Marketing Campaign', 'Creative Solutions', '789 Branding Blvd', 'Business Pro', '321 Enterprise Ave', 1500.00, 150.00, 1650.00, 'UNPAID'),
('INV003', '2024-11-03', '2024-11-17', 'Consulting Services', 'BizConsult', '654 Advisor Lane', 'ClientCo', '876 Customer Way', 800.00, 80.00, 880.00, 'PAID'),
('INV004', '2024-11-04', '2024-11-18', 'SEO Optimization', 'SEO Masters', '101 SEO Drive', 'Ecommerce Inc.', '202 Shopping St', 600.00, 60.00, 660.00, 'UNPAID'),
('INV005', '2024-11-05', '2024-11-19', 'App Development', 'CodeWorks', '123 Code Alley', 'TechSavvy', '789 Startup Lane', 2000.00, 200.00, 2200.00, 'PAID'),
('INV006', '2024-11-06', '2024-11-20', 'Graphic Design', 'DesignHub', '456 Design St', 'Visual Ventures', '654 Art Ave', 1200.00, 120.00, 1320.00, 'UNPAID'),
('INV007', '2024-11-07', '2024-11-21', 'Cloud Hosting', 'CloudNet', '789 Cloud Way', 'OnlineBiz', '987 Web Drive', 500.00, 50.00, 550.00, 'PAID'),
('INV008', '2024-11-08', '2024-11-22', 'IT Support', 'SupportPro', '321 IT Lane', 'RetailTech', '543 Commerce Road', 700.00, 70.00, 770.00, 'UNPAID'),
('INV009', '2024-11-09', '2024-11-23', 'Content Writing', 'WriteHouse', '654 Writing Blvd', 'PublisherCo', '432 Book Ave', 400.00, 40.00, 440.00, 'PAID'),
('INV010', '2024-11-10', '2024-11-24', 'Social Media Management', 'SocialSuite', '876 Social Plaza', 'BrandBoost', '321 Influence Road', 1300.00, 130.00, 1430.00, 'UNPAID');

INSERT INTO invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
VALUES
(1, 'Service', 'Frontend Design', 10, 50.00, 500.00),
(1, 'Service', 'Backend Development', 10, 50.00, 500.00),
(2, 'Service', 'Social Media Ads', 5, 300.00, 1500.00),
(3, 'Service', 'Market Analysis', 8, 100.00, 800.00),
(4, 'Service', 'SEO Audits', 6, 100.00, 600.00),
(5, 'Product', 'iOS Development', 10, 100.00, 1000.00),
(5, 'Service', 'Android Development', 10, 100.00, 1000.00),
(6, 'Service', 'Logo Design', 12, 100.00, 1200.00),
(7, 'Service', 'Hosting Fees', 12, 40.00, 480.00),
(8, 'Service', 'Network Setup', 7, 100.00, 700.00);
