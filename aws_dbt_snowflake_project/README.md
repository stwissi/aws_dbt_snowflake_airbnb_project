# Airbnb dbt Snowflake Project

This dbt project transforms raw Airbnb data (listings, bookings, and hosts) into an analytics-ready dimensional model using Snowflake.

## Project Architecture

The project follows the medallion architecture (Bronze -> Silver -> Gold) to progressively clean and structure the data:

*   **Sources**: Connects to the raw `AIRBNB` staging database in Snowflake containing `listings`, `bookings`, and `hosts`.
*   **Bronze Layer**: Incremental models that load data straight from the raw staging layer.
*   **Silver Layer**: Cleanses and standardizes the data. It adds calculated columns like `total_amount` for bookings, categorizes host response qualities, and generates pricing tags.
*   **Gold Layer**: The final analytics layer consisting of:
    *   **Fact and OBT**: A star-schema `fact` table and a flattened One Big Table (`obt`) to make reporting seamless.
    *   **Snapshots**: Slowly Changing Dimension (SCD) Type 2 tables (`dim_listings`, `dim_hosts`, `dim_bookings`) tracking historical changes.
    *   **Ephemeral Models**: Reusable intermediate CTEs.
*   **Macros**: Custom macros to simplify logic, including `multiply` for calculating fees, `tag` for categorizing prices, and `trimmer` for cleaning strings.

## Running the Project

### Prerequisites
*   You need to have **dbt-core** and **dbt-snowflake** installed.
*   Your `profiles.yml` should be configured to point to your Snowflake account.

### Common Commands

1.  **Install dependencies** (if using any packages):
    ```bash
    dbt deps
    ```

2.  **Run all models** (builds the bronze, silver, and gold layers):
    ```bash
    dbt run
    ```

3.  **Run tests** (runs the unique and not_null tests defined in the `schema.yml` files):
    ```bash
    dbt test
    ```

4.  **Update Snapshots**:
    ```bash
    dbt snapshot
    ```

5.  **Generate Documentation**:
    ```bash
    dbt docs generate
    dbt docs serve
    ```

## Resources

*   Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
*   Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
*   Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
