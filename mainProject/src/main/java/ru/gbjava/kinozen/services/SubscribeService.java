package ru.gbjava.kinozen.services;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import ru.gbjava.kinozen.persistence.entities.Actor;
import ru.gbjava.kinozen.persistence.entities.Content;
import ru.gbjava.kinozen.persistence.entities.Genre;
import ru.gbjava.kinozen.persistence.entities.User;

import javax.transaction.Transactional;
import java.util.HashSet;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class SubscribeService {

    private final ContentService contentService;
    private final UserService userService;

    public Set<Content> getContentSubscribeList (User user){
        Set<Content> contentSubscribeList = new HashSet<>();
        for(Content newContent: contentService.getNewContents()){
            for(Genre newContentGenre: newContent.getGenres()){
                for(Genre subscribeGenre: user.getGenreSubscribeList()){
                    if(newContentGenre.equals(subscribeGenre)){
                        contentSubscribeList.add(newContent);
                    }
                }
            }
            for(Actor newContentActor: newContent.getActors()){
                for(Actor subscribeActor: user.getActorSubscribeList()){
                    if(newContentActor.equals(subscribeActor)){
                        contentSubscribeList.add(newContent);
                    }
                }
            }
        }
        return contentSubscribeList;
    }

    @Transactional
    public void subscribeUserToGenre(User user, Genre genre){
        Set<Genre> userGenreSubscribeList = user.getGenreSubscribeList();

        if (userGenreSubscribeList.contains(genre)) {
            userGenreSubscribeList.remove(genre);
        } else {
            userGenreSubscribeList.add(genre);
        }
        user.setGenreSubscribeList(userGenreSubscribeList);
        userService.save(user);
    }

    @Transactional
    public void subscribeUserToActor(User user, Actor actor){
        Set<Actor> userActorSubscribeList = user.getActorSubscribeList();

        if (userActorSubscribeList.contains(actor)) {
            userActorSubscribeList.remove(actor);
        } else {
            userActorSubscribeList.add(actor);
        }
        user.setActorSubscribeList(userActorSubscribeList);
        userService.save(user);
    }

}
