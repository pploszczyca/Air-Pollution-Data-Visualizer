package pl.edu.agh.apdvbackend.use_cases.field_parser;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.repositories.FieldParserRepository;

@Component
@RequiredArgsConstructor
public class RemoveFieldParserImpl
        implements RemoveFieldParser {

    private final FieldParserRepository fieldParserRepository;

    @Override
    public void execute(Long fieldParserId) {
        fieldParserRepository.deleteById(fieldParserId);
    }
}
