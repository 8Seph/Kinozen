CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
create table if not exists flyway_schema_history
(
    installed_rank integer not null
        constraint flyway_schema_history_pk
        primary key,
    version varchar(50),
    description varchar(200) not null,
    type varchar(20) not null,
    script varchar(1000) not null,
    checksum integer,
    installed_by varchar(100) not null,
    installed_on timestamp default now() not null,
    execution_time integer not null,
    success boolean not null
);



create index if not exists flyway_schema_history_s_idx
    on flyway_schema_history (success);

create table if not exists tbl_typecontent
(
    id_typecontent serial not null
        constraint tbl_typecontent_pk
        primary key,
    name_typecontent varchar(255) not null
);



create table if not exists tbl_director
(
    id_director serial not null
        constraint tbl_director_pk
        primary key,
    firstname_director varchar(255),
    lastname_director varchar(255),
    description_director varchar(255),
    img_director varchar(255)
);


create table if not exists tbl_content
(
    id_content serial not null
        constraint tbl_content_pk
        primary key,
    name_content varchar(255) not null,
    description_content varchar(255),
    released_content date,
    visible_content boolean,
    id_typecontent integer not null
        constraint tbl_content_tbl_typecontent_id_typecontent_fk
        references tbl_typecontent,
    url_content varchar(255),
    img_content varchar(255),
    id_director bigint
);



create table if not exists tbl_genre
(
    id_genre serial not null
        constraint tbl_genre_pk
        primary key,
    name_genre varchar(255) not null
);



create table if not exists tbl_genre_content
(
    id_genre integer not null
        constraint tbl_genre_content_tbl_genre_id_genre_fk
        references tbl_genre,
    id_content integer not null
        constraint tbl_genre_content_tbl_content_id_content_fk
        references tbl_content
);



create table if not exists tbl_actor
(
    id_actor serial not null
        constraint tbl_actor_pk
        primary key,
    firstname_actor varchar(255),
    lastname_actor varchar(255),
    description_actor varchar(255),
    img_actor integer
);



create table if not exists tbl_actor_content
(
    id_actor integer not null
        constraint tbl_actor_content_tbl_actor_id_actor_fk
        references tbl_actor,
    id_content integer not null
        constraint tbl_actor_content_tbl_media_id_content_fk
        references tbl_content
);



create table if not exists tbl_user
(
    id_user serial not null
        constraint tbl_user_pk
        primary key,
    login_user varchar(255) not null,
    password_user varchar(255) not null,
    name_user varchar(255) not null,
    email_user varchar(255)
);



create unique index if not exists tbl_user_login_user_uindex
    on tbl_user (login_user);

create table if not exists tbl_role
(
    id_role serial not null
        constraint tbl_role_pk
        primary key,
    name_role varchar(255) not null
);



create table if not exists tbl_role_user
(
    id_role integer not null
        constraint tbl_role_user_tbl_role_id_role_fk
        references tbl_role,
    id_user integer not null
        constraint tbl_role_user_tbl_user_id_user_fk
        references tbl_user
);



create table if not exists tbl_history
(
    id_history serial not null
        constraint tbl_history_pk
        primary key,
    id_user integer not null
        constraint tbl_history_tbl_user_id_user_fk
        references tbl_user,
    id_content integer not null
        constraint tbl_history_tbl_content_id_content_fk
        references tbl_content (id_content),
    date_history date default now() not null
);



create table if not exists tbl_season
(
    id_season serial not null
        constraint tbl_season_pk
        primary key,
    id_content integer not null
        constraint tbl_season_tbl_content_id_content_fk
        references tbl_content (id_content),
    number_season integer not null,
    description_season varchar(255)
);



create table if not exists tbl_comment
(
    id_comment serial not null
        constraint tbl_comment_pk
        primary key,
    id_user integer not null
        constraint tbl_comment_tbl_user_id_user_fk
        references tbl_user,
    uuid_content integer not null,
    text_comment varchar(255) not null,
    date_comment date default now() not null
);



create table if not exists tbl_director_content
(
    id_director integer not null
        constraint tbl_director_content_tbl_director_id_director_fk
        references tbl_director,
    id_content integer not null
        constraint tbl_director_content_tbl_content_id_content_fk
        references tbl_content (id_content)
);


create table if not exists tbl_episode
(
    uuid_episode uuid default uuid_generate_v4() not null
        constraint tbl_episode_pk
        primary key,
    id_season integer not null
        constraint tbl_episode_tbl_season_id_season_fk
        references tbl_season,
    number_episode integer not null,
    name_episode varchar(255) not null,
    description_episode varchar(255),
    img_episode varchar(255)
);


create unique index if not exists tbl_episode_id_episode_uindex
    on tbl_episode (uuid_episode);

create table if not exists tbl_film
(
    uuid_film uuid default uuid_generate_v4() not null
        constraint tbl_film_pk
        primary key,
    uuid_content integer not null
        constraint tbl_film_tbl_content_id_content_fk
        references tbl_content (id_content)
);


insert into tbl_role(id_role, name_role)
values (1, 'ROLE_ADMIN');
values (2, 'ROLE_USER');

insert into tbl_user(id_user, login_user, password_user, name_user)
values (1, 'admin', '$2a$10$5rAOMKmVsh9.NlzXTLLbq.XwouGdg3dwohvb5/HDn692YfdrLthO2', 'vladimir');
insert into tbl_role_user (id_role, id_user)
VALUES (1, 1);

insert into tbl_typecontent(name_typecontent)
values ('Сериал');
insert into tbl_typecontent(name_typecontent)
values ('Фильм');

insert into tbl_content(name_content, description_content, released_content, visible_content, id_typecontent, url_content, id_director)
values ('Игра престолов', 'описание 1', '2020-05-27', true, 1, 'igra-prestolov',1),
('Игра престолов 2', 'описание 1', '2020-05-17', true, 2, 'igra-prestolov2',1);

insert into tbl_director
(
    firstname_director,
    lastname_director,
    description_director,
    img_director
) values ('Дэвид', 'Наттер', 'карьера	Режиссер, Продюсер
дата рождения	1960 • стрелец стрелец• 60 лет
место рождения	США
жанры	драма, фантастика, детектив
всего фильмов	53, 1985 — 2019','https://www.kinopoisk.ru/name/64671/photos/')
