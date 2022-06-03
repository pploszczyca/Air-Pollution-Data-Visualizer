package pl.edu.agh.apdvbackend.controllers.sensor;

import com.fasterxml.jackson.databind.node.ObjectNode;
import io.swagger.v3.oas.annotations.Operation;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import pl.edu.agh.apdvbackend.controllers.sensor.body_models.AddEndpointRequestBody;
import pl.edu.agh.apdvbackend.models.Endpoint;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.services.EndpointService;

@RestController
@RequestMapping("/sensor")
@RequiredArgsConstructor
public class EndpointController {
    private static final Long GROUP_ID = 1L;

    private final EndpointService endpointService;


    @Operation(summary = "Get list of data from sensor")
    @GetMapping
    public Response<List<ObjectNode>> getWeatherData(
            @RequestParam Long sensorId) {
        return endpointService.getWeatherData(GROUP_ID, sensorId);
    }

    @Operation(summary = "Get endpoint list")
    @GetMapping("/list")
    public Response<List<Endpoint>> getEndpointsList() {
        return endpointService.getEndpointsList();
    }

    @Operation(summary = "Add new endpoint")
    @PostMapping
    public Endpoint addEndpoint(
            @RequestBody AddEndpointRequestBody addEndpointRequestBody) {
        return endpointService.addEndpoint(addEndpointRequestBody);
    }

    @Operation(summary = "Remove endpoint")
    @DeleteMapping
    public void removeEndpoint(@RequestParam Long endpointId) {
        endpointService.removeEndpoint(endpointId);
    }
}
