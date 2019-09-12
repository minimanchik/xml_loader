1)файл tables.sql таблицы 


таблицы - формируют адрес -схема SM
ADDRESS
TOWNNAMES
TOWNAREA
STREETS
STREETTYPES
REGIONS
PROVINCEAREA
_______________________________

таблица операции движения - схема SM
MOVESETS

таблица клиенты - схема SM
CLIENTS

таблица Обязательства - схема SM
OBLIGATIONS


таблица Информация из расчетных документов - СХЕМа LETTER
LETTER.BD
в неё будут загружаться данные из XML

2) файл Function.sql
Содержит в себе функцию EXPANDADDR (используется в коде парсера) схема SM
собирает адрес



3) папка "xml loader pay" исходники парсера XML (Delphi 7)
