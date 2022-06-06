package pl.edu.agh.apdvbackend.use_cases.endpoint;

import java.util.List;
import pl.edu.agh.apdvbackend.models.Endpoint;

public interface GetAllUserEndpoints {
    List<Endpoint> execute(Long userId);
}
