package pl.edu.agh.apdvbackend.use_cases.field_parser;

import pl.edu.agh.apdvbackend.controllers.field_parser.body_models.AddFieldParserRequestBody;
import pl.edu.agh.apdvbackend.models.FieldParser;

public interface UpdateFieldParser {
    FieldParser execute(Long fieldParserId,
                        AddFieldParserRequestBody addFieldParserRequestBody);
}
