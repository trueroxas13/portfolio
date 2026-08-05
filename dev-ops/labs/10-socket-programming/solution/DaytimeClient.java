import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;

public class DaytimeClient {
  public static void main(String[] args) {
    try {
      Socket socket = new Socket("localhost", 13);
      System.out.println("Connected with server " + socket.getInetAddress() +
                         ":" + socket.getPort());
      socket.setSoTimeout(2000);
      BufferedReader input =
          new BufferedReader(new InputStreamReader(socket.getInputStream()));
      System.out.println("Daytime: " + input.readLine());
      input.close();
      socket.close();
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
}