# LinuxMonitoring v2.0

Мониторинг и исследование состояния системы в реальном времени.

## Contents

1. [Description](#description) 
2. [Генератор файлов](#part-1-генератор-файлов)  
3. [Засорение файловой системы](#part-2-засорение-файловой-системы)  
4. [Очистка файловой системы](#part-3-очистка-файловой-системы)  
5. [Генератор логов](#part-4-генератор-логов)  
6. [Мониторинг](#part-5-мониторинг)  
7. [GoAccess](#part-6-goaccess)  
8. [Prometheus и Grafana](#part-7-prometheus-и-grafana)  
9. [Готовый дашборд](#part-8-готовый-дашборд)  
10. [Дополнительно. Свой node_exporter](#part-9-дополнительно-свой-node_exporter)  

## Description

- Написанные Bash-скрипты находятся в src
- Для каждого задания создана папка с названием вида: **0x**, где x - номер задания
- Файл с основным сценарием для каждого задания должен называться **main.sh**
- Во всех скриптах предусмотрены проверки на некорректный ввод


## Part 1. Генератор файлов

Скрипт запускается с 6 параметрами. Пример запуска скрипта: \
`main.sh /opt/test 4 az 5 az.az 3kb` 

**Параметр 1** - это абсолютный путь. \
**Параметр 2** - количество вложенных папок. \
**Параметр 3** - список букв английского алфавита, используемый в названии папок (не более 7 знаков). \
**Параметр 4** - количество файлов в каждой созданной папке. \
**Параметр 5** - список букв английского алфавита, используемый в имени файла и расширении (не более 7 знаков для имени, не более 3 знаков для расширения). \
**Параметр 6** - размер файлов (в килобайтах, но не более 100).  

Имена папок и файлов должны состоять только из букв, указанных в параметрах, и использовать каждую из них хотя бы 1 раз.  
Длина этой части имени должна быть от 4 знаков, плюс дата запуска скрипта в формате DD.MM.YY, отделённая нижним подчёркиванием, например: \
**./aaaz_021121/**, **./aaazzzz_021121** 

При этом, если для имени папок или файлов были заданы символы `az`, то в названии файлов или папок не может быть обратной записи: \
**./zaaa_021121/**, т.е. порядок указанных символов в параметре должен сохраняться.

При запуске скрипта в указанном в параметре 1 месте, должны быть созданы папки и файлы в них с соответствующими именами и размером.  
Скрипт останавливает работу, если в файловой системе (в разделе /) останется 1 Гб свободного места.  
Записывается лог файл с данными по всем созданным папкам и файлам (полный путь, дата создания, размер для файлов).


## Part 2. Засорение файловой системы

Скрипт запускается с 3 параметрами. Пример запуска скрипта: \
`main.sh az az.az 3Mb`

**Параметр 1** - список букв английского алфавита, используемый в названии папок (не более 7 знаков). \
**Параметр 2** - список букв английского алфавита, используемый в имени файла и расширении (не более 7 знаков для имени, не более 3 знаков для расширения). \
**Параметр 3** - размер файла (в Мегабайтах, но не более 100).  

Имена папок и файлов состоят только из букв, указанных в параметрах, и используются хотя бы 1 раз.  
Длина этой части имени - от 5 знаков, плюс дата запуска скрипта в формате DD.MM.YY, отделённая нижним подчёркиванием, например: \
**./aaaz_021121/**, **./aaazzzz_021121** 

При этом, если для имени папок или файлов были заданы символы `az`, то в названии файлов или папок нет обратной записи: \
**./zaaa_021121/**, т.е. порядок указанных в параметре символов должен сохраняться.

При запуске скрипта, в различных (любых, кроме путей содержащих **bin** или **sbin**) местах файловой системы, создаются папки с файлами.
Количество вложенных папок - до 100. Количество файлов в каждой папке - случайное число (для каждой папки своё).  
Скрипт останавливает работу, когда в файловой системе (в разделе /) останется 1 Гб свободного места.  
Свободное место в файловой системе определять командой: `df -h /`  

Записывается лог файл с данными по всем созданным папкам и файлам (полный путь, дата создания, размер для файлов).  
В конце работы скрипта, выводится на экран время начало работы скрипта, время окончания и общее время его работы.


## Part 3. Очистка файловой системы

Скрипт запускается с 1 параметром.
Скрипт очищает систему от созданных в [Part 2](#part-2-засорение-файловой-системы) папок и файлов 3 способами:

1. По лог файлу
2. По дате и времени создания
3. По маске имени (т.е. символы, нижнее подчёркивание и дата).  

Способ очистки задается при запуске скрипта, как параметр со значением 1, 2 или 3.

*При удалении по дате и времени создания, пользователем вводятся времена начала и конца с точностью до минуты. Удаляются все файлы, созданные в указанном временном промежутке. Ввод может быть реализован как через параметры, так и во время выполнения программы.*


## Part 4. Генератор логов

Bash-скрипт, генерирующий 5 файлов логов **nginx** в *combined* формате.
Каждый лог содержит информацию за 1 день.

За день генерируется случайное число записей от 100 до 1000.
Для каждой записи случайным образом генерироваться:

1. IP (любые корректные, т.е. не должно быть ip вида 999.111.777.777)
2. Коды ответа (200, 201, 400, 401, 403, 404, 500, 501, 502, 503)
3. Методы (GET, POST, PUT, PATCH, DELETE)
4. Даты (в рамках заданного дня лога, должны идти по увеличению)
5. URL запроса агента
6. Агенты (Mozilla, Google Chrome, Opera, Safari, Internet Explorer, Microsoft Edge, Crawler and bot, Library and net tool)

В комментариях указано, что означает каждый из использованных кодов ответа.

## Part 5. Мониторинг

Bash-скрипт для разбора логов **nginx** из [Части 4](#part-4-генератор-логов) через **awk**.

Скрипт запускается с 1 параметром, который принимает значение 1, 2, 3 или 4.
В зависимости от значения параметра выводятся:

1. Все записи, отсортированные по коду ответа
2. Все уникальные IP, встречающиеся в записях
3. Все запросы с ошибками (код ответа - 4хх или 5хх)
4. Все уникальные IP, которые встречаются среди ошибочных запросов


## Part 6. **GoAccess**

С помощью утилиты GoAccess получить ту же информацию, что и в [Части 5](#part-5-мониторинг)
Открыть веб интерфейс утилиты на локальной машины.


## Part 7. **Prometheus** и **Grafana**

##### Установить и настроить **Prometheus** и **Grafana** на виртуальную машину
##### Получить доступ к веб интерфейсам **Prometheus** и **Grafana** с локальной машины

##### Добавить на дашборд **Grafana** отображение ЦПУ, доступной оперативной памяти, свободное место и кол-во операций ввода/вывода на жестком диске

##### Запустить ваш bash-скрипт из [Части 2](#part-2-засорение-файловой-системы)
##### Посмотреть на нагрузку жесткого диска (место на диске и операции чтения/записи)

##### Установить утилиту **stress** и запустить команду `stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 10s`
##### Посмотреть на нагрузку жесткого диска, оперативной памяти и ЦПУ


## Part 8. Готовый дашборд

##### Установить готовый дашборд *Node Exporter Quickstart and Dashboard* с официального сайта **Grafana Labs**

##### Провести те же тесты, что и в [Части 7](#part-7-prometheus-и-grafana)

##### Запустить ещё одну виртуальную машину, находящуюся в одной сети с текущей
##### Запустить тест нагрузки сети с помощью утилиты **iperf3**

##### Посмотреть на нагрузку сетевого интерфейса


## Part 9. Дополнительно. Свой *node_exporter*

Bash-скрипт или программу на Си, которая собирает информацию по базовым метрикам системы (ЦПУ, оперативная память, жесткий диск (объем)).
Скрипт или программа должна формировать html страничку по формату **Prometheus**, которую будет отдавать **nginx**. \
Саму страничку обновлять можно как внутри bash-скрипта или программы (в цикле), так и при помощи утилиты cron, но не чаще, чем раз в 3 секунды.

##### Поменять конфигурационный файл **Prometheus**, чтобы он собирал информацию с созданной вами странички.

##### Провести те же тесты, что и в [Части 7](#part-7-prometheus-и-grafana)
