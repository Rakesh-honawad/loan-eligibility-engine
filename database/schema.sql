CREATE TABLE IF NOT EXISTS users (
    user_id VARCHAR(50) PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    monthly_income DECIMAL(10,2),
    credit_score INTEGER,
    employment_status VARCHAR(50),
    age INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_income_credit ON users(monthly_income, credit_score);

CREATE TABLE IF NOT EXISTS loan_products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    lender VARCHAR(255),
    interest_rate DECIMAL(5,2),
    min_income DECIMAL(10,2),
    min_credit_score INTEGER,
    min_age INTEGER DEFAULT 18,
    max_age INTEGER DEFAULT 65,
    employment_required BOOLEAN DEFAULT FALSE,
    scraped_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_eligibility ON loan_products(min_income, min_credit_score);

CREATE TABLE IF NOT EXISTS matches (
    match_id SERIAL PRIMARY KEY,
    user_id VARCHAR(50) REFERENCES users(user_id),
    product_id INTEGER REFERENCES loan_products(product_id),
    match_score INTEGER,
    matched_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notified BOOLEAN DEFAULT FALSE
);

-- Insert sample loan products for testing
INSERT INTO loan_products (product_name, lender, interest_rate, min_income, min_credit_score, min_age, max_age, employment_required) VALUES
('Personal Loan Basic', 'HDFC Bank', 10.50, 25000, 650, 21, 60, TRUE),
('Quick Cash Loan', 'ICICI Bank', 11.25, 20000, 600, 21, 65, FALSE),
('Premium Personal Loan', 'SBI', 9.75, 50000, 750, 25, 58, TRUE),
('Salary Advance Loan', 'Axis Bank', 12.00, 15000, 550, 21, 60, TRUE),
('Flexi Personal Loan', 'Kotak Mahindra', 10.99, 30000, 700, 23, 60, TRUE)
ON CONFLICT DO NOTHING;
