# Brainstorm


* ## Actors 
* traffic police
* user 
* Workshop (who generate certificates)
* Qatar Trade Service
* qPay (maybe)
    The qPay checks for the card's validity by contacting the credit card provider (bank).
   


## use cases
* Registration / Re-new Registration 
    * extends Apply for Fitness Certificate 
* Transfer Ownership of vehicle
* Check imported vehicle (included by Transfer Ownership of unregistered vehicle )
* renew a registered vehicle
* Report Accident (also extends a report to the insurance company)
* Admit fault (extended in Accident)
* Dispute Accident (extended in Accident)
* pay invoice (it should be extended by other use cases (i forgot which))
* Traffic police reviews red-light offences
* confiscating order (extend by Traffic police reviews red-light offences)


### conditions for each use case

|Actors|use case |condition| 
|:-|:- |:- |
|Vehicle owner|Registraion/ Re-new Registration| must purchase / havean insurance policy from from an insurance company.
|Get Certificate workshop |Apply for fitness certificate|if the car is over 2 years old and must be from a workshop in qatar each crtificate valid for 1 vehicle |
|Vehicle owner|Transfer Ownership of vehicle | If a vehicle is new, the current owner enters its VIN, make, model, and year, which the system  Ownership details are updated, a new registration sticker is issued, and an invoice for the transfer fee is created for the new owner.
|IQVR admin and  Qatar Trade Service|Check imported vehicle|
|Vehicle owner|renew Insurance policy for (registed vehicle)| extended after renewing a car which has it's owner changed
||check registered|used by both Transfer Ownership of vehicle and renew Insurance policy
|Vehicle owner|renew a registered vehicle|The system then prepares a new registration sticker with new validity. It finally creates an invoice for the registration renewal. 
|Vehicle owner|Report Accident|
|Vehicle owner|Dispute Accident|if there is a dispute regarding an accident, no online reporting is allowed. Both parties must go to a police station to solve the dispute.  
|police|Traffic police reviews red-light offences|The traffic police officer enters the time period (day, week, month) and selects the red-light offence type.
|police|confiscating order (Traffic police reviews red-light offences extends it)|It saves the confirmation, cancels the registration of those vehicles, and informs the owner of each vehicle. The owner receives the order. The system then broadcasts the orders to all police departments. A confiscating order is attached with only one vehicle; however, one can get more than one order. 




### Notes for use cases 
|Use Case|Note|
|:-|:-
|Fitness Certificate  |Once the vehicle obtains a fitness certificate, the workshop submits it online to the iQVR system by entering the VIN and certificate number and attaching a copy of the certificate. (A workshop can make many certificates for many cars but each car 1 certificate)|


---


## System functions

|Function|details
|:-|:-
|checks for any unpaid invoices| this method is a part of the use case Transfer Ownership of vehicle and is if the vehicle is already registered . If there are any unpaid bills, the system terminates the session with the message “Pay the bills first”. 
|checks if over 2 years old| this method is a part of the use case renew a registered vehicle and Registraion


---


## DFD

### External Entities
* manufacturer database
* Qatar Trade Service
### Processes 

### Data Storages
* Of course everything recorded here is recorded by IQVR.
  
|Data store #|Name|Notes |
|:-|:-|:-|
|D1|Insurance Store|each time a user wants to reister a car or renew registraion he must have an insurance policy / 1 insurance policy for 1 each car the insurance policy must be registed with its VIN (Vehicle Identification Number) and company data after it will generates an acknowledgment receipt for the company.|
|D2|Workshop Certificate| The system stores this information along with the workshop data and generates an acknowledgment receipt for the workshop.
|D3|Accidents Reports|Any authorized workshop can retrieve the accident report if the case number is known.The iQVR system then sends the accident report to the insurance company, which immediately sends an acknowledgement receipt saved by the iQVR system. The accident report is then stored and available for both parties (owners of the offending and victimvehicles) to retrieve at any time.
|D4|Registraion details|The system retrieves the vehicle registration details. If the registration details in pay invoice
|D5|(can't come up with a name) The iQVR system records the outcome sent by qPay (in pay invoice use case)|
|D6|Traffic Offences|Contains records of red-light offences, dates, and the number of offences per vehicle.



--- 

## UML Class
### multiplicities
* 1 vehicle 1 owner
1 Owner many vehicles
* 1 Vehicle owner can have 0 or many orders
each order is for one vehicle owner
--------------------
### Notes (that i don't have a place for) 
## (i recommend  you don't read this now)
* all payments are computer based
* it seems for now we only have 3 actors
*the use case login (
    already developed dc about it ignore it 
    (It is assumed that users are already logged in by 
default, so login functionality does not need to be designed or developed by your team. )
)

* for use case Transfer Ownership of vehicle
    * in details: 
      * for unregistered vehicles in IQVR:
            if the vehicle is new (no previous registraions) the current owner will have to enter the (VIN, vehicle make, model, and year of manufacture into the system) the system then will verify the vehicle info by giving the VIN to manufacturer database if the info is confirmed by manufacturer database. If the response is negative system terminates session with message “Incorrect vehicle information” if the response is positive system requests the current owner’s name and QID.
            Next, the iQVR system communicates with another system run by Qatar Trade Service, using 
            the VIN and QID of the current owner, to check if the owner imported the vehicle from 
            overseas. 
            Qatar Trade Service checks its records and provides a response to iQVR. If the 
            response is positive, the system then retrieves the insurance policy for the vehicle, which was 
            previously submitted by the insurance company. 
            If the response is negative, the system terminates the session with the message “Incorrect ownership.” 
            If the insurance policy exists, the system generates a registration number for the vehicle, assigns it to the vehicle, and displays the number to the owner.
            The current owner then provides the name, QID, address, and mobile phone number of the new owner. The system records these details and assigns the vehicle to the new owner. 
            It designates the current owner as the ‘previous owner’ and the new owner as the ‘current owner’. 
            The system then confirms the ownership transfer by generating a new registration sticker and creating an invoice for the transfer fee, which the new owner will pay later.
        * for registered vehicles in IQVR:
            to transfer a registered vehicle to another person, the current owner enters the VIN 
            of the registered vehicle and the QID number of the current owner. The system first retrieves 
            the registration details of the vehicle. If the retrieved information does not match the provided 
            data, the system terminates the session with the message “Incorrect Information”. Otherwise, 
            it initiates the transfer process. The system checks for any unpaid invoices (bills) for 
            registration fees or traffic fines. If there are any unpaid bills, the system terminates the session 
            with the message “Pay the bills first”. The payment procedure is explained later. If there are 
            no unpaid dues, the system requests the new owner's details. The current owner provides the 
            name, QID, and mobile phone number of the new owner. The system then assigns the vehicle 
            to the new owner, designates the current owner as the ‘previous owner’ and the new owner as 
            the ‘current owner’. The insurance policy assigned to the vehicle during the last registration 
            remains unchanged; however, the new owner can update the insurance policy later. The 
            system confirms the ownership transfer by generating a new registration sticker and creating 
            an invoice for the transfer fee.  
            (it should extend renew insurance policy)
* use case renew a registered vehicle in details:
        To renew a registered vehicle, the vehicle owner enters the VIN into the system.  It retrieves 
        the registration details and checks if the vehicle is over two years old.  If it is, the system finds 
        the vehicle fitness certificate issued by an authorized workshop.  The system terminates with 
        a message “Get fitness certificate first” if the fitness certificate is not available.  If the 
        certificate exists, it retrieves the compulsory insurance policy of the vehicle issued by an 
        insurance company.  If a new insurance policy is available, the system checks for any unpaid 
        fines for traffic offences; otherwise, terminate the system with the message “Get insurance 
        policy”.  If there is any unpaid fine(s), it asks the owner to pay the fine(s) with the message 
        “Pay the bill first’’.  If there are no unpaid fines (s), the system creates a new registration with 
        the same validation period as specified in the new insurance policy.  The insurance policy and 
        the fitness certificate are then attached concurrently with the vehicle registration. The system 
        then prepares a new registration sticker with new validity. It finally creates an invoice for the 
        registration renewal. 

* use case Report Accident details:
    For an accident between only two vehicles, if a vehicle accepts that it was his/her fault, he/she 
    enters VINs of his/her and the other vehicle (victim). The system finds vehicle details and 
    registration information for both vehicles. The system then asks to provide the date, time, 
    location, and a brief accident description. The system records this information, and by default, 
    it sets that the vehicle that entered all information is the offending vehicle’s owner. The other 
    vehicle is the victim of the accident.  The system asks the owner of the offending vehicle to 
    confirm this. Once confirmed, the system stores this. The system then concurrently finds the 
    insurance policy of the offending vehicle and creates an accident report with a unique case 
    number.  The iQVR system then sends the accident report to the insurance company, which 
    immediately sends an acknowledgement receipt saved by the iQVR system. The accident 
    report is then stored and available for both parties (owners of the offending and victimvehicles) to retrieve at any time.


* use case Pay Invoice:
    Vehicle owners can pay any unpaid invoices or fines for a vehicle using a credit card. To pay, 
    the owner provides the VIN, and credit card details such as number, name of the cardholder, and 
    validity. The system retrieves the vehicle registration details. If the registration details do not exist, 
    the system displays an error message and asks to enter the correct VIN. Otherwise, it lists unpaid 
    invoice(s), if there are any.  The owner then selects which of the invoices and fines he/she wants 
    to pay.  The system saves the selection, computes the total amount, and then forwards the card 
    details and the total amount to the qPay system for approval. qPay is a separate software system 
    but owned by the OVR department. The qPay checks for the card's validity by contacting the 
    credit card provider (bank). If the card is invalid, it generates an error message to iQVR without 
    payment processing. Otherwise, qPay returns an approval advice to iQVR. For invalid credit 
    cards, iQVR asks the owner to enter valid credit card details. The iQVR system records the 
    outcome sent by qPay. It then concurrently records the approval number, prepares a payment 
    receipt, and sets the invoice(s) as paid. It then displays the receipt. Finally, the system updates the 
    list of the unpaid invoices associated with the vehicle. 


* external entity:
    * manufacturer database,Qatar Trade Service

(This info is prolly not important and i will proabably filter out later)
* Finance section
* Penalty section 
* Registration section 
* Accident section
* Technical Section
(all these actors which manipulate / control parts of the system must be replaced by with one admin to control the automated online system)
{"the automated online system" that's the system we are devloping}

* Only one employee will manage the system as a system admin



* what the System should know:
The system knows the registration details of vehicles, models and the make of each vehicle; 
previous and current owners of each vehicle such as their name, QID, and address. It also 
knows the insurance policy of every registered vehicle, such as policy number, validity, and 
the name of the contact details of the issuing company of the policy. A company can sell 
many insurance policies. The system also stores information about the fitness certificate of 
each registered vehicle and the details of the workshop that issued the certificate. It keeps 
information about the invoices, fines, traffic offences and the involved vehicles. The system 
knows the details of each accident, such as the date, time of the accident, and the involved 
vehicles.
* what the system doesn't know:
it does not record any information about the traffic police except their 
login data.  The system keeps records of all acknowledgements and responses that it receives 
from external systems. 
