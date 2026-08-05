module com.example.verse {
    requires javafx.controls;
    requires javafx.fxml;


    opens com.example.verse to javafx.fxml;
    exports com.example.verse;
}