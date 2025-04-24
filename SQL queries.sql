--Creating an empty table (customers) to export data from a CSV file into this table
CREATE TABLE customers (
	Customer_ID	VARCHAR (20) PRIMARY KEY,
	Gender VARCHAR (10),
	Age	NUMERIC,
	Married	VARCHAR (5),
	State	VARCHAR (20),
	Number_of_Referrals	NUMERIC,
	Tenure_in_Months NUMERIC,	
	Value_Deal	VARCHAR(10),
	Phone_Service VARCHAR (5),
	Multiple_Lines	VARCHAR (5),
	Internet_Service VARCHAR (5),	
	Internet_Type	VARCHAR (20),
	Online_Security	VARCHAR (5),
	Online_Backup	VARCHAR (5),
	Device_Protection_Plan	VARCHAR (5),
	Premium_Support	VARCHAR (5),
	Streaming_TV	VARCHAR (5),
	Streaming_Movies	VARCHAR (5),
	Streaming_Music	VARCHAR (5),
	Unlimited_Data	VARCHAR (5),
	Contract	VARCHAR (20),
	Paperless_Billing VARCHAR (5),	
	Payment_Method	VARCHAR (20),
	Monthly_Charge	DECIMAL(10,2),
	Total_Charges	DECIMAL(10,2),
	Total_Refunds	DECIMAL (4,2),
	Total_Extra_Data_Charges	NUMERIC,
	Total_Long_Distance_Charges	DECIMAL(10,2),
	Total_Revenue DECIMAL(10,2),
	Customer_Status	VARCHAR(10),
	Churn_Category	VARCHAR(20),
	Churn_Reason VARCHAR(30)
);

ALTER TABLE customers 
	ALTER COLUMN Churn_reason TYPE VARCHAR(100);

SELECT * FROM customers;

--Data Exploration (checking distinct values)

SELECT gender,
	COUNT(gender), 
	ROUND(COUNT(gender)*100.0/(select COUNT(gender) FROM customers),2) AS Gender_proportion 
	FROM customers 
	GROUP BY gender;

SELECT contract,
	COUNT(contract),
	ROUND(COUNT(contract)*100.0/(SELECT COUNT(contract) FROM customers),2) AS Contract_percent
	FROM customers 
	GROUP BY contract;

SELECT state, 
	COUNT(state),ROUND(COUNT(state)*100.0/(SELECT COUNT(state) FROM customers),2) AS state_percent
	FROM customers 
	GROUP BY state
	ORDER BY state_percent desc;

-- Data Exploration (checking for NULL values)

SELECT 
    SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_ID_Null_Count,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_Null_Count,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_Null_Count,
    SUM(CASE WHEN Married IS NULL THEN 1 ELSE 0 END) AS Married_Null_Count,
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_Null_Count,
    SUM(CASE WHEN Number_of_Referrals IS NULL THEN 1 ELSE 0 END) AS Number_of_Referrals_Null_Count,
    SUM(CASE WHEN Tenure_in_Months IS NULL THEN 1 ELSE 0 END) AS Tenure_in_Months_Null_Count,
    SUM(CASE WHEN Value_Deal IS NULL THEN 1 ELSE 0 END) AS Value_Deal_Null_Count,
    SUM(CASE WHEN Phone_Service IS NULL THEN 1 ELSE 0 END) AS Phone_Service_Null_Count,
    SUM(CASE WHEN Multiple_Lines IS NULL THEN 1 ELSE 0 END) AS Multiple_Lines_Null_Count,
    SUM(CASE WHEN Internet_Service IS NULL THEN 1 ELSE 0 END) AS Internet_Service_Null_Count,
    SUM(CASE WHEN Internet_Type IS NULL THEN 1 ELSE 0 END) AS Internet_Type_Null_Count,
    SUM(CASE WHEN Online_Security IS NULL THEN 1 ELSE 0 END) AS Online_Security_Null_Count,
    SUM(CASE WHEN Online_Backup IS NULL THEN 1 ELSE 0 END) AS Online_Backup_Null_Count,
    SUM(CASE WHEN Device_Protection_Plan IS NULL THEN 1 ELSE 0 END) AS Device_Protection_Plan_Null_Count,
    SUM(CASE WHEN Premium_Support IS NULL THEN 1 ELSE 0 END) AS Premium_Support_Null_Count,
    SUM(CASE WHEN Streaming_TV IS NULL THEN 1 ELSE 0 END) AS Streaming_TV_Null_Count,
    SUM(CASE WHEN Streaming_Movies IS NULL THEN 1 ELSE 0 END) AS Streaming_Movies_Null_Count,
    SUM(CASE WHEN Streaming_Music IS NULL THEN 1 ELSE 0 END) AS Streaming_Music_Null_Count,
    SUM(CASE WHEN Unlimited_Data IS NULL THEN 1 ELSE 0 END) AS Unlimited_Data_Null_Count,
    SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS Contract_Null_Count,
    SUM(CASE WHEN Paperless_Billing IS NULL THEN 1 ELSE 0 END) AS Paperless_Billing_Null_Count,
    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Payment_Method_Null_Count,
    SUM(CASE WHEN Monthly_Charge IS NULL THEN 1 ELSE 0 END) AS Monthly_Charge_Null_Count,
    SUM(CASE WHEN Total_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Charges_Null_Count,
    SUM(CASE WHEN Total_Refunds IS NULL THEN 1 ELSE 0 END) AS Total_Refunds_Null_Count,
    SUM(CASE WHEN Total_Extra_Data_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Extra_Data_Charges_Null_Count,
    SUM(CASE WHEN Total_Long_Distance_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Long_Distance_Charges_Null_Count,
    SUM(CASE WHEN Total_Revenue IS NULL THEN 1 ELSE 0 END) AS Total_Revenue_Null_Count,
    SUM(CASE WHEN Customer_Status IS NULL THEN 1 ELSE 0 END) AS Customer_Status_Null_Count,
    SUM(CASE WHEN Churn_Category IS NULL THEN 1 ELSE 0 END) AS Churn_Category_Null_Count,
    SUM(CASE WHEN Churn_Reason IS NULL THEN 1 ELSE 0 END) AS Churn_Reason_Null_Count
FROM customers;

-- Data Cleaning (removing NULL values and replacing them with specific values)
--Creating empty source table Prod_churn
CREATE TABLE prod_churn (
	Customer_ID	VARCHAR (20) PRIMARY KEY,
	Gender VARCHAR (10),
	Age	NUMERIC,
	Married	VARCHAR (5),
	State	VARCHAR (20),
	Number_of_Referrals	NUMERIC,
	Tenure_in_Months NUMERIC,	
	Value_Deal	VARCHAR(10),
	Phone_Service VARCHAR (5),
	Multiple_Lines	VARCHAR (5),
	Internet_Service VARCHAR (5),	
	Internet_Type	VARCHAR (20),
	Online_Security	VARCHAR (5),
	Online_Backup	VARCHAR (5),
	Device_Protection_Plan	VARCHAR (5),
	Premium_Support	VARCHAR (5),
	Streaming_TV	VARCHAR (5),
	Streaming_Movies	VARCHAR (5),
	Streaming_Music	VARCHAR (5),
	Unlimited_Data	VARCHAR (5),
	Contract	VARCHAR (20),
	Paperless_Billing VARCHAR (5),	
	Payment_Method	VARCHAR (20),
	Monthly_Charge	DECIMAL(10,2),
	Total_Charges	DECIMAL(10,2),
	Total_Refunds	DECIMAL (4,2),
	Total_Extra_Data_Charges	NUMERIC,
	Total_Long_Distance_Charges	DECIMAL(10,2),
	Total_Revenue DECIMAL(10,2),
	Customer_Status	VARCHAR(10),
	Churn_Category	VARCHAR(20),
	Churn_Reason VARCHAR(100)
);

--Inserting values from customer table to prod_churn table
INSERT INTO public.prod_churn (
    customer_id,
    Gender,
    Age,
    Married,
    State,
    Number_of_Referrals,
    Tenure_in_Months,
    Value_Deal,
    Phone_Service,
    Multiple_Lines,
    Internet_Service,
    Internet_Type,
    Online_Security,
    Online_Backup,
    Device_Protection_Plan,
    Premium_Support,
    Streaming_TV,
    Streaming_Movies,
    Streaming_Music,
    Unlimited_Data,
    Contract,
    Paperless_Billing,
    Payment_Method,
    Monthly_Charge,
    Total_Charges,
    Total_Refunds,
    Total_Extra_Data_Charges,
    Total_Long_Distance_Charges,
    Total_Revenue,
    Customer_Status,
    Churn_Category,
    Churn_Reason
)
SELECT 
    customer_id,
    Gender,
    Age,
    Married,
    State,
    Number_of_Referrals,
    Tenure_in_Months,
    COALESCE(Value_Deal, 'None'),
    Phone_Service,
    COALESCE(Multiple_Lines, 'No'),
    Internet_Service,
    COALESCE(Internet_Type, 'None'),
    COALESCE(Online_Security, 'No'),
    COALESCE(Online_Backup, 'No'),
    COALESCE(Device_Protection_Plan, 'No'),
    COALESCE(Premium_Support, 'No'),
    COALESCE(Streaming_TV, 'No'),
    COALESCE(Streaming_Movies, 'No'),
    COALESCE(Streaming_Music, 'No'),
    COALESCE(Unlimited_Data, 'No'),
    Contract,
    Paperless_Billing,
    Payment_Method,
    Monthly_Charge,
    Total_Charges,
    Total_Refunds,
    Total_Extra_Data_Charges,
    Total_Long_Distance_Charges,
    Total_Revenue,
    Customer_Status,
    COALESCE(Churn_Category, 'Others'),
    COALESCE(Churn_Reason, 'Others')
FROM public.customers;

select * FROM prod_churn;

--Creating views for Power BI

CREATE VIEW  vw_ChurnData AS
	SELECT * FROM prod_churn 
	WHERE customer_status IN ('Stayed','Churned');

CREATE VIEW  vw_JoinData AS
	SELECT * FROM prod_churn 
	WHERE customer_status IN ('Joined');
