package pl.edu.agh.apdvbackend.mappers.field_parser;

import java.util.List;
import java.util.Map;
import org.mapstruct.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import pl.edu.agh.apdvbackend.models.body_models.field_and_parser.FieldAndParser;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.models.database.FieldParser;

@Mapper(componentModel = "spring")
public abstract class FieldParserMapMapper {

    @Autowired
    private FieldAndParserMapper fieldAndParserMapper;

    public List<FieldAndParser> toFieldAndParserList(Map<Field, FieldParser> fieldParserMap) {
        return fieldParserMap
                .entrySet()
                .stream()
                .map(entry -> fieldAndParserMapper.combineFieldAndParser(entry.getKey(), entry.getValue()))
                .toList();
    }
}
