package pl.edu.agh.apdvbackend.auth;

import com.auth0.jwt.algorithms.Algorithm;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import pl.edu.agh.apdvbackend.models.database.Role;
import pl.edu.agh.apdvbackend.validators.AuthorizationHeaderValidation;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private static final String SECRET = "secret";
    private final UserDetailsService userDetailsService;
    private final PasswordEncoder passwordEncoder;
    private final AuthorizationHeaderValidation authorizationHeaderValidation;

    @Override
    protected void configure(AuthenticationManagerBuilder auth)
            throws Exception {
        auth.userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder);
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable();
        http.sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS);
        http.authorizeRequests().antMatchers(
                "/v3/api-docs/**",
                "/swagger-ui/**",
                "/auth/**"
        ).permitAll();
        http.authorizeRequests().antMatchers(HttpMethod.GET,
                "/sensor/data",
                "/sensor",
                "/sensor/list",
                "/field/enable",
                "/unit/converter",
                "/unit/converter/all").hasAuthority(Role.USER.name());
        http.authorizeRequests().anyRequest().hasAuthority(Role.ADMIN.name());
        http.addFilterBefore(new CustomAuthorizationFilter(getAlgorithm(),
                        authorizationHeaderValidation),
                UsernamePasswordAuthenticationFilter.class);
    }

    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Bean
    public Algorithm getAlgorithm() {
        return Algorithm.HMAC256(SECRET.getBytes());
    }
}
