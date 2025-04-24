# Telecom Sales Analysis and Prediction - Power BI Dashboard

## 📌 Overview
End-to-end solution to analyze and predict customer churn using:
- **PostgreSQL** (Data Engineering)
- **Python** (Machine Learning)
- **Power BI** (Visualization)

**Key Metrics**:
- 6,418 Total Customers
- 27.0% Churn Rate
- 377 Predicted High-Risk Customers

## 📂 Data Pipeline
1. **PostgreSQL**: Raw data → Cleaned tables (`prod_churn`) → Analysis views (`vw_ChurnData`, `vw_JoinData`)
2. **Python**: Random Forest model predicts churn → Exports to `Predictions.csv`
3. **Power BI**: Connects to SQL views + CSV → Interactive dashboards

## 🖥️ Power BI Dashboards

### Summary Dashboard
![Summary Dashboard]([https://via.placeholder.com/600x300?text=Summary+Dashboard](https://app.powerbi.com/groups/me/reports/9dd6c00c-fade-4972-84bf-815002f6e258/ReportSection?experience=power-bi))

**Key Features**:
- Churn by contract type (Month-to-month: 46.5%)
- Top churn reasons: 
  ```plaintext
  Competitor    301
  Dissatisfaction 300
  Price         196
Service impact: Fiber optic (41.1% churn)

Prediction Dashboard
Prediction Dashboard

High-Risk Profiles:

States: Uttar Pradesh, Maharashtra

Contracts: Month-to-month (72% of predicted churn)

Revenue at Risk: $42.5K (377 customers)

⚙️ Technical Implementation
SQL (PostgreSQL)
sql
-- Data Cleaning
INSERT INTO prod_churn 
SELECT 
    customer_id,
    COALESCE(Gender, 'Unknown'),
    COALESCE(Internet_Type, 'None') 
FROM customers;

-- Analysis View
CREATE VIEW vw_ChurnData AS
SELECT * FROM prod_churn 
WHERE customer_status IN ('Stayed','Churned');
Python (Machine Learning)
python
# Model Training
rf_model = RandomForestClassifier(n_estimators=100)
rf_model.fit(X_train, y_train)

# Prediction Export
original_data[original_data['Predicted_Churn'] == 1].to_csv('Predictions.csv')
Power BI Measures
dax
Total Customers = COUNT(prod_Churn[Customer_ID])
Churn Rate = DIVIDE([Total Churn], [Total Customers])
Predicted Churners = COUNT(Predictions[Customer_ID])
Count Predicted Churner = COUNT(Predictions[Customer_ID]) + 0
Title Predicted Churners = “COUNT OF PREDICTED CHURNERS : ” & COUNT(Predictions[Customer_ID])

🚀 Setup Guide
1. Database Setup
bash
psql -U username -d dbname -f setup.sql
3. Python Requirements
bash
pip install -r requirements.txt
Sample requirements.txt:

plaintext
pandas==1.3.4
scikit-learn==0.24.2
joblib==1.0.1
3. Power BI Connection
Connect to PostgreSQL server

Import:

vw_ChurnData

vw_JoinData

Predictions.csv

📈 Key Insights
Top Churn Drivers:

Month-to-month contracts (46.5% churn)

Fiber optic users (41.1% churn)

High monthly charge (>$80)

Retention Opportunities:

Target dissatisfied customers (300 cases)

Offer incentives to long-term contracts
