package pl.edu.agh.apdvbackend.services;

import com.fasterxml.jackson.databind.node.ObjectNode;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import pl.edu.agh.apdvbackend.models.body_models.Response;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointRequestBody;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointResponseBody;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.EndpointWithField;
import pl.edu.agh.apdvbackend.models.body_models.endpoint.UserEndpointResponseBody;
import pl.edu.agh.apdvbackend.models.database.Endpoint;
import pl.edu.agh.apdvbackend.use_cases.endpoint.GetAllEndpointSummaries;
import pl.edu.agh.apdvbackend.use_cases.endpoint.GetAllUserEndpoints;
import pl.edu.agh.apdvbackend.use_cases.endpoint.GetUserEndpointData;
import pl.edu.agh.apdvbackend.use_cases.endpoint.GetUserEndpointDataWithFields;
import pl.edu.agh.apdvbackend.use_cases.endpoint.RemoveEndpointById;
import pl.edu.agh.apdvbackend.use_cases.endpoint.SaveNewEndpoint;
import pl.edu.agh.apdvbackend.use_cases.endpoint.UpdateEndpoint;
import pl.edu.agh.apdvbackend.use_cases.user.FindCurrentUserId;

@Service
@RequiredArgsConstructor
public class EndpointService {
    private final GetUserEndpointData getUserEndpointData;
    private final GetUserEndpointDataWithFields getUserEndpointDataWithFields;
    private final SaveNewEndpoint saveNewEndpoint;
    private final RemoveEndpointById removeEndpointById;
    private final GetAllEndpointSummaries getAllEndpointSummaries;
    private final GetAllUserEndpoints getAllUserEndpoints;
    private final UpdateEndpoint updateEndpoint;
    private final FindCurrentUserId findCurrentUserId;

    public Response<List<ObjectNode>> getData(
            Long sensorId,
            Long limit,
            Long offset
    ) {
        return Response.withOkStatus(getUserEndpointData.execute(findCurrentUserId.execute(), sensorId, limit, offset));
    }

    public Response<EndpointWithField> getDataWithFields(
            Long sensorId,
            Long limit,
            Long offset
    ) {
        return Response.withOkStatus(
                getUserEndpointDataWithFields.execute(findCurrentUserId.execute(), sensorId, limit, offset)
        );
    }

    public Response<List<EndpointResponseBody>> getEndpointsList() {
        return Response.withOkStatus(getAllEndpointSummaries.execute());
    }

    public Response<Endpoint> addEndpoint(EndpointRequestBody endpointRequestBody) {
        return Response.withOkStatus(saveNewEndpoint.execute(endpointRequestBody));
    }

    public void removeEndpoint(Long endpointId) {
        removeEndpointById.execute(endpointId);
    }

    public Response<List<UserEndpointResponseBody>> getUserEndpointsList() {
        return Response.withOkStatus(getAllUserEndpoints.execute(findCurrentUserId.execute()));
    }

    public Response<Endpoint> updateEndpoint(
            EndpointRequestBody endpointRequestBody,
            Long endpointId
    ) {
        return Response.withOkStatus(updateEndpoint.execute(endpointRequestBody, endpointId));
    }
}
