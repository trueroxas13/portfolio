public class SynchronizedBoundedBuffer implements Buffer {
  private int buffer[] = {-1, -1, -1}; // shared by reader and writer threads
  private int size = 0;
  private int writeIndex = 0;
  private int readIndex = 0;

  // place value into buffer
  @Override
  public void set(int value) {
    while (size == buffer.length) {
      try {
        wait();
      } catch (InterruptedException e) {
        e.printStackTrace();
      }
    }

    buffer[writeIndex] = value;
    System.out.printf("%-15s%10s", "Writer writes", value);
    writeIndex = (writeIndex + 1) % buffer.length;
    size += 1;
    notify();
  }

  // return value from buffer
  @Override
  public int get() {
    while (size == 0) {
      try {
        wait();
      } catch (InterruptedException e) {
        e.printStackTrace();
      }
    }

    int value = buffer[readIndex];
    System.out.printf("%-15s%10s", "Reader reads", value);
    size -= 1;
    notify();
    return value;
  }
}