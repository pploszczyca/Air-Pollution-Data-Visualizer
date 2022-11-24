package pl.edu.agh.apdvbackend.use_cases.field_parser;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.field_parser.FieldParserMapper;
import pl.edu.agh.apdvbackend.models.body_models.field_parser.FieldParserRequestBody;
import pl.edu.agh.apdvbackend.models.database.FieldParser;
import pl.edu.agh.apdvbackend.repositories.FieldParserRepository;

@Component
@RequiredArgsConstructor
public class SaveNewFieldParserImpl implements SaveNewFieldParser {

    private final FieldParserRepository fieldParserRepository;
    private final FieldParserMapper fieldParserMapper;

    @Override
    public FieldParser execute(FieldParserRequestBody fieldParserRequestBody) {
        return fieldParserRepository.save(
                fieldParserMapper.addRequestBodyToFieldParser(fieldParserRequestBody)
        );
    }
}
