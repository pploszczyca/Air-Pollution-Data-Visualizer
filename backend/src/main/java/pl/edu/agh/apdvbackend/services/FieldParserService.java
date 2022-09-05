package pl.edu.agh.apdvbackend.services;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.models.body_models.field_parser.AddFieldParserRequestBody;
import pl.edu.agh.apdvbackend.models.database.FieldParser;
import pl.edu.agh.apdvbackend.use_cases.field_parser.GetAllFieldParsers;
import pl.edu.agh.apdvbackend.use_cases.field_parser.RemoveFieldParser;
import pl.edu.agh.apdvbackend.use_cases.field_parser.SaveNewFieldParser;
import pl.edu.agh.apdvbackend.use_cases.field_parser.UpdateFieldParser;

@Service
@RequiredArgsConstructor
public class FieldParserService {

    private final SaveNewFieldParser saveNewFieldParser;
    private final GetAllFieldParsers allFieldParsers;
    private final RemoveFieldParser removeFieldParser;
    private final UpdateFieldParser updateFieldParser;

    public Response<FieldParser> addFieldParser(AddFieldParserRequestBody addFieldParserRequestBody) {
        return Response.withOkStatus(saveNewFieldParser.execute(addFieldParserRequestBody));
    }

    public Response<List<FieldParser>> getAllFieldParsers() {
        return Response.withOkStatus(allFieldParsers.execute());
    }

    public void removeFieldParserById(Long fieldParserId) {
        removeFieldParser.execute(fieldParserId);
    }

    public Response<FieldParser> updateFieldParser(
            Long fieldParserId,
            AddFieldParserRequestBody addFieldParserRequestBody
    ) {
        return Response.withOkStatus(updateFieldParser.execute(fieldParserId, addFieldParserRequestBody));
    }
}
