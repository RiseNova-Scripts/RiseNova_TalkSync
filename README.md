# 🎤 RiseNova_TalkSync — Premium Voice-Reactive Animation System

A next-generation, fully standalone **voice-activated animation system** for  
QBCore, ESX, QBOX, vRP, custom frameworks — or completely standalone.

Your character **moves, gestures, reacts, and animates while speaking**, creating the most immersive roleplay conversations possible.

Talk, and your character comes alive.

---

## ✨ Features

✔ **Real voice-reactive facial animations**  
✔ **Dynamic gestures** while talking (auto-changing)  
✔ **Micro-movements** for realism  
✔ **Expression levels**: low / medium / high  
✔ **Standalone** (no framework required)  
✔ Optional **QBCore metadata blocking** (dead, cuffed, last stand)  
✔ **Universal API** for ESX, vRP & custom frameworks  
✔ Automatic **resource name protection**  
✔ **Optimized to 0.00ms idle**  
✔ Works with all voice systems (pma-voice, mumble, SaltyChat, etc.)

---

## 🔧 Installation

1. Drag the folder into your `resources` directory  
2. Make sure the folder is named **RiseNova_TalkSync**  
3. Add this to your `server.cfg`:

```
ensure RiseNova_TalkSync
```

4. Open `config.lua` and adjust animation settings, expression levels, and framework hooks.

---

## ⚙️ Configuration

Everything is controlled through **config.lua**:

- Enable/disable gestures, facial anims, or micro-movements  
- Adjust gesture frequency & movement intensity  
- Switch expression mode (low/medium/high)  
- Enable optional **QBCore blocking**  
- Use generic API for ESX/vRP/custom  
- Performance tweaks  
- Vehicle/combat restrictions  
- More advanced behaviors

---

## 🔌 Framework Integration

### **Standalone Mode (Default)**  
Runs perfectly with no framework at all.

### **QBCore Mode (Optional)**  
If enabled, TalkSync automatically disables when:  
- Player is **dead**  
- Player is in **last stand**  
- Player is **handcuffed**

### **Universal API (ESX / vRP / Custom)**

Block or unblock talking animations:

```lua
TriggerEvent('RiseNova:TalkSync:SetBlocked', true/false)
```

Perfect for jail systems, custom death scripts, emote locks, etc.

---

## 🎮 Commands

```
/talksync
```

Toggles the entire system for the player (if enabled in config).

---

## 📄 License

MIT License (see LICENSE file).

---

## 💙 Credits

Created with pride by **RiseNova Scripts**  
Bringing premium innovation to your FiveM server.
