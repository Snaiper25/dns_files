# Удаляем предыдущую версию задания
/system scheduler remove [find where name="update-vpn-lists"]
/system script remove [find where name="update-vpn-lists"]

# Создаём скрипт загрузки и импорта списков
/system script add \
    name="update-vpn-lists" \
    policy=ftp,read,write,policy,test \
    source={

        :local downloadUrl "https://raw.githubusercontent.com/Snaiper25/dns_files/main/generated/dns-auto.rsc"
        :local downloadedFile "dns-auto.rsc"

        :log info "VPN lists: starting GitHub update"

        :do {
            /file remove [find where name=$downloadedFile]

            /tool fetch \
                url=$downloadUrl \
                dst-path=$downloadedFile \
                mode=https \
                check-certificate=yes

            :delay 2s

            :if ([:len [/file find where name=$downloadedFile]] = 0) do={
                :error "Downloaded file not found"
            }

            /import file-name=$downloadedFile

            :log info "VPN lists: update completed successfully"
        } on-error={
            :log error "VPN lists: GitHub update failed"
        }
    }

# Создаём запуск каждые 12 часов
/system scheduler add \
    name="update-vpn-lists" \
    interval=12h \
    start-time=startup \
    policy=ftp,read,write,policy,test \
    on-event="/system script run update-vpn-lists"

# Сразу выполняем первое обновление
/system script run update-vpn-lists

:log info "VPN lists updater installed"
