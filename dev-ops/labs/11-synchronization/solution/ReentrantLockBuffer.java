import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class ReentrantLockBuffer implements Buffer {
  private int buffer = -1; // shared by reader and writer threads
  private boolean full = false;
  private Lock lock = new ReentrantLock();
  private Condition canWrite = lock.newCondition();
  private Condition canRead = lock.newCondition();

  // place value into buffer
  @Override
  public void set(int value) {
    lock.lock();
    try {
      while (full) {
        canWrite.await();
      }

      System.out.printf("%-15s%10s", "Writer writes", value);
      buffer = value;
      full = true;
      canRead.signal();
    } catch (InterruptedException e) {
      e.printStackTrace();
    } finally {
      lock.unlock();
    }
  }

  // return value from buffer
  @Override
  public int get() {
    lock.lock();
    try {
      while (!full) {
        canRead.await();
      }

      System.out.printf("%-15s%10s", "Reader reads", buffer);
      full = false;
      canWrite.signal();
    } catch (InterruptedException e) {
      e.printStackTrace();
    } finally {
      lock.unlock();
    }
    return buffer;
  }
}