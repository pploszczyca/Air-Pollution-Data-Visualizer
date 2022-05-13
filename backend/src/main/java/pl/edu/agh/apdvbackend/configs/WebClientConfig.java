package pl.edu.agh.apdvbackend.configs;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import org.springframework.web.reactive.function.client.WebClient;

@Configuration
public class WebClientConfig {

    @Value("${dataHub.url}")
    private String dataHubUrl;

    @Bean
    @Scope("singleton")
    public WebClient getWebClient() {
        return WebClient
                .create(dataHubUrl);
    }
}
