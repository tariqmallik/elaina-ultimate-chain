# elaina-ultimate-chain

> 🧠 AI-driven full-chain NTLM Relay exploitation and internal web exploitation automation suite  
> 🖤 Black Hat Offensive Tool | ☠️ Use responsibly in red team / lab / CTF settings only.

---

## 📌 Description

`elaina-ultimate-chain` is a fully automated black-box internal exploitation framework that chains multiple real-world attack vectors including:

- **NTLM Relay via Impacket's `ntlmrelayx.py`**
- **MITM6 for DNS spoofing and auto coercion**
- **Automated Powershell payload deployment**
- **Post-auth web app vulnerability chaining: XSS, SQLi, LFI, IDOR, Redis RCE, WebSocket hijacking**
- **Selenium-driven JS crawler + cookie extractor**
- **Local privilege escalation stager (planned)**
- **Automatic log collection & report generation**

---

## ⚙️ Features

- ✅ Full NTLM relay setup using MITM6 + NTLMRelayx
- ✅ Auto-launch `ldapdomaindump` to enumerate domain after relay
- ✅ Auto-generate and drop **PowerShell reverse shell payload**
- ✅ Stealth payload auto-deletes itself after execution
- ✅ Extracts `cookies`, `localStorage`, `WebSocket endpoints` using Selenium headless Chrome
- ✅ Attacks internal web apps with:
  - XSS scanner (reflected & stored)
  - SQL Injection tester
  - Local File Inclusion (LFI)
  - XML External Entity (XXE)
  - IDOR enumerator
  - Redis RCE if open
- ✅ Logs everything into structured `elaina_ultimate_log.json`
- ✅ Built-in browser automation with JS DOM crawling

---

## 🧩 Available Flags

| Flag             | Description                                      |
|------------------|--------------------------------------------------|
| `--tor`          | Route all traffic through TOR proxy              |
| `--tor-pass`     | Password for TOR control port                    |
| `--burp`         | Forward HTTP requests to Burp Suite Repeater     |
| `--ldap-subnet`  | Target subnet to scan vulnerable LDAP endpoints  |
| `--winrm-user`   | Username for WinRM remote execution              |
| `--winrm-pass`   | Password for WinRM remote execution              |

---

### Example ENV

```bash
export TARGET_URL="http://victim.internal"
export ATTACKER_HOST="http://192.168.56.1"
export LDAP_HOST="192.168.56.100"
export DOMAIN="corp.local"
export WINRM_USER="corp\\elaina"
export WINRM_PASS="P@ssw0rd123"
```

---

## 🚀 How to Use

### 1. Clone the repository

```bash
git clone https://github.com/Yuri08loveElaina/elaina-ultimate-chain-.git
cd elaina-ultimate-chain-
```

### 2. Setup the environment (Linux)

```bash
chmod +x setup.sh
./setup.sh
```

This installs:

- Impacket (from GitHub)
- mitm6
- ldapdomaindump
- Selenium & headless browser support
- Python dependencies

### 3. Run the chain exploit

```bash
source elaina-env/bin/activate
python exploit.py
```

This will:

- Launch MITM6 (IPv6 spoofing)
- Start `ntlmrelayx.py` to relay to LDAP or SMB
- Auto-deploy reverse shell payload
- Dump domain details
- Extract session cookies from internal web targets
- Start attacking chained web services

---

## 🧪 Sample Output

- `elaina_ultimate_log.json`:
```json
{
  "ntlm_relay": "Success - Administrator@corp.local",
  "powershell_payload": "Executed and self-deleted",
  "cookies": {
    "192.168.1.50": ["PHPSESSID=..."]
  },
  "xss": [
    {"url": "http://intranet.local/dashboard?q=<script>...", "vulnerable": true}
  ],
  "idor": [
    {"endpoint": "/api/user?id=1", "accessible_ids": [2,3,4,5]}
  ]
}
```

---

## 📁 File Structure

```
exploit.py                 # Main full-chain exploit script
requirements.txt           # Python dependencies
setup.sh                   # Automated setup script
payloads.ps1            # Generated reverse shell payload
```

---

## ⚠️ Legal Disclaimer

> ❌ This tool is intended **strictly for authorized penetration testing**, **research**, **labs**, or **CTF** purposes.  
> 🚫 Any **unauthorized usage** against systems without explicit consent is **illegal** and unethical.  
> 👁️‍🗨️ The authors are **not responsible** for any damage or misuse.

---

## 👩‍💻 Developed By

- `Yuri08`
- Powered by stealth automation, deep packet abuse, and chained exploitation

---

## ✅ Tested On

- Kali Linux 2024.2
- Python 3.9+
- Impacket (latest GitHub)
- ChromeDriver v123+

---

## 📬 Contact

This is a **black hat proof-of-concept** and **not maintained** officially.  
Use at your own risk. If you know, you know. 💀
