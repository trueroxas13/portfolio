import java.util.concurrent.Semaphore;

public class SempahoreBoundedBuffer implements Buffer {
  private int buffer[] = {-1, -1, -1}; // shared by reader and writer threads

  private Semaphore mutex = new Semaphore(1);
  private Semaphore producer = new Semaphore(buffer.length);
  private Semaphore consumer = new Semaphore(0);

  private int writeIndex = 0;
  private int readIndex = 0;

  // place value into buffer
  @Override
  public void set(int value) {
    try {
      producer.acquire();
      mutex.acquire();

      buffer[writeIndex] = value;
      System.out.printf("%-15s%10s", "Writer writes", value);
      writeIndex = (writeIndex + 1) % buffer.length;
    } catch (InterruptedException e) {
      e.printStackTrace();
    } finally {
      mutex.release();
      consumer.release();
    }
  }

  // return value from buffer
  @Override
  public int get() {
    int value = 0;
    try {
      consumer.acquire();
      mutex.acquire();

      value = buffer[readIndex];
      System.out.printf("%-15s%10s", "Reader reads", value);
    } catch (InterruptedException e) {

    } finally {
      mutex.release();
      producer.release();
    }
    return value;
  }
}