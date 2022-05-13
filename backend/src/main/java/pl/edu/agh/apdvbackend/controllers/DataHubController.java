package pl.edu.agh.apdvbackend.controllers;

import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import pl.edu.agh.apdvbackend.models.body_models.DataResponse;
import pl.edu.agh.apdvbackend.models.body_models.SensorInfo;
import pl.edu.agh.apdvbackend.services.DataHubService;

import java.util.List;

@RestController
@RequestMapping("/sensor")
public class DataHubController {
    private final DataHubService dataHubService;

    @Autowired
    public DataHubController(DataHubService dataHubService) {
        this.dataHubService = dataHubService;
    }

    @Operation(summary = "Get list of data from sensor")
    @GetMapping
    public List<DataResponse> getData(@RequestParam String sensorUrl) {
        return dataHubService.getData(sensorUrl);
    }

    @Operation(summary = "Get sensor information")
    @GetMapping("/info")
    public SensorInfo getSensorInfo(@RequestParam String sensorUrl) {
        return dataHubService.getSensorInfo(sensorUrl);
    }
}
