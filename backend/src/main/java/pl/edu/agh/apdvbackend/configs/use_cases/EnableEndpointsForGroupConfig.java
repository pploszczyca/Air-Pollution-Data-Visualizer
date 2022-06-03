package pl.edu.agh.apdvbackend.configs.use_cases;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import pl.edu.agh.apdvbackend.repositories.EnableEndpointsForGroupRepository;
import pl.edu.agh.apdvbackend.use_cases.enable_endpoints.GetEnableEndpointsByGroupId;
import pl.edu.agh.apdvbackend.use_cases.enable_endpoints.GetEnableEndpointsByGroupIdImpl;
import pl.edu.agh.apdvbackend.utilities.ListUtilities;

@Configuration
public class EnableEndpointsForGroupConfig {

    @Bean
    @Scope("singleton")
    GetEnableEndpointsByGroupId getEnableEndpointsByGroupId(
            EnableEndpointsForGroupRepository enableEndpointsForGroupRepository,
            ListUtilities listUtilities) {
        return new GetEnableEndpointsByGroupIdImpl(
                enableEndpointsForGroupRepository, listUtilities);
    }
}
