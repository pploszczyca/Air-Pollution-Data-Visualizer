package pl.edu.agh.apdvbackend.controllers;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
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
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.models.body_models.field_parser.AddFieldParserRequestBody;
import pl.edu.agh.apdvbackend.models.database.FieldParser;
import pl.edu.agh.apdvbackend.services.FieldParserService;

import static pl.edu.agh.apdvbackend.configs.SwaggerConfig.JWT_AUTH;

@RestController
@RequestMapping("/field/parser")
@RequiredArgsConstructor
@Tag(name = "Field Parser")
public class FieldParserController {

    private final FieldParserService fieldParserService;

    @Operation(
            summary = "Add new field parser",
            security = @SecurityRequirement(name = JWT_AUTH)
    )
    @PostMapping
    public Response<FieldParser> addField(@RequestBody AddFieldParserRequestBody addFieldParserRequestBody) {
        return fieldParserService.addFieldParser(addFieldParserRequestBody);
    }

    @Operation(
            summary = "Get list of all field parsers",
            security = @SecurityRequirement(name = JWT_AUTH)
    )
    @GetMapping
    public Response<List<FieldParser>> getAllFields() {
        return fieldParserService.getAllFieldParsers();
    }

    @Operation(
            summary = "Remove field parser by id",
            security = @SecurityRequirement(name = JWT_AUTH)
    )
    @DeleteMapping
    public void removeFieldById(@RequestParam Long fieldParserId) {
        fieldParserService.removeFieldParserById(fieldParserId);
    }

    @Operation(
            summary = "Update field parser",
            security = @SecurityRequirement(name = JWT_AUTH)
    )
    @PutMapping
    public Response<FieldParser> updateFieldParser(
            @RequestParam Long fieldParserId,
            @RequestBody AddFieldParserRequestBody addFieldParserRequestBody
    ) {
        return fieldParserService.updateFieldParser(fieldParserId,
                addFieldParserRequestBody);
    }
}
