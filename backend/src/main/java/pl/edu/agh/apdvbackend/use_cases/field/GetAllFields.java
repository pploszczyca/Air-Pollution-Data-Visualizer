package pl.edu.agh.apdvbackend.use_cases.field;

import java.util.List;
import pl.edu.agh.apdvbackend.models.database.Field;

public interface GetAllFields {
    List<Field> execute();
}
