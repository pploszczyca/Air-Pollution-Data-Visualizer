package pl.edu.agh.apdvbackend.configs;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import pl.edu.agh.apdvbackend.models.DataTypes;

@Configuration
public class DataDeserializerConfig {

    @SuppressWarnings("checkstyle:ArrayTrailingComma")
    @Bean(name = "dataDeserializerMap")
    @Scope("singleton")
    public Map<DataTypes, List<String>> initMap() {
        return Stream.of(new Object[][] {
                {DataTypes.TEMPERATURE,
                        List.of("data", "envSensor", "temperature")},
                {DataTypes.PRESSURE, List.of("data", "envSensor", "pressure")},
                {DataTypes.HUMIDITY,
                        List.of("data", "envSensor", "relativeHumidity")},
                {DataTypes.PM1_0, List.of("data", "particleConcentrationSensor",
                        "concentration", "pm1")},
                {DataTypes.PM2_5, List.of("data", "particleConcentrationSensor",
                        "concentration", "pm2_5")},
                {DataTypes.PM10, List.of("data", "particleConcentrationSensor",
                        "concentration", "pm10")},
                {DataTypes.LABEL, List.of("label")},
                {DataTypes.ID, List.of("data", "id")},
                {DataTypes.LOCATION_ALT, List.of("data", "location", "alt")},
                {DataTypes.LOCATION_LAT, List.of("data", "location", "lat")},
                {DataTypes.LOCATION_LON, List.of("data", "location", "lon")},
                {DataTypes.LOCATION_NAME,
                        List.of("data", "location", "locName")}}
        ).collect(Collectors.toMap(data -> (DataTypes) data[0],
                data -> (List<String>) data[1]));
    }
}
