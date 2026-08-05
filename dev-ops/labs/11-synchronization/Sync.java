import java.util.concurrent.ThreadLocalRandom;

public class Sync {
  static int counter = 1;

  public static void main(String[] args) {
    Runnable r = () -> {
      try {
        Thread.sleep(ThreadLocalRandom.current().nextInt(100));
      } catch (InterruptedException e) {
        e.printStackTrace();
      }
      System.out.printf("ID value: %d (%s)%n", getID(),
                        Thread.currentThread().getName());
    };

    for (Integer k = 0; k < 10000; k += 1) {
      new Thread(r, k.toString()).start();
    }
  }

  public static synchronized int getID() { return counter++; }
}