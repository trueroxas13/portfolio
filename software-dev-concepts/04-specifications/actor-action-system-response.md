
# use-case-00
## Register User

| Step | Actor Action                                                                                     | System Response                                                                                            |
| :--- | :----------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------- |
| 1    | User selects register account button.                                                            | System sends the user to the registration page.                                                            |
| 2    | The user enters their email address.                                                             | The system checks if an account with that address is registered.                                           |
| 3    | (if not registered)                                                                              | The user is asked to enter the other details.                                                              |
| 4    | (if registered)                                                                                  | The user is notified that the account already exists (shows forgot password option).                       |
| 5    | The user enters the required details and agrees to the Terms of Service, clicks register button. | The system checks user's age to make sure the user is above 15 and the required details have been entered. |
| 6    | (if user is above 15 and details entered)                                                        | The system sends a verification email to the user's registered email address.                              |
| 7    | (if user is under 15)                                                                            | The system notifies the user of the age restriction.                                                       |
| 8    | (if the user has missing details)                                                                | The system notifies the user about the missing details.                                                    |
| 9    | The user verifies their email address.                                                           | The system registers the user with the provided detail.                                                    |
# use-case-01
## Delete User

| Step | Actor Action                                            | System Response                                                                                   |
| :--- | :------------------------------------------------------ | :------------------------------------------------------------------------------------------------ |
| 1    | The user selects the delete account button.             | The system asks the user to enter their account password correctly twice.                         |
| 2    | The user enters their account password correctly twice. | The system sets the account to the deactivated state (if password is entered correctly).          |
| 3    | (if entered incorrectly 3 times)                        | The system locks the user out of the account and sends a warning email to the registered address. |
| 4    | (after 15 days of no login)                             | The system clears all user data and removes the account from itself.                              |
| 5    | (if user logs in within 15 days)                        | The system informs the user about the scheduled deletion.                                         |
| 6    | (if user selects cancel deletion)                       | The system sets the account to the active state and resets the deletion timer.                    |
| 7    | (if user selects cancel)                                | The system sends the user back to the login screen.                                               |
|      |                                                         |                                                                                                   |
|      |                                                         |                                                                                                   |
|      |                                                         |                                                                                                   |