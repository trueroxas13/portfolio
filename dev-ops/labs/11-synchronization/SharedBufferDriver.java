public class SharedBufferDriver {
  public static void main(String[] args) {
    // create an UnsynchronizedBuffer to store integer values
    Buffer sharedLocation = new UnsynchronizedBuffer();

    // create a new thread pool with two threads
    Writer writer = new Writer(sharedLocation);
    Reader reader = new Reader(sharedLocation);

    System.out.printf("%-15s%10s%10s%10s%n", "Action", "Value", "Written",
                      "Read");
    System.out.printf("---------------------------------------------%n");

    // start writer and reader, giving each of them access
    writer.start();
    reader.start();
  }
}