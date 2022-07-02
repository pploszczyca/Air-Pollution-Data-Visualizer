package pl.edu.agh.apdvbackend.use_cases.field_parser;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.FieldParserMapper;
import pl.edu.agh.apdvbackend.models.body_models.field_parser.AddFieldParserRequestBody;
import pl.edu.agh.apdvbackend.models.database.FieldParser;
import pl.edu.agh.apdvbackend.repositories.FieldParserRepository;

@Component
@RequiredArgsConstructor
public class SaveNewFieldParserImpl
        implements SaveNewFieldParser {

    private final FieldParserRepository fieldParserRepository;

    private final FieldParserMapper fieldParserMapper;

    @Override
    public FieldParser execute(
            AddFieldParserRequestBody addFieldParserRequestBody) {
        return fieldParserRepository.save(
                fieldParserMapper.addRequestBodyToFieldParser(
                        addFieldParserRequestBody));
    }
}
