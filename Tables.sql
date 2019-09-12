-- Create table
create table ADDRESS
(
  id              NUMBER(27) not null,
  house           NUMBER,
  appartment      NUMBER,
  quarter         VARCHAR2(7),
  tank            VARCHAR2(3),
  room            NUMBER,
  streets_id      NUMBER(27),
  townarea_id     NUMBER(27),
  provincearea_id NUMBER(27),
  addon           VARCHAR2(4000),
  kadastrno       VARCHAR2(50),
  btiliter        VARCHAR2(20),
  postcode        CHAR(6),
  main_id         NUMBER,
  house_char      VARCHAR2(10),
  townnames_id    NUMBER(27),
  regions_id      NUMBER(27)
)
tablespace USR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 664K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table ADDRESS
  is 'Адреса';
-- Add comments to the columns 
comment on column ADDRESS.id
  is 'ID {BUTTON:8,153,163,20,"Обновить адрес","UpdateBuildingAddress"}';
comment on column ADDRESS.house
  is 'Дом {FIELD:55,90,40,14 LABEL:8,92,40,14,"Дом"}';
comment on column ADDRESS.appartment
  is 'Квартира {FIELD:170,90,40,14 LABEL:103,92,60,14,"Квартира"}';
comment on column ADDRESS.quarter
  is 'Квартал {FIELD:275,110,40,14 LABEL:218,112,60,14,"Квартал"}';
comment on column ADDRESS.tank
  is 'Корпус {FIELD:400,110,40,14 LABEL:323,112,70,14,"Корпус"}';
comment on column ADDRESS.room
  is 'Помещение {FIELD:170,110,40,14 LABEL:103,112,60,14,"Помещение"}';
comment on column ADDRESS.streets_id
  is 'Улицы ID {FIELD:80,68,150,14 LABEL:8,70,80,14,"Улица"}';
comment on column ADDRESS.townarea_id
  is 'Район ID {FIELD:80,48,150,14 LABEL:8,50,80,14,"Район города"}';
comment on column ADDRESS.provincearea_id
  is 'Район области ID  {FIELD:295,8,150,14 LABEL:240,10,80,14,"Район обл"}';
comment on column ADDRESS.addon
  is 'Дополн. к адресу {FIELD:150,132,300,16 LABEL:8,134,140,14,"Дополнение к адресу"}';
comment on column ADDRESS.kadastrno
  is 'Кадастровый номер {LABEL:240,36,180,14,"Кадастровый номер" FIELD:240,50,200,14}';
comment on column ADDRESS.btiliter
  is 'Литера БТИ {FIELD:400,90,40,14 LABEL:323,92,70,14,"Литера БТИ"}';
comment on column ADDRESS.postcode
  is 'Почтовый индекс {FIELD:275,90,40,14 LABEL:218,92,60,14,"Индекс"}';
comment on column ADDRESS.main_id
  is 'Главный адрес';
comment on column ADDRESS.house_char
  is 'Буква {FIELD:55,110,40,14 LABEL:8,112,40,14,"Буква"}';
comment on column ADDRESS.townnames_id
  is 'Населённый пункт {FIELD:80,28,150,14 LABEL:8,30,80,14,"Город"}';
comment on column ADDRESS.regions_id
  is 'Субъект РФ  {FIELD:80,8,150,14 LABEL:8,10,80,14,"Субъект"}';
-- Create/Recreate indexes 
/*create index IDXADDRESSAREA on ADDRESS (TOWNAREA_ID)
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDXADDRESSCOMPLEX on ADDRESS (PROVINCEAREA_ID, STREETS_ID, HOUSE, TANK, ROOM, QUARTER, KADASTRNO)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 944K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDXADDRESSSTREET on ADDRESS (STREETS_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 600K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_ADDRESS_STREET_HOUSE on ADDRESS (STREETS_ID, HOUSE)
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDXADDRTWNNAME on ADDRESS (TOWNNAMES_ID)
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MAIN_ID on ADDRESS (MAIN_ID)
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  */
-- Create/Recreate primary, unique and foreign key constraints 
alter table ADDRESS
  add constraint PK_ADDRESS primary key (ID)
  using index 
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 456K
    next 1M
    minextents 1
    maxextents unlimited
  );
  /*
alter table ADDRESS
  add constraint FK_ADDRESS_PROVINCEAREA foreign key (PROVINCEAREA_ID)
  references PROVINCEAREA (ID);
alter table ADDRESS
  add constraint FK_ADDRESS_REGIONS_ID foreign key (REGIONS_ID)
  references REGIONS (ID);
alter table ADDRESS
  add constraint FK_ADDRESS_STREETS foreign key (STREETS_ID)
  references STREETS (ID);
alter table ADDRESS
  add constraint FK_ADDRESS_TOWNAREA foreign key (TOWNAREA_ID)
  references TOWNAREA (ID);
alter table ADDRESS
  add constraint FK_ADDRESS_TOWNNAMES foreign key (TOWNNAMES_ID)
  references TOWNNAMES (ID);
alter table ADDRESS
  add constraint FK_MAIN_ID foreign key (MAIN_ID)
  references ADDRESS (ID) on delete cascade;
-- Grant/Revoke object privileges 
grant select, insert, update, references on ADDRESS to BC;
grant select, insert, update on ADDRESS to DEP_ADDRESS;
grant select on ADDRESS to FIN_DEP_ROLE;
grant select, insert, update, delete on ADDRESS to SM_ALLUSERS;
grant select, insert, update, delete on ADDRESS to SM_ALLUSERS_RESTRICT;
grant select, insert, update, delete on ADDRESS to SM_NOCHARGES;
grant select, insert, update on ADDRESS to SM_READONLY;
grant select on ADDRESS to SM_TEST;
*/
----------------



-- Create table
create table TOWNNAMES
(
  id               NUMBER(27) not null,
  name             VARCHAR2(30) not null,
  townname_type_id NUMBER(27) not null,
  full_name        VARCHAR2(50),
  main_postcode    CHAR(6),
  refprovarea_id   NUMBER(27),
  subname          VARCHAR2(12),
  region_id        NUMBER(27)
)
tablespace USR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table TOWNNAMES
  is 'Населённые пункты';
-- Add comments to the columns 
comment on column TOWNNAMES.id
  is 'ID';
comment on column TOWNNAMES.name
  is 'Наименование';
comment on column TOWNNAMES.townname_type_id
  is 'Тип населенного пункта';
comment on column TOWNNAMES.main_postcode
  is 'Почтовый индекс главпочтамта';
comment on column TOWNNAMES.refprovarea_id
  is 'Район области ID';
comment on column TOWNNAMES.region_id
  is 'Субъект ID';
-- Create/Recreate primary, unique and foreign key constraints 
alter table TOWNNAMES
  add constraint PK_TOWNNAMES primary key (ID)
  using index 
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  /*
alter table TOWNNAMES
  add constraint UK_TOWNAMES unique (NAME, TOWNNAME_TYPE_ID)
  using index 
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table TOWNNAMES
  add constraint FK_TOWNNAMES_PROVAREA foreign key (REFPROVAREA_ID)
  references PROVINCEAREA (ID);
alter table TOWNNAMES
  add constraint FK_TOWNNAMES_REGION foreign key (REGION_ID)
  references REGIONS (ID);
alter table TOWNNAMES
  add constraint FK_TOWNNAMES_TOWNNAMETYPES foreign key (TOWNNAME_TYPE_ID)
  references TOWNNAME_TYPES (ID);
-- Grant/Revoke object privileges 
grant select on TOWNNAMES to BC;
grant select on TOWNNAMES to DEP_ADDRESS;
grant select on TOWNNAMES to FIN_DEP_ROLE;
grant select, insert, update, delete on TOWNNAMES to SM_ALLUSERS;
grant select, insert, update, delete on TOWNNAMES to SM_ALLUSERS_RESTRICT;
grant select, insert, update, delete on TOWNNAMES to SM_NOCHARGES;
grant select on TOWNNAMES to SM_READONLY;
*/
-------------------

-- Create table
create table TOWNAREA
(
  id                  NUMBER(27) not null,
  name                VARCHAR2(30) not null,
  kfx                 NUMBER(27,3),
  okato               VARCHAR2(11),
  townname_id         NUMBER(27),
  subname             VARCHAR2(12),
  rating_authority_id NUMBER(27)
)
tablespace USR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 56K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table TOWNAREA
  is 'Районы города';
-- Add comments to the columns 
comment on column TOWNAREA.id
  is 'ID';
comment on column TOWNAREA.name
  is 'Наименование';
comment on column TOWNAREA.kfx
  is 'Коэффицент';
comment on column TOWNAREA.okato
  is 'ОКАТО';
comment on column TOWNAREA.townname_id
  is 'Населённый пункт ID';
comment on column TOWNAREA.rating_authority_id
  is 'Налоговая';
  /*
-- Create/Recreate indexes 
create unique index SYS_C007074 on TOWNAREA (ID)
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 56K
    next 1M
    minextents 1
    maxextents unlimited
  );
  */
  
-- Create/Recreate primary, unique and foreign key constraints 
alter table TOWNAREA
  add constraint PK_TOWNAREA primary key (ID);
  /*
alter table TOWNAREA
  add constraint FK_TOWNAREA_RATING_AUTHORITY foreign key (RATING_AUTHORITY_ID)
  references RATING_AUTHORITY (ID);
alter table TOWNAREA
  add constraint FK_TOWNAREA_TOWNNAMES foreign key (TOWNNAME_ID)
  references TOWNNAMES (ID);
-- Grant/Revoke object privileges 
grant select on TOWNAREA to BC;
grant select on TOWNAREA to DEP_ADDRESS;
grant select on TOWNAREA to FIN_DEP_ROLE;
grant select, insert, update on TOWNAREA to SM_ALLUSERS;
grant select, update on TOWNAREA to SM_ALLUSERS_RESTRICT;
grant select, update on TOWNAREA to SM_NOCHARGES;
grant select on TOWNAREA to SM_READONLY;
grant select on TOWNAREA to SM_TEST;
*/


------------

-- Create table
create table STREETS
(
  id                   NUMBER(27) not null,
  name                 VARCHAR2(255) not null,
  referencetownarea_id NUMBER(27),
  street_name          VARCHAR2(100) not null,
  street_type_id       NUMBER(27) not null,
  b_out_of_town        CHAR(1) default 'Y' not null,
  streetstatus_id      NUMBER(27) default 5 not null,
  address_item_id      NUMBER(10),
  townnames_id         NUMBER(27)
)
tablespace USR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 56K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table STREETS
  is 'Улицы';
-- Add comments to the columns 
comment on column STREETS.id
  is 'ID';
comment on column STREETS.name
  is 'Полное наименование';
comment on column STREETS.referencetownarea_id
  is 'Район города ID';
comment on column STREETS.street_name
  is 'Наименование';
comment on column STREETS.street_type_id
  is 'Тип улицы';
comment on column STREETS.b_out_of_town
  is 'Иногородняя улица';
comment on column STREETS.streetstatus_id
  is 'Список по реестру';
comment on column STREETS.address_item_id
  is 'Номер по реестру';
comment on column STREETS.townnames_id
  is 'Населенный пункт ID';
-- Create/Recreate indexes 
/*
create index STRNAME on STREETS (NAME)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 56K
    next 1M
    minextents 1
    maxextents unlimited
  );
create unique index SYS_C007069 on STREETS (ID)
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 56K
    next 1M
    minextents 1
    maxextents unlimited
  );
  */
-- Create/Recreate primary, unique and foreign key constraints 
alter table STREETS
  add constraint PK_STREETS primary key (ID);
/*alter table STREETS
  add constraint FK_STREETS_TOWNNAMES foreign key (TOWNNAMES_ID)
  references TOWNNAMES (ID);
alter table STREETS
  add constraint FK_STREET_STREETSTATUS foreign key (STREETSTATUS_ID)
  references STREETSTATUS (ID);
alter table STREETS
  add constraint FK_STREET_TOWNAREA_ID foreign key (REFERENCETOWNAREA_ID)
  references TOWNAREA (ID);
alter table STREETS
  add constraint FK_STREETTYPES foreign key (STREET_TYPE_ID)
  references STREETTYPES (ID);
-- Create/Recreate check constraints 
alter table STREETS
  add constraint CHK_STREET_LOCAL
  check (B_OUT_OF_TOWN IN ('Y','N'));
-- Grant/Revoke object privileges 
grant select on STREETS to BC;
grant select on STREETS to DEP_ADDRESS;
grant select, insert, update, delete on STREETS to DEP_FAP;
grant select on STREETS to FIN_DEP_ROLE;
grant select on STREETS to SM_ALLUSERS;
grant select on STREETS to SM_ALLUSERS_RESTRICT;
grant select, insert on STREETS to SM_CANOUTOFTOWNSTREETS;
grant select on STREETS to SM_NOCHARGES;
grant select on STREETS to SM_READONLY;
grant select, insert, update on STREETS to SM_STREETS;
grant select on STREETS to SM_TEST;

*/
------------


-- Create table
create table STREETTYPES
(
  id         NUMBER(27) not null,
  name       VARCHAR2(255) not null,
  short_name VARCHAR2(10) not null,
  kladr_name VARCHAR2(10)
)
tablespace USR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table STREETTYPES
  is 'Типы улиц';
-- Add comments to the columns 
comment on column STREETTYPES.id
  is 'Идентификатор типа улицы';
comment on column STREETTYPES.name
  is 'Наименование  типа улицы';
comment on column STREETTYPES.short_name
  is 'Краткое наименование типа улицы';
comment on column STREETTYPES.kladr_name
  is 'КЛАДР тип улицы';
-- Create/Recreate primary, unique and foreign key constraints 
alter table STREETTYPES
  add constraint PK_STREETTYPES primary key (ID)
  using index 
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  /*
-- Grant/Revoke object privileges 
grant select on STREETTYPES to DEP_ADDRESS;
grant select on STREETTYPES to FIN_DEP_ROLE;
grant select on STREETTYPES to SM_ALLUSERS;
grant select on STREETTYPES to SM_ALLUSERS_RESTRICT;
grant select on STREETTYPES to SM_NOCHARGES;
grant select on STREETTYPES to SM_READONLY;

*/
---------------------


-- Create table
create table REGIONS
(
  id   NUMBER(27) not null,
  name VARCHAR2(50) not null,
  code VARCHAR2(2) not null
)
tablespace USR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table REGIONS
  is 'Регионы';
-- Add comments to the columns 
comment on column REGIONS.id
  is 'ID';
comment on column REGIONS.name
  is 'Наименование';
comment on column REGIONS.code
  is 'Код региона';
-- Create/Recreate primary, unique and foreign key constraints 
alter table REGIONS
  add constraint PK_REGIONS primary key (ID)
  using index 
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  /*
-- Grant/Revoke object privileges 
grant select on REGIONS to BC;
grant select on REGIONS to DEP_ADDRESS;
grant select on REGIONS to FIN_DEP_ROLE;
grant select, insert, update, delete on REGIONS to SM_ALLUSERS;
grant select, insert, update, delete on REGIONS to SM_ALLUSERS_RESTRICT;
grant select, insert, update, delete on REGIONS to SM_NOCHARGES;
grant select on REGIONS to SM_READONLY;
grant select on REGIONS to SM_TEST;
*/

-----------------


-- Create table
create table PROVINCEAREA
(
  id   NUMBER(27) not null,
  name VARCHAR2(30) not null
)
tablespace USR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 56K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table PROVINCEAREA
  is 'Районы области';
-- Add comments to the columns 
comment on column PROVINCEAREA.id
  is 'ID';
comment on column PROVINCEAREA.name
  is 'Наименование';
-- Create/Recreate indexes 
create unique index SYS_C007038 on PROVINCEAREA (ID)
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 56K
    next 1M
    minextents 1
    maxextents unlimited
  );
  
-- Create/Recreate primary, unique and foreign key constraints 
alter table PROVINCEAREA
  add constraint PK_PROVINCEAREA primary key (ID);
  /*
-- Grant/Revoke object privileges 
grant select on PROVINCEAREA to BC;
grant select on PROVINCEAREA to DEP_ADDRESS;
grant select on PROVINCEAREA to FIN_DEP_ROLE;
grant select, insert, update, delete on PROVINCEAREA to SM_ALLUSERS;
grant select, insert, update, delete on PROVINCEAREA to SM_ALLUSERS_RESTRICT;
grant select, insert, update, delete on PROVINCEAREA to SM_NOCHARGES;
grant select on PROVINCEAREA to SM_READONLY;
grant select on PROVINCEAREA to SM_TEST;
*/

-----------------------------------------
--
-- Create table
create table MOVESETS
(
  id                         NUMBER(27) not null,
  movetype_id                NUMBER(27) not null,
  client_id                  NUMBER(27) not null,
  prevclient_id              NUMBER(27),
  docset_id                  NUMBER(27) not null,
  transferbasis_id           NUMBER(27) not null,
  sharemove_id               NUMBER(27),
  hideinreports              CHAR(1) default 'N',
  verified                   CHAR(1) default 'Y',
  munreport_id               NUMBER(27),
  annulreasons_id            NUMBER(27),
  b_arbitrage                CHAR(1) default 'N' not null,
  notes                      VARCHAR2(4000),
  registereduser_id          NUMBER(27),
  insert_date                DATE default trunc(sysdate),
  municipal                  CHAR(1) default 'N' not null,
  complex_name               VARCHAR2(60),
  address_id                 NUMBER(27),
  complex_activities_id      NUMBER(27),
  complex_cost               NUMBER(13,3),
  complex_fixed_assets       NUMBER(13,3),
  complex_floating_assets    NUMBER(13,3),
  b_moveset_denial           CHAR(1) default 'N',
  b_changes_lock             CHAR(1) default 'N',
  date_changes_lock          DATE,
  branch_client_id           NUMBER(27),
  last_period_id             NUMBER(27),
  date_start_municipal       DATE,
  municipal_moveset_id       NUMBER(27),
  do_not_recalc_charges_date DATE,
  control_date               DATE,
  is_multi_subject           CHAR(1) default 'N',
  date_reg_egrp              DATE,
  date_end_municipal         DATE,
  foreigner                  CHAR(1) default 'N' not null,
  act_from_mio               CHAR(1) default 'N',
  storndate                  DATE,
  wasbase                    CHAR(1) default 'N',
  kiosk                      CHAR(1) default 'N',
  period_construction        CHAR(1) default 'N',
  claim_work_id              NUMBER(27)
)
tablespace USR
  pctfree 0
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table MOVESETS
  is 'Операции движения';
-- Add comments to the columns 
comment on column MOVESETS.id
  is 'ID {BUTTON:300,115,75,20,"В поиск","Show_Moveset"}';
comment on column MOVESETS.movetype_id
  is 'Вид  движения ID';
comment on column MOVESETS.client_id
  is 'Название субъекта права ID';
comment on column MOVESETS.prevclient_id
  is 'Предыдущий субъект права ID {BUTTON:380,115,75,20,"Техпаспорт","Add_TP" OPTION:(MOVETYPE_ID=29)}';
comment on column MOVESETS.docset_id
  is 'Совпадает с docset_id последнего периода операции';
comment on column MOVESETS.transferbasis_id
  is 'Основание ID';
comment on column MOVESETS.sharemove_id
  is 'Движение ЦБ';
comment on column MOVESETS.hideinreports
  is 'Скрывать в отчётах';
comment on column MOVESETS.verified
  is 'Кадаст. 2011{FIELD:5,65,200,14 OPTION:((MOVETYPE_ID = 4) or (MOVETYPE_ID = 9))}';
comment on column MOVESETS.munreport_id
  is 'Ссылка на ID отчета';
comment on column MOVESETS.annulreasons_id
  is 'Состояние операции ID {FIELD:95,25,200,14 LABEL:5,27,70,14,"Состояние" OPTION:((MOVETYPE_ID=1) or (MOVETYPE_ID=3)or (MOVETYPE_ID=57) or (MOVETYPE_ID=4) or (MOVETYPE_ID=9) or (MOVETYPE_ID=18) or (MOVETYPE_ID=19) or (MOVETYPE_ID=23) or (MOVETYPE_ID=22) or (MOVETYPE_ID=27) or (MOVETYPE_ID=29) or (MOVETYPE_ID=34) or (MOVETYPE_ID=37)or (MOVETYPE_ID=39)or (MOVETYPE_ID=56)or (MOVETYPE_ID=46))}';
comment on column MOVESETS.b_arbitrage
  is 'Арбитражный суд был {FIELD:5,45,133,14 OPTION:((MOVETYPE_ID=4)or (MOVETYPE_ID=57))}';
comment on column MOVESETS.notes
  is 'Примечание {FIELD:300,5,360,100}';
comment on column MOVESETS.registereduser_id
  is 'Ответственный {FIELD:95,5,200,14 LABEL:5,7,80,14,"Ответственный" OPTION:((MOVETYPE_ID=1) or (MOVETYPE_ID=3)or (MOVETYPE_ID=57) or (MOVETYPE_ID=4) or (MOVETYPE_ID=9) or (MOVETYPE_ID=18) or (MOVETYPE_ID=19) or (MOVETYPE_ID=23) or (MOVETYPE_ID=22) or (MOVETYPE_ID=27) or (MOVETYPE_ID=29)or (MOVETYPE_ID=34)or (MOVETYPE_ID=39)or(MOVETYPE_ID=37)or(MOVETYPE_ID=46)or (MOVETYPE_ID=56) or(MOVETYPE_ID=47))}';
comment on column MOVESETS.insert_date
  is 'Дата добавления';
comment on column MOVESETS.municipal
  is 'Муниципальный объект {FIELD:5,85,140,14 OPTION:((MOVETYPE_ID=22) or(MOVETYPE_ID=37) or (MOVETYPE_ID=1004))}';
comment on column MOVESETS.complex_name
  is 'Наименование комплекса {FIELD:96,47,198,14 LABEL:5,47,70,14,"Комплекс" OPTION:(MOVETYPE_ID=27)}';
comment on column MOVESETS.address_id
  is 'Адрес ID {FIELD:9,67,290,14 OPTION:(MOVETYPE_ID=27)}';
comment on column MOVESETS.complex_activities_id
  is 'Деятельность комплекса имущества {FIELD:96,85,198,14 LABEL:5,87,70,14,"Деятельность" LINE:310,0,0,107 OPTION:(MOVETYPE_ID=27)}';
comment on column MOVESETS.complex_cost
  is 'Стоимость комплекса {FIELD:357,98,60,14 LABEL:300,98,70,14,"Стоимость" OPTION:(MOVETYPE_ID=27)}';
comment on column MOVESETS.complex_fixed_assets
  is 'Основные средства комплекса {FIELD:477,98,60,14 LABEL:422,98,70,14,"Осн. сред." OPTION:(MOVETYPE_ID=27)}';
comment on column MOVESETS.complex_floating_assets
  is 'Оборотные средства коплекса {FIELD:600,98,60,14 LABEL:540,98,70,14,"Обор. сред." OPTION:(MOVETYPE_ID=27)}';
comment on column MOVESETS.b_moveset_denial
  is 'Отказ от права собственности {FIELD:5,45,210,14 OPTION:(MOVETYPE_ID=1)}';
comment on column MOVESETS.b_changes_lock
  is 'Изменение реквизитов объекта c {FIELD:5,85,220,14 OPTION:((MOVETYPE_ID=22) or (MOVETYPE_ID=1) or (MOVETYPE_ID=3) or (MOVETYPE_ID=18) or (MOVETYPE_ID=19))}';
comment on column MOVESETS.date_changes_lock
  is 'Дата изменения реквизитов объекта {FIELD:220,83,75,14 OPTION:((MOVETYPE_ID=22) or (MOVETYPE_ID=1) or (MOVETYPE_ID=3) or (MOVETYPE_ID=18) or (MOVETYPE_ID=19))}';
comment on column MOVESETS.branch_client_id
  is 'Филиал {FIELD:50,100,245,14 LABEL:5,100,40,14,"Филиал" OPTION:((MOVETYPE_ID=4) or (MOVETYPE_ID=9) or (MOVETYPE_ID=57) or (MOVETYPE_ID=19) or (MOVETYPE_ID=3) or (MOVETYPE_ID=1) or (MOVETYPE_ID=23) )}';
comment on column MOVESETS.last_period_id
  is 'Последний период ID {BUTTON:380,115,75,20,"КБК","Show_KBK" OPTION:(MOVETYPE_ID<>29) }';
comment on column MOVESETS.date_start_municipal
  is 'Дата начала муницпальной собственности {FIELD:162,65,80,14 LABEL:150,67,5,14,"c" OPTION:((MOVETYPE_ID=1004))}';
comment on column MOVESETS.municipal_moveset_id
  is 'Ссылка на муниципальную ОП собственность для аренды земли (заполнить как нить)';
comment on column MOVESETS.do_not_recalc_charges_date
  is 'Дата, до которой не пересичтывать начисления FIELD:180,120,115,14 LABEL:5,122,140,14,не пересчитывать начисления до';
comment on column MOVESETS.control_date
  is 'Дата контроля {LABEL:5,57,100,14,"Дата контроля продления договора" FIELD:220,55,75,14 OPTION:(MOVETYPE_ID=29)}';
comment on column MOVESETS.is_multi_subject
  is 'Множественность лиц на стороне субъекта';
comment on column MOVESETS.date_reg_egrp
  is 'Дата регистрации договора в ЕГРП {LABEL:22,122,220,14,"Дата регистрации договора в ЕГРП" FIELD:220,120,75,14 OPTION:((MOVETYPE_ID=22) or (MOVETYPE_ID=46)or (MOVETYPE_ID=57) or (MOVETYPE_ID=4) or (MOVETYPE_ID=30) or (MOVETYPE_ID=47) or (MOVETYPE_ID=16) or (MOVETYPE_ID=12) or (MOVETYPE_ID=39) or (MOVETYPE_ID=18) or (MOVETYPE_ID=3) or (MOVETYPE_ID=5))}';
comment on column MOVESETS.date_end_municipal
  is 'Дата окончания мун.собственности{LABEL:22,85,220,14,"Дата окончания мун.собственности" FIELD:220,85,75,14 OPTION:((MOVETYPE_ID=22) or (MOVETYPE_ID=46) or (MOVETYPE_ID=57) or (MOVETYPE_ID=4) or (MOVETYPE_ID=30) or (MOVETYPE_ID=47) or (MOVETYPE_ID=16) or (MOVETYPE_ID=12) or (MOVETYPE_ID=39) or (MOVETYPE_ID=18) or (MOVETYPE_ID=3) or (MOVETYPE_ID=5))}';
comment on column MOVESETS.foreigner
  is 'Иностранцы{FIELD:150,45,133,14 OPTION:((MOVETYPE_ID = 4) or (MOVETYPE_ID = 9)or (MOVETYPE_ID = 57))}';
comment on column MOVESETS.act_from_mio
  is 'По акту из МИО{FIELD:150,65,133,14 OPTION:((ANNULREASONS_ID = 568) or (ANNULREASONS_ID = 570) or (ANNULREASONS_ID = 582)or (ANNULREASONS_ID = 962)or (ANNULREASONS_ID = 2446)or (ANNULREASONS_ID = 2447)or (ANNULREASONS_ID = 1525)or (ANNULREASONS_ID =2300)or (ANNULREASONS_ID = 2303)or (ANNULREASONS_ID = 2321)or (ANNULREASONS_ID = 2362))}';
comment on column MOVESETS.storndate
  is 'Дата сторнирования {FIELD:576,118,86,14 LABEL:463,120,70,14,"Дата сторнирования" OPTION:((MOVETYPE_ID=22) or (MOVETYPE_ID=7) or (MOVETYPE_ID=27))}';
comment on column MOVESETS.wasbase
  is 'Был базовым{FIELD:95,65,100,14 OPTION:((MOVETYPE_ID = 4) or (MOVETYPE_ID = 9))}';
comment on column MOVESETS.kiosk
  is 'НТО{FIELD:605,115,110,14 OPTION:((MOVETYPE_ID = 4) or (MOVETYPE_ID = 9))}';
comment on column MOVESETS.period_construction
  is 'Период установки{FIELD:480,115,120,14 OPTION:((MOVETYPE_ID = 4) or (MOVETYPE_ID = 9))}';
comment on column MOVESETS.claim_work_id
  is 'Претенз.работа {FIELD:95,142,200,14 LABEL:5,142,70,14,"Претенз.работа " OPTION:((MOVETYPE_ID=1) or (MOVETYPE_ID=3)or (MOVETYPE_ID=57) or (MOVETYPE_ID=4) or (MOVETYPE_ID=9) or (MOVETYPE_ID=18) or (MOVETYPE_ID=19) or (MOVETYPE_ID=23) or (MOVETYPE_ID=22) or (MOVETYPE_ID=27) or (MOVETYPE_ID=29) or (MOVETYPE_ID=34) or (MOVETYPE_ID=37)or (MOVETYPE_ID=39)or (MOVETYPE_ID=56)or (MOVETYPE_ID=46))}';
-- Create/Recreate indexes 
/*
create index IDX_MVS_ADDRESS_ID on MOVESETS (ADDRESS_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MVS_BRANCH_CLIENT_ID on MOVESETS (BRANCH_CLIENT_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MVS_CLIENT_ID on MOVESETS (CLIENT_ID)
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MVS_DOCSET_ID on MOVESETS (DOCSET_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MVS_LAST_PERIOD_ID on MOVESETS (LAST_PERIOD_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MVS_MUNREPORT_ID on MOVESETS (MUNREPORT_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MVS_PREVCLIENT_ID on MOVESETS (PREVCLIENT_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_MVS_SHAREMOVE_ID on MOVESETS (SHAREMOVE_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IX_MVS_MOVETYPE_ANNUALREAS on MOVESETS (MOVETYPE_ID, ANNULREASONS_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  */
-- Create/Recreate primary, unique and foreign key constraints 
alter table MOVESETS
  add constraint PK_MOVESETS primary key (ID)
  using index 
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
--alter table MOVESETS
--  add constraint CS_MS_SHAREMOVE foreign key (SHAREMOVE_ID)
--  references SHAREMOVE (ID)
--  deferrable;
--alter table MOVESETS
--  add constraint FK_COMPLEX_ACTIVITIES_ID foreign key (COMPLEX_ACTIVITIES_ID)
--  references COMPLEX_ACTIVITIES (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_ADDRESS_ID foreign key (ADDRESS_ID)
--  references ADDRESS (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_ANNULREASONS foreign key (ANNULREASONS_ID)
--  references ANNULREASONS (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_CLAIMWORK_TYPE foreign key (CLAIM_WORK_ID)
--  references CLAIM_WORK_TYPE (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_CLIENT foreign key (CLIENT_ID)
--  references CLIENTS (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_CLIENTS foreign key (BRANCH_CLIENT_ID)
--  references CLIENTS (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_DOCSET foreign key (DOCSET_ID)
--  references DOCSETS (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_MOVETYPE foreign key (MOVETYPE_ID)
--  references MOVETYPE (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_MUN_MOVESETS foreign key (MUNICIPAL_MOVESET_ID)
--  references MOVESETS (ID)
--  deferrable initially deferred;
--alter table MOVESETS
--  add constraint FK_MOVESETS_MUNREPORT foreign key (MUNREPORT_ID)
--  references MUNREPORTS (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_PREVCLIENT foreign key (PREVCLIENT_ID)
--  references CLIENTS (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_REGISTEREDUSERS foreign key (REGISTEREDUSER_ID)
--  references REGISTEREDUSERS (ID);
--alter table MOVESETS
--  add constraint FK_MOVESETS_TRANSFERBASIS foreign key (TRANSFERBASIS_ID)
--  references TRANSFERBASIS (ID);
-- Create/Recreate check constraints 
alter table MOVESETS
  add constraint ACT_FROM_MIO_CH
  check (ACT_FROM_MIO  IN ('Y','N'));
alter table MOVESETS
  add constraint CHK_MOVESET_MULTI_SUBJECTS
  check (IS_MULTI_SUBJECT IN ('Y','N'));
alter table MOVESETS
  add constraint CS_ARBITRAGE
  check (b_arbitrage IN ('Y','N'));
alter table MOVESETS
  add constraint CS_B_CHANGES_LOCK
  check (B_CHANGES_LOCK IN ('Y','N'));
alter table MOVESETS
  add constraint CS_FOREIGNER
  check (FOREIGNER IN ('Y','N'));
alter table MOVESETS
  add constraint CS_MOVESET_DENIAL
  check (B_MOVESET_DENIAL IN ('Y','N'));
alter table MOVESETS
  add constraint CS_MUNICIPAL
  check (municipal IN ('Y','N'));
alter table MOVESETS
  add constraint CS_PERIOD_CONSTRUCTION
  check (PERIOD_CONSTRUCTION IN ('Y','N'));
alter table MOVESETS
  add check (WASBASE IN ('Y','N'));
alter table MOVESETS
  add check (KIOSK IN ('Y','N'));
alter table MOVESETS
  add check (HideInReports IN ('Y','N'));
alter table MOVESETS
  add check (VERIFIED IN ('Y','N'));
-- Grant/Revoke object privileges 
--grant select on MOVESETS to DEP_ADDRESS;
--grant select on MOVESETS to LETTER;
--grant select on MOVESETS to LOADER;
--grant select on MOVESETS to SM_ALLUSERS;
--grant select on MOVESETS to SM_ALLUSERS_RESTRICT;
--grant select, update on MOVESETS to SM_CANDISCOUNT;
--grant select, insert, update on MOVESETS to SM_CANMOVE;
--grant select, insert, update, delete on MOVESETS to SM_LAND_PARAMS;
--grant select on MOVESETS to SM_NOCHARGES;
--grant select on MOVESETS to SM_READONLY;
--grant delete on MOVESETS to SM_REMOVEMOVESET;
--grant select on MOVESETS to SM_TEST;


-- Create table
create table CLIENTS
(
  id                  NUMBER(27) not null,
  clienttype          VARCHAR2(60),
  name                VARCHAR2(200),
  sections_id         NUMBER(27),
  rating_authority_id NUMBER(27),
  land_reg_number     VARCHAR2(40),
  land_notes          VARCHAR2(4000),
  inn                 VARCHAR2(14),
  address_id          NUMBER(27) not null,
  change_date         DATE,
  change_doc          NUMBER(27),
  okonh               VARCHAR2(20),
  okpo                VARCHAR2(20),
  okved               VARCHAR2(150),
  bankname            VARCHAR2(50),
  kpp                 VARCHAR2(9),
  account             VARCHAR2(20),
  corraccount         VARCHAR2(20),
  bik                 VARCHAR2(9),
  regdoc_id           NUMBER(27),
  unpreferred         CHAR(1) default 'N',
  info                VARCHAR2(4000),
  bank_id             NUMBER(10),
  ownership_name      VARCHAR2(254),
  client_types_id     NUMBER(27) not null,
  e_mail              VARCHAR2(60),
  mobil_phone         VARCHAR2(12),
  average_employee    NUMBER(13),
  balance_cost        NUMBER(27,2),
  residual_cost       NUMBER(27,2)
)
tablespace USR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 328K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table CLIENTS
  is 'Клиенты';
-- Add comments to the columns 
comment on column CLIENTS.id
  is 'ID';
comment on column CLIENTS.clienttype
  is 'Тип субъекта права';
comment on column CLIENTS.name
  is 'Наименование';
comment on column CLIENTS.sections_id
  is 'Отрасль ID';
comment on column CLIENTS.rating_authority_id
  is 'Налоговые ID {FIELD:108,210,195,14 LABEL:15,212,190,14,"Налоговая" TAB:"Прочее" FRAME:5,203,305,195}';
comment on column CLIENTS.land_reg_number
  is 'Регистрационный номер (Земля) {FIELD:158,18,140,14 LABEL:15,18,190,14,"Регистрационный номер"  TAB:"Прочее"}';
comment on column CLIENTS.land_notes
  is 'Примечания (Земля) {FIELD:15,118,285,70 LABEL:15,102,170,14,"Примечания" TAB:"Прочее" FRAME:5,5,305,190}';
comment on column CLIENTS.inn
  is 'ИНН';
comment on column CLIENTS.address_id
  is 'Адрес ID ';
comment on column CLIENTS.change_date
  is 'Дата, с которой вступает изменение в силу';
comment on column CLIENTS.change_doc
  is 'Документ, на основании которого внесено изменение';
comment on column CLIENTS.okonh
  is 'ОКОНХ';
comment on column CLIENTS.okpo
  is 'ОКПО';
comment on column CLIENTS.okved
  is 'ОКВЭД';
comment on column CLIENTS.bankname
  is 'Банк';
comment on column CLIENTS.kpp
  is 'КПП';
comment on column CLIENTS.account
  is 'Расч.счет';
comment on column CLIENTS.corraccount
  is 'Корр.счет';
comment on column CLIENTS.bik
  is 'БИК';
comment on column CLIENTS.regdoc_id
  is 'Пакет документов субъекта права ID';
comment on column CLIENTS.unpreferred
  is 'Нежелат.клиент';
comment on column CLIENTS.info
  is 'Доп.информация';
comment on column CLIENTS.bank_id
  is 'Идентификатор банка';
comment on column CLIENTS.ownership_name
  is 'Название вида собственности, распоряжаемое данным клиентом';
comment on column CLIENTS.client_types_id
  is 'Тип клиента ID';
comment on column CLIENTS.e_mail
  is 'Электронная почта [TAB:"Физическое лицо" LABEL:10,278,46,13,"e-mail:" FIELD:60,278,277,15 OPTION:(CLIENT_TYPES_ID=1)] {TAB:"Реквизиты" LABEL:188,365,20,13,"e-mail:" FIELD:221,365,111,15 OPTION:(CLIENT_TYPES_ID=2)}';
comment on column CLIENTS.mobil_phone
  is 'Мобильный телефон [TAB:"Физическое лицо" LABEL:168,258,75,13,"Мобильн. тел.:" FIELD:245,257,92,15,"\+\7\9000000000;1;_" OPTION:(CLIENT_TYPES_ID=1)] {TAB:"Реквизиты" LABEL:143,345,75,13,"Мобильн. тел.:" FIELD:221,345,111,15,"\+\7\9000000000;1;_" OPTION:(CLIENT_TYPES_ID=2)}';
comment on column CLIENTS.average_employee
  is 'Среднесписочная численность{FIELD:178,38,120,14 LABEL:15,38,150,14,"Среднесписочная численность"  TAB:"Прочее"}';
comment on column CLIENTS.balance_cost
  is 'Балансовая стоимость {FIELD:182,58,116,14 LABEL:15,58,150,14,"Балансовая стоимость ОФ, руб. "  TAB:"Прочее"}';
comment on column CLIENTS.residual_cost
  is 'Остаточная стоимость {FIELD:182,78,116,14 LABEL:15,78,150,14,"Остаточная стоимость ОФ, руб."  TAB:"Прочее"}';
-- Create/Recreate indexes 
/*
create index IDXCLIENTLANDREGNUMBER on CLIENTS (LAND_REG_NUMBER)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDXCLIENTSADDRESS on CLIENTS (ADDRESS_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDXCLIENTSECTION on CLIENTS (SECTIONS_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 104K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDXCLIENTSINN on CLIENTS (INN)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDXCLIENTSREGDOC on CLIENTS (REGDOC_ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create unique index SYS_C006875 on CLIENTS (ID)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  */
-- Create/Recreate primary, unique and foreign key constraints 
alter table CLIENTS
  add constraint PK_CLIENTS primary key (ID);
  /*
alter table CLIENTS
  add constraint FK_CLIENTS_ADDRESS foreign key (ADDRESS_ID)
  references ADDRESS (ID);
alter table CLIENTS
  add constraint FK_CLIENTS_BANKS foreign key (BANK_ID)
  references BANKS (ID);
alter table CLIENTS
  add constraint FK_CLIENTS_CLIENT_TYPES_ID foreign key (CLIENT_TYPES_ID)
  references CLIENT_TYPES (ID);
alter table CLIENTS
  add constraint FK_CLIENTS_DOCUMENTS foreign key (CHANGE_DOC)
  references DOCUMENTS (ID);
alter table CLIENTS
  add constraint FK_CLIENTS_RATING_AUTHORITY foreign key (RATING_AUTHORITY_ID)
  references RATING_AUTHORITY (ID);
alter table CLIENTS
  add constraint FK_CLIENTS_REGDOC_ID foreign key (REGDOC_ID)
  references DOCSETS (ID);
alter table CLIENTS
  add constraint FK_CLIENTS_SECTIONS_ID foreign key (SECTIONS_ID)
  references SECTIONS (ID);
-- Create/Recreate check constraints 
alter table CLIENTS
  add constraint CSCLI_UNPREFERRED
  check (Unpreferred IN ('Y','N'));
-- Grant/Revoke object privileges 
grant select on CLIENTS to DEP_ADDRESS;
grant select, update on CLIENTS to DEP_IMPMU;
grant select on CLIENTS to FIN_DEP_ROLE;
grant select, insert, update, delete on CLIENTS to KAZUROVA;
grant select on CLIENTS to LETTER;
grant select on CLIENTS to LOADER;
grant select, insert, update, delete on CLIENTS to SM_ALLUSERS;
grant select, insert, update, delete on CLIENTS to SM_ALLUSERS_RESTRICT;
grant select, insert, update, delete on CLIENTS to SM_NOCHARGES;
grant select on CLIENTS to SM_READONLY;
grant select on CLIENTS to SM_TEST;
*/

-----------------------------------

-- Create table
create table OBLIGATIONS
(
  id                 NUMBER(27) not null,
  moveset_id         NUMBER(27) not null,
  obligationtype_id  NUMBER(27) not null,
  cursaldo           NUMBER(27,2),
  curfine            NUMBER(27,2),
  oblig_presets_id   NUMBER(27),
  recalc_actual_date DATE,
  printed_blank      CHAR(1) default 'N'
)
tablespace USR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table OBLIGATIONS
  is 'Обязательства';
-- Add comments to the columns 
comment on column OBLIGATIONS.id
  is 'ID';
comment on column OBLIGATIONS.moveset_id
  is 'Операции движения ID';
comment on column OBLIGATIONS.obligationtype_id
  is 'Тип обязательства ID';
comment on column OBLIGATIONS.cursaldo
  is 'Текущее сальдо по обязательству';
comment on column OBLIGATIONS.curfine
  is 'Текущая пеня по обязательству';
comment on column OBLIGATIONS.oblig_presets_id
  is 'Общие для всего обязательства настройки - чаще всего общие предустановки, но могут быть заданы индивидуально для обязательства.';
comment on column OBLIGATIONS.recalc_actual_date
  is 'Дата, с которой требуется произвести расчет по обязательству';
comment on column OBLIGATIONS.printed_blank
  is 'Печаталась ли квитанция по обязательству.';
-- Create/Recreate indexes 
/*
create index IDX_OBLIGS_MOVESET_ID on OBLIGATIONS (MOVESET_ID)
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create index IDX_OBLIGS_OBLIGATIONTYPE_ID on OBLIGATIONS (OBLIGATIONTYPE_ID)
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  */
  
-- Create/Recreate primary, unique and foreign key constraints 
alter table OBLIGATIONS
  add constraint PK_OBLIGATIONS_ID primary key (ID)
  using index 
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
  /*
alter table OBLIGATIONS
  add constraint UK_OBLIGATIONS_MSID_OTID unique (MOVESET_ID, OBLIGATIONTYPE_ID)
  using index 
  tablespace USR
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table OBLIGATIONS
  add constraint FK_OBLIGATIONS_MOVESETS foreign key (MOVESET_ID)
  references MOVESETS (ID);
alter table OBLIGATIONS
  add constraint FK_OBLIGATIONS_OBTPID_OBTYP foreign key (OBLIGATIONTYPE_ID)
  references OBLIGATIONTYPE (ID) on delete cascade;
-- Grant/Revoke object privileges 
grant select on OBLIGATIONS to DEP_ADDRESS;
grant select on OBLIGATIONS to LOADER;
grant select, insert, update, delete on OBLIGATIONS to SM_ALLUSERS;
grant select, insert, update, delete on OBLIGATIONS to SM_ALLUSERS_RESTRICT;
grant select, insert, update, delete on OBLIGATIONS to SM_NOCHARGES;
grant select on OBLIGATIONS to SM_READONLY;
grant delete on OBLIGATIONS to SM_REMOVEMOVESET;
grant select on OBLIGATIONS to SM_TEST;
*/
----------------------


-- Create table
create table LETTER.BD
(
  bd_id         NUMBER(27) not null,
  ls            VARCHAR2(11),
  rdate         DATE,
  guid_otch     VARCHAR2(255),
  kod_doc       VARCHAR2(2),
  kol           NUMBER(5),
  sum_total     NUMBER(20,2),
  bdpd          VARCHAR2(5),
  num_pp        VARCHAR2(10),
  date_pp       DATE,
  sum_pp        NUMBER(20,2),
  vid_pl        VARCHAR2(10),
  date_pp_in    DATE,
  date_pp_sps   DATE,
  vid_oper      VARCHAR2(2),
  inn_pay       VARCHAR2(12),
  kpp_pay       VARCHAR2(10),
  cname_pay     VARCHAR2(160),
  bs_pay        VARCHAR2(20),
  bic_pay       VARCHAR2(9),
  name_bic_pay  VARCHAR2(160),
  bs_ks_pay     VARCHAR2(20),
  inn_rcp       VARCHAR2(12),
  kpp_rcp       VARCHAR2(9),
  cname_ubp_rcp VARCHAR2(160),
  bs_rcp        VARCHAR2(20),
  bic_rcp       VARCHAR2(9),
  name_bic_rcp  VARCHAR2(160),
  bs_ks_rcp     VARCHAR2(20),
  date_pay      DATE,
  order_pay     VARCHAR2(1),
  purpose       VARCHAR2(210),
  paystatus     VARCHAR2(2),
  kbk           VARCHAR2(20),
  okato         VARCHAR2(11),
  osnplat       VARCHAR2(2),
  nal_per       VARCHAR2(10),
  num_dok       VARCHAR2(15),
  date_dok      VARCHAR2(10),
  type_pl       VARCHAR2(2),
  nom_pl_po     VARCHAR2(3),
  shifr_rd_po   VARCHAR2(2),
  nom_rd_po     VARCHAR2(6),
  date_rd_po    DATE,
  sum_ost_po    NUMBER(20,2),
  oper_po       VARCHAR2(16),
  date_in_tofk  DATE,
  guid          VARCHAR2(255) not null,
  bdpdst        VARCHAR2(255),
  kbk_1         VARCHAR2(20),
  type_kbk      VARCHAR2(2),
  add_klass     VARCHAR2(20),
  num_bo        VARCHAR2(19),
  okato_1       VARCHAR2(11),
  sum           NUMBER(20,2),
  dir_sum       VARCHAR2(1),
  mes_fin       VARCHAR2(2),
  rezerv        VARCHAR2(40),
  cl_id         NUMBER(20),
  uin           VARCHAR2(26),
  nom_el_mes    VARCHAR2(9),
  date_el_mes   DATE,
  id_el_mes     VARCHAR2(10),
  id_contr      VARCHAR2(25),
  num_akk       VARCHAR2(50),
  sum_nds_itog  NUMBER(20,2),
  sum_nds       NUMBER(20,2),
  nom_line      NUMBER(20,2)
)
tablespace USR
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the table 
comment on table LETTER.BD
  is 'Информация из расчетных документов';
-- Add comments to the columns 
comment on column LETTER.BD.bd_id
  is 'ID';
comment on column LETTER.BD.ls
  is 'Номер лицевого счета клиента или номер реестра платежей, поступивших минуя счет ОрФК./ СБЕРБАНК Номер обязательства обработанный';
comment on column LETTER.BD.rdate
  is 'Дата документа, к которому при-лагается инфор-мация из расчет-ных документов';
comment on column LETTER.BD.guid_otch
  is 'Глобальный уникальный идентификатор выписки из лицевого счета, реестра / СБЕРБАНК Имя файла из которого был принят реестр ';
comment on column LETTER.BD.kod_doc
  is 'Код документа, к которому прилагается информация из расчетных документов.';
comment on column LETTER.BD.kol
  is 'Количество прилагаемых рас-четных документов / СБЕРБАНК  -1';
comment on column LETTER.BD.sum_total
  is 'Общая сумма по прилагаемым расчетным документам.';
comment on column LETTER.BD.bdpd
  is '==============================================================================================';
comment on column LETTER.BD.num_pp
  is 'Номер платежно-го документа / СБЕРБАНК номер квитанции';
comment on column LETTER.BD.date_pp
  is 'Дата платежного документа / СБЕРБАНК дата квитанции';
comment on column LETTER.BD.sum_pp
  is 'Сумма платежно-го документа / СБЕРБАНК сумма с пеней';
comment on column LETTER.BD.vid_pl
  is 'Вид платежа: 0 - пусто 1 - почтой 2 - телеграфом 3 - электронно 4 - срочно';
comment on column LETTER.BD.date_pp_in
  is 'Поступило в банк плательщика. ';
comment on column LETTER.BD.date_pp_sps
  is 'Дата списания со счета плательщи-ка. ';
comment on column LETTER.BD.vid_oper
  is 'Вид операции.';
comment on column LETTER.BD.inn_pay
  is 'ИНН Платель-щика';
comment on column LETTER.BD.kpp_pay
  is 'КПП Плательщи-ка. ';
comment on column LETTER.BD.cname_pay
  is 'Наименование Плательщика  / СБЕРБАНК плательщик+ адрес плательщика';
comment on column LETTER.BD.bs_pay
  is 'Расчетный счет Плательщика / СБЕРБАНК номер обязательства в исходном виде';
comment on column LETTER.BD.bic_pay
  is 'БИК банка Пла-тельщика';
comment on column LETTER.BD.name_bic_pay
  is 'Наименование банка Платель-щика';
comment on column LETTER.BD.bs_ks_pay
  is 'Коррсчет банка Плательщика в РКЦ';
comment on column LETTER.BD.inn_rcp
  is 'ИНН Получателя';
comment on column LETTER.BD.kpp_rcp
  is 'КПП Получателя';
comment on column LETTER.BD.cname_ubp_rcp
  is 'Наименование Получателя ';
comment on column LETTER.BD.bs_rcp
  is 'Расчетный счет Получателя';
comment on column LETTER.BD.bic_rcp
  is 'БИК банка Полу-чателя';
comment on column LETTER.BD.name_bic_rcp
  is 'Наименование банка Получателя / СБЕРБАНК филиал+касса';
comment on column LETTER.BD.bs_ks_rcp
  is 'Коррсчет банка Получателя в РКЦ';
comment on column LETTER.BD.date_pay
  is 'Срок платежа Не заполняется до указаний Банка России';
comment on column LETTER.BD.order_pay
  is 'Очередность пла-тежа ';
comment on column LETTER.BD.purpose
  is 'Назначение пла-тежа / СБЕРБАНК доп реквизиты';
comment on column LETTER.BD.paystatus
  is 'Статус состави-теля расчетного документа';
comment on column LETTER.BD.kbk
  is 'Код бюджетной классификации ';
comment on column LETTER.BD.okato
  is 'Код ОКАТО ';
comment on column LETTER.BD.osnplat
  is 'Показатель осно-вания платежа ';
comment on column LETTER.BD.nal_per
  is 'Показатель нало-гового периода ';
comment on column LETTER.BD.num_dok
  is 'Показатель номе-ра документа ';
comment on column LETTER.BD.date_dok
  is 'Показатель даты документа ';
comment on column LETTER.BD.type_pl
  is 'Тип платежа ';
comment on column LETTER.BD.nom_pl_po
  is 'Номер частично-го платежа';
comment on column LETTER.BD.shifr_rd_po
  is 'Шифр платежно-го документа';
comment on column LETTER.BD.nom_rd_po
  is 'Номер платежно-го документа';
comment on column LETTER.BD.date_rd_po
  is 'Дата платежного документа';
comment on column LETTER.BD.sum_ost_po
  is 'Сумма остатка платежа / СБЕРБАНК сумма пени';
comment on column LETTER.BD.oper_po
  is 'Содержание опе-рации';
comment on column LETTER.BD.date_in_tofk
  is 'Дата зачисления на счет ОрФК / СБЕРБАНК дата реестра';
comment on column LETTER.BD.guid
  is 'Глобальный уникальный идентификатор первичного документа, присвоенный ОрФК. / СБЕРБАНК  имя файла + номер строки';
comment on column LETTER.BD.bdpdst
  is '==============================================================================================';
comment on column LETTER.BD.kbk_1
  is 'Указывается код бюджетной классификации в соответствии с действующими Указаниями по БК. / СБЕРБАНК кбк';
comment on column LETTER.BD.type_kbk
  is 'Допустимые символы:
10 - расходы; 
20 - доходы;
31 - источники внутреннего финансирования дефицита бюджета; 
32 - источники внешнего фи-нансирования дефицита бюд-жета.
';
comment on column LETTER.BD.add_klass
  is 'Код цели субсидии (субвен-ции) из федерального бюдже-та.';
comment on column LETTER.BD.num_bo
  is 'Учетный номер бюджетного обязательства, присвоенный в ОрФК.';
comment on column LETTER.BD.okato_1
  is 'Указывается код в соответст-вии с ОКАТО';
comment on column LETTER.BD.sum
  is 'Сумма  / СБЕРБАНК сумма без пени';
comment on column LETTER.BD.dir_sum
  is 'Допустимые значения:
0 - зачисление;
1 - списание.
';
comment on column LETTER.BD.mes_fin
  is 'Месяц финансирования';
comment on column LETTER.BD.rezerv
  is 'Поле зарезервировано';
comment on column LETTER.BD.cl_id
  is 'Айдишник клиента в нашей базе';
comment on column LETTER.BD.uin
  is 'УИН';
comment on column LETTER.BD.nom_el_mes
  is 'Порядковый номер ЭС';
comment on column LETTER.BD.date_el_mes
  is 'Дата составления ЭС';
comment on column LETTER.BD.id_el_mes
  is 'Уникальный идентификатор составителя ЭС';
comment on column LETTER.BD.id_contr
  is 'Идентификатор контракта';
comment on column LETTER.BD.num_akk
  is 'Номер аккредитива';
comment on column LETTER.BD.sum_nds_itog
  is 'Сумма НДС (Итог)';
comment on column LETTER.BD.sum_nds
  is 'Сумма НДС';
comment on column LETTER.BD.nom_line
  is 'Номер строки бандероли';
-- Create/Recreate indexes 
/*
create index LETTER.IDX_BD_DATE_IN_TOFK on LETTER.BD (DATE_IN_TOFK)
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table LETTER.BD
  add constraint PK_BD primary key (BD_ID)
  using index 
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table LETTER.BD
  add constraint AK_BD_GUID unique (GUID)
  using index 
  tablespace INDX
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Grant/Revoke object privileges 
*/
grant references on LETTER.BD to SM;

