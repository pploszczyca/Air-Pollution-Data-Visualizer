package pl.edu.agh.apdvbackend.models;

import io.swagger.v3.oas.annotations.media.Schema;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "endpoint_info")
public class EndpointInfo {
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

    public EndpointInfo(Long id, int endpointNumber, String label,
                        String sensorUrl) {
        this.id = id;
        this.endpointNumber = endpointNumber;
        this.label = label;
        this.sensorUrl = sensorUrl;
    }

    public EndpointInfo() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getEndpointNumber() {
        return endpointNumber;
    }

    public void setEndpointNumber(int endpointNumber) {
        this.endpointNumber = endpointNumber;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getSensorUrl() {
        return sensorUrl;
    }

    public void setSensorUrl(String sensorUrl) {
        this.sensorUrl = sensorUrl;
    }
}
