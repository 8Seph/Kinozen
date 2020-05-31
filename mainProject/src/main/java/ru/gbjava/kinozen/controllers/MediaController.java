package ru.gbjava.kinozen.controllers;

import lombok.RequiredArgsConstructor;

import org.dom4j.rule.Mode;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import ru.gbjava.kinozen.persistence.entities.Media;
import ru.gbjava.kinozen.services.MediaService;
import ru.gbjava.kinozen.services.pojo.MediaPojo;

import java.util.List;

@Controller
@RequestMapping("/media")
@RequiredArgsConstructor
public class MediaController {

    private final MediaService mediaService;

    @GetMapping
    public String getAllMedia(Model model){
        List<MediaPojo> pojoList = mediaService.getAllMedia();
        model.addAttribute("mediaList", pojoList);
        return "media";
    }

    @GetMapping ("/{url}")
    public String getMediaByUrl(Model model, @PathVariable String url){
        MediaPojo mediaPojo = mediaService.findByUrl(url);
        model.addAttribute("media", mediaPojo);
        return "mediaPage";
    }

}