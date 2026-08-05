public class SynchronizedBuffer implements Buffer {
  private int buffer = -1; // shared by reader and writer threads
  private boolean full = false;

  // place value into buffer
  @Override
  public void set(int value) {
    while (full) {
      try {
        wait();
      } catch (InterruptedException e) {
        e.printStackTrace();
      }
    }

    System.out.printf("%-15s%10s", "Writer writes", value);
    buffer = value;
    full = true;
    notify();
  }

  // return value from buffer
  @Override
  public int get() {
    while (!full) {
      try {
        wait();
      } catch (InterruptedException e) {
        e.printStackTrace();
      }
    }

    System.out.printf("%-15s%10s", "Reader reads", buffer);
    full = false;
    notify();
    return buffer;
  }
}