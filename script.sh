#!/bin/bash

# ============================
# Script de Footprinting Automatisé
# Auteur : N'DA Konan Alexandre
# Usage : ./footprint.sh domaine.com
# ============================

if [ -z "$1" ]; then
    echo "Usage : $0 <domaine ou IP>"
    exit 1
fi

TARGET=$1
OUTPUT="footprint_$TARGET.txt"

echo "[+] Footprinting de : $TARGET" | tee $OUTPUT
echo "==============================" | tee -a $OUTPUT

echo -e "\n[1] Résolution DNS" | tee -a $OUTPUT
nslookup $TARGET | tee -a $OUTPUT

echo -e "\n[2] Informations WHOIS" | tee -a $OUTPUT
whois $TARGET | tee -a $OUTPUT

echo -e "\n[3] Enregistrements DNS (dig)" | tee -a $OUTPUT
dig $TARGET any | tee -a $OUTPUT

echo -e "\n[4] Scan de ports (Top 1000 - non agressif)" | tee -a $OUTPUT
nmap -T3 -F $TARGET | tee -a $OUTPUT

echo -e "\n[5] Technologies Web détectées" | tee -a $OUTPUT
whatweb $TARGET | tee -a $OUTPUT

echo -e "\n[+] Footprinting terminé."
echo "[+] Résultats enregistrés dans : $OUTPUT"

