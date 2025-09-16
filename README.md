# BrainSim – Associative Memory for C64 & C128

Welcome to **BrainSim**, a retro excursion into neural networks on the **Commodore 64** and **Commodore 128**.  
This project simulates a simple **Hopfield network** – an associative memory that can *learn* patterns and *recall* them, even when they are noisy or incomplete.

Think of it as a distant ancestor of today’s AI models, written entirely in BASIC with nothing but `POKE`, `PEEK`, and PETSCII graphics.

---

## 📖 Background

In the mid-1980s, neural networks such as **Hopfield associative memories** were among the first attempts to make machines “remember” patterns.  
They can store a handful of binary patterns and later recall them when presented with partial or corrupted input.

BrainSim brings this concept to life on 8-bit hardware:

- **42 neurons** (arranged as a 6×7 pixel grid per pattern).
- **Bipolar encoding**: each pixel is either `−1` (off) or `+1` (on).
- **Hebbian learning** (`m[i,j] += f1[i] * f1[j]`), with diagonal weights set to zero.
- **Iterative recall** until the network stabilizes in a stored pattern.

---

## 🕹️ Controls

When you run BrainSim, you’ll see two 6×7 boxes on screen. Use keys to interact:

- **F1** – Teach the current pattern (store it in the network).
- **F2** – Dump the weight matrix (visualize connections).
- **F3** – Randomize ~10% of the current pattern (test robustness).
- **F4** – Forget all patterns and weights.
- **F5** – Recall (iteratively correct pattern until stable).
- **F6** – Quit.
- **F7** – Save state (patterns + weights) to disk (device 8).
- **F8** – Load state from disk (device 8).
- **a–z, 0–9** – Load that character from the character ROM into the left box.

The **left box** shows the *input pattern*.  
The **right box** shows the *recalled pattern*.

---

## 💾 Running

### Commodore 64
```text
LOAD "BRAINSIM_C64.BAS",8
RUN
```

### Commodore 128
```text
LOAD "BRAINSIM_C128.BAS",8
RUN
```
