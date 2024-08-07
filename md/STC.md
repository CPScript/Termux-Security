# STATIC.sh notes:

---

This is a background noise generator that runs in termux in the background of your android phone (it makes background traffic to make your data less interesting to sell)... This is the beta version I am going to release soon (this has been given out to 2 people for them to review and make changes!

```shell
#!/data/data/com.termux/files/usr/bin/bash

# Configuration
USER_AGENTS=(
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36"
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0"
)

ROOT_URLS=(
    "http://example.com"
    "http://test.com"
)

BLACKLISTED_URLS=(
    "google-analytics.com"
    "ads.com"
)

MIN_SLEEP=5
MAX_SLEEP=15

# Function to generate a random URL under example.com
generate_random_url() {
    echo "http://example.com/$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)"
}

# Function to send an HTTP GET request to a random URL with random user-agent
send_http_request() {
    local url=$1
    local user_agent=${USER_AGENTS[$RANDOM % ${#USER_AGENTS[@]}]}
    curl -s -A "$user_agent" -k "$url" > /dev/null &
}

# Function to send a DNS query using DNS over HTTPS (DoH)
send_dns_query() {
    local domain="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1).com"
    curl -s "https://cloudflare-dns.com/dns-query?name=$domain" > /dev/null &
}

# Main loop to generate traffic noise
main_loop() {
    while true; do
        rand=$((RANDOM % 2))
        
        if [ $rand -eq 0 ]; then
            url=$(generate_random_url)
            send_http_request "$url"
        else
            send_dns_query
        fi
        
        # Randomized sleep timings
        sleep_time=$((RANDOM % 6 + 5))  # Random sleep between 5 to 10 seconds
        sleep $sleep_time
    done
}

# Start the main loop
main_loop
```

## Script Overview:
The script runs in Termux and simulates random HTTP and DNS traffic noise, aiming to obfuscate actual user browsing patterns for enhanced privacy and security.

## Configuration:
```
USER_AGENTS=(
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4515.107 Safari/537.36"
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:89.0) Gecko/20100101 Firefox/89.0"
)

ROOT_URLS=(
    "http://example.com"
    "http://test.com"
)

BLACKLISTED_URLS=(
    "google-analytics.com"
    "ads.com"
)

MIN_SLEEP=5
MAX_SLEEP=15
```
* USER_AGENTS: Array containing various user-agent strings used by different browsers. Each HTTP request selects a random user-agent from this list, simulating diverse browsing behaviors.

* ROOT_URLS: Placeholder list of example root URLs. In a real scenario, these would represent websites of interest or domains to generate traffic towards.

* BLACKLISTED_URLS: Domains listed here are avoided to prevent unnecessary traffic to known tracking or advertisement servers.

* MIN_SLEEP, MAX_SLEEP: Define the minimum and maximum sleep times between each simulated action (HTTP request or DNS query). This randomizes the timing to simulate human-like browsing patterns.

Functions:
1. `generate_random_url()`
```
generate_random_url() {
    echo "http://example.com/$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)"
}
```
* Purpose: Generates a random URL under example.com using alphanumeric characters. This simulates clicking on links on a website.

2. `send_http_request(url)`
```
send_http_request() {
    local url=$1
    local user_agent=${USER_AGENTS[$RANDOM % ${#USER_AGENTS[@]}]}
    curl -s -A "$user_agent" -k "$url" > /dev/null &
}
```

* Purpose: Sends an HTTP GET request to a specified URL with a randomly selected user-agent from USER_AGENTS. This function simulates fetching web pages from different browsers.

* Enhancement: -k option is used to ignore SSL certificate validation (-k is optional and may be omitted if you do not need it).

3. `send_dns_query()`
```
send_dns_query() {
    local domain="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1).com"
    curl -s "https://cloudflare-dns.com/dns-query?name=$domain" > /dev/null &
}
```

* Purpose: Performs a DNS query using DNS over HTTPS (DoH) to cloudflare-dns.com. This encrypts DNS traffic, enhancing privacy by preventing interception or manipulation of DNS queries.

4. `main_loop()`
```
main_loop() {
    while true; do
        rand=$((RANDOM % 2))
        
        if [ $rand -eq 0 ]; then
            url=$(generate_random_url)
            send_http_request "$url"
        else
            send_dns_query
        fi
        
        # Randomized sleep timings
        sleep_time=$((RANDOM % 6 + 5))  # Random sleep between 5 to 10 seconds
        sleep $sleep_time
    done
}
```
* Purpose: The main loop continuously generates traffic noise by randomly selecting between sending an HTTP request (send_http_request) and a DNS query (send_dns_query).

* Enhancement: Uses dynamic sleep timings (sleep_time=$((RANDOM % 6 + 5))) to introduce variability in action timings, mimicking human-like browsing behavior with periods of activity and inactivity.
