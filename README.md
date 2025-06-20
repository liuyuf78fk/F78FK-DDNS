# F78FK-DDNS

> 🌐 This README is in English. [点击查看中文版本](README.zh-CN.md)

A shell script collection for **automated dynamic DNS updates**, **only for users who host their zones on f78fk.com**.

It helps automatically synchronize your public IP to a specific hostname (e.g., `home.example.com`) every 15 minutes using DDNS with TSIG.

---

## Requirements

This project depends on the following command-line tools:

- `nsupdate`: for performing dynamic DNS updates
- `dig`: for testing and verifying DNS records

You can install these tools using your Linux distribution’s package manager:

<details>
<summary>Click to expand installation instructions for different systems</summary>

### 🐧 Ubuntu / Debian

```bash
sudo apt install bind9-dnsutils
```

### 🐧 CentOS / RHEL / Rocky Linux

```bash
sudo yum install bind-utils
```

### 🐧 Alpine Linux

```bash
apk add bind-tools
```

### 🐧 Arch Linux

```bash
sudo pacman -S bind
```

</details>

Make sure these tools are properly installed before running any scripts.


## How to use

1. Clone this repo:

   ```bash
   git clone https://github.com/liuyuf78fk/F78FK-DDNS.git
   cd F78FK-DDNS
   ```

2. Edit the `auto_ddns_update.sh` script to set your own:
   - Zone name (e.g., `example.com`)
   - Hostname to update (e.g., `home.example.com.`)
   - Record type (A or AAAA)
   - Path to your TSIG key file

3. Add a cron job to run every 15 minutes:

   ```bash
   crontab -e
   ```

   Add this line (adjust path as needed):

   ```cron
   */15 * * * * /home/<your_username>/F78FK-DDNS/auto_ddns_update.sh
   ```

---

## File Description

| Filename               | Description                                      |
|------------------------|--------------------------------------------------|
| `auto_ddns_update.sh`  | Automatically gets public IP and updates DDNS   |
| `f78fk.ddns_update.sh` | Main DDNS script with TTL, type checking        |
| `getip.sh`             | Detects current public IP                       |
| `LICENSE`              |  CC BY-NC 4.0 License (Non-commercial use only) |

---

## License

This project is licensed under [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/)

- ✅ Free for personal or internal company use;
- ❌ Commercial usage, redistribution, or integration into paid services is prohibited.
