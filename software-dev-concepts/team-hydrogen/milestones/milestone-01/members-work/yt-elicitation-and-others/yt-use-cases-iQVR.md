### Candidate Actors
- Vehicle Owners
- Insurance Company
- Authorized Workshop
- Vehicle
- Vehicle Manufacturer
- Qatar Trade Service (QTS)
- Police
- qPay
- ...
### Candidate Use Cases
1. **register vehicle**
	- precondition: insurance policy exists
2. **purchase insurance policy**
3. **obtain fitness certificate**
5. **transfer ownership**
	- of an **unregistered** vehicle
		1. verify Vehicle specifications
			- If the manufacturer confirms the information, the iQVR system requests the current owner’s name and QID. – normal day scenario
			- If the manufacturer’s response is negative, the system terminates the session with the message “Incorrect vehicle information.” – alternative flow
		2. check vehicle import
			- If the response is positive, the system then retrieves the insurance policy for the vehicle, which was previously submitted by the insurance company. 
			- If the response is negative, the system terminates the session with the message “Incorrect ownership.”
		3. <<include: register a new vehicle>>
		4. transfer ownership:
			- designate the current owner as the previous owner and the new owner as the current owner. 
			- **confirm ownership transfer by** *generating a new registration sticker* and *creating an invoice for the transfer fee*, which the new owner will pay later
	- of a **registered** vehicle
		-  current owner enters the VIN of the registered vehicle and his QID number.
			- **If the retrieved information does not match the provided data**, the system terminates the session with the message “Incorrect Information.” – alternative flow
			- Otherwise, it initiates the transfer process.
				- check for any unpaid invoices (bills) for registration fees or traffic fines.
					- **If there are any unpaid bills**,
						- terminate the session with the message “Pay the bills first.” 
					- **If there are no unpaid dues**
						- request the new owner’s details.
							- The current owner provides the name, QID, and mobile phone number of the new owner.
							- The system then assigns the vehicle to the new owner, designates the current owner as the previous owner and the new owner as the current owner.
							- The system confirms the ownership transfer by generating a new registration sticker and creating an invoice for the transfer fee.
6. **renew registered vehicle**
	- if over two years old; i.e the vehicle is renewable only if it is over 2 years old
		- find the vehicle fitness certificate
			- if not averrable terminate
		- retrieves the compulsory insurance policy
			- if not averrable terminate
		- check for any unpaid fines for traffic offenses
			- if unpaid ask the owner to pay the fine(s) with the message “Pay the bill first.”
		- <<include: register vehicle>> create a new registration with the same validation period as specified in the new insurance policy
		- attach insurance policy and the fitness certificate to the vehicle's registration
		- prepare a new registration sticker with new validity
		- create an invoice
7. **register accident**
	-  if a vehicle accepts that it was their fault
		- offending vehicle enters the VINs of theirs and the other vehicle
		- enter date, time, location, accident description
			- the vehicle that entered all information is the offending vehicle’s owner
		- offending vehicle to confirms accident
			- store
		- create an accident report using insurance policy of the offending vehicle
		- send accident report to the insurance company
		- insurance company sends an acknowledgment receipt
			- stored.
	- if there is a dispute
		- no online reporting is allowed
		- parties must go to a police station to solve the dispute
		- Vehicle owners can pay any unpaid invoices or fines for a vehicle using a credit card
			- To pay, the owner provides the VIN, and credit card details such as number, name of the cardholder, and validity.
				- The system retrieves the vehicle registration details. 
				- If the registration details do not exist, the system displays an error message and asks to enter the correct VIN.
			- The system then lists unpaid invoice(s), if there are any. 
			- The owner then selects which of the invoices and fines they want to pay.
		- <<include: pay invoice>> 
8. **pay charges**
	- charges: **invoices, fines, and traffic offenses**
	- compute total amount
	- forward card details and total amount to qPay for approval
	- qPay checks for the card’s validity by contacting the credit card provider (bank)
		- If the card is invalid
			- qPay generates an error message to iQVR without payment processing
		- Otherwise
			- qPay returns an approval advice to iQVR
			- For invalid credit cards, iQVR asks the owner to enter valid credit card details
			- record the approval number and outcome sent by qPay
			- prepare a payment receipt, and sets the invoice(s) as paid
			- update the list of the unpaid invoices associated with the vehicle
9. **issue confiscation order**
	- police can determine which vehicle has how many offenses based on certain criteria,
	- find a list of vehicles that match these criteria and police select them
	- create a confiscating order for those vehicles
		- ask for confirmation from police
		- saves the confirmation
		- cancel the registration of those vehicles
		- inform the owner of each vehicle
		- owner receives the order. 
		- broadcast the orders to all police departments
