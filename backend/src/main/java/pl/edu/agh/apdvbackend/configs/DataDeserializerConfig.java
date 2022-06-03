package pl.edu.agh.apdvbackend.configs;

import java.util.List;
import java.util.Map;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import pl.edu.agh.apdvbackend.models.DataTypes;

@Configuration
public class DataDeserializerConfig {

    @Bean(name = "dataDeserializerMap")
    @Scope("singleton")
    public Map<String, List<String>> initMap() {
        return Map.of(
                DataTypes.TEMPERATURE.name(),
                List.of("data", "envSensor", "temperature"),
                DataTypes.PRESSURE.name(),
                List.of("data", "envSensor", "pressure"),
                DataTypes.HUMIDITY.name(),
                List.of("data", "envSensor", "relativeHumidity"),
                DataTypes.PM1_0.name(),
                List.of("data", "particleConcentrationSensor", "concentration",
                        "pm1"),
                DataTypes.PM2_5.name(),
                List.of("data", "particleConcentrationSensor", "concentration",
                        "pm2_5"),
                DataTypes.PM10.name(),
                List.of("data", "particleConcentrationSensor", "concentration",
                        "pm10"),
                DataTypes.LABEL.name(), List.of("label"),
                DataTypes.ID.name(), List.of("data", "id"),
                DataTypes.TIMESTAMP.name(), List.of("timestamp")
        );
    }
}
