package pl.edu.agh.apdvbackend.controllers;

import com.fasterxml.jackson.databind.node.ObjectNode;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
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
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointWithField;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.UserEndpointResponseBody;
import pl.edu.agh.apdvbackend.models.database.Endpoint;
import pl.edu.agh.apdvbackend.services.EndpointService;

import static pl.edu.agh.apdvbackend.configs.SwaggerConfig.JWT_AUTH;

@RestController
@RequestMapping("/sensor")
@RequiredArgsConstructor
@Tag(name = "Endpoint")
public class EndpointController {
    private final EndpointService endpointService;

    @Operation(
            summary = "Get list of data from sensor that belongs to user",
            security = @SecurityRequirement(name = JWT_AUTH)
    )
    @GetMapping
    public Response<List<ObjectNode>> getData(
            @RequestParam Long sensorId,
            @RequestParam(required = false, defaultValue = "25") Long limit,
            @RequestParam(required = false, defaultValue = "0") Long offset
    ) {
        return endpointService.getData(sensorId, limit, offset);
    }

    @Operation(
            summary = "Get list of data from sensor that belongs to user with enable fields",
            security = @SecurityRequirement(name = JWT_AUTH)
    )
    @GetMapping("/data")
    public Response<EndpointWithField> getDataWithFields(
            @RequestParam Long sensorId,
            @RequestParam(required = false, defaultValue = "25") Long limit,
            @RequestParam(required = false, defaultValue = "0") Long offset
    ) {
        return endpointService.getDataWithFields(sensorId, limit, offset);
    }

    @Operation(
            summary = "Get user's endpoints list",
            security = @SecurityRequirement(name = JWT_AUTH)
    )
    @GetMapping("/list")
    public Response<List<UserEndpointResponseBody>> getUserEndpointsList() {
        return endpointService.getUserEndpointsList();
    }

    @Operation(
            summary = "Get all endpoints list with fields information",
            security = @SecurityRequirement(name = JWT_AUTH)
    )
    @GetMapping("/list/all")
    public Response<List<EndpointResponseBody>> getEndpointsList() {
        return endpointService.getEndpointsList();
    }

    @Operation(
            summary = "Add new endpoint",
            security = @SecurityRequirement(name = JWT_AUTH)
    )
    @PostMapping
    public Response<Endpoint> addEndpoint(@RequestBody EndpointRequestBody endpointRequestBody) {
        return endpointService.addEndpoint(endpointRequestBody);
    }

    @Operation(
            summary = "Remove endpoint",
            security = @SecurityRequirement(name = JWT_AUTH)
    )
    @DeleteMapping
    public void removeEndpoint(@RequestParam Long endpointId) {
        endpointService.removeEndpoint(endpointId);
    }

    @Operation(
            summary = "Update endpoint",
            security = @SecurityRequirement(name = JWT_AUTH)
    )
    @PutMapping
    public Response<EndpointResponseBody> updateEndpoint(
            @RequestBody EndpointRequestBody endpointRequestBody,
            @RequestParam Long endpointId
    ) {
        return endpointService.updateEndpoint(endpointRequestBody,
                endpointId);
    }
}
