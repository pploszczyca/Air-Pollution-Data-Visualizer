package pl.edu.agh.apdvbackend.use_cases.unit_converter;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import pl.edu.agh.apdvbackend.repositories.UnitConverterRepository;

@Component
@RequiredArgsConstructor
public class RemoveUnitConverterByIdImpl implements RemoveUnitConverterById {

    private final UnitConverterRepository unitConverterRepository;

    @Override
    public void execute(Long unitConverterId) {
        unitConverterRepository.deleteById(unitConverterId);
    }
}
