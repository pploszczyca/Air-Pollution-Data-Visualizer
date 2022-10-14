package pl.edu.agh.apdvbackend.use_cases.field_parser;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.body_models.field_parser.FieldParserRequestBody;
import pl.edu.agh.apdvbackend.models.database.FieldParser;
import pl.edu.agh.apdvbackend.repositories.FieldParserRepository;

@Component
@RequiredArgsConstructor
public class GetOrSaveFieldParserImpl implements GetOrSaveFieldParser {

    private final FieldParserRepository repository;

    private final SaveNewFieldParser saveNewFieldParser;

    @Override
    public FieldParser execute(String fieldParserPath) {
        return repository
                .findByPath(fieldParserPath)
                .orElseGet(() -> saveNewFieldParser.execute(new FieldParserRequestBody(fieldParserPath)));
    }
}
