package pl.edu.agh.apdvbackend.configs;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import pl.edu.agh.apdvbackend.utilities.StreamUtilities;

@Configuration
public class AppConfig {

    @Bean
    @Scope("singleton")
    public StreamUtilities getStreamUtilities() {
        return new StreamUtilities();
    }
}
