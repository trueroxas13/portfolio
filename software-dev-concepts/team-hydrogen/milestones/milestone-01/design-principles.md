This document document demonstrates how design principles were applied in our UML class diagram.
### Assigning Responsibilities & High Cohesion
- The design imposes cohesion through defining single and clear responsibilities without any unnecessary methods.
- Example: `InsuranceCompany` handles insurance policy information.
### Low Coupling
- We made sure that the relationships are well-defined and do not create unnecessary interdependence.
- Example: `PaymentDue` only interacts with `PaymentReceipt` and `VehicleOwner`.
### Encapsulation
- The design enforces encapsulation by assigning the `private` access modifier to all attributes, which can be read or overwritten only using setters, getters, or other methods.
	- Ensuring that the objects are altered in a controlled manner
- Example: `renewPolicy(newDate : LocalDate, newCoverageAmount : double, newPrice : double)`
### Generalisation
Besides providing simplicity and a clear hierarchical structure, generalisation is utilized in many aspects of this design like:
- **Extensibility**: More subclasses can be added to the base **Abstract** classes `Document`, `Receipt`, and `PaymentDue`.
- **Polymorphism**: Applied through the methods `calcToal(paymentDues : ArrayList<PaymentDue>` and `viewPaymentDues()`.
### Aggregation
- Aggregation is seen in the relationship between: `VehicleOwner` – `PaymentDue`. (this is just one example from the diagram)
	- The `VehicleOwner` "owns" the `PaymentDue` but does not fully control its lifecycle 
		- Payments can exist even if the owner is deleted, for legal, financial, or other long term reasons.
### Composition
   - Composition is seen in relationships like `Vehicle` – `Registration`.
	   - `Registration` cannot exist without the `Vehicle`.
		   - Ensures strong ownership and lifecycle dependency between the two objects.
### Dependency
- In this design, the dependency arrow is used to signify that the class depends on or makes use of values defined in an enumeration.
- Example: The class `PaymentDue` uses the values of the enumeration `PaymentStatus` to identify the payment's status.
### Multiplicities
- `Vehicle` – `Registration`
	- A `Vehicle` can have zero or one `Registration`, and a `Registration` must belong to one `Vehicle`.
- `Vehicle` – `FitnessCertificate`
	- A `Vehicle` can have zero or one `FitnessCertificate`, and a `FitnessCertificate` must belong to one `Vehicle`.
- `Vehicle` – `InsurancePolicy`
	- A `Vehicle` must have one `InsurancePolicy`, and an `InsurancePolicy` must belong to one `Vehicle`.
- `Vehicle` – `ConfiscationOrder`
	- A `Vehicle` can have 0 or many `ConfiscationOrder`s, and an `ConfiscationOrder` can belong to one `Vehicle`.
- `Vehicle` – `Accident`
	- A `Vehicle` can have 0 or many `Accident`s, and an `Accident` must involve exactly 2 `Vehicle`s.
- `Vehicle` –  `VehicleOwner`
	- A `VehicleOwner` can have one or many `Vehicle`s, and a `Vehicle` must belong to minimum one `VehicleOwner` (in the case of a new vehicle) and at most two  `VehicleOwner`s (current and previous).
- `VehicleOwner` – `PaymentDue`
	- A `VehicleOwner` can have zero or many `PaymentDue`s, a `PaymentDue` belongs to one `VehicleOwner`.
- `PaymentReceipt` – `PaymentDue`
	- A `PaymentReceipt` can have one or many `PaymentDue`s, a `PaymentDue` belongs to one `PaymentReceipt`.
- `InsuranceCompany` – `InsurancePolicy`
	- An `InsuranceCompany` can issue one or many `InsurancePolicy`s, an `InsurancePolicy` belongs to one `InsuranceCompany`.
- `AuthorizedWorkshop` – `FitnessCertificate`
	- An `AuthorizedWorkshop` can issue zero or many `FitnessCertificate`s, an `FitnessCertificate` belongs to one `AuthorizedWorkshop`.
		- Assumption: An `AuthorizedWorkshop`, besides issuing `FitnessCertificate`s, has other functions outside the scope of the system.

---

  
  
