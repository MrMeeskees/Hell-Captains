# Hell Captains

**Hell Captains** is a **GameMaker Studio–based 2D game project** set in an alternate World War II dieselpunk universe featuring flying warships, interior ship combat, and crew-driven systems.

---

## 🚨 Language & Engine Requirements (IMPORTANT)

This project uses **GameMaker Language (GML) exclusively**.

* **All gameplay code is written in GML**
* **No other programming languages are used**
* Do **not** generate or suggest code in:

  * JavaScript
  * TypeScript
  * C#
  * C++
  * Python
  * Lua
  * Pseudocode

If you are generating code for this project, it **must be valid GML** compatible with **GameMaker Studio 2**.

---

## 🧐 Coding Expectations

* Use **native GML syntax only**
* Follow GameMaker Studio 2 conventions
* Prefer **structs, enums, and state machines**
* Avoid deprecated or legacy GameMaker syntax unless explicitly noted
* Assume code is running inside standard GMS2 events (Create, Step, Draw, etc.)

Example constructs that are expected and encouraged:

* `enum`
* `struct`
* `switch` statements
* `with` blocks
* `instance_create_layer`
* `collision_line`, `instance_place`, etc.

---

## 📂 Naming Conventions

Use consistent GameMaker-style naming:

* Objects: `obj_`
* Scripts: `scr_`
* Enums: `enum_`
* Struct instances: `*_data` or `*_stats`
* State variables: `state`, `substate`

Example:

```gml
enum enum_ai_state {
    IDLE,
    PATROL,
    ALERT,
    COMBAT
}
```

---

## 🎮 Project Scope (High-Level)

Hell Captains focuses on:

* Interior combat aboard massive flying warships
* Crew AI with defined roles and behaviors
* Depth-based cover and targeting
* Destructible ship interiors
* Weapon and equipment systems driven by data structures

All systems are implemented in **GML only**.

---

## 💾 Save/Load System

A complete, production-ready save/load system has been implemented with:

* DS Map-based save structure with JSON encoding
* Automatic instance recreation with full property restoration
* Multiple save slots (3 slots, expandable)
* Custom variable support via User Events 6 & 7
* Memory leak prevention with proper cleanup
* Error handling for corrupt or missing files

### Quick Start

**⚡ [5-Minute Setup Guide](GETTING_STARTED.md)** - Get running fast!

1. **Add Game Manager**: Place `obj_game_manager` in your first room
2. **Make Objects Saveable**: Set parent to `obj_saveable` and implement User Events 6 & 7
3. **Test**: Press ESC to open pause menu, save/load game

### Save System Documentation

- [**🚀 Getting Started**](GETTING_STARTED.md) - 5-minute quick start guide
- [**📖 Save System README**](SAVE_SYSTEM_README.md) - Complete system documentation
- [**⚡ Quick Reference**](QUICK_REFERENCE.md) - API reference and examples
- [**🔧 Setup Guide**](SETUP_GUIDE.md) - Detailed setup instructions
- [**✅ Testing Checklist**](TESTING_CHECKLIST.md) - Comprehensive test plan
- [**📐 Architecture**](ARCHITECTURE.md) - System diagrams and flow charts
- [**📑 File Index**](FILE_INDEX.md) - Complete file reference

### Usage Example

```gml
// Save game
scr_save_game(0); // Save to slot 0

// Load game
if (scr_save_exists(0)) {
    scr_load_game(0);
}

// Make any object saveable - set parent to obj_saveable
// User Event 6 - Save
other.extra_data[? "health"] = health;
other.extra_data[? "ammo"] = ammo;

// User Event 7 - Load
if (ds_exists(other.loaded_extra_data, ds_type_map)) {
    health = other.loaded_extra_data[? "health"];
    ammo = other.loaded_extra_data[? "ammo"];
}
```

---

## 📌 Notes for AI Assistance (Copilot / LLMs)

When assisting with this repository:

* Always output **GML**
* Match existing naming patterns
* Assume this is a **GameMaker Studio 2 project**
* Do not invent APIs from other engines or languages
* The save/load system is fully implemented - extend it for new objects by inheriting from `obj_saveable`

---

## 💄 License

(TBD)
