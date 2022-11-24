package pl.edu.agh.apdvbackend.use_cases.field_parser;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.database.FieldParser;
import pl.edu.agh.apdvbackend.repositories.EndpointRepository;
import pl.edu.agh.apdvbackend.repositories.FieldParserRepository;

@Component
@RequiredArgsConstructor
public class RemoveFieldParserImpl implements RemoveFieldParser {

    private final EndpointRepository endpointRepository;
    private final FieldParserRepository fieldParserRepository;

    @Override
    public void execute(Long fieldParserId) {
        final var fieldParser = fieldParserRepository
                .findById(fieldParserId)
                .orElseThrow();

        removeFieldParserFromEndpoint(fieldParser);

        fieldParserRepository.deleteById(fieldParserId);
    }

    private void removeFieldParserFromEndpoint(FieldParser fieldParser) {
        final var endpointsWithRemovedFieldParser = fieldParser
                .getEndpoints()
                .stream()
                .peek(endpoint -> endpoint.removeFieldParser(fieldParser))
                .toList();
        endpointRepository.saveAll(endpointsWithRemovedFieldParser);
    }
}
