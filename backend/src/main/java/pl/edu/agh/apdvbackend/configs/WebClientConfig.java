package pl.edu.agh.apdvbackend.configs;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

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

    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                // TODO: Properly set up CORS policy, now allows everything
                registry.addMapping("/**").allowedOrigins("*");
            }
        };
    }
}
