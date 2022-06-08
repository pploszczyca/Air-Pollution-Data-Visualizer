package pl.edu.agh.apdvbackend.controllers.field_parser;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import pl.edu.agh.apdvbackend.controllers.field_parser.body_models.AddFieldParserRequestBody;
import pl.edu.agh.apdvbackend.models.FieldParser;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.services.FieldParserService;

@RestController
@RequestMapping("/field/parser")
@RequiredArgsConstructor
@Tag(name = "Field Parser")
public class FieldParserController {

    private final FieldParserService fieldParserService;

    @Operation(summary = "Add new field parser")
    @PostMapping
    public Response<FieldParser> addField(
            @RequestBody AddFieldParserRequestBody addFieldParserRequestBody) {
        return fieldParserService.addFieldParser(addFieldParserRequestBody);
    }

    @Operation(summary = "Get list of all field parsers")
    @GetMapping
    public Response<List<FieldParser>> getAllFields() {
        return fieldParserService.getAllFieldParsers();
    }

    @Operation(summary = "Remove field parser by id")
    @DeleteMapping
    public void removeFieldById(@RequestParam Long fieldParserId) {
        fieldParserService.removeFieldParserById(fieldParserId);
    }

    @Operation(summary = "Update field parser")
    @PutMapping
    public Response<FieldParser> updateFieldParser(
            @RequestParam Long fieldParserId,
            @RequestBody AddFieldParserRequestBody addFieldParserRequestBody) {
        return fieldParserService.updateFieldParser(fieldParserId,
                addFieldParserRequestBody);
    }
}
