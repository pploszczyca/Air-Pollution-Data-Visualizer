package pl.edu.agh.apdvbackend.mappers.group_endpoint_key;

import org.mapstruct.Mapper;
import pl.edu.agh.apdvbackend.models.database.GroupEndpointKey;

@Mapper(componentModel = "spring")
public interface GroupEndpointKeyMapper {
    GroupEndpointKey map(Long groupId, Long endpointId);
}
