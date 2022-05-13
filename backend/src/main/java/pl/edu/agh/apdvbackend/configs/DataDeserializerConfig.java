package pl.edu.agh.apdvbackend.configs;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import pl.edu.agh.apdvbackend.models.DataTypes;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Configuration
public class DataDeserializerConfig {

    @Bean(name = "dataDeserializerMap")
    @Scope("singleton")
    public Map<DataTypes, List<String>> initMap() {
        final Map<DataTypes, List<String>> valuesMap = new HashMap<>();
        valuesMap.put(DataTypes.TEMPERATURE, List.of("data", "envSensor", "temperature"));
        valuesMap.put(DataTypes.PRESSURE, List.of("data", "envSensor", "pressure"));
        valuesMap.put(DataTypes.HUMIDITY, List.of("data", "envSensor", "relativeHumidity"));
        valuesMap.put(DataTypes.PM1_0, List.of("data", "particleConcentrationSensor", "concentration", "pm1"));
        valuesMap.put(DataTypes.PM2_5, List.of("data", "particleConcentrationSensor", "concentration", "pm2_5"));
        valuesMap.put(DataTypes.PM10, List.of("data", "particleConcentrationSensor", "concentration", "pm10"));
        return valuesMap;
    }
}
