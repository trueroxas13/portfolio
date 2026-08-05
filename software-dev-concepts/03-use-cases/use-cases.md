
## Register User

- ID: 00
- Description:
	- Add a new user to the system upon successful registration. A user may be a client or a seller.
- Actors: Client/Seller
- Event Flow:
	1. User provides email address.
	2. The system checks if the address is already registered.
		 - If user is already registered, informs the user to login instead.
	3. User provides the password for their account.
	4. User enters DOB and has to agree to the Terms of Service.
		- If user is under 15, informs user about the age restriction. 
	5. User's email address is sent a verification email.
	6. If verified, the user's account is made and registered in the system. Otherwise, nothing happens.   
- Special Requirements:
	- User must not be already registered.
	- User must be 15+.

## Delete User

- ID: 01
- Description:
	- Delete a user from the system. The user may be a client or a seller. The user has 15 days to recover their account before permanent deletion.
- Actors: Client/Seller
- Event Flow:
	1. The user selects the delete user option.
	2. The user is asked to enter their password twice.
		- If the user fails to enter the correct password, informs the user about incorrect password.
	3. The user is informed about the 15 day reactivation period and the account goes into the deactivated state.
	4. The account is deleted from the system after the 15 days time period.
- Special Requirements:
	- The user must be registered and logged in.

## List Goods

- ID: 02
- Description:
	- The seller puts up an item in the market for sale. The item has a quantity and a price.
- Actors: Seller
- Event Flow:
	1. The user selects the option to list a product.
	2. The user is asked to enter the details of the product (name, quantity, images, description, price, delivery options...).
		- If the user does not provide the necessary details, ask the user to enter the missing details appropriately. Do not allow the user to proceed until the required fields are filled.
	3. The listed product is inspected by the system.
	4. When verified, the item is available on the market for clients to purchase.
- Special Requirements:
	- The user must be registered and logged in.

## Search Goods

- ID: 03
- Description:
	- The user searches for products that they are looking for in the marketplace.
- Actors: Client
- Event Flow:
	1. The user enters the keywords in the search bar.
		- The user may use filters to further narrow their search results.
	2. Upon hitting the search button, the system provides the user with the results that meet the keyword and filter requirements of the user.
		- If there are no products that match the requirements, the user is notified that there are no results.
- Special Requirements:
	- The user must enter keywords or use the search filter option.

## Register for Membership

- ID: 04
- Description:
	- The user subscribes to a membership tier. The user may be a client or a seller.
- Actors: Client/Seller
- Event Flow:
	1. The user selects their preferred subscription plan.
		- If the user is already subscribed to a subscription plan that is different from their currently selected plan, inform them of cancelling their current subscription. If user selects yes, invoke the "Remove Membership" use case.
		- If the user is already subscribed to the selected subscription plan, inform them of the option of renewing their membership. If the user selects yes, invoke the "Renew Membership" use case.
	2. The user enters their payment details, which are then verified by the system.
		- If the verification fails, inform the user about the invalid payment details.
	3. When payment is successful, the user is updated to have the membership benefits applied to their account.
- Special Requirements:
	- The user is not subscribed to a subscription plan.

## Make Payment

- ID: 05
- Description:
	- The user makes the required payment. The user has to select a payment method, which is then verified.
- Actors:
- Event Flow:
	1. The user selects a payment method.
		- The method can be by card (credit or debit), or by PayPal.
	1. The user enters the payment details.
	2. The user's payment details are verified by the system and the transaction takes place.
- Special Requirements:
	- The user must have an item in the cart (for membership subscriptions, a "subscription item" is added to a temporary cart by the system).
