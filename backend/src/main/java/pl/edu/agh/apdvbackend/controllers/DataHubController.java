package pl.edu.agh.apdvbackend.controllers;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Schema;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pl.edu.agh.apdvbackend.models.body_models.DataHubDataRequest;
import pl.edu.agh.apdvbackend.models.body_models.DataResponse;
import pl.edu.agh.apdvbackend.models.body_models.SensorInfo;
import pl.edu.agh.apdvbackend.services.DataHubService;

import java.util.List;

@RestController
@RequestMapping("/datahub")
public class DataHubController {
    private final DataHubService dataHubService;

    @Autowired
    public DataHubController(DataHubService dataHubService) {
        this.dataHubService = dataHubService;
    }

    @Operation(summary = "Get list of data from sensor")
    @GetMapping
    public List<DataResponse> getData(@RequestBody DataHubDataRequest dataHubDataRequest) {
        return dataHubService.getData(dataHubDataRequest);
    }

    @Operation(summary = "Get sensor information")
    @GetMapping("/info")
    public SensorInfo getSensorInfo(@RequestBody DataHubDataRequest dataHubDataRequest) {
        return dataHubService.getSensorInfo(dataHubDataRequest);
    }
}
