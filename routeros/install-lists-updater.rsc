# Installs a guarded daily updater for the generated RouterOS list.
/system scheduler remove [find where name="update-vpn-lists"]
/system script remove [find where name="update-vpn-lists"]

/system script add name="update-vpn-lists" policy=ftp,read,write,test source={
    :local url "https://raw.githubusercontent.com/Snaiper25/dns_files/main/generated/dns-auto.rsc"
    :local staging "dns-auto.new.rsc"
    :local active "dns-auto.rsc"
    :log info "VPN lists: checking GitHub artifact"
    :do {
        /file remove [find where name=$staging]
        /tool fetch url=$url dst-path=$staging mode=https check-certificate=yes
        :delay 2s
        :local item [/file find where name=$staging]
        :if ([:len $item] = 0) do={ :error "downloaded file is missing" }
        :local size [/file get $item size]
        :if (($size < 200) || ($size > 2000000)) do={
            :error ("unexpected artifact size: " . $size)
        }
        /import file-name=$staging
        /file remove [find where name=$active]
        /file set $item name=$active
        :log info ("VPN lists: update completed, bytes=" . $size)
    } on-error={
        /file remove [find where name=$staging]
        :log error ("VPN lists: update failed: " . $message)
    }
}

/system scheduler add name="update-vpn-lists" interval=1d start-time=04:35:00 \
    policy=ftp,read,write,test on-event="/system script run update-vpn-lists"
:log info "VPN lists: guarded updater installed"
