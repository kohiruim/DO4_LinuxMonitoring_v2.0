date() {
	CPU="$(cat /proc/loadavg | awk '{print $1}')"
	diskFree="$(df /| grep / | awk '{print $4}')"
	MemTotal="$(free -b | grep Mem | awk '{print $2}')"
	MemUsed="$(free -b | grep Mem | awk '{print $3}')"
	MemCache="$(free -b | grep Mem | awk '{print $6}')"

	echo "# HELP node_cpu_seconds_total Seconds the CPUs spent in each mode."
	echo "# TYPE node_cpu_seconds_total counter"
	echo "node_cpu_seconds_total{cpu=\"0\",mode=\"user\"} $CPU"

	echo "# HELP node_memory_MemTotal_bytes Memory information field MemTotal_bytes."
	echo "# TYPE node_memory_MemTotal_bytes gauge"
	echo "node_memory_MemTotal_bytes $MemTotal"

	echo "# HELP node_memory_SwapCached_bytes Memory information field SwapCached_bytes."
	echo "# TYPE node_memory_SwapCached_bytes gauge"
	echo "node_memory_SwapCached_bytes $MemCache"

	echo "# HELP node_memory_Active_file_bytes Memory information field Active_file_bytes."
	echo "# TYPE node_memory_Active_file_bytes gauge"
	echo "node_memory_Active_file_bytes $MemUsed"

	echo "# HELP node_filesystem_avail_bytes Filesystem space available to non-root users in bytes."
	echo "# TYPE node_filesystem_avail_bytes gauge"
	echo "node_filesystem_avail_bytes{device=\"/dev/mapper/ubuntu--vg-ubuntu--lv\",fstype=\"ext4\",mountpoint=\"/\"} $diskFree"
}

main()
{
    while true
    do
        if [[ -f index.html ]]
	then
	    rm index.html
	fi
	date > index.html
	cp index.html /var/www/index.html
	nginx -s reload
	sleep 3
    done
}

main > index.html
