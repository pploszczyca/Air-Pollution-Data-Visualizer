package pl.edu.agh.apdvbackend.models.database;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import io.swagger.v3.oas.annotations.media.Schema;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "group")
@Getter
@Setter
@NoArgsConstructor
@JsonIgnoreProperties({"groupEndpoints"})
@EqualsAndHashCode
public class Group {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Schema(required = true)
    private Long id;

    @Schema(required = true)
    @Column(unique = true)
    private String name;

    @ManyToMany
    @JoinTable(
            name = "users_in_group",
            joinColumns = @JoinColumn(name = "group_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id")
    )
    private Set<User> usersInGroup = new HashSet<>();

    @OneToMany(mappedBy = "group", cascade = CascadeType.ALL)
    private List<GroupEndpoint> groupEndpoints = new ArrayList<>();

    public void addUser(User user) {
        usersInGroup.add(user);
    }

    public void removeUser(User user) {
        usersInGroup.remove(user);
    }
}
