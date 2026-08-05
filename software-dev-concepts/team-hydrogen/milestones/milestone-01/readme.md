# Summary 
This is a summary of how we went about this milestone.
* We began by thoroughly reading the document at least twice. The first read-through was solely for comprehension, while during the second, we highlighted sections we found important.
* Afterward, we extracted information by brainstorming and categorizing different aspects, aligning them with relevant diagrams.
* Following this, we refined and organized the document to capture the most essential points for diagram creation.
* From there, it became a collaborative process of adjusting and reviewing the diagrams, with each team member contributing to refine them further.
# Assumptions
## Vehicle:
   *  New vehicle:
      * A new vehicle in the IQVR system is a vehicle which has not been registered before related to the owner of the vehicle.
      * Example let's say you have a 2017 Honda Civic Type R that you bought in 2018 and have been using it since then, this car is considered as a new vehicle in the IQVR system if no vehicle of the same model was registered before.
    * 2 year old vehicle:
      * Is a vehicle which has been used for 2 years. This vehicle will then need a fitness certificate.
      * Example let's say you bought a brand new 2015 Toyota Avalon in 2024 this car is considered new just because it was made in 2015 doesn't make it more than 2 years old the model older than 2 years but the car itself was just used in 2024.
      * Fitness certificate for vehicle if you want to register / renew registration your vehicle must have a fitness certificate if:
          1. it has been used for longer than 2 years.
          2. The last time you got a fitness certificate for it was 2 years ago.
   * Logic of the attribute `datePurchased` in class `Vehicle`:
     * This attribute will be used for a when the vehicle is new to calculate it's age.
     * Later, the age will be calculated using fitness certificate’s expiry date.
   * Reasoning behind the attribute `dueDate` in class `PaymentDue` in the class diagram.
     * For all payment dues there is a time limit for them to be paid.
     * After the time limit there will be reminders sent to the user to pay off the payment dues, otherwise he might not be able to use some of the system's features, or some other consequence.
     * We think that this idea is important because if we don't add it the system might have a flaw in which users don't pay off their fees at all.
## About registration:
  * One of the problems was how to implement the registration condition of fitness certificate  it stated if the vehicle over 2 years it needs a fitness certificate.
  * The Fitness Certificate (FC) of a vehicle is an official document that certifies the vehicle is fit enough to run on public roads.
  * Obviously a new car made 2 years ago probably wouldn't need a certificate since it's brand new not used. So it means it's been registered in iQVR for 2 years or has been used for 2 years if we're talking re-new registration.
## About transferring a registered/ unregistered vehicle:
  * The new vehicle owner can be already registered in the system or a new owner that is not registered with in the system. After the transfer of the vehicle, they will be registered as the vehicle owner.
## About QTS's role:
  * If a vehicle is imported from overseas and already has an insurance policy associated with it, the QTS system forwards this to iQVR. This insurance policy will be active and used until it is past its expiration date, and the responsible overseas insurance company will cover it.
# Comments
## Reporting an accident
- We didn't design it like this and we think it should be handled differently.
> The system records this information, and by default, it sets that the vehicle that entered all information is the offending vehicle’s owner.
- In our opinion we think it's a wrong idea to have the reporter of the accident by default be the assaulter/ the person at fault in the accident. It should be the other way around.
- Usually the person at fault wouldn't want to be held accountable and the person who is the victim will be the one to rush to report. So if the victim rushes to report he might be in an aggravated state to notice that he is reporting with default settings as the offender rather than the victim. We believe this could lead too many issues and confusion.
