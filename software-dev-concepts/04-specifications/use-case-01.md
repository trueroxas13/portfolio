- Name: Delete User
- Description: Delete a user from the system. The user may be a client or a seller. The user has 15 days to recover their account before permanent deletion.
- Primary actor: User (Client/Seller)
- Goal: Deletion of the logged in user's account from the system.
- Triggers: The user selects the delete account button.
- Preconditions: The user is logged in.
- Postconditions: The user's account is removed from the system.
- Main scenario:
  1. The user selects the delete account button.
  2. The user is asked to enter their password twice.
  3. If the user enters the password correctly both times, they are informed of the 15 day reactivation period.
  4. The user's account is set to the deactivated state by the system.
  5. If the user does not log in for 15 days, the system deletes all user data and removes the user account from itself.
- Extensions:
	- Alternative flow for 3
	  1. If the user does not enter the correct password, ask the user to enter the password again.
	  2. If the user enters the password wrongly three times, the user is locked out of the account and a warning email is sent to the registered user's address. 
	- Alternative flow for 5
	  1. If the user logs into the account within the 15 day time period, the user is shown a pop up that reminds them that the account is scheduled for deletion.
	  2. If the user selects the cancel deletion prompt, the user gains back the access to their account.
	  3. The account is set to the active state by the system.
	  4. The deletion time limit on the account is reset by the system.
- Special requirements: The user must be registered and logged in.