package pl.edu.agh.apdvbackend.use_cases.field_parser;

import pl.edu.agh.apdvbackend.models.FieldParser;

public interface GetFieldParser {
    FieldParser execute(Long fieldParserId);
}
