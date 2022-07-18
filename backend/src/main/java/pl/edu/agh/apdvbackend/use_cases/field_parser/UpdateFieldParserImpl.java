package pl.edu.agh.apdvbackend.use_cases.field_parser;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.FieldParserMapper;
import pl.edu.agh.apdvbackend.models.body_models.field_parser.AddFieldParserRequestBody;
import pl.edu.agh.apdvbackend.models.database.FieldParser;
import pl.edu.agh.apdvbackend.repositories.FieldParserRepository;

@Component
@RequiredArgsConstructor
public class UpdateFieldParserImpl
        implements UpdateFieldParser {

    private final FieldParserRepository fieldParserRepository;

    private final FieldParserMapper fieldParserMapper;

    @Override
    public FieldParser execute(Long fieldParserId,
                               AddFieldParserRequestBody addFieldParserRequestBody) {
        final var updatingFieldParser =
                fieldParserRepository.findById(fieldParserId).orElseThrow();
        fieldParserMapper.updateFieldParserFromAddRequestBody(
                addFieldParserRequestBody, updatingFieldParser);
        return fieldParserRepository.save(updatingFieldParser);
    }
}
