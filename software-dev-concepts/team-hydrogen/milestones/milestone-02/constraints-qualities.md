# Constraints and Requirements

## Constraints
1. External Systems Integration:
   *  iQVR system must interact with the following:
   1. Vehicle Manufacturer (for specifications and verifications)  
   2. qPay (Payment processes for all processes e.g: purchases or salaries)
   3. Insurance Companies (policy validation)
   4. Authentication (users already logged in)
   5. QTS (import checks)
2. Registration / renew registration constraints:
    1. Must have insurance policy to register or renew vehicle registration.(each policy is valid for only one vehicle.)
    2. fitness certificate froman authorized workshop in Qatar required for all vehicles which have been registered for 2 years or used for 2 years. (used for 2 years means it's been purchased 2 years ago not necessarily have been using it for 2 years we can't really tell that info of course.) (Each fitness certificate is valid for one vehicle)
    3. All unpaid fines must be paid for a renewal of registration for the vehicle.

3. Portability Constraints:
    1. Portability (IQVR should function on multiple devices)
4. Maintenance Constraints:
    1. Upgradability (Functions might end up needing upgrades in the future)
5. Usability Constraints:
    1. Administrator liberty (One admin is only needed to manage the entire system)
    2. End-User liberty (System must provide functionality for vehicle owners, insurers, workshops, and traffic police.)
6. Technical Constraints:
    1. Initially the system will have to handle 10 million vehicles, with future plans to scale up to 30 million.
    2. Must be developed on java and C according to department’s staff expertise.
    3. Oracle must be used for database management.
7. Legal and Confidentiality Constraints:
    1. Sensitive vehicle and ownership data must be confidential.
    2. Adherence to Qatar's data security and privacy regulations.
8. Process Constraints:
    1. Process dependencies (Confirmation from independent systems and services which are in contact with IQVR are necessary for a processes completion.)
    2. All Acknowledgment receipts generated or recieved for all transactions should be stored.
9. Transfering a registered vehicle
    * All outstanding bills must be paid for the transfer process to commence.
## Requirements 
1. Vehicle owners can:
    1. Register and renew registration for new and old vehicles.
    2. Support the transfer of ownership for vehicles in both registered and unregistered states for the vehicle.
    3. When reporting accidents one vehicle owner should accept responsibility of being wrong.
    4. No accident disputes will bw resolved on IQVR, in case of dispute they must go to a police station.
    5. Payment of all kinds must be done online.
    6. Can select which fines to pay if there are any.
   
2. Traffic police must be able to:
    1. Issue confiscation orders for traffic violations for vehicles that exceed a certain number of red-light offences during a selected period.
3. Athorized workshops must be able to:
    1. Provide fitness certificates for vehicles.
4. Insurance companies should be able to:
    1. Submit comprehensive insurance policy details, including the Vehicle Identification Number (VIN).
5. Integration with external systems must allow:
    1. Manufactures shall provide VIN confirmation and details foe vehicles when requested to do so.
    2. Verify vehicle ownership through Qatar Trade Service.
6. System/Application access:
    1. Only to signed up users (vehicle owners, insurance companies, workshops)
7. User info within the system:
    * The system should keep record of the following:
        1. Registration details of each vehicle.
        2. Models and the make of each vehicle.
        3. Previous and current owners of each vehicle such as their name.
        4. QID.
        5. address
        6. Insurance policy and fitness certificate of every registered vehicle.
        7. authorized workshops details.
        8. previous and current owners of each vehicle.
        9. Invoice information.
        10. Fines and traffic offences.
        11. Accident details if any.
   

## Non-Functional Requirements (NFR)
1. Performance:
    1. High Availability (should be avaliable at all times (assuming it is supported by backup modules))
    2. Response Time (System response time to handling any processes should be quick (i.e: should process payments under 10 seconds))
    3. Concurrent Users (System should be able to support many users at a time (10 million in our case))
2. Maintainability:
    1. Documentation (Maintain comprehensive documentation for all modules.)
3. Reliable System:
    1. Error Handling (must help the users in case of failures in any operation. e.g: "Pay the bills first")
    2. Backup and Recovery (Daily backups with disaster recovery)
4. Compliance Requirements:
    1. Legal Compliance (The system must comply with Qatar's legal framework for data and vehicles.)
5. Security
    1. Audit Logs (Log all operations with timestamps for auditing.)
    2. Encryption (Encrypt any sensitive data e.g: user credentials)
    3.  Authentication and Authorization (Depending on the users role they'll have specific features. e.g: features of a vehicle owner will be different from the features of a workshop)
6. Usability 
    1. User friendly
    2. Cross platform (Compatibility with a wide range of browsers or phones)


## Additional Constraints 
1. No cross System Dependency (IQVR should run the same on every system it is on in order to be at it's best at every system and avoid third party failure e.g: [need an example])
2. Language Constraint (The application should be able to support english and arabic the 2 commonly spoken languages in qatar)

## Additional NFR

1. Accessibility (must accommodate users with disabilities)

