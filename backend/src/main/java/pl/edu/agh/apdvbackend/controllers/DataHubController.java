package pl.edu.agh.apdvbackend.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pl.edu.agh.apdvbackend.models.body_models.DataHubDataRequest;
import pl.edu.agh.apdvbackend.models.body_models.DataResponse;
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

    @GetMapping
    public List<DataResponse> getData(@RequestBody DataHubDataRequest dataHubDataRequest) {
        return dataHubService.getData(dataHubDataRequest);
    }
}
