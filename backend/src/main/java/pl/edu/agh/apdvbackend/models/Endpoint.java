package pl.edu.agh.apdvbackend.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import io.swagger.v3.oas.annotations.media.Schema;
import java.util.Map;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.MapKeyJoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "endpoint")
@Getter
@Setter
@NoArgsConstructor
@JsonIgnoreProperties({"fieldParserMap", "enableEndpointsForGroups"})
public class Endpoint {
    @Id
    @GeneratedValue
    @Schema(required = true)
    private Long id;

    @Schema(required = true)
    private int endpointNumber;

    @Schema(required = true)
    private String label;

    @Schema(required = true)
    private String sensorUrl;

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "fields_parser_mapping",
            joinColumns = {
                    @JoinColumn(name = "endpoint_id", referencedColumnName = "id")},
            inverseJoinColumns = {
                    @JoinColumn(name = "field_parser_id", referencedColumnName = "id")})
    @MapKeyJoinColumn(name = "field_id")
    private Map<Field, FieldParser> fieldParserMap;

    @OneToMany(mappedBy = "endpoint")
    private Set<EnableEndpointsForGroup> enableEndpointsForGroups;

    public String getFieldPath(Field field) {
        return fieldParserMap.get(field).getPath();
    }
}
