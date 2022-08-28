package pl.edu.agh.apdvbackend.fakes.body_models.field_and_parser;

import lombok.Builder;
import pl.edu.agh.apdvbackend.models.body_models.field_and_parser.FieldAndParser;

public class FieldAndParserFakes {
    
    @Builder
    private static FieldAndParser buildNewFieldAndParser(
            Long fieldId,
            Long parserId,
            String label,
            String path
    ) {
        return new FieldAndParser(
                fieldId, 
                parserId, 
                getOrElse(label, "dummy label"), 
                getOrElse(path, "/dummy/path")
        );
    }

    private static <T> T getOrElse(T value, T defaultValue) {
        return value == null ? defaultValue : value;
    }
}
