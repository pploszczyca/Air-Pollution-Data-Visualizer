package pl.edu.agh.apdvbackend.use_cases.field_parser;

import pl.edu.agh.apdvbackend.models.database.FieldParser;

public interface GetOrSaveFieldParser {
    FieldParser execute(String fieldPath);
}
