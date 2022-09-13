package pl.edu.agh.apdvbackend.fakes.body_models.user;

import lombok.Builder;
import pl.edu.agh.apdvbackend.models.body_models.user.ShortUserResponseBody;

public class ShortUserResponseBodyFakes {
    @Builder
    private static ShortUserResponseBody buildNewShortUser(
            Long id,
            String email
    ) {
        return new ShortUserResponseBody(
                id,
                getOrElse(email, "dummy email")
        );
    }

    private static <T> T getOrElse(T value, T defaultValue) {
        return value == null ? defaultValue : value;
    }
}
