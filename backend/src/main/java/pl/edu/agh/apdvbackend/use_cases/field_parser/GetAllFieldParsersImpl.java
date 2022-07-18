package pl.edu.agh.apdvbackend.use_cases.field_parser;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.database.FieldParser;
import pl.edu.agh.apdvbackend.repositories.FieldParserRepository;
import pl.edu.agh.apdvbackend.utilities.ListUtilities;

@Component
@RequiredArgsConstructor
public class GetAllFieldParsersImpl
        implements GetAllFieldParsers {

    private final FieldParserRepository fieldParserRepository;

    private final ListUtilities listUtilities;

    @Override
    public List<FieldParser> execute() {
        return listUtilities.iterableToList(fieldParserRepository.findAll());
    }
}
