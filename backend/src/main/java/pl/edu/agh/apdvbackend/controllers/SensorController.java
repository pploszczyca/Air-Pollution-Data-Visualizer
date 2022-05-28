package pl.edu.agh.apdvbackend.controllers;

import io.swagger.v3.oas.annotations.Operation;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import pl.edu.agh.apdvbackend.models.body_models.DataResponse;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.models.body_models.SensorInfo;
import pl.edu.agh.apdvbackend.services.SensorService;

@RestController
@RequestMapping("/sensor")
public class SensorController {
    private final SensorService sensorService;

    @Autowired
    public SensorController(SensorService sensorService) {
        this.sensorService = sensorService;
    }

    @Operation(summary = "Get list of data from sensor")
    @GetMapping
    public Response<List<DataResponse>> getWeatherData(
            @RequestParam String sensorUrl) {
        return sensorService.getWeatherData(sensorUrl);
    }

    @Operation(summary = "Get sensor information")
    @GetMapping("/info")
    public Response<SensorInfo> getSensorInfo(@RequestParam String sensorUrl) {
        return sensorService.getSensorInfo(sensorUrl);
    }
}
