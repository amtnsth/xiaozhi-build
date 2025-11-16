#!/bin/bash

# ====== BUILD XIAOZHI ======
if [ "$1" = "build" ]; then
    echo "🚀 Building XiaoZhi firmware..."
    cd ~/xiaozhi-esp32 || exit
    idf.py set-target esp32s3
    idf.py build
    exit
fi

# ====== RUN QEMU ======
if [ "$1" = "emu" ]; then
    echo "🖥️ Starting ESP32 QEMU..."
    cd ~/xiaozhi-esp32/build || exit
    qemu-system-xtensa -nographic \
        -M esp32 \
        -drive file=xiaozhi-esp32.bin,if=mtd,format=raw
    exit
fi

# ====== MOCK AUDIO ======
if [ "$1" = "audiomock" ]; then
    echo "🎤 Mocking microphone input from audio.wav"
    nc -lk 9999 < audio.wav
    exit
fi

# ====== START WEB DEBUG ======
if [ "$1" = "webdebug" ]; then
    echo "🌐 Starting Web Debug server on http://localhost:8080"
    http-server ~/xiaozhi-esp32 -p 8080
    exit
fi

# ====== SERIAL LOG VIEWER ======
if [ "$1" = "log" ]; then
    echo "📄 Watching logs (simulated)..."
    tail -f ~/xiaozhi-esp32/log.txt
    exit
fi

# ====== HELP ======
echo "
Commands:
  ./tools.sh build       → Build firmware
  ./tools.sh emu         → Run firmware in QEMU
  ./tools.sh audiomock   → Fake microphone audio
  ./tools.sh webdebug    → Open Web Debug UI
  ./tools.sh log         → Log viewer
"
