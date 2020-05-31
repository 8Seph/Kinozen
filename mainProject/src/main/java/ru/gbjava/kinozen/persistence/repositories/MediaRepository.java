package ru.gbjava.kinozen.persistence.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.gbjava.kinozen.persistence.entities.Media;
import ru.gbjava.kinozen.persistence.entities.TypeMedia;

import java.util.List;
import java.util.Optional;

public interface MediaRepository extends JpaRepository<Media, Integer> {
    Optional<Media> findMediaByUrl(String url);
}