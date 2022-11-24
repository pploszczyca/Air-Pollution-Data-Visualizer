package pl.edu.agh.apdvbackend.services;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.models.body_models.unit_converter.UnitConverterRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.unit_converter.UnitConverterResponseBody;
import pl.edu.agh.apdvbackend.use_cases.unit_converter.GetAllRelatedUnitConvertersResponseBodies;
import pl.edu.agh.apdvbackend.use_cases.unit_converter.GetAllUnitConverterResponseBodies;
import pl.edu.agh.apdvbackend.use_cases.unit_converter.RemoveUnitConverterById;
import pl.edu.agh.apdvbackend.use_cases.unit_converter.SaveUnitConverter;
import pl.edu.agh.apdvbackend.use_cases.unit_converter.UpdateUnitConverter;

@Service
@RequiredArgsConstructor
public class UnitConverterService {

    private final GetAllUnitConverterResponseBodies getAllUnitConverterResponseBodies;
    private final GetAllRelatedUnitConvertersResponseBodies getAllRelatedUnitConvertersResponseBodies;
    private final SaveUnitConverter saveUnitConverter;
    private final RemoveUnitConverterById removeUnitConverterById;
    private final UpdateUnitConverter updateUnitConverter;

    public Response<List<UnitConverterResponseBody>> getAllUnitConverters() {
        return Response.withOkStatus(getAllUnitConverterResponseBodies.execute());
    }

    public Response<List<UnitConverterResponseBody>> getAllUnitConvertersRelatedWithUnit(Long unitId) {
        return Response.withOkStatus(getAllRelatedUnitConvertersResponseBodies.execute(unitId));
    }

    public Response<UnitConverterResponseBody> addUnitConverter(
            UnitConverterRequestBody unitConverterRequestBody
    ) {
        return Response.withOkStatus(saveUnitConverter.execute(unitConverterRequestBody));
    }

    public void removeUnitConverter(Long unitConverterId) {
        removeUnitConverterById.execute(unitConverterId);
    }

    public Response<UnitConverterResponseBody> updateUnitConverter(
            Long unitConverterId,
            UnitConverterRequestBody unitConverterRequestBody
    ) {
        return Response.withOkStatus(updateUnitConverter.execute(unitConverterId, unitConverterRequestBody));
    }
}
