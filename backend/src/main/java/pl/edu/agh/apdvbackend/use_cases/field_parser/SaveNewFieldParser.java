package pl.edu.agh.apdvbackend.use_cases.field_parser;

import pl.edu.agh.apdvbackend.models.body_models.field_parser.FieldParserRequestBody;
import pl.edu.agh.apdvbackend.models.database.FieldParser;

public interface SaveNewFieldParser {
    FieldParser execute(FieldParserRequestBody fieldParserRequestBody);
}
