package pl.edu.agh.apdvbackend.services;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.models.body_models.field.FieldRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.field.FieldResponseBody;
import pl.edu.agh.apdvbackend.use_cases.field.GetAllEnableFieldsAsResponseBody;
import pl.edu.agh.apdvbackend.use_cases.field.GetAllFields;
import pl.edu.agh.apdvbackend.use_cases.field.RemoveField;
import pl.edu.agh.apdvbackend.use_cases.field.SaveNewField;
import pl.edu.agh.apdvbackend.use_cases.field.UpdateField;
import pl.edu.agh.apdvbackend.use_cases.user.FindCurrentUserId;

@Service
@RequiredArgsConstructor
public class FieldService {

    private final SaveNewField saveNewField;
    private final GetAllFields getAllFields;
    private final GetAllEnableFieldsAsResponseBody getAllEnableFieldsAsResponseBody;
    private final RemoveField removeField;
    private final UpdateField updateField;
    private final FindCurrentUserId findCurrentUserId;

    public Response<FieldResponseBody> addField(FieldRequestBody fieldRequestBody) {
        return Response.withOkStatus(saveNewField.execute(fieldRequestBody));
    }

    public Response<List<FieldResponseBody>> getAllFields() {
        return Response.withOkStatus(getAllFields.execute());
    }

    public Response<List<FieldResponseBody>> getAllEnableEndpoints(Long endpointId) {
        return Response.withOkStatus(
                getAllEnableFieldsAsResponseBody.execute(findCurrentUserId.execute(), endpointId)
        );
    }

    public void removeFieldById(Long fieldId) {
        removeField.execute(fieldId);
    }

    public Response<FieldResponseBody> updateField(
            Long fieldId,
            FieldRequestBody fieldRequestBody
    ) {
        return Response.withOkStatus(updateField.execute(fieldId, fieldRequestBody));
    }
}
