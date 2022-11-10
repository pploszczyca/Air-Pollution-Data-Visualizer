package pl.edu.agh.apdvbackend.use_cases.field;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.models.database.Field;
import pl.edu.agh.apdvbackend.repositories.EndpointRepository;
import pl.edu.agh.apdvbackend.repositories.FieldRepository;
import pl.edu.agh.apdvbackend.repositories.GroupEndpointRepository;

@Component
@RequiredArgsConstructor
public class RemoveFieldImpl implements RemoveField {

    private final FieldRepository fieldRepository;
    private final EndpointRepository endpointRepository;
    private final GroupEndpointRepository groupEndpointRepository;

    @Override
    public void execute(Long fieldId) {
        final var field = fieldRepository
                .findById(fieldId)
                .orElseThrow();

        removeFieldFromEndpoint(field);
        removeFieldFromGroupEndpoint(field);
        fieldRepository.deleteById(fieldId);
    }

    private void removeFieldFromEndpoint(Field field) {
        final var endpointsWithRemovedField = field
                .getEndpoints()
                .stream()
                .peek(endpoint -> endpoint.removeField(field))
                .toList();
        endpointRepository.saveAll(endpointsWithRemovedField);
    }

    private void removeFieldFromGroupEndpoint(Field field) {
        final var groupEndpointsWithRemovedField = field
                .getGroupEndpoint()
                .stream()
                .peek(groupEndpoint -> groupEndpoint.removeField(field))
                .toList();
        groupEndpointRepository.saveAll(groupEndpointsWithRemovedField);
    }
}
