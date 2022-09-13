package pl.edu.agh.apdvbackend.fakes;

import lombok.Builder;
import pl.edu.agh.apdvbackend.models.database.FieldParser;

public class FieldParserFakes {

    public static final long FIELD_PARSER_ID = 999L;

    public static FieldParser getFieldParser() {
        final var fieldParser = new FieldParser();
        fieldParser.setId(FIELD_PARSER_ID);
        fieldParser.setPath("dummy field parser path");

        return fieldParser;
    }

    @Builder
    private static FieldParser buildNewFieldParser(
            Long id,
            String path
    ) {
        final var fieldParser = new FieldParser();
        fieldParser.setId(id);
        fieldParser.setPath(getOrElse(path, "dummy field parser path"));

        return fieldParser;
    }

    private static <T> T getOrElse(T value, T defaultValue) {
        return value == null ? defaultValue : value;
    }
}
