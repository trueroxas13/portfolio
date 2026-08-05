
# iQVR Online System Requirements

## 1. Functional Requirements (FRs)

1. **User Authentication and Access Control:**  
   - Users (vehicle owners, insurance companies, workshops) need login credentials to access the system.
   - Access control: Only authorized workshops can submit fitness certificates, and only traffic police can create confiscation orders.

2. **Insurance Policy Management:**  
   - Insurance companies must input vehicle insurance details (VIN and policy).
   - A vehicle can have only one active insurance policy.

3. **Vehicle Registration and Renewal:**  
   - Vehicle registration requires:
     - Insurance policy submission.
     - Fitness certificate submission (if the vehicle is over two years old).
   - The system generates invoices for registration and renewal fees and prepares registration stickers.

4. **Ownership Transfer:**  
   - **New vehicle transfer**: Verify the VIN and car details through the manufacturer’s system and Qatar Trade Service.
   - **Registered vehicle transfer**: Ensure no unpaid dues before initiating the transfer.
   - Record new owner’s details and update ownership records.

5. **Accident Reporting:**  
   - Owners of involved vehicles can report accidents online.
   - System stores accident details (e.g., VINs, date, time, description) and sends the report to the offending vehicle's insurance company.
   - Accident reports are available to both parties and authorized workshops.

6. **Payment Handling and Integration with qPay:**  
   - Retrieve unpaid invoices and fines.
   - Forward credit card details to qPay for approval.
   - Mark invoices as paid once payment is successful.

7. **Penalty Management:**  
   - Traffic police can search and retrieve a list of vehicles with red-light offences within specific periods.
   - Generate confiscation orders and broadcast them to police departments.

8. **Vehicle Data Management:**  
   - Store and manage data on registration details, ownership, insurance policies, fitness certificates, accidents, and penalties.
   - Ensure each vehicle’s data is linked to the correct owner, insurance policy, and certificates.

9. **System Notifications:**  
   - Send notifications to vehicle owners regarding registration status, fines, and confiscation orders.

---

## 2. Non-Functional Requirements (NFRs)

1. **Performance and Scalability:**  
   - System must initially handle **10 million vehicles** but should scale to **30 million vehicles** within 10 years.
   - The system should handle multiple concurrent users and transactions efficiently.

2. **Availability and Reliability:**  
   - Ensure high availability with minimal downtime by implementing **backup modules**.
   - System should be available to users most of the time.

3. **Security and Data Protection:**  
   - Core data (e.g., vehicle ownership and personal information) must remain **confidential** and protected from unauthorized access.
   - System must use **encryption** for sensitive data (e.g., credit card information).

4. **Portability:**  
   - The system should be **platform-independent** and work on desktops, tablets, and mobile devices.

5. **Maintainability and Extensibility:**  
   - System components should be **modular** to support upgrades, modifications, and the addition of new functionalities without affecting the rest of the system.
   - The system should be designed for **distributed deployment** across multiple machines if needed in the future.

6. **Compatibility:**  
   - Must integrate seamlessly with the **existing qPay system** for payment processing.
   - Oracle database system must be used for data management, as the existing technical team is familiar with it.
   - Functions must be developed using **Java and C**, leveraging the department’s staff expertise.

7. **Resource Constraints:**  
   - Limited to **10 technical staff** and **20 new servers**.
   - System development must be completed in **three months** to meet the project timeline.

8. **User Interface Design:**  
   - The interface should be **user-friendly** and provide clear error messages (e.g., “Incorrect vehicle information,” “Pay the bills first”).

9. **Fault Tolerance:**  
   - The system should gracefully handle external system failures (e.g., manufacturer’s system or Qatar Trade Service) by providing appropriate error messages.

10. **Deadline and Project Delivery:**  
   - The system must be ready within **12 months** to avoid financial penalties for the traffic department.
