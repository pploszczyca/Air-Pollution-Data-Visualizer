package pl.edu.agh.apdvbackend.controllers;

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
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.models.body_models.field.AddFieldBodyRequest;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.services.FieldService;

@RestController
@RequestMapping("/field")
@RequiredArgsConstructor
@Tag(name = "Field")
public class FieldController {
    // TODO: Remove USER_ID when JWT will be implemented
    private static final Long USER_ID = 1L;

    private final FieldService fieldService;

    @Operation(summary = "Add new field")
    @PostMapping
    public Response<Field> addField(
            @RequestBody AddFieldBodyRequest addFieldBodyRequest) {
        return fieldService.addField(addFieldBodyRequest);
    }

    @Operation(summary = "Get list of all fields")
    @GetMapping
    public Response<List<Field>> getAllFields() {
        return fieldService.getAllFields();
    }

    @Operation(summary = "Get list of fields, that are enable for user by endpointId")
    @GetMapping("/enable")
    public Response<List<Field>> getAllEnableEndpoints(
            @RequestParam Long endpointId) {
        return fieldService.getAllEnableEndpoints(USER_ID, endpointId);
    }

    @Operation(summary = "Remove field by id")
    @DeleteMapping
    public void removeFieldById(@RequestParam Long fieldId) {
        fieldService.removeFieldById(fieldId);
    }

    @Operation(summary = "Update field")
    @PutMapping
    public Response<Field> updateField(
            @RequestParam Long fieldId,
            @RequestBody AddFieldBodyRequest addFieldBodyRequest) {
        return fieldService.updateField(fieldId, addFieldBodyRequest);
    }
}
