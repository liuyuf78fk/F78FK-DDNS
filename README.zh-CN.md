# F78FK-DDNS

> 🌐 当前为中文文档。如需英文版本，请点击 [English README](README.md)

这是一个自动动态更新 DNS 的脚本集合，仅限 **将域名托管到 f78fk.com 的用户** 使用。

适用于想要自动将本机公网 IP 同步到某个域名（如 `home.example.com`）的场景，脚本会每隔 15 分钟检测当前 IP 并通过 TSIG 密钥调用 DDNS 更新。

---

## 依赖工具

本项目依赖以下命令行工具，通常在安装 BIND 或 DNS 工具包时一并提供：

- `nsupdate`：用于动态 DNS 更新
- `dig`：用于 DNS 记录测试和验证

你可以根据使用的操作系统，通过以下命令安装这些工具：

<details>
<summary>点击展开不同系统的安装方法</summary>

### 🐧 Ubuntu / Debian 系统

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

请确保在使用脚本前已经正确安装以上工具。

## 使用方法

1. 克隆本项目：

   ```bash
   git clone https://github.com/liuyuf78fk/F78FK-DDNS.git
   cd F78FK-DDNS
   ```

2. 修改 `auto_ddns_update.sh` 脚本，填写你自己的：
   - zone 名（如 `example.com`）
   - 需要更新的完整域名（如 `home.example.com.`）
   - 类型（A 或 AAAA）
   - TSIG 密钥路径

3. 编辑 crontab，添加定时任务（每 15 分钟执行一次）：

   ```bash
   crontab -e
   ```

   添加以下内容（路径根据实际修改）：

   ```cron
   */15 * * * * /home/<your_username>/F78FK-DDNS/auto_ddns_update.sh
   ```

---

## 文件说明

| 文件名                  | 说明                                           |
|-------------------------|------------------------------------------------|
| `auto_ddns_update.sh`   | 定时自动获取 IP 并执行 DDNS 更新               |
| `f78fk.ddns_update.sh`  | 核心 DDNS 更新脚本，支持 TTL、类型判断等       |
| `getip.sh`              | 获取当前公网 IP 的脚本                       |
| `LICENSE`               | CC BY-NC 4.0 非商业许可证，禁止用于商业用途    |

---

## 许可证 / License

本项目遵循 [CC BY-NC 4.0 非商业许可证](https://creativecommons.org/licenses/by-nc/4.0/deed.zh)

- ✅ 允许您用于个人或公司内部用途；
- ❌ 禁止将本脚本用于任何商业服务、销售或再打包；
- ❌ 禁止用作他人收费服务的一部分。