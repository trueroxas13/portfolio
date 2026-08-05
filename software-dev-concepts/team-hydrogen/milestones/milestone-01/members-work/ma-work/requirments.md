# Brainstorm

## Actors
* Finance section
* Penalty section 
* Registration section 
* Accident section
* Technical Section
(all these actors which manipulate / control parts of the system must be replaced by with an automated online system)
{that system we are devloping}

* Only one employee will manage the system as a system admin
* #### Actors (that won't be replaced)
* police
* user 
    * such as (Vehicle owners, insurance companies, and authorized workshops the police too but police have more control will get into later)


## use cases
* Registration / Re-new Registration 
    * extends Apply for Fitness Certificate 
* 

## conditions for each use case

|Actors|use case |condition| 
|:-|:- |:- |
|Veicle owner|Registraion/ Re-new Registration| must purchase / havean insurance policy from from an insurance company.
|Certificate workshop |Apply for fitness certificate|if the car is over 2 years old and must be from a workshop in qatar each crtificate valid for 1 vehicle |

## Notes for use cases 
|Use Case|Note|
|:-|:-
|Fitness Certificate  |Once the vehicle obtains a fitness certificate, the workshop submits it online to the iQVR system by entering the VIN and certificate number and attaching a copy of the certificate. (A workshop can make many certificates for many cars but each car 1 certificate)|

## Data Storages
* Of course everything recorded here is recorded by IQVR.
  
|Data store #|Name|Notes |
|:-|:-|:-|
|D1|Insurance Store|each time a user wants to reister a car or renew registraion he must have an insurance policy / 1 insurance policy for 1 each car the insurance policy must be registed with its VIN (Vehicle Identification Number) and company data after it will generates an acknowledgment receipt for the company.|
|D2|Workshop Certificate| The system stores this information along with the workshop data and generates an acknowledgment receipt for the workshop.



--------------------
### Notes (that i don't have a place for)
* all payments are computer based
* it seems for now we only have 3 actors
*the use case login (
    already developed dc about it ignore it 
    (It is assumed that users are already logged in by 
default, so login functionality does not need to be designed or developed by your team. )
)

