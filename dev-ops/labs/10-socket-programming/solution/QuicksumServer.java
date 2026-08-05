import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class QuicksumServer {
  public static void main(String[] args) {
    try (ServerSocket server = new ServerSocket(3333)) {
      System.out.printf("Started on %s%n", server.getLocalPort());
      while (true) {
        Socket client = server.accept();
        System.out.printf("Connection from %s:%s%n", client.getInetAddress(),
                          client.getPort());
        Thread service = new Thread(new QuicksumService(client));
        service.start();
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
}