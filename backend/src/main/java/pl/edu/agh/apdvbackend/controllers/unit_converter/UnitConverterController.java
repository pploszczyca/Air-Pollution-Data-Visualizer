package pl.edu.agh.apdvbackend.controllers.unit_converter;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import pl.edu.agh.apdvbackend.controllers.unit_converter.body_models.AddUnitConverterRequestBody;
import pl.edu.agh.apdvbackend.controllers.unit_converter.body_models.UnitConverterResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.services.UnitConverterService;

@RestController
@RequestMapping("/unit/converter")
@RequiredArgsConstructor
@Tag(name = "Unit Converter")
public class UnitConverterController {

    private final UnitConverterService unitConverterService;

    @Operation(summary = "Get all available unit converters.")
    @GetMapping("/all")
    public Response<List<UnitConverterResponseBody>> getAllUnitConverters() {
        return unitConverterService.getAllUnitConverters();
    }

    @Operation(summary = "Get all unit converters related with specific unit.")
    @GetMapping
    public Response<List<UnitConverterResponseBody>> getAllUnitConvertersRelatedWithUnit(@RequestParam Long unitId) {
        return unitConverterService.getAllUnitConvertersRelatedWithUnit(unitId);
    }

    @Operation(summary = "Add new unit converter")
    @PostMapping
    public Response<UnitConverterResponseBody> addUnitConverter(@RequestBody
                                                                AddUnitConverterRequestBody addUnitConverterRequestBody) {
        return unitConverterService.addUnitConverter(addUnitConverterRequestBody);
    }

    @Operation(summary = "Delete unit converter")
    @DeleteMapping
    public void removeUnitConverter(@RequestParam Long unitConverterId) {
        unitConverterService.removeUnitConverter(unitConverterId);
    }
}
