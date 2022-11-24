package pl.edu.agh.apdvbackend.mappers.field_parser;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.mapstruct.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.models.body_models.field_and_parser.FieldAndParserKey;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.FieldParser;
import pl.edu.agh.apdvbackend.use_cases.field.GetField;
import pl.edu.agh.apdvbackend.use_cases.field_parser.GetOrSaveFieldParser;

@Mapper(componentModel = "spring")
public abstract class FieldAndParserKeyMapper {

    @Autowired
    private GetField getField;

    @Autowired
    private GetOrSaveFieldParser getOrSaveFieldParser;

    public Map<Field, FieldParser> toMap(List<FieldAndParserKey> fieldAndParserKeys) {
        return fieldAndParserKeys.stream().collect(
                Collectors.toMap(
                        key -> getField.execute(key.fieldId()),
                        key -> getOrSaveFieldParser.execute(key.fieldParserPath())
                )
        );
    }
}
