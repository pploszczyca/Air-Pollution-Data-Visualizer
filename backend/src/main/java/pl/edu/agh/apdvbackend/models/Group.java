package pl.edu.agh.apdvbackend.models;

import io.swagger.v3.oas.annotations.media.Schema;
import java.util.Set;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "group")
@Getter
@Setter
@NoArgsConstructor
public class Group {
    @Id
    @GeneratedValue
    @Schema(required = true)
    private Long id;

    @Schema(required = true)
    private String name;

    @ManyToMany
    @JoinTable(
            name = "users_in_group",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "group_id")
    )
    private Set<User> usersInGroup;

    @ManyToMany
    @JoinTable(
            name = "endpoints_in_group",
            joinColumns = @JoinColumn(name = "endpoint_info_id"),
            inverseJoinColumns = @JoinColumn(name = "group_id")
    )
    private Set<EndpointInfo> availableEndpoints;
}
