package ru.gbjava.kinozen.dto.mappers;

import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;
import ru.gbjava.kinozen.dto.SeasonDto;
import ru.gbjava.kinozen.persistence.entities.Season;

import java.util.List;

@Mapper
public interface SeasonMapper {

    SeasonMapper INSTANCE = Mappers.getMapper(SeasonMapper.class);

    SeasonDto toDto(Season season);

    Season toEntity(SeasonDto seasonDto);

    Iterable<SeasonDto> toDtoList(List<Season> seasons);
}