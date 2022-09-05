package pl.edu.agh.apdvbackend.fakes;

import pl.edu.agh.apdvbackend.models.database.FieldParser;

public class FieldParserFakes {

    public static final long FIELD_PARSER_ID = 999L;

    public static FieldParser getFieldParser() {
        final var fieldParser = new FieldParser();
        fieldParser.setId(FIELD_PARSER_ID);
        fieldParser.setPath("dummy field parser path");

        return fieldParser;
    }
}
