package pl.edu.agh.apdvbackend.models.database;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import io.swagger.v3.oas.annotations.media.Schema;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
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
@JsonIgnoreProperties({"fieldParserMap", "groupEndpoints"})
public class Endpoint {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(requiredMode = Schema.RequiredMode.REQUIRED)
    private Long id;

    @Schema(requiredMode = Schema.RequiredMode.REQUIRED)
    private int endpointNumber;

    @Schema(requiredMode = Schema.RequiredMode.REQUIRED)
    private String label;

    @Schema(requiredMode = Schema.RequiredMode.REQUIRED)
    private String sensorUrl;

    @ManyToMany
    @JoinTable(name = "fields_parser_mapping",
            joinColumns = {
                    @JoinColumn(name = "endpoint_id", referencedColumnName = "id")},
            inverseJoinColumns = {
                    @JoinColumn(name = "field_parser_id", referencedColumnName = "id")})
    @MapKeyJoinColumn(name = "field_id")
    private Map<Field, FieldParser> fieldParserMap = new HashMap<>();

    @OneToMany(mappedBy = "endpoint", cascade = CascadeType.ALL)
    private Set<GroupEndpoint> groupEndpoints = new HashSet<>();

    public String getFieldPath(Field field) {
        return fieldParserMap.get(field).getPath();
    }

    public void removeField(Field field) {
        fieldParserMap.remove(field);
    }

    public void removeFieldParser(FieldParser fieldParserToRemove) {
        fieldParserMap.values().remove(fieldParserToRemove);
    }
}
