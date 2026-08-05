import java.util.concurrent.ThreadLocalRandom;

public class Reader extends Thread {
  private Buffer sharedLocation; // reference to the shared object

  public Reader(Buffer shared) { this.sharedLocation = shared; }

  // read sharedLocation's value multiple times and add the values
  @Override
  public void run() {
    int total = 0;

    for (int count = 1; count <= 10; count++) {
      // sleep 0 to 3 seconds, then read value from buffer and add to total
      try {
        Thread.sleep(ThreadLocalRandom.current().nextInt(3000)); // sleep thread
        total += this.sharedLocation.get(); // add value to total
        System.out.printf("%10s%10s%n", "", total);
      }

      // if the sleeping thread is interrupted, print the stack trace
      catch (InterruptedException e) {
        e.printStackTrace();
      }
    }

    System.out.printf("%n%s: %d. %s%n%n", "Reader is done", total,
                      "Terminating...");
  }
}