package pl.edu.agh.apdvbackend.models;

import io.swagger.v3.oas.annotations.media.Schema;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "data_type_parser")
@Getter
@Setter
@NoArgsConstructor
public class DataTypeParser {
    @Id
    @GeneratedValue
    @Schema(required = true)
    private Long id;

    @Schema(required = true)
    private String path;
}
