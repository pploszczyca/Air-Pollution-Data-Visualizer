package pl.edu.agh.apdvbackend.configs;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import pl.edu.agh.apdvbackend.utilities.ListUtilities;
import pl.edu.agh.apdvbackend.utilities.StreamUtilities;
import pl.edu.agh.apdvbackend.validators.UserDataValidationUtilities;

@Configuration
public class AppConfig {

    @Bean
    @Scope("singleton")
    public StreamUtilities getStreamUtilities() {
        return new StreamUtilities();
    }

    @Bean
    @Scope("singleton")
    public ListUtilities getListUtilities() {
        return new ListUtilities();
    }

    @Bean
    @Scope("singleton")
    public UserDataValidationUtilities getUserDataValidationUtilities() {
        return new UserDataValidationUtilities();
    }
}
