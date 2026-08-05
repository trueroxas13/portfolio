import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class ReentrantLockWrapper {
  Lock lock = new ReentrantLock();

  public void print(int count) {
    lock.lock();
    try {
      for (int i = 1; i <= 10; i++) {
        System.out.println(count * i);
        Thread.sleep(500);
      }
    } catch (InterruptedException e) {
      e.printStackTrace();
    } finally {
      lock.unlock();
    }
  }
}