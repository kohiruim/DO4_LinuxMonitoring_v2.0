## Part 9. Дополнительно. Свой *node_exporter*

##### Добавить на дашборд **Grafana** отображение ЦПУ, оперативной памяти, обьем жесткого диска.
# ![DO4_LinuxMonitoring_v2.0](/src/09/img/9.prometheus.jpg)
# ![DO4_LinuxMonitoring_v2.0](/src/09/img/9.1.jpg)

##### Запустить ваш bash-скрипт из Части 2
##### Посмотреть на нагрузку жесткого диска (место на диске и операции чтения/записи)
# ![DO4_LinuxMonitoring_v2.0](/src/09/img/9.2.jpg)

##### Установить утилиту **stress** и запустить команду `stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 10s`
##### Посмотреть на нагрузку жесткого диска, оперативной памяти и ЦПУ

# ![DO4_LinuxMonitoring_v2.0](/src/09/img/9.3.jpg)
# ![DO4_LinuxMonitoring_v2.0](/src/09/img/9.4.jpg)