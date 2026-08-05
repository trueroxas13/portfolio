
- two main types of goods, physical and virtual
- purchase goods (must be a registered user)
- sell goods (must be a registered user)
- user accounts that must include name, address, contact...; they should have unique identifiers
- if user does not have an account, generate an identifier for them
- user accounts can have stored balance - gift cards implementation (assumption)
- financial management for users to keep track of their finances
- transaction management for users to keep track of their transactions
- user memberships that include benefits like discounts, early access...; dependent on membership level - based on client's engagement
- user memberships will have tiers, higher tiers offer better rewards
- goods listing on the marketplace (can have fixed prices or an auction format)
- sellers should be able to run promotions/limited time deals
- a delivery set up system for physical goods
- a delivery tracking system for physical goods
- a marketplace where users can search for goods
- a filtering system for goods based on type (virtual/physical, sub-genres...)
- a cart system where users can add both virtual and physical items to cart (for physical items, a delivery should be set up upon purchasing - assumption)
- a payment monitoring system (penalties for late payments...)
- a transaction history system to keep track of past purchases
- Verse members have priority for customer support
- security system for user data to protect their crucial information (card details, address...)
- backend to manage user data (Tesseract)

## Functional vs. Non-functional

| Requirement                                                   | Type           |
| :------------------------------------------------------------ | :------------- |
| good types: physical and virtual                              | functional     |
| purchase goods from sellers                                   | functional     |
| sell goods to clients                                         | functional     |
| list goods for sale                                           | functional     |
| user membership for rewards                                   | functional     |
| user accounts for user details                                | functional     |
| user identifier to manage transactions                        | functional     |
| delivery setup for physical goods                             | functional     |
| delivery tracking for physical goods                          | functional     |
| marketplace to see listed goods                               | functional     |
| cart to purchase multiple goods simultaneously                | functional     |
| search filter to filter out goods                             | functional     |
| payment monitoring to ensure payment in time                  | functional     |
| transaction history to view past transactions                 | functional     |
| user data security to prevent data leaks                      | functional     |
| transaction management to keep track of a transaction process | functional     |
| financial management to manage user stored funds              | functional     |
| cannot list illegal goods                                     | non-functional |
| UI must feel intuitive                                        | non-functional |
| UI must be able to switch between light and dark themes       | functional     |
| sellers can run promotions                                    | functional     |
| sellers can run no more than two promotions                   | non-functional |
| fixed prices and auction-based prices for listed products     | functional     |
| Tesseract for backend                                         | functional     |
| UI must have fluid animations (assumption)                    | non-functional |
| customer support setup for users (assumption)                 | functional     |
| a ticket system for customer support - one ticket per user    | non-functional |
