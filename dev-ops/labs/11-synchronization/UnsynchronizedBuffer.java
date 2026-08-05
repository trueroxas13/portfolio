public class UnsynchronizedBuffer implements Buffer {
  private int buffer = -1; // shared by reader and writer threads

  // place value into buffer
  @Override
  public void set(int value) {
    System.out.printf("%-15s%10s", "Writer writes", value);
    buffer = value;
  }

  // return value from buffer
  @Override
  public int get() {
    System.out.printf("%-15s%10s", "Reader reads", buffer);
    return buffer;
  }
}