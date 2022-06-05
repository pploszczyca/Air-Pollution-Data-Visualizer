package pl.edu.agh.apdvbackend.use_cases.field_parser;

import java.util.List;
import pl.edu.agh.apdvbackend.models.FieldParser;

public interface GetAllFieldParsers {
    List<FieldParser> execute();
}
