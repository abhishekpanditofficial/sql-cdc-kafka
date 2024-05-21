# Project Overview

This project streams Change Data Capture (CDC) events from a Microsoft SQL Server to a Kafka topic using a Kafka Connect plugin called Debezium. Additionally, it launches a NestJS server configured with a Kafka consumer to process events received from Debezium.

# Prerequisite

* Install Docker

# Setting Up SQL Database

Setting up the SQL database involves several steps to ensure proper configuration for Change Data Capture (CDC) functionality:

1. **Enable CDC**:
   
    **Enable CDC on the Database:**
    - Connect to your SQL Server instance using SQL Server Management Studio (SSMS).
    - Execute the following SQL command to enable CDC on the database:
      ```sql
      USE YourDatabaseName;
      GO
      EXEC sys.sp_cdc_enable_db;
      GO
      ```

    **Enable CDC on Specific Tables:**
    - Execute the following SQL command for each table you want to enable CDC on:
      ```sql
      USE YourDatabaseName;
      GO
      EXEC sys.sp_cdc_enable_table
          @source_schema = N'dbo',
          @source_name = N'YourTableName',
          @role_name = NULL,
          @supports_net_changes = 0;
      GO
      ```

2. **Enable SA Account using SSMS**:

    **Using SQL Server Management Studio (SSMS)**:
    - Launch SSMS and connect to your SQL Server instance.
    - Expand the "Security" node in Object Explorer.
    - Right-click on the "Logins" folder and select "New Login..."
    - In the "Login - New" dialog, enter 'sa' for the login name, select the authentication method, and set the password.
    - Click "OK" to create the SA account.

3. **Restart the MSSQL Server using SQL Configuration Manager**:

    **Using SQL Server Configuration Manager**:
    - Open SQL Server Configuration Manager.
    - Expand the "SQL Server Services" node.
    - Right-click on your SQL Server instance and select "Restart".

4. **Turn On SQL Server Agent using SQL Configuration Manager**:

    **Using SQL Server Configuration Manager**:
    - Open SQL Server Configuration Manager.
    - Click on "SQL Server Services".
    - Right-click on "SQL Server Agent" and select "Properties".
    - In the "SQL Server Agent Properties" window, set the "Startup type" to "Automatic".
    - Click "OK" to save the changes.
    - Right-click on "SQL Server Agent" again and select "Start" to start the service.


# Installation Guide

Follow these steps to install and run the project:

1. **Grant Execution Permissions**: Make the start.sh and stop.sh scripts executable by running the following commands:
   ```
   chmod +x start.sh && chmod +x stop.sh
   ```

2. **Update Configuration**: Update the credentials in the config.json file with your SQL database credentials.

3. **Start the Script**: Execute the start.sh script to begin the project:
   ```
   ./start.sh
   ```

4. **Stop the Script**: Execute the stop.sh script to stop the project:
   ```
   ./stop.sh
   ```

These instructions will help you set up and run the project successfully, ensuring that CDC events are streamed from your SQL database to the Kafka topic, and the NestJS server is ready to consume and process these events.
