module org.example.demo {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.desktop;
    requires junit;
    requires org.junit.jupiter.api;


    opens org.example.demo to javafx.fxml;
    exports org.example.demo;
}