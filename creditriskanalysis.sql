DROP TABLE IF EXISTS loan_records;

CREATE TABLE loan_records (
    loan_id VARCHAR(10) PRIMARY KEY,
    employment_type VARCHAR(20),
    credit_score INT,
    loan_amount INT,
    interest_rate NUMERIC(4,2),
    debt_to_income NUMERIC(4,2),
    previous_delinquencies INT,
    loan_status VARCHAR(20)
);

INSERT INTO loan_records (loan_id, employment_type, credit_score, loan_amount, interest_rate, debt_to_income, previous_delinquencies, loan_status) VALUES
('LN001', 'Salaried', 740, 25000, 6.50, 0.22, 0, 'Fully Paid'),
('LN002', 'Self-Employed', 580, 15000, 14.25, 0.48, 3, 'Charged Off'),
('LN003', 'Salaried', 690, 30000, 8.75, 0.31, 0, 'Fully Paid'),
('LN004', 'Self-Employed', 610, 20000, 12.50, 0.42, 1, 'Charged Off'),
('LN005', 'Salaried', 720, 10000, 7.20, 0.15, 0, 'Fully Paid'),
('LN006', 'Unemployed', 500, 5000, 18.00, 0.65, 4, 'Charged Off'),
('LN007', 'Salaried', 660, 18000, 9.99, 0.38, 1, 'Current'),
('LN008', 'Self-Employed', 780, 45000, 5.75, 0.18, 0, 'Fully Paid'),
('LN009', 'Salaried', 630, 12000, 11.50, 0.46, 2, 'Charged Off'),
('LN010', 'Salaried', 705, 22000, 7.99, 0.27, 0, 'Fully Paid'),
('LN011', 'Self-Employed', 595, 8000, 15.00, 0.52, 2, 'Charged Off'),
('LN012', 'Salaried', 750, 35000, 6.25, 0.20, 0, 'Fully Paid'),
('LN013', 'Unemployed', 520, 4000, 19.50, 0.58, 3, 'Charged Off'),
('LN014', 'Salaried', 680, 15000, 8.90, 0.33, 0, 'Fully Paid'),
('LN015', 'Self-Employed', 640, 26000, 11.20, 0.41, 1, 'Current'),
('LN016', 'Salaried', 710, 17500, 7.50, 0.24, 0, 'Fully Paid'),
('LN017', 'Self-Employed', 570, 19000, 16.00, 0.49, 4, 'Charged Off'),
('LN018', 'Salaried', 790, 50000, 5.25, 0.12, 0, 'Fully Paid'),
('LN019', 'Salaried', 625, 14000, 12.00, 0.44, 2, 'Charged Off'),
('LN020', 'Self-Employed', 670, 21000, 9.50, 0.35, 0, 'Fully Paid');

SELECT * FROM loan_records;


CREATE OR REPLACE VIEW v_risk_portfolio_cleansed AS 
SELECT 
    loan_id,
    employment_type,
    credit_score,
    loan_amount,
    interest_rate,
    debt_to_income,
    previous_delinquencies,
    loan_status,
	case 
	when credit_score>= 720 then 'Prime (Excellent)'
	when credit_score between 660 and 719 then 'Near-Prime (Good)'
	when credit_score between 600 and 659 then 'Subprime (Fair)'
	else 'Deep Subprime (High Risk)'
	end as credit_risk_tier,
	case 
	when loan_status ='Charged Off' then 1
	else 0
	end as is_defaulted
	from loan_records;
	
	select * from v_risk_portfolio_cleansed;

	select credit_risk_tier,
	count(*) as total_loans_issued,
	sum(loan_amount) as total_financial_exposure,
	round(sum(is_defaulted)* 100.0/ count(*),2) as default_rate_pct,
	sum(case when is_defaulted = 1 then loan_amount
	else 0 end) as charged_off_principal
	from v_risk_portfolio_cleansed
	group by credit_risk_tier
	order by default_rate_pct desc;


	select
	case when debt_to_income <= 0.25 then 'low dti'
	when debt_to_income <= 0.45 then 'medium dti'
	else 'high dti'
	end as dti_risk_buckets,
	count(*) as borrower_count,
	round(avg(credit_score), 0) as avg_credit_score,
	round(sum(is_defaulted)* 100.0/ count(*), 2) as default_rate_pct
	from v_risk_portfolio_cleansed
	group by 1
	order bY default_rate_pct DESC;

	
   select employment_type,
  round(avg(interest_rate),2) as average_portfolio_yield,
  round(sum(is_defaulted)*100.0/ count(*),2) as default_rate_pct,
  round(avg(interest_rate)- (sum(is_defaulted)*100.0/ count(*)),2) as net_yield_index
  from v_risk_portfolio_cleansed
  group by employment_type
  order by net_yield_index;          
