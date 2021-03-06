package pl.edu.agh.apdvbackend.controllers;

import com.fasterxml.jackson.databind.node.ObjectNode;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.AddEndpointRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointData;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointSummaryResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.UserEndpointResponseBody;
import pl.edu.agh.apdvbackend.models.database.Endpoint;
import pl.edu.agh.apdvbackend.services.EndpointService;

@RestController
@RequestMapping("/sensor")
@RequiredArgsConstructor
@Tag(name = "Endpoint")
public class EndpointController {
    // TODO: Remove USER_ID when JWT will be implemented
    private static final Long USER_ID = 1L;

    private final EndpointService endpointService;

    @Operation(summary = "Get list of data from sensor that belongs to user")
    @GetMapping
    public Response<List<ObjectNode>> getData(
            @RequestParam Long sensorId,
            @RequestParam(required = false, defaultValue = "25") Long limit,
            @RequestParam(required = false, defaultValue = "0") Long offset) {
        return endpointService.getData(USER_ID, sensorId, limit, offset);
    }

    @Operation(summary = "Get list of data from sensor that belongs to user with enable fields")
    @GetMapping("/data")
    public Response<EndpointData> getDataWithFields(
            @RequestParam Long sensorId,
            @RequestParam(required = false, defaultValue = "25") Long limit,
            @RequestParam(required = false, defaultValue = "0") Long offset) {
        return endpointService.getDataWithFields(USER_ID, sensorId, limit,
                offset);
    }

    @Operation(summary = "Get user's endpoints list")
    @GetMapping("/list")
    public Response<List<UserEndpointResponseBody>> getUserEndpointsList() {
        return endpointService.getUserEndpointsList(USER_ID);
    }

    @Operation(summary = "Get all endpoints list with fields information")
    @GetMapping("/list/all")
    public Response<List<EndpointSummaryResponseBody>> getEndpointsList() {
        return endpointService.getEndpointsList();
    }

    @Operation(summary = "Add new endpoint")
    @PostMapping
    public Response<Endpoint> addEndpoint(
            @RequestBody AddEndpointRequestBody addEndpointRequestBody) {
        return endpointService.addEndpoint(addEndpointRequestBody);
    }

    @Operation(summary = "Remove endpoint")
    @DeleteMapping
    public void removeEndpoint(@RequestParam Long endpointId) {
        endpointService.removeEndpoint(endpointId);
    }

    @Operation(summary = "Update endpoint")
    @PutMapping
    public Response<Endpoint> updateEndpoint(
            @RequestBody AddEndpointRequestBody addEndpointRequestBody,
            @RequestParam Long endpointId) {
        return endpointService.updateEndpoint(addEndpointRequestBody,
                endpointId);
    }
}
