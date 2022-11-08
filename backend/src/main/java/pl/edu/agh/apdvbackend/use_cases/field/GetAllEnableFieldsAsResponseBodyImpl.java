package pl.edu.agh.apdvbackend.use_cases.field;

import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.mappers.field.FieldResponseBodyMapper;
import pl.edu.agh.apdvbackend.models.body_models.field.FieldResponseBody;

@Component
@RequiredArgsConstructor
public class GetAllEnableFieldsAsResponseBodyImpl implements GetAllEnableFieldsAsResponseBody {

    private final GetAllEnableFieldsForEndpointAndUser getAllEnableFieldsForEndpointAndUser;
    private final FieldResponseBodyMapper fieldResponseBodyMapper;

    @Override
    public List<FieldResponseBody> execute(Long userId, Long endpointId) {
        return fieldResponseBodyMapper.toResponseBodyList(
                getAllEnableFieldsForEndpointAndUser.execute(userId, endpointId)
        );
    }
}
