package pl.edu.agh.apdvbackend.services;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import pl.edu.agh.apdvbackend.controllers.field.body_models.AddFieldBodyRequest;
import pl.edu.agh.apdvbackend.models.Field;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.use_cases.field.GetAllFields;
import pl.edu.agh.apdvbackend.use_cases.field.RemoveField;
import pl.edu.agh.apdvbackend.use_cases.field.SaveNewField;
import pl.edu.agh.apdvbackend.use_cases.field.UpdateField;

@Service
@RequiredArgsConstructor
public class FieldService {

    private final SaveNewField saveNewField;

    private final GetAllFields getAllFields;

    private final RemoveField removeField;

    private final UpdateField updateField;

    public Response<Field> addField(AddFieldBodyRequest addFieldBodyRequest) {
        return Response.withOkStatus(saveNewField.execute(addFieldBodyRequest));
    }

    public Response<List<Field>> getAllFields() {
        return Response.withOkStatus(getAllFields.execute());
    }

    public void removeFieldById(Long fieldId) {
        removeField.execute(fieldId);
    }

    public Response<Field> updateField(Long fieldId, AddFieldBodyRequest addFieldBodyRequest) {
        return Response.withOkStatus(updateField.execute(fieldId, addFieldBodyRequest));
    }
}
