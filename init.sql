create table objects
(
    id    int auto_increment
        primary key,
    tag   varchar(255) not null,
    name  varchar(255) null,
    image varchar(255) null,
    constraint objects_tag_uindex
        unique (tag)
);

create table servers
(
    id    int auto_increment
        primary key,
    do_id int          null,
    tag   varchar(5)   null,
    name  varchar(100) null,
    tab   varchar(100) null,
    constraint servers_tag_uindex
        unique (tag)
);

create table history
(
    id         int auto_increment
        primary key,
    auction_id varchar(255)                 null,
    type       enum ('hour', 'day', 'week') null,
    time       datetime                     not null,
    server     varchar(5)                   null,
    constraint history_servers_tag_fk
        foreign key (server) references servers (tag)
);

create table bids
(
    id      varchar(255) not null,
    session int          null,
    object  varchar(255) null,
    owner   varchar(255) null,
    price   bigint       null,
    constraint bids_id_uindex
        unique (id),
    constraint bids_history_id_fk
        foreign key (session) references history (id)
            on update cascade on delete cascade,
    constraint bids_objects_tag_fk
        foreign key (object) references objects (tag)
            on update cascade on delete cascade
);

alter table bids
    add primary key (id);

insert into do_auction.servers (id, do_id, tag, name, tab)
values  (1, 48, 'fr1', 'France', 'eu_west'),
        (2, 151, 'de2', 'Deutschland 2', 'eu_west'),
        (3, 392, 'de4', 'Deutschland 4', 'eu_west'),
        (4, 89, 'es1', 'España', 'eu_west'),
        (5, 22, 'int1', 'Global Europe', 'eu_west'),
        (6, 182, 'int5', 'Global Europe 2', 'eu_west'),
        (7, 277, 'int7', 'Global Europe 3', 'eu_west'),
        (8, 502, 'int11', 'Global Europe 5', 'eu_west'),
        (9, 727, 'int14', 'Global Europe 7', 'eu_west'),
        (10, 1389, 'gbl1', 'Global', 'eu_west'),
        (11, 69, 'int2', 'Global America', 'us_east'),
        (12, 257, 'int6', 'Global America 2', 'us_east'),
        (13, 755, 'mx1', 'Mexico 1', 'us_west'),
        (14, 145, 'us2', 'USA (West Coast)', 'us_west'),
        (15, 578, 'pl3', 'Polska 3', 'eu_east'),
        (16, 68, 'ru1', 'Россия', 'eu_east'),
        (17, 574, 'ru5', 'Россия 5', 'eu_east'),
        (18, 210, 'tr3', 'Türkiye 3', 'eu_east'),
        (19, 387, 'tr4', 'Türkiye 4', 'eu_east'),
        (20, 577, 'tr5', 'Türkiye 5', 'eu_east');

insert into do_auction.objects (id, tag, name, image)
values  (1, 'mcb-25', 'MCB-25', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ammunition/laser/mcb-25_30x30.png'),
        (2, 'sab-50', 'SAB-50', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ammunition/laser/sab-50_30x30.png'),
        (3, 'mcb-50', 'MCB-50', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ammunition/laser/mcb-50_30x30.png'),
        (4, 'aegis', 'Aegis', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/aegis-mmo_30x30.png'),
        (5, 'plt-3030', 'PLT-3030', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ammunition/rocket/plt-3030_30x30.png'),
        (6, 'v-lightning', 'Vengeance Lightning', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/v-lightning_30x30.png'),
        (7, 'diminisher', 'Diminisher', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/diminisher_30x30.png'),
        (8, 'sentinel', 'Sentinel', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/sentinel_30x30.png'),
        (9, 'plt-2021', 'PLT-2021', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ammunition/rocket/plt-2021_30x30.png'),
        (10, 'g3n-7900', 'Propulseur-G3N-7900', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/generator/speed/g3n-7900_30x30.png'),
        (11, 'rllb-x', 'CPU lance-roquettes', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/rllb-x_30x30.png'),
        (12, 'hon-b01', 'Booster honneur', 'https://darkorbit-22.bpsecure.com/do_img/global/items/booster/hon-b01_30x30.png'),
        (13, 's-veteran', 'Spearhead Veteran', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/s-veteran-mmo_30x30.png'),
        (14, 'acm-01', 'ACM-1', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ammunition/mine/acm-01_30x30.png'),
        (15, 'venom', 'Venom', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/venom_30x30.png'),
        (16, 'leonov', 'Leonov', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/leonov_30x30.png'),
        (17, 'nc-agb-x', 'CPU-Boost de générateurs', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/nc-agb-x_30x30.png'),
        (18, 'v-adept', 'Vengeance Adept', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/v-adept_30x30.png'),
        (19, 'rep-b01', 'Booster réparations', 'https://darkorbit-22.bpsecure.com/do_img/global/items/booster/rep-b01_30x30.png'),
        (20, 'spectrum', 'Spectrum', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/spectrum_30x30.png'),
        (21, 'shd-b01', 'Booster boucliers', 'https://darkorbit-22.bpsecure.com/do_img/global/items/booster/shd-b01_30x30.png'),
        (22, 'hst-2', 'Lance-roquettes Hellstorm 2', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/weapon/rocketlauncher/hst-2_30x30.png'),
        (23, 'sapphire', 'Sapphire Goliath', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/goliath/design/sapphire_30x30.png'),
        (24, 'ish-01', 'CPU-Bouclier instantané', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/ish-01_30x30.png'),
        (25, 'ram-ma', 'Module de roquettes PM', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/ram-ma_30x30.png'),
        (26, 'amber', 'Amber Goliath', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/goliath/design/amber_30x30.png'),
        (27, 'sle-03', 'CPU Emplacement 3', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/sle-03_30x30.png'),
        (28, 'logfile', 'Logfile', 'https://darkorbit-22.bpsecure.com/do_img/global/items/resource/logfile_30x30.png'),
        (29, 'sreg-b01', 'Booster recharg. bouclier', 'https://darkorbit-22.bpsecure.com/do_img/global/items/booster/sreg-b01_30x30.png'),
        (30, 'dr-02', 'CPU-réparation de drones 2', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/dr-02_30x30.png'),
        (31, 'cl04k-xs', 'Système-Camouflage Type A', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/cl04k-xs_30x30.png'),
        (32, 'rep-3', 'Robot-réparateur 3', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/repbot/rep-3_30x30.png'),
        (33, 'jp-02', 'CPU-Jump 2', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/jp-02_30x30.png'),
        (34, 'min-t02', 'CPU-Turbo mines 2', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/min-t02_30x30.png'),
        (35, 'iris-1', 'Iris', 'https://darkorbit-22.bpsecure.com/do_img/global/items/drone/iris-1_30x30.png'),
        (36, 'ltm-mr', 'Module de laser MP', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/ltm-mr_30x30.png'),
        (37, 'solace', 'Solace', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/solace_30x30.png'),
        (38, 'alb-x', 'CPU-munitions', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/alb-x_30x30.png'),
        (39, 's-elite', 'Spearhead Elite', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/s-elite-mmo_30x30.png'),
        (40, 'ajp-01', 'CPU de saut avancé 1', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/ajp-01_30x30.png'),
        (41, 'v-corsair', 'Vengeance Corsair', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/v-corsair_30x30.png'),
        (42, 'defm-1', 'Module de déflecteur', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/defm-1_30x30.png'),
        (43, 'c-veteran', 'Citadel Veteran', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/c-veteran-mmo_30x30.png'),
        (44, 'goliath', 'Goliath', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/goliath_30x30.png'),
        (45, 'ram-la', 'Module de roquettes PL', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/ram-la_30x30.png'),
        (46, 'ltm-lr', 'Module de lasers CP', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/ltm-lr_30x30.png'),
        (47, 'xpm-1', 'Module de booster expérience', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/xpm-1_30x30.png'),
        (48, 'spearhead', 'Spearhead', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/spearhead-mmo_30x30.png'),
        (49, 'v-revenge', 'Vengeance Revenge', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/v-revenge_30x30.png'),
        (50, 'rok-t01', 'Turbo-roquette', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/rok-t01_30x30.png'),
        (51, 'dmg-b01', 'Booster dommages', 'https://darkorbit-22.bpsecure.com/do_img/global/items/booster/dmg-b01_30x30.png'),
        (52, 'vengeance', 'Vengeance', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/vengeance_30x30.png'),
        (53, 'c-elite', 'Citadel Elite', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/c-elite-mmo_30x30.png'),
        (54, 'g-exalted', 'Goliath Exalted', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/g-exalted_30x30.png'),
        (55, 'honm-1', 'Module de booster honneur', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/honm-1_30x30.png'),
        (56, 'hp-b01', 'Booster points de vie', 'https://darkorbit-22.bpsecure.com/do_img/global/items/booster/hp-b01_30x30.png'),
        (57, 'smb-01', 'CPU Bombe intelligente', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/smb-01_30x30.png'),
        (58, 'ltm-hr', 'Module de lasers LP', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/ltm-hr_30x30.png'),
        (59, 'aim-02', 'CPU-Aide à la visée 2', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/aim-02_30x30.png'),
        (60, 'xenomit', 'Xenomit', 'https://darkorbit-22.bpsecure.com/do_img/global/items/resource/ore/xenomit_30x30.png'),
        (61, 'a-elite', 'Aegis Elite', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/a-elite-mmo_30x30.png'),
        (62, 'crimson', 'Crimson', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/goliath/design/crimson_30x30.png'),
        (63, 'repm-1', 'Module de réparation', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/repm-1_30x30.png'),
        (64, 'g-veteran', 'Goliath Veteran', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/g-veteran_30x30.png'),
        (65, 'nc-awb-x', 'CPU-Laboratoire', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/nc-awb-x_30x30.png'),
        (66, 'citadel', 'Citadel', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/citadel-mmo_30x30.png'),
        (67, 'cl04k-xl', 'CPU camouflage XL', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/cl04k-xl_30x30.png'),
        (68, 'rd-x', 'CPU-radar', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/rd-x_30x30.png'),
        (69, 'ep-b01', 'Booster points d''expérience', 'https://darkorbit-22.bpsecure.com/do_img/global/items/booster/ep-b01_30x30.png'),
        (70, 'g3x-crgo-x', 'Extension de la soute', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/g3x-crgo-x_30x30.png'),
        (71, 'hulm-1', 'Module de coque', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/hulm-1_30x30.png'),
        (72, 'rep-4', 'Robot réparateur 4', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/repbot/rep-4_30x30.png'),
        (73, 'v-avenger', 'Vengeance Avenger', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/v-avenger_30x30.png'),
        (74, 'cl04k-m', 'CPU Camouflage', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/cl04k-m_30x30.png'),
        (75, 'nc-rrb-x', 'CPU réparation automatique', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/nc-rrb-x_30x30.png'),
        (76, 'a-veteran', 'Aegis Veteran', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/a-veteran-mmo_30x30.png'),
        (77, 'res-b01', 'Booster ressources', 'https://darkorbit-22.bpsecure.com/do_img/global/items/booster/res-b01_30x30.png'),
        (78, 'sle-04', 'CPU Emplacement 4', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/sle-04_30x30.png'),
        (79, 'lf-3', 'LF-3', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/weapon/laser/lf-3_30x30.png'),
        (80, 'arol-x', 'CPU roquettes automatiques', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/arol-x_30x30.png'),
        (81, 'g-enforcer', 'Goliath Enforcer', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/g-enforcer_30x30.png'),
        (82, 'dmgm-1', 'Module de booster dégâts', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/dmgm-1_30x30.png'),
        (83, 'sle-02', 'CPU-Emplacement 2', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/sle-02_30x30.png'),
        (84, 'g-bastion', 'Goliath Bastion', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/g-bastion_30x30.png'),
        (85, 'rb-x', 'CPU-roquettes', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/rb-x_30x30.png'),
        (86, 'sg3n-b02', 'Bouclier-SG3N-B02', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/generator/shield/sg3n-b02_30x30.png'),
        (87, 'jade', 'Jade Goliath', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/goliath/design/jade_30x30.png');
