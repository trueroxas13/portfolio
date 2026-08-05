import java.util.concurrent.ThreadLocalRandom;

public class Writer extends Thread {
  private Buffer sharedLocation; // reference to the shared object

  public Writer(Buffer shared) { this.sharedLocation = shared; }

  // store values from 1 to 10 in sharedLocation
  @Override
  public void run() {
    int total = 0;

    for (int count = 1; count <= 10; count++) {
      // sleep 0 to 3 seconds, then place value in buffer
      try {
        Thread.sleep(ThreadLocalRandom.current().nextInt(3000)); // sleep thread
        this.sharedLocation.set(count); // set value in buffer
        total += count;                 // increment total of values
        System.out.printf("%10s%n", total);
      }

      // if the sleeping thread is interrupted, print the stack trace
      catch (InterruptedException e) {
        e.printStackTrace();
      }
    }

    System.out.printf("%n%s%n%n", "Writer is done. Terminating...");
  }
}