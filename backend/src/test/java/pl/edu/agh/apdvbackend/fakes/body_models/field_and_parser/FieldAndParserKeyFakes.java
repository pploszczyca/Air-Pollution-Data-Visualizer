package pl.edu.agh.apdvbackend.fakes.body_models.field_and_parser;

import lombok.Builder;
import pl.edu.agh.apdvbackend.models.body_models.field_and_parser.FieldAndParserKey;

public class FieldAndParserKeyFakes {

    @Builder
    private static FieldAndParserKey buildNewFieldAndParserKey(
            Long fieldId,
            Long parserId
    ) {
        return new FieldAndParserKey(fieldId, parserId);
    }
}
