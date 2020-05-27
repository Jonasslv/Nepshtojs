while true; do
    json=$(
        {
            interface=enp4s0
            pairs=()

            R1=$(cat /sys/class/net/$interface/statistics/rx_bytes)
            T1=$(cat /sys/class/net/$interface/statistics/tx_bytes)
            sleep 1
            R2=$(cat /sys/class/net/$interface/statistics/rx_bytes)
            T2=$(cat /sys/class/net/$interface/statistics/tx_bytes)
            TBPS=$(expr $T2 - $T1)
            RBPS=$(expr $R2 - $R1)
            TKBPS=$(expr $TBPS / 1024)
            RKBPS=$(expr $RBPS / 1024)

            pairs+=("\"Up\":\"$TKBPS\"")
            pairs+=("\"Down\":\"$RKBPS\"")
            CPU=$(top -b -n 1 | grep ^%CPU | awk '{print $2}')
            CPUT=$(sensors | grep -i Tdie | awk '{print $2}' | head -c5)

            pairs+=("\"CPU\":\"$CPU\"")
            pairs+=("\"CPUT\":\"$CPUT\"")

            GPU=$(nvidia-smi --query-gpu=utilization.gpu --format=csv | tail -n1)
            GPUT=$(nvidia-smi --query-gpu=temperature.gpu --format=csv | tail -n1)

            pairs+=("\"GPU\":\"$GPU\"")
            pairs+=("\"GPUT\":\"$GPUT\"")

            UPTIME=$(uptime | awk '{print $3}')

            pairs+=("\"UPTIME\":\"$UPTIME\"")

            TOTALMEM=$(free -m | grep -i Mem | awk '{print $2}')
            FREEMEM=$(free -m | grep -i Mem | awk '{print $7}')

            pairs+=("\"TOTALMEM\":\"$TOTALMEM\"")
            pairs+=("\"FREEMEM\":\"$FREEMEM\"")

            KERNEL=$(uname -r)

            pairs+=("\"KERNEL\":\"$KERNEL\"")

            CURRENT=$(bash sp.sh current | tr -d '\n')

            pairs+=("\"CURRENT\":\"$CURRENT\"")

            ALBUMART=$(bash sp.sh art | tr -d '\n')

            pairs+=("\"ALBUMART\":\"$ALBUMART\"")

            IFS=,
            echo "{${pairs[*]}}"
        }
    )
    sleep 2;
    echo "$json" >stats.json
done
