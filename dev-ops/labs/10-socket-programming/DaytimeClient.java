import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;

public class DaytimeClient {
  public static void main(String[] args) {
    try {
      // get a socket to the daytime service
      Socket daytime = new Socket("localhost", 13);
      System.out.println("Connected with server " + daytime.getInetAddress() +
                         ":" + daytime.getPort());
      // set the socket timeout just in case the server stalls
      daytime.setSoTimeout(2000);
      // read from the server
      BufferedReader reader =
          new BufferedReader(new InputStreamReader(daytime.getInputStream()));
      // display result on the screen
      System.out.println("Result: " + reader.readLine());
      // close the connection
      daytime.close();
    } catch (IOException e) {
      System.out.println("Error: " + e);
    }
  }
}