# sql-credit-risk-portfolio-analysis
SQL-based analysis of a synthetic lending portfolio, exploring borrower segmentation, charge-off rates, financial exposure, and debt-to-income risk.
# Credit Risk Portfolio Analysis Using SQL

### Project Overview

This project explores credit risk within a synthetic consumer lending portfolio using SQL.

The objective is to analyse borrower characteristics, segment loans into risk categories, and investigate relationships between credit scores, debt-to-income ratios, employment status, and observed loan outcomes.

### Tools Used
- PostgreSQL
- SQL (CASE WHEN, GROUP BY, aggregate functions, views)
- Exploratory Data Analysis

### Dataset

The dataset contains 20 synthetic loan records with the following attributes:

- Loan ID
- Employment Type
- Credit Score
- Loan Amount
- Interest Rate
- Debt-to-Income Ratio (DTI)
- Previous Delinquencies
- Loan Status

The dataset is illustrative and does not represent actual bank or customer information.

### Analytical Approach

**1. Credit Risk Segmentation**

Categorised borrowers into four credit score tiers: Prime, Near-Prime, Subprime, and Deep Subprime.

**2. Portfolio Exposure Analysis**

Calculated loan counts, total original loan principal, observed charge-off rates, and charged-off original principal across credit risk tiers.

**3. Debt-to-Income Analysis**

Investigated the relationship between borrower DTI, average credit score, and observed charge-off frequency.

**4. Employment-Based Risk Analysis**

Compared average contractual interest rates and observed charge-off rates across employment categories.

### Key Findings

- The sample exhibits a clear relationship between lower credit scores and higher observed charge-off frequency.
- Borrowers with elevated DTI ratios demonstrate greater credit risk within the synthetic dataset.
- Employment-based segmentation highlights differences in borrower outcomes and contractual interest rates.

### Limitations

- The analysis uses a small synthetic dataset and should not be interpreted as a statistically validated credit risk model.
- Current loans are unresolved and should be excluded when estimating completed-loan charge-off rates.
- Charged-off original principal is not equivalent to realised financial loss.
- Interest rates represent contractual rates, not realised portfolio yield.
- Credit score tiers are illustrative project-defined classifications.

### Future Improvements

- Expand the dataset using a larger publicly available lending dataset.
- Introduce Probability of Default (PD) modelling.
- Incorporate Loss Given Default (LGD) and Exposure at Default (EAD).
- Develop an interactive Power BI dashboard.

### Project Objective

Demonstrate how SQL can support credit risk monitoring, borrower segmentation, and data-driven lending portfolio analysis.
