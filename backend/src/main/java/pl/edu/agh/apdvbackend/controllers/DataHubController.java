package pl.edu.agh.apdvbackend.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import pl.edu.agh.apdvbackend.services.DataHubService;

@RestController
@RequestMapping("/datahub")
public class DataHubController {
    private final DataHubService dataHubService;

    @Autowired
    public DataHubController(DataHubService dataHubService) {
        this.dataHubService = dataHubService;
    }

    @GetMapping
    public ResponseEntity<?> getData() {
        return dataHubService.getData();
    }
}
