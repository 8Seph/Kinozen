package ru.gbjava.collectionservice.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import ru.gbjava.collectionservice.persistance.entity.Collection;
import ru.gbjava.collectionservice.service.CollectionService;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
public class CollectionController {

    private final CollectionService collectionService;

    @GetMapping(value = "/{user}")
    public ResponseEntity<Map<UUID, Collection>> getUserCollection(@PathVariable String user) {
        Map<UUID, Collection> result = collectionService.findAllCollection(user);

        if (result == null) {
            return ResponseEntity.notFound().build();
        } else {
            return ResponseEntity.ok(result);
        }
    }

    @GetMapping(value = "/wish/{user}")
    public ResponseEntity<List<UUID>> getWishCollection(@PathVariable String user) {
        List<UUID> result = collectionService.getWishCollection(user);

        if (result == null) {
            return ResponseEntity.notFound().build();
        } else {
            return ResponseEntity.ok(result);
        }
    }
}