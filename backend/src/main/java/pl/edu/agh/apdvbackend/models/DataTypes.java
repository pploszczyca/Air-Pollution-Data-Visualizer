package pl.edu.agh.apdvbackend.models;

public enum DataTypes {
    TEMPERATURE("temperature"),
    HUMIDITY("humidity"),
    PRESSURE("pressure"),
    PM1_0("pm1_0"),
    PM2_5("pm2_5"),
    PM10("pm10"),
    LABEL("label"),
    ID("id"),
    TIMESTAMP("timestamp");
    private final String name;

    DataTypes(String name) {
        this.name = name;
    }
}
