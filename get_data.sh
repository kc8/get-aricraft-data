curl \
    -H "Host: registry.faa.gov" \
    -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8" \
    -H "Accept-Language: en-US,en;q=0.5" \
    -H "Accept-Encoding: gzip, deflate, br, zstd" \
    -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:127.0) Gecko/20100101 Firefox/127.0" \
    -H "DNT: 1" \
    -H "Sec-GPC: 1" \
    -H "Connection: keep-alive" \
    -H "Referer: https://www.faa.gov/" \
    -H "Upgrade-Insecure-Requests: 1" \
    -H "Sec-Fetch-Dest: document" \
    -H "Sec-Fetch-Mode: navigate" \
    -H "Sec-Fetch-Site: same-site" \
    -H "Sec-Fetch-User: ?1" \
    -H "Priority: u=1" \
    -o "ReleasableAircraft.zip"\
    https://registry.faa.gov/database/ReleasableAircraft.zip 

