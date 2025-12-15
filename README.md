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

## 📌 Notes for AI Assistance (Copilot / LLMs)

When assisting with this repository:

* Always output **GML**
* Match existing naming patterns
* Assume this is a **GameMaker Studio 2 project**
* Do not invent APIs from other engines or languages

---

## 💄 License

(TBD)
