package pl.edu.agh.apdvbackend.use_cases.field_parser;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.FieldParser;
import pl.edu.agh.apdvbackend.repositories.FieldParserRepository;

@Component
@RequiredArgsConstructor
public class GetFieldParserImpl
        implements GetFieldParser {

    private final FieldParserRepository fieldParserRepository;

    @Override
    public FieldParser execute(Long fieldParserId) {
        return fieldParserRepository.findById(fieldParserId).orElseThrow();
    }
}
