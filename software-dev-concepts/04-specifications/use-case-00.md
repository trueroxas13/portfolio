- Name: Register User
- Description: Adds a new user to the system upon successful registration. A user may be a client or a seller.
- Primary actor: User (Client/Seller)
- Goal: Register a new user account.
- Triggers: User selects the register user button.
- Preconditions: The user is not logged in.
- Postconditions: The user is successfully registered in the system.
- Main scenario:
  1. The user selects the register user button.
  2. The user enters their email address. 
  3. The system checks if the address is already registered.
  4. If the user's email is not registered, the user is asked to input their password and other details.
  5. The user agrees to Terms of Service and hits the create account button. 
  6. The system sends a verification email to the user.
  7. Upon verification, the user's account is registered in the system.
- Extensions:
	- Alternative flow for 4
	  1. If the email is already registered, inform the user that they have an account registered in the system.
	  2. Show the user an option to recover their password (forgot password?)
	- Alternative flow for 5
	  1. If the user's entered DOB shows that the user is under 15, inform the user about the age restriction  
- Special requirements: The user must be 15+. The user's email must not be already registered in the system.