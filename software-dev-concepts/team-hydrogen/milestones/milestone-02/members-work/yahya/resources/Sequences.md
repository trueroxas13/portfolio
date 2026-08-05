## Sequences[](https://queue.qa/cmps310/labs/09-sequences-states/#sequences)

“There are only two hard problems in distributed systems: 2. Exactly-once delivery 1. Guaranteed order of messages 2. Exactly-once delivery” —Mathias Verraes

Sequence diagrams are a type of interaction diagram that visualize the sequence of messages exchanged between objects or components within a system over time. They help illustrate how objects interact and the temporal order of these interactions, making them particularly useful for understanding both high-level system behavior and intricate object interactions.

Sequence diagrams are widely used in software engineering, particularly for modeling the dynamic behavior of complex systems such as user interfaces, web applications, or distributed systems. They are commonly applied during the design and analysis phases of software development, facilitating the planning, validation, and refinement of interactions between system components. Additionally, they assist in communicating design choices among stakeholders and serve as a foundation for testing.

### Lifelines[](https://queue.qa/cmps310/labs/09-sequences-states/#lifelines)

Lifelines represent the individual objects or actors involved in the interaction. Each lifeline is depicted as a vertical dashed line extending from the top of the diagram, representing the object’s lifespan throughout the interaction. Time progresses from top to bottom, and the position of the lifeline conveys the relative presence and involvement of each object over the course of the system’s operation.

Lifelines can represent both external actors (such as users or external systems) and internal objects within the system. An actor’s lifeline typically begins with the initiation of an interaction, while an object’s lifeline may start when it is instantiated.

### Messages[](https://queue.qa/cmps310/labs/09-sequences-states/#messages)

Messages represent the communication between objects and are shown as arrows connecting the lifelines. The message name is placed above the arrow to describe the specific action or request being made. There are different types of messages in sequence diagrams, each indicating a specific interaction.

#### Synchronous[](https://queue.qa/cmps310/labs/09-sequences-states/#synchronous)

A solid line with a filled arrowhead. The sender waits for the receiver to process the message and return control. It is used when an operation must complete before the next one begins.

#### Asynchronous[](https://queue.qa/cmps310/labs/09-sequences-states/#asynchronous)

A solid line with an open arrowhead. The sender does not wait for the receiver to process the message. Both the sender and receiver can continue independently after the message is sent.

#### Reply[](https://queue.qa/cmps310/labs/09-sequences-states/#reply)

A dashed line with an open arrowhead. It shows the return of control from the receiver back to the sender, indicating that the requested operation has completed. This message is typically used after a synchronous message.

#### Create[](https://queue.qa/cmps310/labs/09-sequences-states/#create)

A dashed line with a solid arrowhead, indicating that a new object is being created. It starts a new lifeline for the receiving object.

#### Destroy[](https://queue.qa/cmps310/labs/09-sequences-states/#destroy)

A dashed line with a solid arrowhead, followed by an $\times$ at the end of the lifeline. It indicates that the receiving object is being destroyed or terminated at that point in the interaction.

#### Self[](https://queue.qa/cmps310/labs/09-sequences-states/#self)

A looped arrow returning to the same lifeline. It shows that an object is calling one of its own methods or performing an internal action.

#### Found[](https://queue.qa/cmps310/labs/09-sequences-states/#found)

An arrow starting from an open circle at the edge of the diagram. This message indicates that the interaction starts from an unknown or unspecified source outside the system.

#### Lost[](https://queue.qa/cmps310/labs/09-sequences-states/#lost)

An arrow ending with an open circle at the edge of the diagram. It indicates that a message is sent but the recipient is outside the system or not specified.

#### Time Signal[](https://queue.qa/cmps310/labs/09-sequences-states/#time-signal)

Typically marked with a clock symbol, it represents a message that is triggered by a specific time or timing event, for example, a timeout or scheduled event.

These message types provide nuanced ways to represent complex system interactions, ensuring clarity in the modeling of both internal and external behaviors.

### Activation Elements[](https://queue.qa/cmps310/labs/09-sequences-states/#activation-elements)

#### Activation Intervals[](https://queue.qa/cmps310/labs/09-sequences-states/#activation-intervals)

Activation intervals, also known as activation bars, are vertical rectangular boxes on top of the lifeline that represent the time during which an object is actively processing or executing an operation. These bars visually depict when an object is involved in the interaction, making it clear when and for how long an object is engaged in sending or receiving messages.

#### Execution Occurrences[](https://queue.qa/cmps310/labs/09-sequences-states/#execution-occurrences)

Execution occurrences, also called execution specifications, are thin rectangles on the lifeline that indicate when an object is performing a specific action or operation. They are typically used alongside activation intervals but more explicitly focus on a particular point in time when an object is engaged in an execution.

#### Destruction Occurrences[](https://queue.qa/cmps310/labs/09-sequences-states/#destruction-occurrences)

Destruction occurrences represent the termination of an object’s life in a sequence diagram, typically marked with an $\times$ at the bottom of a lifeline. This notation shows that an object is no longer part of the interaction, often used when the object is deleted or its role ends after a specific operation.

### Interaction Organization[](https://queue.qa/cmps310/labs/09-sequences-states/#interaction-organization)

#### Gates[](https://queue.qa/cmps310/labs/09-sequences-states/#gates)

Gates act as entry and exit points for messages into or out of a fragment or diagram. They are useful in breaking down complex diagrams by organizing related interactions and maintaining clarity. Gates can represent messages sent to or received from external systems or actors, making them vital for handling multi-layered or distributed systems.

#### Reference Fragments[](https://queue.qa/cmps310/labs/09-sequences-states/#reference-fragments)

Reference fragments (ref frames) are used to reference another sequence diagram from within the current diagram. Similar to interaction uses, ref frames simplify large diagrams by encapsulating commonly used interactions into a separate diagram. The referenced diagram is displayed in a smaller frame with the `ref` label, indicating that the interaction continues in another diagram.

### Interaction Fragments[](https://queue.qa/cmps310/labs/09-sequences-states/#interaction-fragments)

Interaction fragments are powerful mechanisms for organizing and representing complex interactions within a sequence diagram. They allow sub-interactions to be encapsulated and managed efficiently, making the diagram easier to comprehend and modify.

#### Interaction Use[](https://queue.qa/cmps310/labs/09-sequences-states/#interaction-use)

An interaction use fragment references another sequence diagram, effectively allowing you to _call_ or reuse a pre-defined sequence of interactions within a larger diagram. This technique is particularly useful for simplifying large, complex diagrams by avoiding redundancy and promoting reusability.

#### Combined Fragments[](https://queue.qa/cmps310/labs/09-sequences-states/#combined-fragments)

Combined fragments allow for modeling more complex scenarios through interaction operators, such as:

- `alt` (Alternative): Represents conditional branches, allowing you to model if-else logic within the interaction.
- `opt` (Optional): Denotes an optional interaction that only occurs under certain conditions.
- `loop`: Models iterative behavior, where a set of messages is repeated a specific number of times or until a condition is met.
- `break`: Represents an interruptive condition that exits the interaction prematurely.
- `par` (Parallel): Models parallel processing, where multiple messages can be sent simultaneously across different lifelines.
- `strict`: Ensures strict sequencing of messages within the fragment.

### Constraints and Conditions[](https://queue.qa/cmps310/labs/09-sequences-states/#constraints-and-conditions)

#### State Invariants[](https://queue.qa/cmps310/labs/09-sequences-states/#state-invariants)

State invariants are constraints or conditions that must hold true at a specific point in the sequence diagram. They are typically placed on a lifeline between two messages, representing a condition that the object must satisfy before the next interaction occurs. State invariants are useful for enforcing specific system states or validating certain behaviors during the interaction.

#### Duration and Timing[](https://queue.qa/cmps310/labs/09-sequences-states/#duration-and-timing)

Duration constraints indicate how long an interaction between two objects should take. This is shown with a double-headed arrow labeled with a time duration between two messages. Timing constraints define conditions related to the timing of message exchanges and can be used to specify deadlines, maximum allowable delays, or synchronization requirements.
