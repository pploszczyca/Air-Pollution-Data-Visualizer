package pl.edu.agh.apdvbackend.services;

import com.fasterxml.jackson.databind.node.ObjectNode;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pl.edu.agh.apdvbackend.controllers.endpoint.body_models.AddEndpointRequestBody;
import pl.edu.agh.apdvbackend.controllers.endpoint.body_models.UserEndpointResponseBody;
import pl.edu.agh.apdvbackend.models.Endpoint;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.use_cases.endpoint.GetAllEndpoints;
import pl.edu.agh.apdvbackend.use_cases.endpoint.GetAllUserEndpoints;
import pl.edu.agh.apdvbackend.use_cases.endpoint.GetUserEndpointData;
import pl.edu.agh.apdvbackend.use_cases.endpoint.RemoveEndpointById;
import pl.edu.agh.apdvbackend.use_cases.endpoint.SaveNewEndpoint;
import pl.edu.agh.apdvbackend.use_cases.endpoint.UpdateEndpoint;

@Service
@RequiredArgsConstructor
public class EndpointService {
    private final GetUserEndpointData getUserEndpointData;

    private final SaveNewEndpoint saveNewEndpoint;

    private final RemoveEndpointById removeEndpointById;

    private final GetAllEndpoints getAllEndpoints;

    private final GetAllUserEndpoints getAllUserEndpoints;

    private final UpdateEndpoint updateEndpoint;

    public Response<List<ObjectNode>> getData(Long userId,
                                              Long sensorId) {
        return Response.withOkStatus(
                getUserEndpointData.execute(userId, sensorId));
    }

    public Response<List<Endpoint>> getEndpointsList() {
        return Response.withOkStatus(getAllEndpoints.execute());
    }

    public Endpoint addEndpoint(
            AddEndpointRequestBody addEndpointRequestBody) {
        return saveNewEndpoint.execute(addEndpointRequestBody);
    }

    public void removeEndpoint(Long endpointId) {
        removeEndpointById.execute(endpointId);
    }

    public Response<List<UserEndpointResponseBody>> getUserEndpointsList(Long userId) {
        return Response.withOkStatus(getAllUserEndpoints.execute(userId));
    }

    public Response<Endpoint> updateEndpoint(
            AddEndpointRequestBody addEndpointRequestBody, Long endpointId) {
        return Response.withOkStatus(
                updateEndpoint.execute(addEndpointRequestBody, endpointId));
    }
}
