package pl.edu.agh.apdvbackend.services;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.models.body_models.field.AddFieldBodyRequest;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.use_cases.field.GetAllEnableFieldsForEndpointAndUser;
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

    private final GetAllEnableFieldsForEndpointAndUser
            getAllEnableFieldsForEndpointAndUser;

    private final RemoveField removeField;

    private final UpdateField updateField;

    private final FindCurrentUserId findCurrentUserId;

    public Response<Field> addField(AddFieldBodyRequest addFieldBodyRequest) {
        return Response.withOkStatus(saveNewField.execute(addFieldBodyRequest));
    }

    public Response<List<Field>> getAllFields() {
        return Response.withOkStatus(getAllFields.execute());
    }

    public Response<List<Field>> getAllEnableEndpoints(Long endpointId) {
        return Response.withOkStatus(
                getAllEnableFieldsForEndpointAndUser.execute(findCurrentUserId.execute(),
                        endpointId));
    }

    public void removeFieldById(Long fieldId) {
        removeField.execute(fieldId);
    }

    public Response<Field> updateField(Long fieldId,
                                       AddFieldBodyRequest addFieldBodyRequest) {
        return Response.withOkStatus(
                updateField.execute(fieldId, addFieldBodyRequest));
    }
}
