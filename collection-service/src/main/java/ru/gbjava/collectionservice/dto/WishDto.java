package ru.gbjava.collectionservice.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class WishDto {

    private String id;
    private String userId;
    private String contentId;
    private String added;
}
