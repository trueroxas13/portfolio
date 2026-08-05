import java.util.concurrent.Semaphore;
import java.util.concurrent.ThreadLocalRandom;

class Device extends Thread {
  private static Semaphore sem = new Semaphore(4);

  public Device(String name) { super(name); }

  public void run() {
    try {
      sem.acquire();
      System.out.println(this.getName() + " is charging...");
      Thread.sleep(ThreadLocalRandom.current().nextInt(5000, 10000));
    } catch (InterruptedException e) {
      e.printStackTrace();
    } finally {
      System.out.println(this.getName() + " is charged.");
      sem.release();
    }
  }
}
public class Charger {
  public static void main(String args[]) {
    for (int i = 0; i < 30; i++) {
      new Device("Phone-" + i).start();
    }
  }
}