# Facade

This pattern was chosen and implemented due to the complex nature of how the program functions overall with various entities interacting with each other. We want the user to have a positive and smooth experience while using the application, so _hiding_ everything that the user does not need to know about behind a _wall_ is ideal in this case. 

This is where **facade** enters the scene. Being the perfect pattern to fulfill this role, it results in the application having a barrier that only shows the user the functionalities that they desire in simple terms, with everything else handled behind the scenes. 

-  **_Note:_** Another side effect of implementing this pattern is also that it improves code readability as well, since the actual logic of the app and the visuals section is essentially sectioned off. In this way, it is also of benefit to the developers. If they want to add a new functionality to the app, they can start by adding a new theoretical client request to the facade class, then handle how it is implemented in a separate class, reducing the chances of error and confusion in contrast to, for example, both of these being handled in one class. It brings out and amplifies the modularity aspect of programming, which is a good coding practice.   
---

# Iterator Design Pattern

The Iterator Design Patternprovides a standard way to sequentially access elements in a collection without exposing its underlying implementation. In this project, the Setup class uses the Iterator Design Pattern to manage and traverse a list of vehicles (Vehicles) while encapsulating the iteration logic. This ensures flexibility and maintainability.


###  Advantages of This Design

1. **Encapsulation**:  
   The `Setup` class exposes only the iterator for traversing the vehicle list, hiding the implementation details of the `ArrayList`.

2. **Reusability**:  
   The `VehiclesIterator` can be reused in other contexts where traversal of vehicle lists is required.

3. **Modularity**:  
   Changes to the traversal logic (e.g., adding a reverse iterator) do not affect the `Setup` class or its clients.

4. **Flexibility**:  
   The iterator makes it easy to add more traversal strategies or change the underlying collection type in the future.


###  Implementation Details

1. **Collection (`List<Vehicle> Vehicles`)**:
   - The `Setup` class maintains a private collection of vehicles using an `ArrayList`. Direct access to this collection is avoided to maintain encapsulation.

2. **Iterator Interface**:
   - The project uses a generic `Iterator<T>` interface that defines the methods for traversal:
     ```java
     public interface Iterator<T> {
         boolean hasNext();
         T next();
         void setCurrentIndex(int index); // Optional: to reset traversal
     }
     ```

3. **Concrete Iterator (`VehiclesIterator`)**:
   - Implements the `Iterator<Vehicle>` interface.
   - Encapsulates the traversal logic for the `Vehicles` list.
   - Example:
     ```java
     public class VehiclesIterator implements Iterator<Vehicle> {
         private List<Vehicle> vehicles;
         private int currentIndex = 0;

         public VehiclesIterator(List<Vehicle> vehicles) {
             this.vehicles = vehicles;
         }

         @Override
         public boolean hasNext() {
             return currentIndex < vehicles.size();
         }

         @Override
         public Vehicle next() {
             return vehicles.get(currentIndex++);
         }

         @Override
         public void setCurrentIndex(int index) {
             this.currentIndex = index;
         }
     }
     ```

4. **Aggregate Interface (`Aggregate<T>`)**:
   - Provides a factory method for creating iterators:
     ```java
     public interface Aggregate<T> {
         Iterator<T> createIterator();
     }
     ```

5. **(Concrete Aggregate) Setup Class**:
   - Implements the `Aggregate<Vehicle>` interface.
   - The `createIterator()` method instantiates a new `VehiclesIterator` for the `Vehicles` list:
     ```java
     @Override
     public Iterator<Vehicle> createIterator() {
         return new VehiclesIterator(Vehicles);
     }
     ```




