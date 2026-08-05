import java.util.concurrent.ThreadLocalRandom;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.util.stream.IntStream;

class Customer extends Thread {
  @Override
  public void run() {
    BarberShop.lock.lock();
    try {
      while (BarberShop.customers >=
             BarberShop.MAX_CHAIRS) { // wait for a free chair
        BarberShop.condition.await();
      }
      BarberShop.customers += 1; // acquire a chair
      BarberShop.condition.signal();
    } catch (InterruptedException e) {
      e.printStackTrace();
    } finally {
      BarberShop.lock.unlock();
    }

    System.out.printf("%s Haircut started...%n",
                      Thread.currentThread().getName());
    try {
      Thread.sleep(ThreadLocalRandom.current().nextInt(5000, 10000));
    } catch (InterruptedException e) {
      e.printStackTrace();
    }

    BarberShop.lock.lock();
    BarberShop.customers -= 1; // release a chair
    System.out.printf("%s Haircut complete!%n",
                      Thread.currentThread().getName());
    BarberShop.condition.signal();
    BarberShop.lock.unlock();
  }
}

public class BarberShop {
  static final int MAX_CHAIRS = 4;
  static int customers = 0;
  static Lock lock = new ReentrantLock();
  static Condition condition = lock.newCondition();

  public static void main(String[] args) {
    IntStream.range(0, 10).forEach(k -> { new Customer().start(); });
  }
}