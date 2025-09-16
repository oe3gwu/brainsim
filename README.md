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

The Brain Simulator is written in BASIC for the 64 and 128 (in 64 mode). When you've finished typing in the program, save a copy to tape or disk. To run the program, simply load it and type RUN. You'll see two blank windows on the screen. Below them is a legend that explains the action of the function keys. When you type a letter or number, the dot pattern for that symbol appears in the left window. Try typing a few letters and numbers to see how this works. When you start the program, it doesn't know any patterns—so we'll teach it some. To learn a pattern, place it in the left window by pressing the key for the letter or number and then press F1. The program trains its simulated neurons to memorize the pattern (this takes about 30 seconds). READY reappears on the screen when the pattern has been learned. Go ahead and teach the program three different-looking letters, “A”, “T”, and “Z”.

Now let's try recalling a pattern. Press the “A” key to place an A in the left window. Now press F3—this introduces errors in the pattern by randomly changing about 10% of the dots in the pattern each time you press it. After you press F3, you'll have a pattern that looks something like an A, but doesn't exactly match what we taught the program. Press F5 to start the recall process. The pattern is run back and forth through the neuron network until it stabilizes on a fixed pattern (an arrow in the middle of the screen shows the direction of the transfer). After the neuron network has “thought” about the problem for a few cycles, you'll probably get back the original A we taught the program (just like the brain, this process doesn't always remember the right thing; if the random changes made the pattern more like another pattern the program has learned, that one will be found instead).

Try entering T and Z, creating errors in them by pressing F3 one or two times, and recalling with F5. Note how the neuron network almost always recalls the correct pattern even though you've given it something quite different from what it learned. Enter “I” and try recalling with F5. The network recognizes this as T because I looks more like T than A or Z, the other patterns it has learned. This is what your brain does when it sees a pattern of lines and immediately thinks of a sleeping cat. Many researchers think the basic process the brain uses is much the same as the one used by this program.

You can make the program forget everything it has learned by pressing F4. If you press F6, the program exits to BASIC. When you leave the program everything it has learned is forgotten, but you can save learned patterns on the disk by pressing F7 and entering a file name. The next time you run the program you can reload the program's memory by pressing F8 and entering the same file name.

## How it Works

The remarkable thing about this program is that it doesn't “know” it's recognizing letters and numbers. As far as the program is concerned, it could be learning phrases of music, combinations of medical symptoms, or pictures of animals.

The program simulates two fields of neurons with the arrays F1% and F2%, and displays these fields in the two windows on the screen. When you type a letter or number, the dot pattern for that symbol is read from the character ROM and stored in F1%. Lighted dots are stored as 1 and background dots as −1. The character patterns are 6 dots wide by 7 dots high, so F1% and F2% both hold 42 numbers.

Each neuron in a field potentially connects to every neuron in the other field. Each connection, which is equivalent to a synapse in the brain, has its own weight: positive to excite, negative to inhibit, and zero if there is no connection. These weights are stored in the 42×42 matrix M%, for a total of 1,764 connections. To learn a pattern, we form a matrix from the pattern in F1% and add it to the weight matrix M% (see lines 1020–1060 in the program). To recall a pattern we take the the pattern in F1% and multiply it by the weight matrix (lines 1410–1480). If the value is 1 or more, we place a 1 in that position of F2%; if it's negative, we store a −1 there. If the value is zero, we leave the value in F2% alone. Then we take the value in F2% and multiply it back through the the matrix, but swapping rows and columns, and store it back into F1% (lines 1540–1610). We keep this up until the pattern in F1% stops changing. That's our final value, the pattern we've recalled from the network.

## Limits of Learning

The number of different patterns a neuron network can learn is determined by the number of neurons and connections. This very small network can learn only 2 or 3 distinct patterns before it begins to get confused. If you try to teach it 4 or 5 patterns, it will often recall the wrong pattern, or even a spurious pattern you never taught it. That's where the enormous complexity of the brain comes in; your brain has at least five billion times as many connections as this little program, so your ability to learn and remember is correspondingly greater.

But like a singing dog, it's not how well it sings but the fact it sings at all. With less than 250 lines of BASIC, we can make the Commodore 64 play the brain's game, pattern recognition, the brain's way, by simulating a neuron network. It can learn simply by being shown patterns and recall a similar pattern when shown something it's never seen before. Research into neuron networks is one of the most exciting and rapidly expanding fields in science today, bringing together computer science, psychology, mathematics, and biology to discover how the brain accomplishes the remarkable things it does. This research may lead to computers that can recognize faces, understand speech, and answer complicated questions. But more importantly, we may find answers to questions as old as mankind: “What is thought?”, “What is memory?”, and “How do people reason?”. That your home computer can help you understand and experiment with such matters is testimony to the power latent within it. 
