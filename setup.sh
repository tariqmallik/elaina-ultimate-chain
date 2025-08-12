#!/bin/bash

echo "[*] Starting environment setup for elaina-ultimate-chain"
echo "[*] Checking and installing system dependencies..."

# Update and install system tools
sudo apt update && sudo apt install -y \
  python3 python3-pip python3-venv git gcc make \
  libssl-dev libffi-dev build-essential smbclient \
  net-tools dnsutils

echo "[*] Creating virtual environment (venv)..."
python3 -m venv elaina-env
source elaina-env/bin/activate

echo "[*] Upgrading pip..."
pip install --upgrade pip

echo "[*] Installing Python dependencies from requirements.txt..."
pip install -r requirements.txt

echo "[*] Cloning impacket if not present..."
if [ ! -d "impacket" ]; then
  git clone https://github.com/SecureAuthCorp/impacket.git
  cd impacket
  pip install .
  cd ..
else
  echo "[*] Impacket already cloned."
fi

echo "[*] Cloning mitm6 if not present..."
if [ ! -d "mitm6" ]; then
  git clone https://github.com/fox-it/mitm6.git
  cd mitm6
  pip install .
  cd ..
else
  echo "[*] mitm6 already cloned."
fi

echo "[*] Installing ldapdomaindump..."
pip install ldapdomaindump

echo "[*] All dependencies installed."
echo "[*] To activate virtual environment later: source elaina-env/bin/activate"
echo "[*] Setup complete."
