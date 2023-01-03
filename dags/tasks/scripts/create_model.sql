CREATE OR REPLACE MODEL {{MODEL_NAME}}
OPTIONS (
    model_type = 'BOOSTED_TREE_CLASSIFIER',
    NUM_PARALLEL_TREE = 6,
    MAX_ITERATIONS = 50,
    input_label_cols=['TX_FRAUD']
) AS 
    SELECT
        TX_AMOUNT,
        TX_DURING_WEEKEND,
        TX_DURING_NIGHT,
        CUSTOMER_ID_NB_TX_1DAY_WINDOW,
        CUSTOMER_ID_AVG_AMOUNT_1DAY_WINDOW,
        CUSTOMER_ID_NB_TX_7DAY_WINDOW,
        CUSTOMER_ID_AVG_AMOUNT_7DAY_WINDOW,
        CUSTOMER_ID_NB_TX_30DAY_WINDOW,
        CUSTOMER_ID_AVG_AMOUNT_30DAY_WINDOW,
        TERMINAL_ID_NB_TX_1DAY_WINDOW,
        TERMINAL_ID_RISK_1DAY_WINDOW,
        TERMINAL_ID_NB_TX_7DAY_WINDOW,
        TERMINAL_ID_RISK_7DAY_WINDOW,
        TERMINAL_ID_NB_TX_30DAY_WINDOW,
        TERMINAL_ID_RISK_30DAY_WINDOW
    FROM
        {{DATASET_IN}}.{{TABLE_FEATURES}}
