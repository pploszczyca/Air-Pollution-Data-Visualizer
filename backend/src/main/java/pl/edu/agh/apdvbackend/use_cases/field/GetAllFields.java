package pl.edu.agh.apdvbackend.use_cases.field;

import java.util.List;
import pl.edu.agh.apdvbackend.models.body_models.field.FieldResponseBody;

public interface GetAllFields {
    List<FieldResponseBody> execute();
}
