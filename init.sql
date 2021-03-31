create table objects
(
    id        int auto_increment
        primary key,
    tag       varchar(255) charset utf8mb4                 not null,
    name      varchar(255) charset utf8mb4                 null,
    image     varchar(255) charset utf8mb4                 null,
    frequency enum ('day', 'hour', 'week') charset utf8mb4 not null,
    constraint objects_tag_uindex
        unique (tag)
)
    charset = utf8;

create table servers
(
    id    int auto_increment
        primary key,
    do_id int                          null,
    tag   varchar(5) charset utf8mb4   null,
    name  varchar(100) charset utf8mb4 null,
    tab   varchar(100) charset utf8mb4 null,
    constraint servers_tag_uindex
        unique (tag)
)
    charset = utf8;

create table history
(
    id         int auto_increment
        primary key,
    auction_id varchar(255) charset utf8mb4                 null,
    type       enum ('hour', 'day', 'week') charset utf8mb4 null,
    time       datetime                                     not null,
    server     varchar(5) charset utf8mb4                   null,
    constraint history_server_auction_id_type_time_uindex
        unique (server, auction_id, type, time),
    constraint history_servers_tag_fk
        foreign key (server) references servers (tag)
)
    charset = utf8;

create table bids
(
    id      varchar(255) charset utf8mb4 not null,
    session int                          null,
    object  varchar(255) charset utf8mb4 null,
    owner   varchar(255) charset utf8mb4 null,
    price   bigint                       null,
    constraint bids_id_uindex
        unique (id),
    constraint bids_history_id_fk
        foreign key (session) references history (id)
            on update cascade on delete cascade,
    constraint bids_objects_tag_fk
        foreign key (object) references objects (tag)
            on update cascade on delete cascade
)
    charset = utf8;

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

insert into do_auction.objects (id, tag, name, image, frequency)
values  (1, 'mcb-25', 'MCB-25', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ammunition/laser/mcb-25_30x30.png', 'hour'),
        (2, 'sab-50', 'SAB-50', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ammunition/laser/sab-50_30x30.png', 'hour'),
        (3, 'mcb-50', 'MCB-50', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ammunition/laser/mcb-50_30x30.png', 'hour'),
        (4, 'aegis', 'Aegis', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/aegis-mmo_30x30.png', 'day'),
        (5, 'plt-3030', 'PLT-3030', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ammunition/rocket/plt-3030_30x30.png', 'hour'),
        (6, 'v-lightning', 'Vengeance Lightning', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/v-lightning_30x30.png', 'week'),
        (7, 'diminisher', 'Diminisher', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/diminisher_30x30.png', 'week'),
        (8, 'sentinel', 'Sentinel', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/sentinel_30x30.png', 'week'),
        (9, 'plt-2021', 'PLT-2021', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ammunition/rocket/plt-2021_30x30.png', 'hour'),
        (10, 'g3n-7900', 'G3N-7900 speed generator', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/generator/speed/g3n-7900_30x30.png', 'hour'),
        (11, 'rllb-x', 'Rocket-launcher CPU', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/rllb-x_30x30.png', 'hour'),
        (12, 'hon-b01', 'Honor booster', 'https://darkorbit-22.bpsecure.com/do_img/global/items/booster/hon-b01_30x30.png', 'hour'),
        (13, 's-veteran', 'Spearhead Veteran', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/s-veteran-mmo_30x30.png', 'day'),
        (14, 'acm-01', 'ACM-1', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ammunition/mine/acm-01_30x30.png', 'hour'),
        (15, 'venom', 'Venom', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/venom_30x30.png', 'week'),
        (16, 'leonov', 'Leonov', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/leonov_30x30.png', 'hour'),
        (17, 'nc-agb-x', 'Generator boost CPU', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/nc-agb-x_30x30.png', 'hour'),
        (18, 'v-adept', 'Vengeance Adept', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/v-adept_30x30.png', 'hour'),
        (19, 'rep-b01', 'Repair booster', 'https://darkorbit-22.bpsecure.com/do_img/global/items/booster/rep-b01_30x30.png', 'hour'),
        (20, 'spectrum', 'Spectrum', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/spectrum_30x30.png', 'week'),
        (21, 'shd-b01', 'Shield booster', 'https://darkorbit-22.bpsecure.com/do_img/global/items/booster/shd-b01_30x30.png', 'hour'),
        (22, 'hst-2', 'Hellstorm launcher 2', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/weapon/rocketlauncher/hst-2_30x30.png', 'hour'),
        (23, 'sapphire', 'Sapphire Goliath', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/goliath/design/sapphire_30x30.png', 'hour'),
        (24, 'ish-01', 'Insta-shield CPU', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/ish-01_30x30.png', 'hour'),
        (25, 'ram-ma', 'MA Rocket Module', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/ram-ma_30x30.png', 'day'),
        (26, 'amber', 'Amber Goliath', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/goliath/design/amber_30x30.png', 'hour'),
        (27, 'sle-03', 'Slot CPU 3', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/sle-03_30x30.png', 'hour'),
        (28, 'logfile', 'Log-disks', 'https://darkorbit-22.bpsecure.com/do_img/global/items/resource/logfile_30x30.png', 'hour'),
        (29, 'sreg-b01', 'Shield recharger booster', 'https://darkorbit-22.bpsecure.com/do_img/global/items/booster/sreg-b01_30x30.png', 'hour'),
        (30, 'dr-02', 'Drone repair CPU 2', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/dr-02_30x30.png', 'hour'),
        (31, 'cl04k-xs', 'Cloaking Device Type A', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/cl04k-xs_30x30.png', 'hour'),
        (32, 'rep-3', 'Repair Robot 3', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/repbot/rep-3_30x30.png', 'hour'),
        (33, 'jp-02', 'Jump CPU 2', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/jp-02_30x30.png', 'hour'),
        (34, 'min-t02', 'Turbo Mine CPU 2', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/min-t02_30x30.png', 'hour'),
        (35, 'iris-1', 'Iris', 'https://darkorbit-22.bpsecure.com/do_img/global/items/drone/iris-1_30x30.png', 'hour'),
        (36, 'ltm-mr', 'MR Laser Module', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/ltm-mr_30x30.png', 'day'),
        (37, 'solace', 'Solace', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/solace_30x30.png', 'week'),
        (38, 'alb-x', 'Ammunition CPU', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/alb-x_30x30.png', 'hour'),
        (39, 's-elite', 'Spearhead Elite', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/s-elite-mmo_30x30.png', 'day'),
        (40, 'ajp-01', 'Advanced Jump CPU 1', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/ajp-01_30x30.png', 'hour'),
        (41, 'v-corsair', 'Vengeance Corsair', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/v-corsair_30x30.png', 'hour'),
        (42, 'defm-1', 'Deflector Module', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/defm-1_30x30.png', 'day'),
        (43, 'c-veteran', 'Citadel Veteran', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/c-veteran-mmo_30x30.png', 'day'),
        (44, 'goliath', 'Goliath', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/goliath_30x30.png', 'hour'),
        (45, 'ram-la', 'LA Rocket Module', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/ram-la_30x30.png', 'day'),
        (46, 'ltm-lr', 'LR Laser Module', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/ltm-lr_30x30.png', 'day'),
        (47, 'xpm-1', 'Experience Booster Module', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/xpm-1_30x30.png', 'day'),
        (48, 'spearhead', 'Spearhead', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/spearhead-mmo_30x30.png', 'day'),
        (49, 'v-revenge', 'Vengeance Revenge', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/v-revenge_30x30.png', 'hour'),
        (50, 'rok-t01', 'Rocket Turbo', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/rok-t01_30x30.png', 'hour'),
        (51, 'dmg-b01', 'Damage Booster', 'https://darkorbit-22.bpsecure.com/do_img/global/items/booster/dmg-b01_30x30.png', 'hour'),
        (52, 'vengeance', 'Vengeance', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/vengeance_30x30.png', 'hour'),
        (53, 'c-elite', 'Citadel Elite', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/c-elite-mmo_30x30.png', 'day'),
        (54, 'g-exalted', 'Goliath Exalted', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/g-exalted_30x30.png', 'hour'),
        (55, 'honm-1', 'Honor Booster Module', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/honm-1_30x30.png', 'day'),
        (56, 'hp-b01', 'Hit point booster', 'https://darkorbit-22.bpsecure.com/do_img/global/items/booster/hp-b01_30x30.png', 'hour'),
        (57, 'smb-01', 'Smart bomb CPU', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/smb-01_30x30.png', 'hour'),
        (58, 'ltm-hr', 'HR Laser Module', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/ltm-hr_30x30.png', 'day'),
        (59, 'aim-02', 'Targeting guidance CPU 2', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/aim-02_30x30.png', 'hour'),
        (60, 'xenomit', 'Xenomit', 'https://darkorbit-22.bpsecure.com/do_img/global/items/resource/ore/xenomit_30x30.png', 'hour'),
        (61, 'a-elite', 'Aegis Elite', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/a-elite-mmo_30x30.png', 'day'),
        (62, 'crimson', 'Crimson', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/goliath/design/crimson_30x30.png', 'hour'),
        (63, 'repm-1', 'Repair Module', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/repm-1_30x30.png', 'day'),
        (64, 'g-veteran', 'Goliath Veteran', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/g-veteran_30x30.png', 'hour'),
        (65, 'nc-awb-x', 'Lab CPU', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/nc-awb-x_30x30.png', 'hour'),
        (66, 'citadel', 'Citadel', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/citadel-mmo_30x30.png', 'day'),
        (67, 'cl04k-xl', 'Cloaking CPU XL', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/cl04k-xl_30x30.png', 'hour'),
        (68, 'rd-x', 'Radar CPU', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/rd-x_30x30.png', 'hour'),
        (69, 'ep-b01', 'Experience booster', 'https://darkorbit-22.bpsecure.com/do_img/global/items/booster/ep-b01_30x30.png', 'hour'),
        (70, 'g3x-crgo-x', 'Cargo bay expansion', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/g3x-crgo-x_30x30.png', 'hour'),
        (71, 'hulm-1', 'Hull Module', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/hulm-1_30x30.png', 'day'),
        (72, 'rep-4', 'Repair Robot 4', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/repbot/rep-4_30x30.png', 'hour'),
        (73, 'v-avenger', 'Vengeance Avenger', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/v-avenger_30x30.png', 'hour'),
        (74, 'cl04k-m', 'Cloaking CPU', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/cl04k-m_30x30.png', 'hour'),
        (75, 'nc-rrb-x', 'Repair-bot auto CPU', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/nc-rrb-x_30x30.png', 'hour'),
        (76, 'a-veteran', 'Aegis Veteran', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/a-veteran-mmo_30x30.png', 'day'),
        (77, 'res-b01', 'Resource booster', 'https://darkorbit-22.bpsecure.com/do_img/global/items/booster/res-b01_30x30.png', 'hour'),
        (78, 'sle-04', 'Slot CPU 4', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/sle-04_30x30.png', 'hour'),
        (79, 'lf-3', 'LF-3', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/weapon/laser/lf-3_30x30.png', 'hour'),
        (80, 'arol-x', 'Auto Rocket CPU', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/arol-x_30x30.png', 'hour'),
        (81, 'g-enforcer', 'Goliath Enforcer', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/g-enforcer_30x30.png', 'hour'),
        (82, 'dmgm-1', 'Damage Booster Module', 'https://darkorbit-22.bpsecure.com/do_img/global/items/module/dmgm-1_30x30.png', 'day'),
        (83, 'sle-02', 'Slot CPU 2', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/sle-02_30x30.png', 'hour'),
        (84, 'g-bastion', 'Goliath Bastion', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/g-bastion_30x30.png', 'hour'),
        (85, 'rb-x', 'Rocket CPU', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/extra/cpu/rb-x_30x30.png', 'hour'),
        (86, 'sg3n-b02', 'SG3N-B02 shield', 'https://darkorbit-22.bpsecure.com/do_img/global/items/equipment/generator/shield/sg3n-b02_30x30.png', 'hour'),
        (87, 'jade', 'Jade Goliath', 'https://darkorbit-22.bpsecure.com/do_img/global/items/ship/goliath/design/jade_30x30.png', 'hour');
